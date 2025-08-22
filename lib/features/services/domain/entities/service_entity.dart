class ServiceEntity {
  final String id;
  final String nombre;
  final String descripcion;
  final String icono;
  final String fechaCreacion;

  ServiceEntity({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.icono,
    required this.fechaCreacion,
  });

  factory ServiceEntity.fromJson(Map<String, dynamic> json) {
    return ServiceEntity(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      icono: json['icono'],
      fechaCreacion: json['fecha_creacion'],
    );
  }
}
