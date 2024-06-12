import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkOpenerScreen extends StatelessWidget {
  final Uri url = Uri.parse("https://www.google.com");  // Use Uri.parse for proper URL handling

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Open Link"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _launchURL(context, url),
          child: Text('Open Link'),
        ),
      ),
    );
  }

  Future<void> _launchURL(BuildContext context, Uri url) async {
    if (!await canLaunchUrl(url)) {  // Use canLaunchUrl
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not launch $url'),
        ),
      );
      return;
    }
    if (!await launchUrl(url)) {  // Use launchUrl
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to launch $url'),
        ),
      );
    }
  }
}
