import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:layout/models/chuck_response.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppTitle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }

}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);




  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late var myQuote = "Press the button";

  void makeNetworkCall(String category) async {
    try {
      var response = await Dio().get('https://api.chucknorris.io/jokes/random?category=animal');
      var chuckie = ChuckResponse.fromJsonMap(response.data);
      String quote = chuckie.value.toString();
      updateText(quote);

    } catch (e) {
      print(e);
    }

  }

  updateText(String quote) {
    setState(() {
      myQuote = quote.toString();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chuck Norris Trivia'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(myQuote,
              style: const TextStyle(fontSize: 26),
              textAlign: TextAlign.center,),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: MaterialButton(
                  child: const Text('Tap'),
                    onPressed: () {
                      makeNetworkCall('animal');

                    },
                color: Colors.blue,
                textColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}