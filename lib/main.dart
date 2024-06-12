// import 'package:flutter/material.dart';
// import 'sensor_status_screen.dart';
// import 'video_streaming_screen.dart';
// import 'package:web_socket_channel/io.dart';  // Import the WebSocket channel
// import 'package:open_weather_api_client/open_weather_api_client.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Sensor App',
//       theme: ThemeData(
//         primarySwatch: Colors.blueGrey,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MainScreen(),
//     );
//   }
// }
//
// class MainScreen extends StatelessWidget {
//   final IOWebSocketChannel channel = IOWebSocketChannel.connect('ws://192.168.196.192:8765');
//
//   MainScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Dashboard'),
//         backgroundColor: Colors.blueGrey[900],
//       ),
//       body: Container(
//         padding: EdgeInsets.all(20),
//         color: Colors.grey[200],
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton.icon(
//                 icon: Icon(Icons.security),
//                 label: Text('Go to Sensor Status'),
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.blueGrey[800],
//                   onPrimary: Colors.white,
//                   textStyle: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => SensorStatusScreen(
//                         channelUri: Uri.parse('ws://192.168.180.192:5678'),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton.icon(
//                 icon: Icon(Icons.videocam),
//                 label: Text('Open Video Stream'),
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.blueGrey[800],
//                   onPrimary: Colors.white,
//                   textStyle: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 ),
//                 onPressed: () {
//                   // Send a command to start the camera stream service before opening the video stream
//                   channel.sink.add('start_camera');
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => VideoStreamingScreen(),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'sensor_status_screen.dart';
import 'video_streaming_screen.dart';
import 'package:web_socket_channel/io.dart';  // Import the WebSocket channel
//import 'package:open_weather_api_client/open_weather_api_client.dart';
import 'doorsensor.dart';
import 'weather_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sensor App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  final IOWebSocketChannel channel = IOWebSocketChannel.connect('ws://192.168.196.192:8765');

  MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Dashboard'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.grey[200],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: Icon(Icons.security),
                label: Text('Motion sensor - Front yard'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey[800],
                  onPrimary: Colors.white,
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SensorStatusScreen(
                        channelUri: Uri.parse('ws://192.168.180.192:5678'),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                icon: Icon(Icons.videocam),
                label: Text('Open Video Stream'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey[800],
                  onPrimary: Colors.white,
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                onPressed: () {
                  // Send a command to start the camera stream service before opening the video stream
                  channel.sink.add('start_camera');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoStreamingScreen(),
                    ),
                  );
                },
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.security),
                label: Text('Front door sensor'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey[800],
                  onPrimary: Colors.white,
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoorStatusScreen(
                        channelUri: Uri.parse('ws://192.168.180.192:5679'),
                      ),
                    ),
                  );
                },
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.security),
                label: Text('Current Weather'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey[800],
                  onPrimary: Colors.white,
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WeatherScreen(
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}