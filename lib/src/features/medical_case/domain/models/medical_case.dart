class MedicalCase {
  final String description;
  final String status;
  final String diagnosticType;
  final String specialist;

  const MedicalCase({required this.specialist, required this.diagnosticType, required this.status, required this.description});

  static MedicalCase fromJson(json) => MedicalCase(
      description: json['descripcion'],
      status: json['estado'],
      diagnosticType: json['diagnostic_type'],
      specialist: json['medico'] !=null ? json['medico']['nombres']: '');
}
