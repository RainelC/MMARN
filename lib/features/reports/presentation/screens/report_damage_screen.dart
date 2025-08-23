import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'package:mmarn/core/constants/app_colors.dart';
import 'package:mmarn/features/reports/data/models/report_request_model.dart';
import 'package:mmarn/features/reports/data/repositories/reports_repository.dart';
import 'package:mmarn/features/reports/domain/usecases/send_report_usecase.dart';
import 'package:mmarn/shared/widgets/bottom_navbar.dart';

class ReportDamageScreen extends StatefulWidget {
  const ReportDamageScreen({super.key});

  @override
  State<ReportDamageScreen> createState() => _ReportDamageScreenState();
}

class _ReportDamageScreenState extends State<ReportDamageScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();
  File? _image;
  String? _base64Image;

  double? _latitud;
  double? _longitud;
  String _ubicacionTexto = "Ubicación no seleccionada";
  bool _isLoadingLocation = false;

  final SendReportUseCase useCase = SendReportUseCase(ReportRepository());

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoadingLocation = true;
    });

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showLocationError("Permisos de ubicación denegados");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showLocationError("Permisos de ubicación denegados permanentemente");
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _latitud = position.latitude;
        _longitud = position.longitude;
        _ubicacionTexto = "Lat: ${_latitud!.toStringAsFixed(6)}, Lng: ${_longitud!.toStringAsFixed(6)}";
        _isLoadingLocation = false;
      });
    } catch (e) {
      _showLocationError("Error al obtener ubicación: $e");
      setState(() {
        _isLoadingLocation = false;
      });
    }
  }

  void _showLocationError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _selectLocationOnMap() async {
    if (_latitud == null || _longitud == null) {
      _showLocationError("Primero debe obtenerse la ubicación actual");
      return;
    }

    final selectedPosition = await Navigator.push<latlng.LatLng>(
      context,
      MaterialPageRoute(
        builder: (context) => MapLocationPicker(
          initialPosition: latlng.LatLng(_latitud!, _longitud!),
        ),
      ),
    );

    if (selectedPosition != null) {
      setState(() {
        _latitud = selectedPosition.latitude;
        _longitud = selectedPosition.longitude;
        _ubicacionTexto = "Lat: ${_latitud!.toStringAsFixed(6)}, Lng: ${_longitud!.toStringAsFixed(6)}";
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _image = File(pickedFile.path);
        _base64Image = base64Encode(bytes);
      });
    }
  }

  Future<void> _sendReport() async {
    if (_formKey.currentState!.validate() &&
        _base64Image != null &&
        _latitud != null &&
        _longitud != null) {

      final report = ReportRequestModel(
        titulo: _tituloController.text,
        descripcion: _descripcionController.text,
        foto: _base64Image!,
        latitud: _latitud!,
        longitud: _longitud!,
      );

      try {
        await useCase(report);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Reporte enviado con éxito")),
        );

        _formKey.currentState!.reset();
        setState(() {
          _image = null;
          _base64Image = null;
        });

        _getCurrentLocation();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al enviar reporte: $e")),
        );
      }
    } else {
      String mensaje = "Faltan campos obligatorios: ";
      if (_base64Image == null) mensaje += "foto, ";
      if (_latitud == null || _longitud == null) mensaje += "ubicación, ";

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensaje)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reportar Daño Ambiental")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Tu reporte ayuda a proteger el medio ambiente 🌎",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _tituloController,
                      decoration: const InputDecoration(
                        labelText: "Título",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                      value!.isEmpty ? "Campo requerido" : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descripcionController,
                      decoration: const InputDecoration(
                        labelText: "Descripción",
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      validator: (value) =>
                      value!.isEmpty ? "Campo requerido" : null,
                    ),
                    const SizedBox(height: 16),

                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Ubicación",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            if (_isLoadingLocation)
                              const Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  ),
                                  SizedBox(width: 10),
                                  Text("Obteniendo ubicación..."),
                                ],
                              )
                            else
                              Text(_ubicacionTexto),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: _getCurrentLocation,
                                    icon: const Icon(Icons.my_location),
                                    label: const Text("Ubicación Actual"),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: _selectLocationOnMap,
                                    icon: const Icon(Icons.map),
                                    label: const Text("Seleccionar en Mapa"),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Fotografía",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _image == null
                                ? const Text("No hay imagen seleccionada")
                                : ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                _image!,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: _pickImage,
                                icon: const Icon(Icons.camera_alt),
                                label: const Text("Tomar Foto"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _sendReport,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          "Enviar Reporte",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentRoute: '/report'),
    );
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }
}

// Widget para seleccionar ubicación en el mapa
class MapLocationPicker extends StatefulWidget {
  final latlng.LatLng initialPosition;

  const MapLocationPicker({
    super.key,
    required this.initialPosition,
  });

  @override
  State<MapLocationPicker> createState() => _MapLocationPickerState();
}

class _MapLocationPickerState extends State<MapLocationPicker> {
  late MapController _mapController;
  late latlng.LatLng _selectedPosition;

  @override
  void initState() {
    super.initState();
    _selectedPosition = widget.initialPosition;
    _mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seleccionar Ubicación"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, _selectedPosition);
            },
            child: const Text(
              "CONFIRMAR",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: widget.initialPosition,
          initialZoom: 15.0,
          onTap: (tapPosition, point) {
            setState(() {
              _selectedPosition = point;
            });
          },
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: _selectedPosition,
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 40.0,
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            Position position = await Geolocator.getCurrentPosition();
            latlng.LatLng currentPos = latlng.LatLng(position.latitude, position.longitude);
            _mapController.move(currentPos, 15.0);
            setState(() {
              _selectedPosition = currentPos;
            });
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error al obtener ubicación: $e")),
            );
          }
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
