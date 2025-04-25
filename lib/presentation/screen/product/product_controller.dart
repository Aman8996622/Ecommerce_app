import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movieapp/data/api_service/api_service.dart';
import 'package:movieapp/data/models/product_model.dart';
import 'package:movieapp/main.dart';

class ProductController extends GetxController {
  final ApiService _apiService = ApiService();
  final GetStorage _storage = GetStorage();

  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxList<String> categories = <String>[].obs;
  final RxBool isLoading = false.obs;
  final RxString selectedCategory = 'all'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    fetchCategories();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;

      // Try to get cached products first
      final cachedProducts = _storage.read('products');
      if (cachedProducts != null) {
        final List<dynamic> decodedProducts = json.decode(cachedProducts);
        products.value =
            decodedProducts.map((item) => ProductModel.fromJson(item)).toList();
      }

      // Fetch fresh data from API
      final List<ProductModel> fetchedProducts =
          await _apiService.getProducts();
      products.value = fetchedProducts;

      // Cache the fetched products
      _storage.write('products',
          json.encode(fetchedProducts.map((p) => p.toJson()).toList()));
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load products. Using cached data if available.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCategories() async {
    try {
      // Try to get cached categories first
      final cachedCategories = _storage.read('categories');
      if (cachedCategories != null) {
        final List<dynamic> decodedCategories = json.decode(cachedCategories);
        categories.value =
            decodedCategories.map((item) => item.toString()).toList();
      }

      // Add 'all' category
      if (!categories.contains('all')) {
        categories.add('all');
      }

      // Fetch fresh data from API
      final List<String> fetchedCategories = await _apiService.getCategories();
      categories.value = ['all', ...fetchedCategories];

      // Cache the fetched categories
      _storage.write('categories', json.encode(categories));
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  Future<ProductModel> getProductById(int id) async {
    try {
      // Check if the product is in the local list
      final product =
          products.firstWhere((p) => p.id == id, orElse: () => ProductModel());

      if (product.id != null) {
        return product;
      }

      // If not found locally, fetch from API
      return await _apiService.getProduct(id);
    } catch (e) {
      throw Exception('Failed to get product: $e');
    }
  }

  void filterByCategory(String category) {
    selectedCategory.value = category;
    if (category == 'all') {
      fetchProducts();
    } else {
      fetchProductsByCategory(category);
    }
  }

  Future<void> fetchProductsByCategory(String category) async {
    try {
      isLoading.value = true;

      if (category == 'all') {
        await fetchProducts();
        return;
      }

      final List<ProductModel> categoryProducts =
          await _apiService.getProductsByCategory(category);
      products.value = categoryProducts;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load products by category.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
