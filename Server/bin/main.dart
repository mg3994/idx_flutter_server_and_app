import 'dart:io';
import 'package:args/args.dart';

void main(List<String> arguments) async {
  // Initialize the argument parser
  var parser = ArgParser();
  parser.addOption('port', abbr: 'p', defaultsTo: '8087', help: 'Port to listen on');
  parser.addOption('host', abbr: 'h', defaultsTo: '0.0.0.0', help: 'Host address to bind to');

  // Parse the arguments
  var results = parser.parse(arguments);

  // Extract the port and host values from parsed arguments
  var port = int.parse(results['port']);
  var host = results['host'];
  

  // Bind the server to the specified host and port
  var server = await HttpServer.bind(host, port);
  print('Server running on http://$host:$port');

  await for (HttpRequest request in server) {
    // Log the request method and URI to the console
    print('${request.method}: ${request.uri}');

    // Set response headers (optional)
    // request.response.headers.set('Content-Type', 'text/plain');

    // Write a response to the client
    request.response.write('Hello, world! : Listing on http://$host:$port' '\n'  "https://$port-${Platform.environment['WEB_HOST']}" );
    await request.response.close();
  }
}
