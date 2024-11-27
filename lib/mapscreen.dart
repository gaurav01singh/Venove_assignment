import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location123/member.dart';


//Map Screen where all members' last location or current location will be shown
class MapScreen extends StatefulWidget {
  final List<Member> members;

  const MapScreen({
    super.key,
    required this.members,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _createCustomMarkers();
  }

  Future<void> _createCustomMarkers() async {
    for (var member in widget.members) {
      final BitmapDescriptor customMarker = await _getCustomMarker(member.imageUrl);

      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId(member.id),
            position: member.currentLocation,
            icon: customMarker,
            infoWindow: InfoWindow(
              title: member.name,
              snippet: member.status == 'WORKING'
                  ? 'Current Location'
                  : 'Last Location',
            ),
          ),
        );
      });
    }
  }

 Future<BitmapDescriptor> _getCustomMarker(String imageUrl) async {
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  const double size = 120.0; 

  // Draw the blue border circle
  final Paint borderPaint = Paint()
    ..color = Colors.blue
    ..style = PaintingStyle.fill
    ..isAntiAlias = true;
  canvas.drawCircle(
    const Offset(size / 2, size / 2),
    size / 2,
    borderPaint,
  );

  // Draw the white inner circle
  final Paint backgroundPaint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill
    ..isAntiAlias = true;
  canvas.drawCircle(
    const Offset(size / 2, size / 2),
    (size / 2) - 5, 
    backgroundPaint,
  );

  // Loading images from assets
  final ui.Image image = await _loadImage(imageUrl);

  const double imageSize = (size - 10); 
  final double imageWidth = image.width.toDouble();
  final double imageHeight = image.height.toDouble();

  final Rect srcRect = Rect.fromLTWH(0, 0, imageWidth, imageHeight);
  const Rect dstRect = Rect.fromLTWH(5, 5, imageSize, imageSize);

  final Paint imagePaint = Paint()..isAntiAlias = true;

  canvas.save();
  canvas.clipPath(
    Path()..addOval(Rect.fromCircle(center: const Offset(size / 2, size / 2), radius: (size / 2) - 5)),
  );

  canvas.drawImageRect(image, srcRect, dstRect, imagePaint);
  canvas.restore();

  final ui.Image markerImage = await pictureRecorder.endRecording().toImage(size.toInt(), size.toInt());
  final ByteData? byteData = await markerImage.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
}


  Future<ui.Image> _loadImage(String imageUrl) async {
    final Completer<ui.Image> completer = Completer();

    // Load image as an asset
    final ImageStream imageStream = AssetImage(imageUrl).resolve(const ImageConfiguration());
    imageStream.addListener(ImageStreamListener((ImageInfo imageInfo, bool _) {
      completer.complete(imageInfo.image);
    }));

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    final LatLngBounds bounds = _getBounds(widget.members);

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Members Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
            (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
          ),
          zoom: 10,
        ),
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          controller.animateCamera(
            CameraUpdate.newLatLngBounds(bounds, 50.0),
          );
        },
      ),
    );
  }

  LatLngBounds _getBounds(List<Member> members) {
    double minLat = 90.0;
    double maxLat = -90.0;
    double minLng = 180.0;
    double maxLng = -180.0;

    for (var member in members) {
      if (member.currentLocation.latitude < minLat) minLat = member.currentLocation.latitude;
      if (member.currentLocation.latitude > maxLat) maxLat = member.currentLocation.latitude;
      if (member.currentLocation.longitude < minLng) minLng = member.currentLocation.longitude;
      if (member.currentLocation.longitude > maxLng) maxLng = member.currentLocation.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }
}
