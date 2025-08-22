import 'package:mmarn/features/team/domain/entities/miembro_team_entity.dart';

class MiembroTeamModel extends MiembroTeamEntity {
  const MiembroTeamModel({
    required super.id,
    required super.nombre,
    required super.cargo,
    required super.departamento,
    required super.foto,
    required super.biografia,
    required super.orden,
    required super.fechaCreacion,
  });

  factory MiembroTeamModel.fromJson(Map<String, dynamic> json) {
    return MiembroTeamModel(
      id: json['id'] ?? '',
      nombre: json['nombre'] ?? '',
      cargo: json['cargo'] ?? '',
      departamento: json['departamento'] ?? '',
      foto: json['foto'] ?? '',
      biografia: json['biografia'] ?? '',
      orden: json['orden'] ?? 0,
      fechaCreacion: DateTime.parse(json['fecha_creacion'] ?? '2025-01-01 00:00:00'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'cargo': cargo,
      'departamento': departamento,
      'foto': foto,
      'biografia': biografia,
      'orden': orden,
      'fecha_creacion': fechaCreacion.toIso8601String(),
    };
  }
}