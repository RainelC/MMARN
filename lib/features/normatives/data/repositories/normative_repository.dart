import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mmarn/core/storage/secure_storage_service.dart';
import '../../domain/entities/normative_entity.dart';

class NormativeRepository {
  Future<List<Normative>> getNormatives({String? tipo, String? busqueda}) async {
    final response = await http.get(
      headers: {'Authorization': 'Bearer ${await SecureStorageService().getToken()}'},
      Uri.parse(
          "https://adamix.net/medioambiente/normativas?tipo=${tipo ?? ''}&busqueda=${busqueda ?? ''}"
      ),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Normative.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar normatives");
    }
  }
}

