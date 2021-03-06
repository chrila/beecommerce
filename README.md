# Readme
En este documento se describe los cambios y como se utiliza las nuevas funcionalidades.

# Categorías
Al modelo `Category` se agregó un campo `category_id` para guardar la categoría padre (si existe). En el modelo, la categoría padre se llama `parent`, y las categorías subordinadas se llaman `children`

## Crear una categoría
No cambió nada:
```ruby
c = Category.create(name: 'Category name')
```

## Subordinar una categoría a otra
En el momento de creación:
```ruby
c1 = Category.create(name: 'Parent category')
c2 = Category.create(name: 'Child category', parent: c1)
```

Después:
```ruby
c1 = Category.create(name: 'Parent category')
c2 = Category.create(name: 'Child category')
c2.parent = c1
```

## Agregar categorías subordinadas a una categoría
En el momento de creación:
```ruby
c1 = Category.create(name: 'Child category 1')
c2 = Category.create(name: 'Child category 2')
c3 = Category.create(name: 'Parent category', children: [c1, c2])
```

Después:
```ruby
c1 = Category.create(name: 'Child category 1')
c2 = Category.create(name: 'Child category 2')
c3 = Category.create(name: 'Parent category')
c3.children << c1
c3.children << c2
```

## Obtener todas las categorías subordinadas
El método `all_children` entrega una lista que incluye los children, los chldren de los children, etc. Ejemplo:
```ruby
c1 = Category.create(name: 'Child category 1')
c2 = Category.create(name: 'Child category 2')
c3 = Category.create(name: 'Sub-child category 1', parent: c2)
c4 = Category.create(name: 'Parent category', children: [c1, c2])
c4.all_children
# --> [Child category 1, Child category 2, Sub-child category 1]
```

## Obtener todas las categorías de mayor relevancia
El método `all_parents` entrega una lista del parent, el parent del parent, etc. Ejemplo:
```ruby
c1 = Category.create(name: 'Child category 1')
c2 = Category.create(name: 'Child category 2')
c3 = Category.create(name: 'Sub-child category 1', parent: c2)
c4 = Category.create(name: 'Parent category', children: [c1, c2])
c3.all_parents
# --> [Child category 2, Parent category]
```

# Coupons
Un coupon tiene un valor (`value`), un flag si es un porcentaje o un monto específico (`percent`) y un código (`code`).

## Crear un cuopon
```ruby
c1 = Coupon.create(value: 20000, percent: false, code: 'ABCDEFGH')
c2 = Coupon.create(value: 10, percent: true, code: 'TUVWXYZ')
```

## Relacionar un coupon a usuarios y pedidos
```ruby
c = Coupon.create(value: 20000, percent: false, code: 'ABCDEFGH')
u = User.create(email: 'test@example.com', password: '123456')
o = Order.create(user: u)

# agregar el coupon al pedido
o.coupon = c
# agregar el coupon al usuario
u.coupons << c
```

# Variaciones de productos
## Uso
Los distintos tipos de variaciones están en el modelo `Variant` (ejemplo: color). Cuando se relaciona con un producto, hay que crear un `ProductVariant`, indicando el valor (ejemplo: rojo). Ejemplo:
```ruby
p = Product.create(name: 'Tennis shoes', description: 'Shoes with a resistant sole, ideal for playing tennis', stock: 50, price: 60, sku: 'SHTNSXGH95')
v = Variant.create(name: 'Color')
pv = ProductVariant.create(variant: v, value: 'red')
p.product_variants << pv
```

## Mostrar el catálogo de productos
Para mostrar un catálogo de productos disponibles (los que tienen stock), se puede usar el scope `Product.catalogue`. Por ejemplo:
```erb
<% Product.catalogue.each do |prod| %>
  <%= "SKU: #{prod.sku}; Name: #{prod.name}" %>
<% end %>
```

# El modelo
Con las modificaciones, el modelo se ve así:
![ERD diagram](doc/erd.png)
