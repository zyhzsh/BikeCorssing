import 'dart:async';
import 'package:flutter/rendering.dart';
import 'package:BikeCrossing/models/location_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../models/bike_model.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen(
      {Key? key, required this.startLocation, required this.bike})
      : super(key: key);

  final LocationModel startLocation;
  final BikeModel bike;

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  BitmapDescriptor startMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationMarker = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentMarker = BitmapDescriptor.defaultMarker;
  Location location = Location();
  late StreamSubscription<LocationData> locationSubscription;

  void addCustomIcon() async {
    BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(
          size: Size(20, 20),
        ), "assets/images/location_marker_start.png")
        .then(
          (icon) {
        setState(() {
          startMarker = icon;
        });
      },
    );
    BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(
          size: Size(20, 20),
        ), "assets/images/location_marker_destination.png")
        .then(
          (icon) {
        setState(() {
          destinationMarker = icon;
        });
      },
    );
    BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(

        ), "assets/images/location_marker_current.png")
        .then(
          (icon) {
        setState(() {
          currentMarker = icon;
        });
      },
    );


    // Uint8List destinationMarkerByte =
    //     (await NetworkAssetBundle(Uri.parse(widget.bike.images[0]))
    //             .load(widget.bike.images[0]))
    //         .buffer
    //         .asUint8List();
    //
    // setState(() {
    //   destinationMarker = BitmapDescriptor.fromBytes(destinationMarkerByte);
    // });
  }

  void getCurrentLocation() async {
    location.getLocation().then((location) => {
          setState(() {
            currentLocation = location;
          })
        });
    GoogleMapController googleMapController = await _controller.future;

    locationSubscription =
        location.onLocationChanged.listen((LocationData currentLocation) {
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target:
                LatLng(currentLocation.latitude!, currentLocation.longitude!),
            zoom: 13.5,
          ),
        ),
      );

      setState(() {
        this.currentLocation = currentLocation;
      });
    });
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyC9bn22ZcoAiJVJJAEYTziTrdkCDuV-F1I',
      PointLatLng(
          widget.startLocation.latitude, widget.startLocation.longitude),
      PointLatLng(widget.bike.lastRegisteredLocation.latitude,
          widget.bike.lastRegisteredLocation.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {});
    }
  }
  @override
  void initState() {
    getCurrentLocation();
    getPolyPoints();
    addCustomIcon();
    super.initState();
  }
  @override
  void dispose() {
    locationSubscription.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocation == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GoogleMap(
              myLocationButtonEnabled: true,
              mapType: MapType.hybrid,
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.startLocation.latitude,
                    widget.startLocation.longitude),
                zoom: 10,
              ),
              polylines: {
                Polyline(
                  polylineId: const PolylineId('route'),
                  color: Theme.of(context).colorScheme.primary,
                  points: polylineCoordinates,
                  width: 6,
                ),
              },
              markers: {
                Marker(
                  markerId: const MarkerId('start'),
                  position: LatLng(widget.startLocation.latitude,
                      widget.startLocation.longitude),
                  icon: startMarker,
                ),
                Marker(
                  markerId: const MarkerId('current'),
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                  icon: currentMarker,
                ),
                Marker(
                  markerId: const MarkerId('destination'),
                  position: LatLng(widget.bike.lastRegisteredLocation.latitude,
                      widget.bike.lastRegisteredLocation.longitude),
                  icon: destinationMarker,
                ),
              },
              onMapCreated: (mapController) {
                _controller.complete(mapController);
              },
            ),
    );
  }
}
