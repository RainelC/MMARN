import '../../domain/entities/report_entity.dart';

class ReportRequestModel extends Report {
  ReportRequestModel({
    required super.titulo,
    required super.descripcion,
    required super.foto,
    required super.latitud,
    required super.longitud,
  });

  Map<String, dynamic> toJson() {
    return {
      "titulo": titulo,
      "descripcion": descripcion,
      "foto": foto,
      "latitud": latitud,
      "longitud": longitud,
    };
  }
}
