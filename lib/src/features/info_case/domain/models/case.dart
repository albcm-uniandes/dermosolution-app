class CaseInformation {
  final int idCase;
  final String lesion;
  final String shape;
  final String quantity;
  final String distribution;
  final String color;
  final List<dynamic> images;

  const CaseInformation(
      { required this.idCase, required this.lesion, required this.shape,
        required this.quantity, required this.distribution, required this.color,
      required this.images});

  factory CaseInformation.fromJson(Map<String, dynamic> json) {
    return CaseInformation(
      idCase: json['id'],
      lesion: json['tipo'],
      shape: json['forma'],
      quantity: json['numero'],
      distribution: json['distribucion'],
      color: json['color'],
      images: json['imagenes'],
    );
  }
}
