import 'dart:io';

import 'package:appsivalmattel/app/data/models/resquest/request_matteldesabaste_model.dart';
import 'package:dio/dio.dart';

class MatteldesabasteProvider {
  Future<String> save(RequestMatteldesabasteModel request) async {
    final dio = Dio();
    final response = await dio.post(
      'http://www.sivalaplicativos.com/matteldesabastesSubir',
      data: request.toMap(),
    );
    return "";
  }

  Future<String> uploadFile(Map<String, dynamic> file) async {
    final dio = Dio();

    //Definir imagen
    FormData formData = FormData.fromMap({
      //PREGUNTA 1
      'F01': await MultipartFile.fromFile(
        (file["F01"] as File).path,
        filename: file["F01_NAME"],
      ),
      'F011': await MultipartFile.fromFile(
        (file["F011"] as File).path,
        filename: file["F011_NAME"],
      ),
      //PREGUNTA 2
    });

    final response = await dio.post(
      'http://www.sivalaplicativos.com/matteldesabastesSubirImagen',
      data: formData,
    );
    return "";
  }
}
