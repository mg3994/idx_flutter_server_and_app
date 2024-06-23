import 'dart:convert';

import 'package:flutter/material.dart';

import 'dart:io';
// import 'package:args/args.dart'; // can't use any of those args and  => Platform.env // string from env will not work too



void main(List<String> arguments) {
    // Initialize the argument parser
  // var parser = ArgParser();
  // parser.addOption('port', abbr: 'p', defaultsTo: Platform.environment['PORT'] ??'9002', help: 'Port to listen on');
  // parser.addOption('host', abbr: 'h', defaultsTo: Platform.environment['WEB_HOST'] ?? '0.0.0.0', help: 'Host address to bind to');

  // Parse the arguments
  // var results = parser.parse(arguments);

  // Extract the port and host values from parsed arguments
  // var port = int.parse(results['port']);
  var host = Platform.environment['WEB_HOST'] ?? "idx-testserrrc-1719163323306.cluster-bs35cdu5w5cuaxdfch3hqqt7zm.cloudworkstations.dev";
 var port = 9002; //change thihese 2 + 1 access token
  // var host 
  runApp( MyApp(
     PORT: port,
 WEB_HOST:host,
  ));
}

class MyApp extends StatelessWidget {
 final dynamic PORT;
 final dynamic WEB_HOST;
  const MyApp({super.key, this.PORT = 9002, this.WEB_HOST});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MyHomePage(title: 'Flutter Demo Home Page',    PORT: PORT,
 WEB_HOST:WEB_HOST,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final dynamic PORT;
 final dynamic WEB_HOST;
  const MyHomePage({super.key, required this.title, this.PORT, this.WEB_HOST});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _counter = "0";
  String access_token = "GENERATE your Own"; //ctrl +shift + p => search idx => generate access token

  void _incrementCounter() async {
    //8087 is port and we have to replace that everytime as per our app, may be whole url (remember the idx uses https , say secured) else SocketException: Connection refused (OS Error:Connection refused, errno = 111)
      final url = 'https://${widget.PORT}-${widget.WEB_HOST}'; // Change the port number if needed
  final httpClient = HttpClient();

  try {
    final request = await httpClient.getUrl(Uri.parse(url))..headers.set('Authorization', 'Bearer $access_token');
    final response = await request.close();
    
    if (response.statusCode == HttpStatus.ok) {
      final responseBody = await response.transform(utf8.decoder).join();
      _counter = responseBody;
      print('Response: $responseBody');
    } else {
      _counter = response.statusCode.toString();
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    _counter = e.toString();
    print('Exception: $e');
  } finally {
    httpClient.close();
  }
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              _counter,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
