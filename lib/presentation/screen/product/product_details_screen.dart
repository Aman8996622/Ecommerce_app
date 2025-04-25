import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/data/models/product_model.dart';
import 'package:movieapp/presentation/screen/cart/cart_controller.dart';
import 'package:movieapp/presentation/screen/product/product_controller.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;
  final ProductController _productController = Get.find<ProductController>();
  final CartController _cartController = Get.find<CartController>();

  ProductDetailScreen({required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<ProductModel>(
        future: _productController.getProductById(productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error loading product'));
          }

          if (!snapshot.hasData || snapshot.data!.id == null) {
            return Center(child: Text('Product not found'));
          }

          final product = snapshot.data!;

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Hero(
                          tag: 'product-${product.id}',
                          child: Image.network(
                            product.image ?? '',
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                  child: Icon(Icons.image_not_supported,
                                      size: 50));
                            },
                          ),
                        ),
                      ),

                      // Product Details
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    product.title ?? 'No Title',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Text(
                                  '\$${product.price?.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 12),

                            if (product.rating != null)
                              Row(
                                children: [
                                  Row(
                                    children: List.generate(5, (index) {
                                      return Icon(
                                        index <
                                                ((product.rating?['rate'] ?? 0)
                                                        as num)
                                                    .floor()
                                            ? Icons.star
                                            : Icons.star_border,
                                        color: Colors.amber,
                                        size: 18,
                                      );
                                    }),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    '${product.rating?['rate'] ?? 0} (${product.rating?['count'] ?? 0} reviews)',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),

                            SizedBox(height: 16),

                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                product.category?.capitalizeFirst ??
                                    'No Category',
                                style: TextStyle(color: Colors.grey[800]),
                              ),
                            ),

                            SizedBox(height: 24),

                            Text(
                              'Description',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              product.description ?? 'No description available',
                              style: TextStyle(
                                color: Colors.grey[700],
                                height: 1.5,
                              ),
                            ),

                            SizedBox(
                                height: 80), // Space for the bottom buttons
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Cart Controls
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          _cartController.addToCart(product);
                          Get.snackbar(
                            'Added to Cart',
                            '${product.title} has been added to your cart',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                        child: Text('+ Add to Cart'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
