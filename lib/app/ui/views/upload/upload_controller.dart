import 'dart:io';

import 'package:appsivalmattel/app/data/models/response/response_matteldesabaste_model.dart';
import 'package:appsivalmattel/app/data/models/resquest/request_matteldesabaste_model.dart';
import 'package:appsivalmattel/app/data/providers/matteldesabaste_provider.dart';
import 'package:get/get.dart';

class UploadController extends GetxController {
  @override
  void onInit() {
    inicialize();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  //Instance
  MatteldesabasteProvider _provider = MatteldesabasteProvider();
  //Variables

  //Funciones

  void inicialize() async {}

  doSave() async {
    try {
      //1.- Obtener información de la BD local
      final dataSQLITE = await ResponseMatteldesabasteModel().query("");
      final results = (dataSQLITE as List)
          .map((data) => ResponseMatteldesabasteModel.fromJson(data))
          .toList();
      //2.- Guardar los registros en el servidor
      for (ResponseMatteldesabasteModel item in results) {
        final response = await _provider.save(
          RequestMatteldesabasteModel(
            usuarioId: item.usuarioId,
            puntoventaId: item.puntoventaId,
            puntoventa: item.puntoventa,
            fecha: item.fecha,
            p01: item.p01,
            p02: item.p02,
            p03: item.p03,
            p04: item.p04,
            p05: item.p05,
            p06: item.p06,
            p07: item.p07,
            f01: (item.f01 != "" ? item.f01.split('/').last : ""),
            f02: item.f02,
            f03: item.f03,
            f04: item.f04,
            f05: item.f05,
            f06: item.f06,
            f07: item.f07,
            f011: (item.f011 != "" ? item.f011.split('/').last : ""),
            f021: item.f021,
            f031: item.f031,
            f041: item.f041,
            f051: item.f051,
            f061: item.f061,
            f071: item.f071,
            comentario: item.comentario,
            supfecha: item.supfecha,
            suplatitud: "",
            suplongitud: "",
          ),
        );

        //3.- Subir todas las imagenes
        if (item.f01 != "") {
          Map<String, dynamic> file = {
            //FOTO PREGUNTA 1
            "F01": item.f01 != "" ? File(item.f01) : "",
            "F01_NAME": item.f01 != "" ? item.f01.split('/').last : "",
            "F011": item.f011 != "" ? File(item.f011) : "",
            "F011_NAME": item.f011 != "" ? item.f011.split('/').last : "",
            //FOTO PREGUNTA 2
          };
          await _provider.uploadFile(file);
          //4.- Eliminar datos de BD local para no procesar nuevamente
        }
      }
    } catch (error) {
      print("save error: $error");
    }
  }
}
