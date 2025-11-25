import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/photo.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String customUrl =
      'https://my-json-server.typicode.com/hygorlumertz1/albuns-api';

  // Buscar todos os usuários
  static Future<List<User>> fetchUsers() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users'),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Erro ao buscar usuários');
      }
    } catch (e) {
      throw Exception('Erro: $e');
    }
  }

  // Buscar álbuns de um usuário
  static Future<List<Album>> fetchAlbums(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/albums?userId=1'),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Album.fromJson(json)).toList();
      } else {
        throw Exception('Erro ao buscar álbuns');
      }
    } catch (e) {
      throw Exception('Erro: $e');
    }
  }

  // Buscar fotos de um álbum
  static Future<List<Photo>> fetchPhotos(int albumId) async {
    try {
      final response = await http.get(
        Uri.parse('$customUrl/fotos?albumId=$albumId'),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Photo.fromJson(json)).toList();
      } else {
        throw Exception('Erro ao buscar fotos');
      }
    } catch (e) {
      throw Exception('Erro: $e');
    }
  }
}