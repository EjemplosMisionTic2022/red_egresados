import 'dart:convert';
import 'package:red_egresados/domain/models/public_job.dart';
import 'package:red_egresados/domain/services/misiontic_interface.dart';
import 'package:http/http.dart' as http;

class WorkPoolService implements MisionTicService {

  //ACTIVIDAD
  // AÑADA SUS CREDENCIALES PARA CONECTARSE AL SERVICIO EXTERNO
  // final String baseUrl = ?
  // final String apiKey = ?

  @override
  Future<List<PublicJob>> fecthData({int limit = 5, Map? map}) async {

    // Defina la URI para hacer las peticiones al servicio
    // var uri = Uri.https();

    // Implemente la solicitud 
    // final response = await http.get();

    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      final List<PublicJob> jobs = [];
      for (var job in res['jobs']) {
        jobs.add(PublicJob.fromJson(job));
      }
      return jobs;
    } else {
      throw Exception('Error on request');
    }
  }
}
