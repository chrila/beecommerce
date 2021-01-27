class ApplicationController < ActionController::Base

  helper_method :current_order

  def current_order
    order = nil
    
    if current_user
      order = Order.where(user: current_user).where(state: 'created').last
      if !order
        order = Order.create(user: current_user, state: 'created')
      end
    end

    return order
  end

end
