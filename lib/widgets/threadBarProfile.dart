import 'package:flutter/material.dart';

class ThreadBarProfile extends StatelessWidget {
  final String threadName;

  const ThreadBarProfile({Key? key, required this.threadName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          bottomLeft: Radius.circular(12.0),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.circle, color: Colors.white, size: 12.0),
          SizedBox(width: 8.0),
          Text(
            threadName,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
