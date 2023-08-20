import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../constant.dart';


class PolyLinePoints{


  Future<List <LatLng>> getPolylinePoints({required LatLng source,required LatLng destination})async{
    List <LatLng>polyCoordinates=[];
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey,
        PointLatLng(source.latitude, source.longitude),
        PointLatLng(destination.latitude, destination.longitude)
    );
    if(result.points.isNotEmpty){
     for (var point in result.points) {
        polyCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
   return polyCoordinates;
  }



}