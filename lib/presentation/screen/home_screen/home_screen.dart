import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/main.dart';
import 'package:movieapp/presentation/screen/auth/auth_controller.dart';
import 'package:movieapp/presentation/screen/cart/cart_controller.dart';
import 'package:movieapp/presentation/screen/cart/cart_screen.dart';
import 'package:movieapp/presentation/screen/product/product_controller.dart';
import 'package:movieapp/presentation/screen/product/product_details_screen.dart';
import 'package:movieapp/presentation/widget/product_card.dart';

class HomeScreen extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();
  final ProductController _productController = Get.find<ProductController>();
  final CartController _cartController = Get.find<CartController>();
  // final ConnectivityController _connectivityController = Get.find<ConnectivityController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ShopEase',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () {
                  Get.to(() => CartScreen());
                },
              ),
              Obx(() {
                if (_cartController.itemCount > 0) {
                  return Positioned(
                    top: 5,
                    right: 5,
                    child: // Continuing from the previous code

                        Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '${_cartController.itemCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _authController.logout();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Connection Status
          // Obx(() {
          //   if (!_connectivityController.isConnected) {
          //     return Container(
          //       width: double.infinity,
          //       padding: EdgeInsets.symmetric(vertical: 6),
          //       color: Colors.orange,
          //       child: Text(
          //         'Offline Mode - Using Cached Data',
          //         style: TextStyle(color: Colors.white),
          //         textAlign: TextAlign.center,
          //       ),
          //     );
          //   }
          //   return SizedBox.shrink();
          // }),

          // Categories
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: SizedBox(
              height: 40,
              child: Obx(() {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _productController.categories.length,
                  itemBuilder: (context, index) {
                    final category = _productController.categories[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Obx(() {
                        final isSelected = category ==
                            _productController.selectedCategory.value;
                        return FilterChip(
                          selected: isSelected,
                          label: Text(
                            category.capitalizeFirst!,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                          backgroundColor: Colors.white,
                          selectedColor: Theme.of(context).primaryColor,
                          onSelected: (selected) {
                            _productController.filterByCategory(category);
                          },
                        );
                      }),
                    );
                  },
                );
              }),
            ),
          ),

          // Products Grid
          Expanded(
            child: Obx(() {
              if (_productController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (_productController.products.isEmpty) {
                return const Center(child: Text('No products available'));
              }

              return RefreshIndicator(
                onRefresh: () => _productController.fetchProducts(),
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        MediaQuery.of(context).size.width > 600 ? 3 : 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: _productController.products.length,
                  itemBuilder: (context, index) {
                    final product = _productController.products[index];
                    return ProductCard(
                      product: product,
                      onTap: () {
                        Get.to(
                            () => ProductDetailScreen(productId: product.id!));
                      },
                      onAddToCart: () {
                        _cartController.addToCart(product);
                      },
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
