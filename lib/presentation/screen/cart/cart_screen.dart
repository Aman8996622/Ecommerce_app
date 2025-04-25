import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/main.dart';
import 'package:movieapp/presentation/screen/cart/cart_controller.dart';
import 'package:movieapp/presentation/widget/cart_card.dart';

class CartScreen extends StatelessWidget {
  final CartController _cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        actions: [
          if (_cartController.cartItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                Get.defaultDialog(
                  title: 'Clear Cart',
                  middleText: 'Are you sure you want to clear your cart?',
                  textConfirm: 'Yes',
                  textCancel: 'No',
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    _cartController.clearCart();
                    Get.back();
                  },
                );
              },
            ),
        ],
      ),
      body: Obx(() {
        if (_cartController.cartItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 80,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'Your cart is empty',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Start Shopping'),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = _cartController.cartItems[index];
                  return CartItemCard(
                    cartItem: cartItem,
                    onIncrease: () {
                      _cartController.increaseQuantity(cartItem.product.id!);
                    },
                    onDecrease: () {
                      _cartController.decreaseQuantity(cartItem.product.id!);
                    },
                    onRemove: () {
                      _cartController.removeFromCart(cartItem.product.id!);
                    },
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${_cartController.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.snackbar(
                          'Checkout',
                          'Checkout functionality will be implemented in future updates',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                      child: const Text('Checkout'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
