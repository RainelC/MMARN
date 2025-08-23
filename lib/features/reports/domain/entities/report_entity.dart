class Report {
  final String? codigo;
  final String titulo;
  final String descripcion;
  final String foto;
  final double latitud;
  final double longitud;
  final String? estado;
  final String? comentario_ministerio;
  final String? fecha;

  Report({
    this.codigo,
    required this.titulo,
    required this.descripcion,
    required this.foto,
    required this.latitud,
    required this.longitud,
    this.estado,
    this.comentario_ministerio,
    this.fecha,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      codigo: json['codigo'] ?? '',
      titulo: json['titulo'] ?? '',
      descripcion: json['descripcion'] ?? '',
      foto: json['foto'] ?? '',
      latitud: (json['latitud'] ?? 0.0).toDouble(),
      longitud: (json['longitud'] ?? 0.0).toDouble(),
      estado: json['estado'] ?? '',
      comentario_ministerio: json['comentario_ministerio'] ?? '',
      fecha: json['fecha'] ?? '',
    );
  }
}