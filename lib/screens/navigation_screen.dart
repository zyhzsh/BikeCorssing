import 'dart:io' show File, Platform;
import 'dart:async';
import 'package:BikeCrossing/screens/qrscanner_screen.dart';
import 'package:flutter/rendering.dart';
import 'package:BikeCrossing/models/location_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../models/bike_model.dart';
import '../providers/profile_provider.dart';

class NavigationScreen extends ConsumerStatefulWidget {
  const NavigationScreen(
      {Key? key, required this.startLocation, required this.bike})
      : super(key: key);

  final LocationModel startLocation;
  final BikeModel bike;

  @override
  ConsumerState<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends ConsumerState<NavigationScreen> {
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
            ),
            "assets/images/location_marker_start.png")
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
            ),
            "assets/images/location_marker_destination.png")
        .then(
      (icon) {
        setState(() {
          destinationMarker = icon;
        });
      },
    );



    // BitmapDescriptor.fromAssetImage(const ImageConfiguration(),
    //         "assets/images/location_marker_current.png")
    //     .then(
    //   (icon) {
    //     setState(() {
    //       currentMarker = icon;
    //     });
    //   },
    // );
   final avatarUrl = ref.read(userProfileProvider.notifier).state.avatarUrl;
    Uint8List destinationMarkerByte =
        (await NetworkAssetBundle(Uri.parse(avatarUrl))
                .load(avatarUrl))
            .buffer
            .asUint8List();

    setState(() {
      currentMarker = BitmapDescriptor.fromBytes(destinationMarkerByte);
    });
  }

  void initCameraPosition()async{
    location.getLocation().then((location) => {
      setState(() {
        currentLocation = location;
      })
    });
    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
          zoom: 13.5,
        ),
      ),
    );
  }

  void getCurrentLocation() async {
    GoogleMapController googleMapController = await _controller.future;
    locationSubscription =
        location.onLocationChanged.listen((LocationData currentLocation) {
      // googleMapController.animateCamera(
      //   CameraUpdate.newCameraPosition(
      //     CameraPosition(
      //       target:
      //           LatLng(currentLocation.latitude!, currentLocation.longitude!),
      //       zoom: 13.5,
      //     ),
      //   ),
      // );
      setState(() {
        this.currentLocation = currentLocation;
      });
    });
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    await dotenv.load(fileName: ".env");
    final IOSAPIKEY = dotenv.env['GOOGLEMAPS_IOS_API_KEY'];
    final ANDROIDAPIKEY = dotenv.env['GOOGLEMAPS_ANDROID_API_KEY'];


    String MapApiKey = '';

    if (Platform.isAndroid) {
      MapApiKey = ANDROIDAPIKEY!;}
    else if (Platform.isIOS) {
      MapApiKey = IOSAPIKEY!;
    }

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      MapApiKey,
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

  void _scanQr() {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => QrScannerScreen(bike: widget.bike)),
    );
  }

  @override
  void initState() {
    initCameraPosition();
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: _scanQr,
        child: const Icon(Icons.qr_code_scanner, color: Colors.white),
      ),
      body: currentLocation == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
            children: [
              GoogleMap(
                  myLocationButtonEnabled: true,
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
                      infoWindow: InfoWindow(
                        title: widget.bike.name,
                        snippet: widget.bike.lastRegisteredLocation.address,
                      ),
                      icon: destinationMarker,
                    ),
                  },
                  onMapCreated: (mapController) {
                    _controller.complete(mapController);
                  },
                ),
              Positioned(
                top: 70,
                left: 20,
                child: ElevatedButton.icon(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Icons.arrow_circle_left_outlined), label: Text('Back')),
              ),
            ],
          ),
    );
  }
}
