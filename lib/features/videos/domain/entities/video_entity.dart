class VideoEntity {
  final String id;
  final String titulo;
  final String descripcion;
  final String url;
  final String thumbnail;
  final String categoria;
  final String duracion;
  final String fechaCreacion;

  VideoEntity({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.url,
    required this.thumbnail,
    required this.categoria,
    required this.duracion,
    required this.fechaCreacion,
  });

  factory VideoEntity.fromJson(Map<String, dynamic> json) {
    return VideoEntity(
      id: json['id'] ?? '',
      titulo: json['titulo'] ?? '',
      descripcion: json['descripcion'] ?? '',
      url: json['url'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      categoria: json['categoria'] ?? '',
      duracion: json['duracion'] ?? '',
      fechaCreacion: json['fecha_creacion'] ?? '',
    );
  }
}
