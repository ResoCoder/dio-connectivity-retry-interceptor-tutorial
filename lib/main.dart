import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Dio dio;
  String firstPostTitle;
  bool isLoading;

  @override
  void initState() {
    super.initState();
    dio = Dio();
    firstPostTitle = 'Press the button 👇';
    isLoading = false;

    // TODO: Add the interceptor to Dio
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (isLoading)
              CircularProgressIndicator()
            else
              Text(
                firstPostTitle,
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            RaisedButton(
              child: Text('REQUEST DATA'),
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                final response =
                    await dio.get('https://jsonplaceholder.typicode.com/posts');
                setState(() {
                  firstPostTitle = response.data[0]['title'] as String;
                  isLoading = false;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
