class Paciente {
  final String nombres;
  final String apellidos;
  final String fechaNacimiento;
  final String lugarNacimiento;
  final String lugarResidencia;
  final String edad;
  final String sexo;
  final int numeroCelular;
  final String correo;
  final String clave;


  const Paciente({ required this.nombres,required  this.apellidos, required this.fechaNacimiento,
    required this.lugarNacimiento, required this.lugarResidencia, required this.edad, required this.sexo,
    required this.numeroCelular, required this.correo, required this.clave});

  factory Paciente.fromJson(Map<String, dynamic> json) {
    return Paciente(
      nombres: json['nombres'],
      apellidos: json['apellidos'],
      fechaNacimiento: json['fecha_nacimiento'],
      lugarNacimiento: json['lugar_nacimiento'],
      lugarResidencia: json['lugar_residencia'],
      numeroCelular: json['numero_celular'],
      correo: json['correo'],
      clave: json['clave'],
      edad: json['edad'],
      sexo: json['sexo'],
    );
  }
}