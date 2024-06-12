import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:async';
import 'dart:convert';  // Import JSON codec

class SensorStatusScreen extends StatefulWidget {
  final Uri channelUri;

  SensorStatusScreen({required this.channelUri});

  @override
  _SensorStatusScreenState createState() => _SensorStatusScreenState();
}

class _SensorStatusScreenState extends State<SensorStatusScreen> {
  late WebSocketChannel channel;
  late Stream broadcastStream;
  StreamSubscription? streamSubscription;
  int retrySeconds = 2;  // Declare this variable to store the initial retry seconds
  String displayText = 'Waiting for data...';  // Initial text to display

  @override
  void initState() {
    super.initState();
    connectToWebSocket();
  }

  void connectToWebSocket() {
    channel = WebSocketChannel.connect(widget.channelUri);
    broadcastStream = channel.stream.asBroadcastStream();

    streamSubscription = broadcastStream.listen(
          (data) {
        updateDisplay(data);  // Update display based on data received
      },
      onError: (error) {
        setState(() {
          displayText = 'Error: $error';  // Display error message
        });
      },
      onDone: () {
        handleReconnect();  // Handle reconnection on done
      },
    );
  }

  void updateDisplay(String jsonData) {
    final data = json.decode(jsonData);
    setState(() {
      displayText = data['motion'] == 0 ? 'Motion not detected' : 'Motion detected';
    });
  }

  void handleReconnect() {
    if (!mounted) return;
    setState(() {
      displayText = 'Attempting to reconnect...';
    });
    Future.delayed(Duration(seconds: retrySeconds), () {
      connectToWebSocket();
      retrySeconds = retrySeconds * 2 > 64 ? 64 : retrySeconds * 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensor Status'),
        backgroundColor: Colors.blueGrey,  // Add a custom color to the AppBar
      ),
      body: Center(
        child: Card(
          elevation: 8.0,  // Add some elevation for a shadow effect
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              displayText,
              style: TextStyle(
                fontSize: 24,  // Increase font size for better readability
                color: Colors.blueGrey,  // Set text color
                fontWeight: FontWeight.bold,  // Make text bold
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    channel.sink.close();
    super.dispose();
  }
}
