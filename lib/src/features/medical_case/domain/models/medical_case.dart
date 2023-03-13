class MedicalCase {
  final int id;
  final String description;
  final String status;
  final String diagnosticType;
  final String specialist;

  const MedicalCase({required this.id, required this.specialist, required this.diagnosticType, required this.status, required this.description});

  static MedicalCase fromJson(json) => MedicalCase(
      id: json['id'],
      description: json['descripcion'],
      status: json['estado'],
      diagnosticType: json['diagnosticos'] == '' ? json['diagnosticos']: 'Sin diagnostico',
      specialist: json['medico'] !=null ? json['medico']['nombres']: '');
}
