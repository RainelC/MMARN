class MiembroEntity {
  final String id;
  final String nombre;
  final String cargo;
  final String departamento;
  final String foto;
  final String biografia;
  final int orden;

  MiembroEntity({
    required this.id,
    required this.nombre,
    required this.cargo,
    required this.departamento,
    required this.foto,
    required this.biografia,
    required this.orden,
  });

  factory MiembroEntity.fromJson(Map<String, dynamic> json) {
    return MiembroEntity(
      id: json['id'],
      nombre: json['nombre'],
      cargo: json['cargo'],
      departamento: json['departamento'],
      foto: json['foto'],
      biografia: json['biografia'],
      orden: json['orden'],
    );
  }
}
