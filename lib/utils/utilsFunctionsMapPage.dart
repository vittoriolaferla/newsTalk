import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/article.dart';
import '../widgets/articleCard/articleCardHome.dart';
import '../widgets/articleCard/articleCardMap.dart';

Widget zoomminusfunction(CameraPosition _lastKnownPosition, double zoomVal,
    Completer<GoogleMapController> _controller) {
  return Align(
    alignment: Alignment.topLeft,
    child: IconButton(
      icon: Icon(FontAwesomeIcons.searchMinus,
          color: Color.fromARGB(255, 9, 0, 21)),
      onPressed: () {
        _minus(_lastKnownPosition, zoomVal, _controller);
      },
    ),
  );
}

Widget zoomplusfunction(CameraPosition _lastKnownPosition, double zoomVal,
    Completer<GoogleMapController> _controller) {
  return Align(
    alignment: Alignment.topRight,
    child: IconButton(
      icon: Icon(FontAwesomeIcons.searchPlus,
          color: Color.fromARGB(255, 0, 0, 0)),
      onPressed: () {
        _plus(_lastKnownPosition, zoomVal, _controller);
      },
    ),
  );
}

Future<void> _minus(CameraPosition _lastKnownPosition, double zoomVal,
    Completer<GoogleMapController> _controller) async {
  final GoogleMapController controller = await _controller.future;
  double newZoom = _lastKnownPosition.zoom - 1; // Decrease zoom level
  controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
    target: _lastKnownPosition.target,
    zoom: newZoom,
  )));
}

Future<void> _plus(CameraPosition _lastKnownPosition, double zoomVal,
    Completer<GoogleMapController> _controller) async {
  final GoogleMapController controller = await _controller.future;
  double newZoom = _lastKnownPosition.zoom + 1; // Increase zoom level
  controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
    target: _lastKnownPosition.target,
    zoom: newZoom,
  )));
}

Widget showArticlesCard(Completer<GoogleMapController> _controller,
    List<Article> visibleArticles, double height, double width) {
  return Align(
    alignment: Alignment.bottomLeft,
    child: Container(
      width: width,
      child: visibleArticles.isEmpty
          ? Center(
              child: Text("No articles in this part of the map", 
                          style: TextStyle(fontSize: 16, color: Colors.black))
            )
          : Swiper(
        itemCount: visibleArticles.length,
        itemBuilder: (context, index) {
                Article article = visibleArticles[index];
                return SizedBox(
                  width: width * 0.4,
                  child: ArticleCardMap(
                    article: article,
                    onLocationTap: (lat, long) => _gotoLocation(lat, long, _controller),
                    width: width,
                    height:height,
                  )
                );
              },
        itemWidth: width * 0.6,
        itemHeight: height,
        viewportFraction: 0.5,
        scale: 0.9,
        loop: false,
            ),
    ),
  );
}

void _gotoLocation(
    double lat, double long, Completer<GoogleMapController> _controller) {
  _controller.future.then((GoogleMapController mapController) {
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  });
}

void showCustomDialogWithArticleInfo(Article article, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
                backgroundColor: Colors.transparent, // Makes the dialog itself transparent

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8, // Maximum height
          ),
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ArticleCardHome(
                      article: article,
                      height: MediaQuery.of(context).size.height * 0.7, // Fixed syntax
                    ),
                  ],
                ),
              
            ),
            Positioned(
              left: 20,
              top:
                  20, // Position slightly outside the top boundary of the dialog
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Set the background color to white
                  borderRadius: BorderRadius.circular(
                      30), // Circular border radius for a rounded icon button
                  boxShadow: [
                    // Optional: Adds a subtle shadow for better visual separation
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 1), // Changes position of shadow
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.times, // Updated icon to 'times'
                    color: Colors.black, // Icon color
                    size: 15, // Icon size
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
