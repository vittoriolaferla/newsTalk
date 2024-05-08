import 'dart:async';
import 'package:dima/config.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../managers/article_provider.dart';
import '../model/article.dart';
import '../utils/utilsFunctionsMapPage.dart';

class MapPage extends StatefulWidget {
  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  LatLngBounds? currentBounds; // This will hold the current map bounds
  List<Article> articles = [];
  List<Article> visibleArticles = [];
  double zoomVal = 5.0;
  CameraPosition _lastKnownPosition =
      CameraPosition(target: LatLng(45.4642, 9.1900), zoom: 12);
  CameraPosition _initialCameraPosition =
      CameraPosition(target: LatLng(45.4642, 9.1900), zoom: 12);
  String selectedCategory = "All";
  final List<String> categories = [
    'All',
    'General',
    'Sports',
    'Entertainment',
    'Health',
    "Business",
    "Technology"
  ];

  @override
  void initState() {
    super.initState();
    _determinePosition().then((_) {
      _loadAllMarkers(); // Ensure markers are loaded after position is determined.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map Page"),
        actions: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min, // Added to prevent expanding beyond the TextField
            children: [
              Text(selectedCategory, style: TextStyle(color: Colors.black)), // Display selected category
              PopupMenuButton<String>(
                icon: const Icon(Icons.arrow_drop_down),
                onSelected: (value) {
                  _onCategorySelected(value);
                },
                itemBuilder: (BuildContext context) {
                  return categories.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          ),
        ],
      ),
      body:  LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Column(children:[
        Container(
          height: constraints.maxHeight*0.65,
          child:Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          //zoomminusfunction(_lastKnownPosition, zoomVal, _controller),
          //zoomplusfunction(_lastKnownPosition, zoomVal, _controller),
        ],
      ),),
      Container(
        height: constraints.maxHeight*0.35,
        child: 
       showArticlesCard(_controller, visibleArticles, constraints.maxHeight*0.35, constraints.maxWidth)
      ),
      ]
      );
    })
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initialCameraPosition, // Milan coordinates
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onCameraIdle: () {
          _updateMapBounds(); // Call your method to update bounds here
        },
        onCameraMove: (CameraPosition position) {
          _lastKnownPosition = position;
        },
        markers: _markers,
      ),
    );
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    Marker currentPositionMarker = Marker(
      markerId: MarkerId("current_position"),
      position: LatLng(position.latitude, position.longitude),
      infoWindow: InfoWindow(title: "Your Location"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );

    setState(() {
      _initialCameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14.0,
      );
      _markers.add(currentPositionMarker);
    });

    final GoogleMapController mapController = await _controller.future;
    mapController
        .animateCamera(CameraUpdate.newCameraPosition(_initialCameraPosition));
  }

  bool _isWithinBounds(LatLng point, LatLngBounds bounds) {
    bool withinLat = (point.latitude <= bounds.northeast.latitude) &&
        (point.latitude >= bounds.southwest.latitude);
    bool withinLng = (point.longitude <= bounds.northeast.longitude) &&
        (point.longitude >= bounds.southwest.longitude);
    return withinLat && withinLng;
  }

  bool _isInSelectedCategory(Article article, String selectedCategory) {
    if (article.category == selectedCategory.toLowerCase() ||
        selectedCategory == "All") {
      return true;
    } else {
      return false;
    }
  }

  void _updateVisibleArticles() {
    if (currentBounds == null) return;
    List<Article> filteredArticles = articles.where((article) {
      // Adjust this line to use the new method
      return _isWithinBounds(article.coordinates, currentBounds!) &&
          _isInSelectedCategory(article, selectedCategory);
    }).toList();

    setState(() {
      visibleArticles = filteredArticles;
    });
  }

  Future<void> _updateMapBounds() async {
    final GoogleMapController controller = await _controller.future;
    LatLngBounds bounds =
        await controller.getVisibleRegion(); // This calls the built-in method.
    setState(() {
      currentBounds = bounds; // Updates your currentBounds with the new bounds.
    });
    _updateVisibleArticles(); // Call this to filter articles based on the new bounds.
  }

  Future<void> _loadAllMarkers() async {
    List<List<Article>> groupedArticles = await retrieveArticles();
    articles = groupedArticles.expand((group) => group).toList();
    Set<Marker> markers = articles.asMap().entries.map((entry) {
      int idx = entry.key;
      Article article = entry.value;
      return Marker(
        markerId: MarkerId('article_$idx'),
        position: article.coordinates,
        onTap: () => showCustomDialogWithArticleInfo(article, context),
        // Hide the default InfoWindow by not setting it or by providing an empty title
        infoWindow: InfoWindow(title: ''),
      );
    }).toSet();

    setState(() {
      _markers.addAll(markers);
    });
  }

  void _onCategorySelected(String value) {
    setState(() {
      selectedCategory = value;
      _filterMarkersAndArticles();
    });
  }

  void _filterMarkersAndArticles() {
    // Filter articles based on the selected category.
    List<Article> filteredArticles = articles
        .where((article) => _isInSelectedCategory(article, selectedCategory))
        .toList();

    // Create a new set of markers for the filtered articles.
    Set<Marker> filteredMarkers = filteredArticles.asMap().entries.map((entry) {
      int idx = entry.key;
      Article article = entry.value;
      return Marker(
        markerId: MarkerId('article_$idx'),
        position: article.coordinates,
        onTap: () => showCustomDialogWithArticleInfo(article, context),
        // Hide the default InfoWindow by not setting it or by providing an empty title
        infoWindow: InfoWindow(title: ''),
      );
    }).toSet();

    setState(() {
      _markers.clear();
      _markers.addAll(filteredMarkers);
      visibleArticles = filteredArticles;
    });
  }
}
