import 'dart:convert';
import 'accessToken.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TopTracks extends StatefulWidget {
  @override
  _TopTracksState createState() => _TopTracksState();
}

class _TopTracksState extends State<TopTracks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Tracks'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        child: RaisedButton(
          child: Text('Get Data'),
          onPressed: () async {
            await getTracks();
          },
        ),
      ),
    );
  }
}

Future<void> getTracks() async {
  var _accessToken = access_token['access_token'];
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $_accessToken',
  };

  var params = {
    'offset': '0',
  };
  var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');

  var res = await http.get('https://api.spotify.com/v1/me/top/tracks?$query',
      headers: headers);
  if (res.statusCode != 200)
    throw Exception('http.get error: statusCode= ${res.statusCode}');

  Map top_tracks = await json.decode(res.body.toString());
  for (int i = 0; i < 20; i++) {
    var artists_map = top_tracks['items'][i]['name'];

    // artists_map = artists_map[i];
    // artists_map = artists_map['name'];
    print(artists_map.toString());
  }
}
