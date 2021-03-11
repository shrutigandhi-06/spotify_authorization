import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;
import 'package:webview_url/top_tracks.dart';
import 'screen2.dart';
import 'top_tracks.dart';

String code;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(),
      routes: {
        //'/': (context) => MyHomePage(),
        '/screen2': (context) => Screen2(),
        '/screen3': (context) => TopTracks(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  StreamSubscription<String> _onUrlChanged;

  @override
  void initState() {
    super.initState();

    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen(
      (String url) async {
        if (mounted) {
          var res = await http.get(url);
          print('Current URL: $url');
          print('Status code: ' + res.request.headers.toString());
          if (res.request.url.queryParameters['code'].isNotEmpty) {
            code = res.request.url.queryParameters['code'];
            print('Authorization Code: ' + code);
            flutterWebviewPlugin.close();
            Navigator.pushNamed(context, '/screen2');
          }
          // if (res.statusCode != 200)
          //   throw Exception('http.get error: statusCode= ${res.statusCode}');
        }
      },
    );
  }

  @override
  void dispose() {
    _onUrlChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      key: scaffoldKey,
      url:
          'https://accounts.spotify.com/authorize?client_id=5a9756f5bf2d45398a737632c8aa867b&response_type=code&redirect_uri=https://musically-mine.000webhostapp.com/index.php&scope=user-read-private%20user-read-email%20user-top-read&show_dialog=true',
      hidden: true,
      appBar:
          AppBar(backgroundColor: Colors.indigo, title: Text("Current Url")),
    );
  }
}
