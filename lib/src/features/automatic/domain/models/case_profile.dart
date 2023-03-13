class Automatico {
  final int id;
  final int caso;
  final String fecha_diagnostico;
  final String diagnostico;
  final String nombre_medico;
  final String correo;
  final String recomendaciones;
  final String ciudadcita;
  final String fechacitapresencial;
  final String urlCitaremota;

  const Automatico({ required this.id,required  this.caso, required this.fecha_diagnostico,
    required this.diagnostico, required this.nombre_medico, required this.correo,
    required this.recomendaciones, required this.ciudadcita, required this.fechacitapresencial,
    required this.urlCitaremota});

  factory Automatico.fromJson(Map<String, dynamic> json) {
    return Automatico(
      id: json['id'],
      caso: json['caso'],
      fecha_diagnostico: json['fecha_diagnostico'],
      diagnostico: json['diagnostico'],
      nombre_medico: json['nombre_medico'],
      correo: json['correo'],
      recomendaciones: json['recomendaciones'],
      ciudadcita: json['ciudadcita'],
      fechacitapresencial: json['fechacitapresencial'],
      urlCitaremota: json['urlCitaremota']
    );
  }
}