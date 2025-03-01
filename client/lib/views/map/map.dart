import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maps Donation App',
      debugShowCheckedModeBanner: false,
      home: const MapScreen(),
    );
  }
}

// Clase para representar un centro de donación
class DonationCenter {
  final String id;
  final LatLng position;
  final String title;
  final String snippet;

  DonationCenter({
    required this.id,
    required this.position,
    required this.title,
    required this.snippet,
  });
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  final TextEditingController _searchController = TextEditingController();
  
  // Posición por defecto hasta obtener la ubicación actual
  static final CameraPosition _defaultPosition = const CameraPosition(
    target: LatLng(-34.903280, -56.188160),
    zoom: 11.0,
  );

  List<DonationCenter> _centers = [];
  String? _selectedCenter;
  LatLng? _userLocation;
  List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _fetchDonationCenters();
  }

  // ubicación actual
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Para activar 
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _userLocation = LatLng(position.latitude, position.longitude);
    });

    // Si el mapa ya está creado, centramos la cámara
    if (mapController != null && _userLocation != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLng(_userLocation!),
      );
    }
  }

  // Se obtienen los centros de donación
  Future<void> _fetchDonationCenters() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('isCentro', isEqualTo: 2)
          .get();

      List<Marker> newMarkers = [];
      List<DonationCenter> centers = [];

      for (var doc in snapshot.docs) {
        String address = doc.get('address');
        String centerName = doc.get('centerName');
        String snippet = doc.data().toString().contains('snippet')
            ? (doc.get('snippet') ?? "Centro de Donación")
            : "Centro de Donación";

        try {
          List<Location> locations = await locationFromAddress(address);
          if (locations.isNotEmpty) {
            LatLng position =
                LatLng(locations.first.latitude, locations.first.longitude);
            
            centers.add(DonationCenter(
              id: doc.id,
              position: position,
              title: centerName,
              snippet: snippet,
              )
            );

            newMarkers.add(
              Marker(
                markerId: MarkerId(doc.id),
                position: position,
                infoWindow: InfoWindow(title: centerName, snippet: snippet),
              ),
            );
          }
        } catch (e) {
          print("-----------------------Error al geocodificar la dirección $address: $e-----------------------");
        }
      }

      print("----------------Centros de donación cargados: ${_markers.length}------------------");
      setState(() {
        _centers = centers;
        _markers = newMarkers;
      });
      if (mapController != null && _centers.isNotEmpty) {
        mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(_centers.first.position, 12),
        );
      }
    } catch (e) {
      print("----------------------------------Error al obtener centros de donación: $e----------------");
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (_userLocation != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLng(_userLocation!),
      );
    }
  }

  // Marcadores de ubi actual y de centros
  Set<Marker> _buildMarkers() {
    final markers = <Marker>{};

    // Marcadores de centros
    for (var center in _centers) {
      bool isSelected = _selectedCenter == center.id;
      markers.add(
        Marker(
          markerId: MarkerId(center.id),
          position: center.position,
          infoWindow: InfoWindow(
            title: center.title,
            snippet: center.snippet,
          ),
          icon: 
            isSelected
              ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet)
              : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
          onTap: (){
            setState(() {
              _selectedCenter = center.id;
            });
          },
        ),
      );
    }
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            zoomControlsEnabled: false,
            compassEnabled: false,
            initialCameraPosition: _userLocation != null
                ? CameraPosition(target: _userLocation!, zoom: 14.0)
                : _defaultPosition,
            markers: _buildMarkers(),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          // Busacdor
          Positioned(
            left: 16.0,
            right: 16.0,
            bottom: 670.0,
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Color(0xFF9D4EDD)),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'Buscar centros',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          // Implementa la lógica de búsqueda según tus necesidades
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // Biton
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Scaffold(

          );
        },
        shape: CircleBorder(),
        backgroundColor: Color(0xFF9D4EDD),
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
        child: const Icon(Icons.done),
      ),
    );
  }
}
