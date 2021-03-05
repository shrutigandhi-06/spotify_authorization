import 'dart:convert';

import 'package:http/http.dart' as http;
import 'main.dart';

void getAccessToken() async {
  print('Code in access token:' + code);
  var headers = <String, String>{
    'Accept': 'application/json',
    'Content-type': 'application/x-www-form-urlencoded',
    'Authorization':
        'Basic NWE5NzU2ZjViZjJkNDUzOThhNzM3NjMyYzhhYTg2N2I6MTllMDZmMWZmNDY4NDZmMTkyZjFkZmQ1YmExYzA4ZjY=',
  };

  var data = jsonEncode(<String, String>{
    'grant_type': 'authorization_code',
    'code': code,
    'redirect_uri': 'http%3A%2F%2Fgoogle.com%2F',
  });
  // {
  //   'grant_type': 'authorization_code',
  //   'code': code,
  //   'redirect_uri': 'http%3A%2F%2Fgoogle.com%2F',
  // };

  // var res = await http.post('https://accounts.spotify.com/api/token',
  //     headers: headers, body: data);

  var res = await http.post(
      Uri.https('accounts.spotify.com%2Fapi\%\2\Ftoken', 'access_token'),
      headers: headers,
      body: data);

  if (res.statusCode != 200)
    throw Exception('http.post error: statusCode= ${res.statusCode}');
  print(res.body);
}
//https://accounts.spotify.com/authorize?client_id=5fe01282e44241328a84e7c5cc169165&response_type=code&redirect_uri=https%3A%2F%2Fexample.com%2Fcallback&scope=user-read-private%20user-read-email&state=34fFs29kd09
