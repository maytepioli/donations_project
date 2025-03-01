// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'pagina.dart';
// import 'dart:math';

// class MarcadorLugarPagina extends Pagina {
//   MarcadorLugarPagina() : super (const Icon(Icons.place), 'Marcadores');

//   @override
//   Widget build(BuildContext context) {
//     return MarcadorLugar();
//   }
// }

// class MarcadorLugar extends StatefulWidget {
//   const MarcadorLugar();

//   @override
//   State<StatefulWidget> createState() => MarcadorLugarState();
// }

// class MarcadorLugarState extends State<MarcadorLugar> {
//   MarcadorLugarState();

//   static final LatLng centro = const LatLng(-34.903280, -56.188160);

//   GoogleMapController? _controllerMap;
//   Map<MarkerId, Marker> _marcadores = <MarkerId, Marker>{};
//   MarkerId? _marcadorSeleccionado;
//   int _contadorIdMarcador = 1;
//   LatLng? _posicionMarcador;

//   void _onMapCreated(GoogleMapController controller) {
//     this._controllerMap = controller;
//   }

//   void _addMarcador() {
//     if (_marcadores.length == 12)
//       return;

//     final String cadenaIdMarcador = 'marcador_id_$_contadorIdMarcador'; 
//     _contadorIdMarcador++;
//     final MarkerId idMarcador = MarkerId(cadenaIdMarcador);
  
//     final Marker marcador = Marker(
//       markerId: idMarcador,
//       position: LatLng(centro.latitude + sin(_contadorIdMarcador * pi / 6.0) / 20.0,
//       centro.longitude + cos(_contadorIdMarcador * pi / 6.0) / 20.0,
//       ),
//       infoWindow: InfoWindow(
//         title:  cadenaIdMarcador,
//         snippet: 'info'
//       ),
//       onTap: () => _onMarkerTapped(idMarcador),
//       onDragEnd: (LatLng posicion) => _onMarkerDragEnd(idMarcador, posicion),
//       onDrag: (LatLng posicion) => _onMarkerDrag(idMarcador, posicion),
//     );
//     setState(() {
//       _marcadores[idMarcador] = marcador;
//     });
//   }

//   void _onMarkerTapped(MarkerId idMarcador) {
//     final Marker? marcadorTocado = _marcadores[idMarcador];

//     if (marcadorTocado != null) {
//       setState(() {
//         final MarkerId? idMarcadorAnterior = _marcadorSeleccionado;
//         if (idMarcadorAnterior != null && _marcadores.containsKey(idMarcadorAnterior)) {
//           final Marker anteriorActualizado = _marcadores[idMarcadorAnterior]!.copyWith(
//             iconParam: BitmapDescriptor.defaultMarker,
//           );
//         }
//         _marcadorSeleccionado = idMarcador;
//         final Marker marcadorNuevo = marcadorTocado.copyWith(
//           iconParam: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose)
//         );
//         _marcadores[idMarcador] = marcadorNuevo;
//         _posicionMarcador = null;
//       });
//     }
//   }

//   void _onMarkerDragEnd() {

//   }

//   void _onMarkerDrag() {
    
//   }
// }

