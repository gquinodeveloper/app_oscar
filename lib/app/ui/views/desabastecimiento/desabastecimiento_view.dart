import 'dart:io';

import 'package:appsivalmattel/app/ui/components/btn_prymary.dart';
import 'package:appsivalmattel/app/ui/components/templates/custom_scaffold_base.dart';
import 'package:appsivalmattel/app/ui/views/desabastecimiento/desabastecimiento_controller.dart';
import 'package:appsivalmattel/app/ui/views/desabastecimiento/widgets/attach_file.dart';
import 'package:appsivalmattel/core/theme/app_text_style.dart';
import 'package:appsivalmattel/core/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../data/models/response/response_distribuidora_model.dart';
import '../../../data/models/response/response_puntoventa_model.dart';
import '../../../data/providers/distribuidora_provider.dart';
import '../../../data/providers/puntoventa_provider.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

class DesabastecimientoView extends StatefulWidget {
  const DesabastecimientoView({super.key});

  @override
  State<DesabastecimientoView> createState() => _DesabastecimientoViewState();
}

class _DesabastecimientoViewState extends State<DesabastecimientoView> {
  DistribuidoraProvider distribuidoraProvider = DistribuidoraProvider();
  List<ResponseDistribuidoraModel> distribuidoras = [];

  PuntoventaProvider puntoventaProvider = PuntoventaProvider();
  List<ResponsePuntoventaModel> puntoventas = [];

  String empresanombre = "Empresa";
  String empresaid = "Seleccione ...";
  int buscaempresaid = 0;
  String puntoventa = "Punto Ventas";
  String puntoventaid = "Seleccione...";

  String fechaSupervision = "Seleccione...";
  String comentario = "";

  DateTime fecha = DateTime.now();
  String p01 = "";
  String p02 = "";
  String p03 = "";
  String p04 = "";
  String p05 = "";
  String p06 = "";
  String p07 = "";
  List lp = List.generate(11, (i) => i * 10);

  File? imageFile1;
  File? imageFile11;
  File? imageFile2;
  File? imageFile21;
  File? imageFile3;
  File? imageFile31;
  File? imageFile4;
  File? imageFile41;
  File? imageFile5;
  File? imageFile51;
  File? imageFile6;
  File? imageFile61;
  File? imageFile7;
  File? imageFile71;

  TextEditingController fechaController = TextEditingController();
  @override
  void initState() {
    getAllSqlite();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getAllSqlite() async {
    final response2 = await ResponseDistribuidoraModel().query("");
    distribuidoras = (response2 as List)
        .map(
          (data) => ResponseDistribuidoraModel.fromJson(data),
        )
        .toList();

    //final response1 = await ResponsePuntoventaModel().query("");
    final response1 = await ResponsePuntoventaModel()
        .query("WHERE distribuidora_id=?", arguments: [buscaempresaid]);
    puntoventas = (response1 as List)
        .map(
          (data) => ResponsePuntoventaModel.fromJson(data),
        )
        .toList();

    setState(() {});
  }

  getPuntoVenta() async {
    final response1 = await ResponsePuntoventaModel()
        .query("WHERE distribuidora_id=?", arguments: [buscaempresaid]);
    puntoventas = (response1 as List)
        .map(
          (data) => ResponsePuntoventaModel.fromJson(data),
        )
        .toList();

    setState(() {});
  }

/*   void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2024),
    ).then(
      (value) {
        setState(() {
          fecha = value!;
        });
      },
    );
  } */

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DesabastecimientoController>(
      init: DesabastecimientoController(),
      builder: (controller) {
        return CustomScaffoldBase(
          titleAppBar: "Desabastecimiento",
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              ListTile(
                contentPadding: const EdgeInsets.all(0.0),
                leading: const Icon(
                  Iconsax.building,
                  size: 30.0,
                  color: Colors.red,
                ),
                title: Text(empresanombre),
                subtitle: Text(empresaid),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Helpers.getShowModalBS(
                    context,
                    content: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: distribuidoras.length,
                      itemBuilder: (context, index) => ListTile(
                        contentPadding: const EdgeInsets.all(0.0),
                        title: Text(distribuidoras[index].nombre),
                        onTap: () {
                          empresanombre = distribuidoras[index].nombre;
                          empresaid = distribuidoras[index].id.toString();
                          buscaempresaid = distribuidoras[index].id;
                          getPuntoVenta();
                          Navigator.pop(context);
                          setState(() {});
                        },
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0.0),
                leading: const Icon(
                  Iconsax.shop,
                  size: 30.0,
                  color: Colors.red,
                ),
                title: Text(puntoventa),
                subtitle: Text(puntoventaid),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Helpers.getShowModalBS(
                    context,
                    content: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: puntoventas.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(puntoventas[index].nombre),
                        onTap: () {
                          controller.puntoventa = puntoventas[index].nombre;
                          puntoventa = puntoventas[index].nombre;
                          puntoventaid = puntoventas[index].id.toString();
                          Navigator.pop(context);
                          setState(() {});
                        },
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0.0),
                leading: const Icon(
                  Iconsax.calendar,
                  size: 30.0,
                  color: Colors.red,
                ),
                title: const Text("Fecha supervision"),
                subtitle: Text(fechaSupervision),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2024),
                  );
                  if (picked != null) {
                    setState(() {
                      fechaSupervision = DateFormat('yyy-MM-dd').format(picked);
                    });
                  }
                },
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "Preguntas:",
                  style: AppTextStyle(context).bold18(),
                ),
              ),
              const SizedBox(height: 15.0),
              question(
                title: "1. En que % de carga se encuentra Barbie?",
                subTitle: p01,
                onTap: () {
                  _p0(context, lp, 1);
                },
              ),
              const AttachFile(numberQuestion: 1),
              question(
                title: "2. En que % de carga se encuentra Polly Poket?",
                subTitle: p02,
                onTap: () {
                  _p0(context, lp, 2);
                },
              ),
              const AttachFile(numberQuestion: 2),
              question(
                title: "3. En que % de carga se encuentra Disney ?",
                subTitle: p03,
                onTap: () {
                  _p0(context, lp, 3);
                },
              ),
              const AttachFile(numberQuestion: 3),
              question(
                title: "4. En que % de carga se encuentra Hot Wheels?",
                subTitle: p04,
                onTap: () {
                  _p0(context, lp, 4);
                },
              ),
              const AttachFile(numberQuestion: 4),
              question(
                title: "5. En que % de carga se encuentra Jurassic World?",
                subTitle: p05,
                onTap: () {
                  _p0(context, lp, 5);
                },
              ),
              const AttachFile(numberQuestion: 5),
              question(
                title: "6. En que % de carga se encuentra Fisher Price?",
                subTitle: p06,
                onTap: () {
                  _p0(context, lp, 6);
                },
              ),
              const AttachFile(numberQuestion: 6),
              question(
                title: "7. En que % de carga se encuentra Mega Blocks?",
                subTitle: p07,
                onTap: () {
                  _p0(context, lp, 7);
                },
              ),
              const AttachFile(numberQuestion: 7),
              const Text(
                "Comentario",
                style: TextStyle(fontSize: 17.0),
              ),
              TextField(
                maxLines: 3,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
                decoration: const InputDecoration(
                  hintText: "Ingrese Comentario",
                  filled: true,
                  fillColor: Color.fromARGB(255, 221, 237, 245),
                ),
                onChanged: (value) {
                  comentario = (value);
                },
              ),
              const SizedBox(height: 15.0),
              BtnPrimary(
                text: "Guardar",
                onPressed: () {
                  controller.doSave(puntoventaid, puntoventa, fechaSupervision,
                      p01, p02, p03, p04, p05, p06, p07, comentario);
                },
              ),

              /*  MaterialButton(
                onPressed: controller.doSave,
                //elevation: 10.0,
                minWidth: 170.0,
                height: 50.0,
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: const Text(
                  "Guardar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                  ),
                ),
              ), */
            ],
          ),
        );
      },
    );
  }

  Widget question({
    required String title,
    required String subTitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0.0),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18.0),
      ),
      subtitle: Text(
        subTitle,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }

  _p0(BuildContext context, lp, p0) {
    showModalBottomSheet(
      barrierColor: Colors.black12,
      backgroundColor: Colors.white,
      isDismissible: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(35),
        ),
      ),
      context: context,
      builder: (context) {
        return SizedBox(
          height: 400.0,
          child: ListView.builder(
            itemCount: lp.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(lp[index].toString()),
              onTap: () {
                switch (p0) {
                  case 1:
                    p01 = lp[index].toString();
                  case 2:
                    p02 = lp[index].toString();
                  case 3:
                    p03 = lp[index].toString();
                  case 4:
                    p04 = lp[index].toString();
                  case 5:
                    p05 = lp[index].toString();
                  case 6:
                    p06 = lp[index].toString();
                  case 7:
                    p07 = lp[index].toString();
                }

                Navigator.pop(context);
                setState(() {});
              },
            ),
          ),
        );
      },
    );
  }

/*   _distribuidoras(BuildContext context, distribuidoras) {
    showModalBottomSheet(
      barrierColor: Colors.black12,
      backgroundColor: Colors.blue.shade100,
      isDismissible: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(35),
        ),
      ),
      context: context,
      builder: (context) {
        return SizedBox(
          height: 400.0,
          child: ListView.builder(
            itemCount: distribuidoras.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(distribuidoras[index].nombre),
              onTap: () {
                empresanombre = distribuidoras[index].nombre;
                empresaid = distribuidoras[index].id.toString();
                buscaempresaid = distribuidoras[index].id;
                getPuntoVenta();
                Navigator.pop(context);
                setState(() {});
              },
            ),
          ),
        );
      },
    );
  } */

/*   _puntoventas(BuildContext context, puntoventas) {
    showModalBottomSheet(
      barrierColor: Colors.black12,
      backgroundColor: Colors.blue.shade200,
      isDismissible: true,
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(35),
        ),
      ),
      context: context,
      builder: (context) {
        return SizedBox(
          height: 400.0,
          child: ListView.builder(
            itemCount: puntoventas.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(puntoventas[index].nombre),
              onTap: () {
                puntoventa = puntoventas[index].nombre;
                puntoventaid = puntoventas[index].id.toString();
                Navigator.pop(context);
                setState(() {});
              },
            ),
          ),
        );
      },
    );
  } */

/*                 Container(
                width: 600,
                height: 360,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  //image: DecorationImage(
                  //  image: FileImage(imageFile!),
                  //),
                  border: Border.all(
                    width: 8,
                    color: Colors.black12,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
*/
}
