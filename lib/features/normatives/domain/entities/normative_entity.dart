class Normative {
  final String id;
  final String titulo;
  final String tipo;
  final String numero;
  final String fechaPublicacion;
  final String descripcion;
  final String urlDocumento;

  Normative({
    required this.id,
    required this.titulo,
    required this.tipo,
    required this.numero,
    required this.fechaPublicacion,
    required this.descripcion,
    required this.urlDocumento,
  });

  factory Normative.fromJson(Map<String, dynamic> json) {
    return Normative(
      id: json['id'] ?? '',
      titulo: json['titulo'] ?? '',
      tipo: json['tipo'] ?? '',
      numero: json['numero'] ?? '',
      fechaPublicacion: json['fecha_publicacion'] ?? '',
      descripcion: json['descripcion'] ?? '',
      urlDocumento: json['url_documento'] ?? '',
    );
  }
}
