import 'dart:convert';
import 'package:http/http.dart' as http;
import 'main.dart';

void getAccessToken() async {
  print('Code in access token:' + code);

  var headers = <String, String>{
    'Content-Type': 'application/x-www-form-urlencoded',
    'Accept': '*/*',
    'Authorization': 'Basic ' +
        'NWE5NzU2ZjViZjJkNDUzOThhNzM3NjMyYzhhYTg2N2I6MTllMDZmMWZmNDY4NDZmMTkyZjFkZmQ1YmExYzA4ZjY=',
  };

  var data = {
    'grant_type': 'authorization_code',
    'code': code,
    'redirect_uri': 'https://musically-mine.000webhostapp.com/index.php'
  };

  print(headers);
  var res = await http.post('https://accounts.spotify.com/api/token',
      headers: headers, body: data, encoding: Encoding.getByName("utf-8"));

  if (res.statusCode != 200)
    throw Exception('http.post error: statusCode= ${res.statusCode}');

  print(res.body);
}
