import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movieapp/data/models/cart_item_model.dart';

class CartItemCard extends StatelessWidget {
  final CartItemModel cartItem;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  const CartItemCard({
    super.key,
    required this.cartItem,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.network(
              cartItem.product.image ?? '',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Icon(Icons.image_not_supported));
              },
            ),
          ),
          const SizedBox(width: 12),

          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.product.title ?? 'No Title',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${cartItem.product.price?.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 8),

                // Quantity Controls
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: onDecrease,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              child: const Icon(Icons.remove, size: 16),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              '${cartItem.quantity}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          InkWell(
                            onTap: onIncrease,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              child: const Icon(Icons.add, size: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: onRemove,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
