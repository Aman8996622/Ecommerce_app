import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movieapp/data/models/cart_item_model.dart';
import 'package:movieapp/data/models/product_model.dart';

class CartController extends GetxController {
  final GetStorage _storage = GetStorage();
  final RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCartFromStorage();
  }

  void loadCartFromStorage() {
    try {
      final cartData = _storage.read('cart');
      if (cartData != null) {
        final List<dynamic> decodedCart = json.decode(cartData);
        cartItems.value =
            decodedCart.map((item) => CartItemModel.fromJson(item)).toList();
      }
    } catch (e) {
      print('Error loading cart: $e');
    }
  }

  void saveCartToStorage() {
    _storage.write(
        'cart', json.encode(cartItems.map((item) => item.toJson()).toList()));
  }

  void addToCart(ProductModel product) {
    final existingItem = cartItems.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItemModel(product: product, quantity: 0),
    );

    if (existingItem.quantity == 0) {
      cartItems.add(CartItemModel(product: product));
    } else {
      existingItem.quantity++;
      cartItems.refresh();
    }

    saveCartToStorage();
    Get.snackbar(
      'Added to Cart',
      '${product.title} has been added to your cart',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void removeFromCart(int productId) {
    cartItems.removeWhere((item) => item.product.id == productId);
    saveCartToStorage();
  }

  void decreaseQuantity(int productId) {
    final item = cartItems.firstWhere((item) => item.product.id == productId);
    if (item.quantity > 1) {
      item.quantity--;
      cartItems.refresh();
    } else {
      removeFromCart(productId);
    }
    saveCartToStorage();
  }

  void increaseQuantity(int productId) {
    final item = cartItems.firstWhere((item) => item.product.id == productId);
    item.quantity++;
    cartItems.refresh();
    saveCartToStorage();
  }

  void clearCart() {
    cartItems.clear();
    saveCartToStorage();
  }

  double get totalAmount {
    return cartItems.fold(
      0,
      (sum, item) => sum + (item.product.price ?? 0) * item.quantity,
    );
  }

  int get itemCount => cartItems.fold(0, (sum, item) => sum + item.quantity);
}
