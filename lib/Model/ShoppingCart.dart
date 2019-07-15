import 'package:coromandel_mobile/Model/dto/ProductDetails/Modifier.dart';
import 'package:coromandel_mobile/Model/dto/OrderVerification/ModifierOrder.dart';
import 'package:coromandel_mobile/Model/dto/OrderVerification/Order.dart';
import 'package:coromandel_mobile/Model/dto/OrderVerification/OrderItem.dart';
import 'package:coromandel_mobile/Model/dto/ProductDetails/Product.dart';
/*
Singleton class used to store products added to the shopping cart by user
This class is also responsible for services such as
- Adding Products to Cart and incrementing product count
- Removing Products from Cart and decrementing product count
- Updating Cart items
- Computing Bill, Tax, Total based on products in cart.
 */
class ShoppingCart {
  static final ShoppingCart instance = new ShoppingCart._internal();

  Order orders;
  int totalCartCount;
  Map<int, Modifier> toppingsSelected;

  factory ShoppingCart() {
    return instance;
  }

  ShoppingCart._internal() {
    this.orders = new Order();
    toppingsSelected = new Map<int, Modifier>();
    totalCartCount = 0;
  }

  addNewProduct(Product product) {
    if (this.orders.orderProducts != null) {
      //todo: utility boolean method to check if product exists in cart or not
      var existingProduct = this
          .orders
          .orderProducts
          .firstWhere((p) => p?.product_id == product.itemId, orElse: () => null);
      if (existingProduct != null) {
        existingProduct.quantity++;
        incrementCartCount();
        return;
      }
    }

    var _orderItem = new OrderProduct(product.productName, product.productPrice, product.itemId,
        1.00, "", "", "", "", "", "", new List<ModifierOrder>());

    var modifiersInOrder = List<ModifierOrder>();
    if (toppingsSelected.isNotEmpty) {
      toppingsSelected.values.forEach((t) => modifiersInOrder
          .add(new ModifierOrder(t.toppingid, t.toppingid, t.toppingprice)));
    }
    _orderItem.modifierOrders = modifiersInOrder;
    this.orders.orderProducts.add(_orderItem);
    incrementCartCount();
    toppingsSelected.clear();
  }

  UpdateProduct(OrderProduct orderItem) {
    this
        .orders
        .orderProducts
        .firstWhere((p) => p?.product_id == orderItem.product_id)
        .quantity++;

    incrementCartCount();
  }

  void incrementCartCount() {
    this.totalCartCount++;
  }

  removeProduct(int productId) {
    if (orders.orderProducts != null) {
      //todo: utility boolean method to check if product exists in cart or not
      var existingProduct = this
          .orders
          .orderProducts
          .firstWhere((p) => p?.product_id == productId, orElse: () => null);
      if (existingProduct != null) {
        if (existingProduct.quantity == 1.00) {
          existingProduct.quantity = existingProduct.quantity - 1.0;
          this
              .orders
              .orderProducts
              .removeWhere((p) => p.product_id == productId);
          decrementCartCount();
          return;
        }
        existingProduct.quantity = existingProduct.quantity - 1.0;
        decrementCartCount();
        return;
      }
    }

    this.orders.orderProducts.removeWhere((p) => p.product_id == productId);
    decrementCartCount();
  }

  void decrementCartCount() {
    if (this.totalCartCount <= 0) {
      this.totalCartCount = 0;
      return;
    }
    this.totalCartCount--;
  }

  computeBilling() {
    this.orders.cartTotal = this.orders.orderProducts.fold(
        0.0, (prev, element) => (prev + (element.price * element.quantity)));
    //this.orders.promotiondiscount = 5.0;

    // order subtotal = cartTotal - discounts
    this.orders.subTotal =
        this.orders.cartTotal - this.orders.promotiondiscount;

    //TODO: Tax exemption if corporate user
    this.orders.tax = .0635 * this.orders.subTotal;

    this.orders.deliverycharge =
        5.0; //TODO: calculate based on address selected

    this.orders.total =
        this.orders.subTotal + this.orders.tax + this.orders.deliverycharge;

    if (this.orders.tips == 0.0) {
      //default tip amount is 25% of cart total
      this.orders.tips = 0.25 * this.orders.total;
    }

    this.orders.total = this.orders.total + this.orders.tips;
  }

  updateSelectedModifiers(Modifier modifier) {
      toppingsSelected[modifier.toppingCategoryId] = modifier;
  }
}
