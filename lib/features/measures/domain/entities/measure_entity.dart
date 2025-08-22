class MeasureEntity {
  final String id;
  final String titulo;
  final String descripcion;
  final String categoria;
  final String icono;
  final String fechaCreacion;

  MeasureEntity({
  required this.id,
  required this.titulo,
  required this.descripcion,
  required this.categoria,
  required this.icono,
  required this.fechaCreacion,
  });

  factory MeasureEntity.fromJson(Map<String, dynamic> json) {
    return MeasureEntity(
      id: json["id"] ?? "",
      titulo: json["titulo"] ?? "",
      descripcion: json["descripcion"] ?? "",
      categoria: json["categoria"] ?? "",
      icono: json["icono"] ?? "",
      fechaCreacion: json["fecha_creacion"] ?? "",
      );
    }
  }

