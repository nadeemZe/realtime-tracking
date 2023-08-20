import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:tracking_map/services/get_polyline_points.dart';


class TrackingPage extends StatefulWidget{
  const TrackingPage({super.key});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {

  final Completer<GoogleMapController>_controller=Completer();

  static const LatLng source=LatLng(35.5292967, 35.8064094);
  static const LatLng destination=LatLng(35.5492967, 35.8064094);

  List <LatLng> polyCoordinates=[];
  LocationData? myLocation;

   getMyLocation()async{

    Location location = Location();
    location.getLocation().then((location) {
      myLocation=location;
      setState(() {});
    });
    GoogleMapController googleMapController=await _controller.future;
    location.onLocationChanged.listen((newLocation) {
      myLocation=newLocation;
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
               CameraPosition(zoom:15,target: LatLng(newLocation.latitude!,newLocation.longitude!))));
      setState(() {});
    });
  }

  getPolylinePoints()async{

    PolyLinePoints polyLinePoints=PolyLinePoints();
    polyCoordinates=await polyLinePoints.getPolylinePoints(source: source, destination: destination);
      setState(() {});

  }

  @override
  void initState() {
    super.initState();
    getMyLocation();
    getPolylinePoints();
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      body: myLocation==null
          ?const Center(child: CircularProgressIndicator(color: Colors.deepPurple,))
          :GoogleMap(
            initialCameraPosition:CameraPosition(
                target: LatLng(myLocation!.latitude!,myLocation!.longitude!),
                zoom: 15
            ) ,
            polylines: {
              Polyline(polylineId: const PolylineId('route'),points: polyCoordinates,color: Colors.deepPurple,width: 5),
           },
           markers: {
             Marker(markerId: const MarkerId('myLocation'),position: LatLng(myLocation!.latitude!,myLocation!.longitude!),),
             const Marker(markerId: MarkerId('source'),position: source),
             const Marker(markerId: MarkerId('destination'),position: destination),
          },
          onMapCreated: (mapController){
              _controller.complete(mapController);
          },

      ),
    );
  }
}