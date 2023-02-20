
class MedicalCase {
  final int id;
  final String title;

  const MedicalCase({required this.id, required this.title});

  factory MedicalCase.fromJson(Map<String, dynamic> json){
    return MedicalCase(
      id: json['id'],
      title: json['tittle']
    );
  }
}