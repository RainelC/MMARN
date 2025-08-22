class MiembroTeamEntity {
  final String id;
  final String nombre;
  final String cargo;
  final String departamento;
  final String foto;
  final String biografia;
  final int orden;
  final DateTime fechaCreacion;

  const MiembroTeamEntity({
    required this.id,
    required this.nombre,
    required this.cargo,
    required this.departamento,
    required this.foto,
    required this.biografia,
    required this.orden,
    required this.fechaCreacion,
  });
}