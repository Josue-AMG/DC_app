import 'package:dc_app/components/AlberguesListComponentMap.dart';
import 'package:dc_app/services/AlbergueService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

void launchUrl(Uri url) async {
  if (await canLaunch(url.toString())) {
    await launch(url.toString());
  } else {
    throw 'Could not launch $url';
  }
}

class CurrentLocationIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
      child: Center(
        child: Icon(
          Icons.my_location,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}

class MapViewComponent extends StatefulWidget {
  @override
  _MapViewComponentState createState() => _MapViewComponentState();
}

class _MapViewComponentState extends State<MapViewComponent> {
  LatLng? _currentLocation;
  final MapController _mapController = MapController();
  double _currentZoom = 9.2;
  CentroDeVacunacion? _selectedAlbergue;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  void _zoomIn() {
    setState(() {
      _currentZoom = _currentZoom + 1;
      _mapController.move(_mapController.center, _currentZoom);
    });
  }

  void _zoomOut() {
    setState(() {
      _currentZoom = _currentZoom - 1;
      _mapController.move(_mapController.center, _currentZoom);
    });
  }

  void _showAlberguesList() async {
    final albergue = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AlberguesComponentMap(),
      ),
    );

    if (albergue != null) {
      setState(() {
        _selectedAlbergue = albergue;
      });
      _mapController.move(LatLng(albergue.lng, albergue.lat), 15.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    LatLng markerLocation = _selectedAlbergue != null
        ? LatLng(_selectedAlbergue!.lng, _selectedAlbergue!.lat)
        : LatLng(18.4787121, -69.8592574);

    return Scaffold(
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: _currentLocation ?? markerLocation,
          initialZoom: _currentZoom,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: markerLocation,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40.0,
                ),
              ),
              if (_currentLocation != null)
                Marker(
                  point: _currentLocation!,
                  child: CurrentLocationIcon(),
                ),
            ],
          ),
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'zoom_in',
            child: Icon(Icons.add),
            onPressed: _zoomIn,
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'location',
            child: Icon(Icons.home),
            onPressed: _showAlberguesList,
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'zoom_out',
            child: Icon(Icons.remove),
            onPressed: _zoomOut,
          ),
        ],
      ),
    );
  }
}