protocol DiscountStrategy {
    func NoDiscountStrategy() -> Int
    func PercentageDiscountStrategy() -> Int
}

public class Product {
    var name: String
    var price: Double
    var quantity: Int

    init(name: String, price: Double, quantity: Int) {
        self.name = name
        self.price = price
        self.quantity = quantity
    }
}

var product1 = Product(name: "Shirt", price: 599, quantity: 0)
var product2 = Product(name: "Pant", price: 399, quantity: 0)
var product3 = Product(name: "Shoe", price: 899, quantity: 0)
var product4 = Product(name: "Watch", price: 999, quantity: 0)

class ShoppingCartSingleton: DiscountStrategy {
    private var productList: [Product] = []
    
    private init() {}

    @MainActor private static var currentInstance: ShoppingCartSingleton?
    @MainActor public class func sharedInstance() -> ShoppingCartSingleton {
        if currentInstance == nil {
            currentInstance = ShoppingCartSingleton()
        }
        return currentInstance!
    }

    func addProduct(product: Product, quantityAdd: Int) {
        var productInTheList: Bool = false
        for index in 0 ..< productList.count {
            if productList[index].name == product.name {
                productInTheList = true
                productList[index].quantity += quantityAdd
                print("Yayy! \(productList[index].quantity) \(product.name) are in the Cart!!!")
                print("After changing quantity to the existing product, total products in the Cart: \(productList.count)!!!\n")
                break
            }
        }
        if !productInTheList {
            var newProduct = Product(name: product.name, price: product.price, quantity: quantityAdd)
            productList.append(newProduct)
            print("Yayy! \(newProduct.quantity) \(newProduct.name) added to the Cart!!!")
            print("After adding new product to the cart, total products: \(productList.count)!!!\n")
        }
    }

    func removeProduct(product: Product) {
        var productInTheList: Bool = false
        for index in 0 ..< productList.count {
            if product.name == productList[index].name {
                productInTheList = true
                productList.remove(at: index)
                print("\(product.name) removed from the Cart!!!")
                print("After removing, total products in the cart: \(productList.count)!!!\n")
                break
            }
        }
        if !productInTheList {
            print("Product is not in the cart to remove!!!\n")
        }

    }

    func clearCart() {
        productList.removeAll()
        print("Your Cart is Empty!!!")
    }

    func getTotalPrice() -> Double{
        var totalPrice: Double = 0
        for index in 0 ..< productList.count {
            totalPrice += Double(productList[index].quantity) * productList[index].price
        }
        return totalPrice
    }

    func NoDiscountStrategy() -> Int {
        return 0
    }

    func PercentageDiscountStrategy() -> Int {
        var totalPrice = getTotalPrice()
        if totalPrice > 5000 {
            return 15
        } else if totalPrice > 3000 {
            return 10
        } else if totalPrice > 1000 {
            return 5
        } else {
            return 0
        }
    }
}

var Cart = ShoppingCartSingleton.sharedInstance()

var dummyCart = ShoppingCartSingleton.sharedInstance()

//Adding products to the Cart.
Cart.addProduct(product: product1, quantityAdd: 3)
Cart.addProduct(product: product2, quantityAdd: 2)
Cart.addProduct(product: product3, quantityAdd: 1)
Cart.addProduct(product: product4, quantityAdd: 1)

print("Total Cart Value: \(Cart.getTotalPrice())\n")
Cart.removeProduct(product: product2)
Cart.removeProduct(product: product2)
print("Total Cart Value: \(Cart.getTotalPrice())\n")

dummyCart.addProduct(product: product3, quantityAdd: 2)

var totalPrice: Double = Cart.getTotalPrice()
print("Total Cart Value: \(totalPrice)\n")

var discount = Cart.PercentageDiscountStrategy()
print("You will get discount of \(discount)% on the Cart Value")
var afterDiscount = totalPrice - (totalPrice * (Double(discount) / 100))
print("You have to Pay \(afterDiscount) finally!\n")

Cart.clearCart()
print("Total Cart Value: \(Cart.getTotalPrice())\n")
