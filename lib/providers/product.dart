import 'package:flutter/foundation.dart';
import 'package:go_shoppin/models/http_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String authToken, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    print(userId);
    final url =
        'https://shop-app-flutter-ca52d-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$authToken';
    // Optimistic updation : first update local value and revert if fails in server communication
    try {
      final response = await http.put(
        url,
        body: json.encode(
          isFavorite,
        ),
      );
      if (response.statusCode >= 400) {
        print("Response is ${response.body}");
        _setFavValue(oldStatus);
      }
    } catch (error) {
      print(error.toString());
      _setFavValue(oldStatus);
    }
  }
}
