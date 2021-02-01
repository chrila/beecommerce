class Payment < ApplicationRecord
  belongs_to :order
  belongs_to :payment_method

  def process_paypal_payment(remote_ip)
    details = EXPRESS_GATEWAY.details_for(self.token)
    express_purchase_options =
      {
        ip: remote_ip,
        token: self.token,
        payer_id: details.payer_id,
        currency: "USD"
      }

    price = details.params["order_total"].to_d * 100

    response = EXPRESS_GATEWAY.purchase(price, express_purchase_options)
    if response.success?
      #update object states
      self.state = "completed"
      order.state = "completed"

      ActiveRecord::Base.transaction do
        order.save!
        self.save!
      end
    end

    response
  end
end
