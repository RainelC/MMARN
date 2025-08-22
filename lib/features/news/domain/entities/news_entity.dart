class NewsEntity {
  final String id;
  final String titulo;
  final String resumen;
  final String contenido;
  final String imagen;
  final String fecha;
  final String fechaCreacion;

  NewsEntity({
    required this.id,
    required this.titulo,
    required this.resumen,
    required this.contenido,
    required this.imagen,
    required this.fecha,
    required this.fechaCreacion,
  });

  factory NewsEntity.fromJson(Map<String, dynamic> json) {
    return NewsEntity(
      id: json["id"] ?? "",
      titulo: json["titulo"] ?? "",
      resumen: json["resumen"] ?? "",
      contenido: json["contenido"] ?? "",
      imagen: json["imagen"] ?? "",
      fecha: json["fecha"] ?? "",
      fechaCreacion: json["fecha_creacion"] ?? "",
    );
  }
}
