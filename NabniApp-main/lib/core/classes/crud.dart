import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'statusrequest.dart';

class Crud {
  Future<Either<StatusRequest, Map>> postData(String url, Map data) async {
    try {
      var respons = await http.post(Uri.parse(url), body: data);
      if (respons.statusCode == 200 || respons.statusCode == 201) {
        Map responsBody = jsonDecode(respons.body);
        print(responsBody);
        return Right(responsBody);
      } else {
        return const Left(StatusRequest.serverFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverFailure);
    }
  }
}
