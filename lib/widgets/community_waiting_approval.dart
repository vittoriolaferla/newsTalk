import 'package:flutter/material.dart';
import 'package:dima/pages/community_list_page.dart';

class WaitingForApproval extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void onBackButtonPressed() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CommunityListPage()),
      );
    }

    return Container(
      color: Colors.black.withOpacity(0.5), // Opacity for the overlay
      child: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.hourglass_empty,
                size: 48,
                color: Colors.grey[600],
              ),
              SizedBox(height: 20),
              Text(
                'Richiesta di accesso inviata!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Attendi l\'approvazione da parte dell\'amministratore della community.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: onBackButtonPressed,
                child: Text('Torna alla lista delle community'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
