import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movieapp/data/models/product_model.dart';
import 'package:movieapp/data/models/user_model.dart';

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';
  final GetStorage _storage = GetStorage();
  final Dio _dio = Dio();

  // Auth API
  Future<UserModel> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '$baseUrl/auth/login',
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;

        // For fake store API, we need to get the user details
        final userResponse = await _dio.get('$baseUrl/users/1'); // Demo user

        if (userResponse.statusCode == 200) {
          final userData = userResponse.data;
          final user = {
            'id': userData['id'],
            'email': userData['email'],
            'username': username,
            'token': data['token'],
          };

          return UserModel.fromJson(user);
        } else {
          throw Exception('Failed to get user info');
        }
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Get all products
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _dio.get('$baseUrl/products');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((item) => ProductModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Get a single product
  Future<ProductModel> getProduct(int id) async {
    try {
      final response = await _dio.get('$baseUrl/products/$id');

      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load product');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Get products by category
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    try {
      final response = await _dio.get('$baseUrl/products/category/$category');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((item) => ProductModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products by category');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Get all categories
  Future<List<String>> getCategories() async {
    try {
      final response = await _dio.get('$baseUrl/products/categories');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((item) => item.toString()).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
