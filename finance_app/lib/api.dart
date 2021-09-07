import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const request_finance = "https://api.hgbrasil.com/finance?key=c012f8b5";

Future<Map> getData() async {
  http.Response response = await http.get(request_finance);
  return json.decode(response.body);
}
