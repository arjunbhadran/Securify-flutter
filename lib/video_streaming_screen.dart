import 'package:flutter/material.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';

class VideoStreamingScreen extends StatelessWidget {
  final String streamUrl = "http://192.168.180.192:8000/stream.mjpg";  // MJPEG stream URL

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CCTV Video Stream"),
        backgroundColor: Colors.blueGrey, // Custom color for AppBar
      ),
      body: Container(
        color: Colors.black, // Set a dark background to enhance video visibility
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8), // Add padding around the video
                  child: Mjpeg(
                    stream: streamUrl,
                    isLive: true,
                    error: (context, error, stack) {
                      print(error);  // Log errors
                      return Center(
                        child: Text(
                          "Failed to load video stream.",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
                    timeout: const Duration(seconds: 30),  // Timeout for the stream
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Live feed from Raspberry Pi Camera',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
