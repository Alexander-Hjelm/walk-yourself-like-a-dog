import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _distance = Distance();

  final MapController _mapController = MapController();
  final List<LatLng> _route = [];
  StreamSubscription<Position>? _sub;
  double _meters = 0;
  String? _error;

  @override
  void initState() {
    super.initState();
    _startTracking();
  }

  Future<void> _startTracking() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      if (mounted) setState(() => _error = 'Location services are disabled.');
      return;
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      if (mounted) setState(() => _error = 'Location permission denied.');
      return;
    }

    _sub = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 3,
      ),
    ).listen(_onPosition, onError: (Object e) {
      if (mounted) setState(() => _error = '$e');
    });
  }

  void _onPosition(Position p) {
    final point = LatLng(p.latitude, p.longitude);
    setState(() {
      if (_route.isNotEmpty) {
        _meters += _distance.as(LengthUnit.Meter, _route.last, point);
      }
      _route.add(point);
    });
    _mapController.move(point, _mapController.camera.zoom);
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final current = _route.isEmpty ? null : _route.last;
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: current ?? const LatLng(59.3293, 18.0686),
            initialZoom: 17,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.walk_yourself_like_a_dog',
            ),
            PolylineLayer(
              polylines: [
                Polyline(points: _route, strokeWidth: 5, color: Colors.deepOrange),
              ],
            ),
            if (current != null)
              MarkerLayer(
                markers: [
                  Marker(
                    point: current,
                    width: 28,
                    height: 28,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: Card(
              margin: const EdgeInsets.all(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Text(
                  _error ??
                      (current == null
                          ? 'Waiting for GPS…'
                          : '${_meters.toStringAsFixed(0)} m'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
