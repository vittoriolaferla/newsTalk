import 'package:flutter/material.dart';

class AlertLoginDialog extends StatefulWidget {
  AlertLoginDialog({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  State<AlertLoginDialog> createState() => _AlertLoginDialogState();
}

class _AlertLoginDialogState extends State<AlertLoginDialog> {
  @override
  Widget build(BuildContext context) {
    final data = widget.text; // Rimuovi 'const' qui
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.warning,
            color: Colors.black,
            size: 50.0,
          ),
          const SizedBox(height: 10.0),
          Text(
            data,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
