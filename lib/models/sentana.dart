class SentAna {
  final String emotions;

  SentAna({required this.emotions});
  factory SentAna.fromJson(Map<String, dynamic> json) {
    return SentAna(emotions: json['emotions_detected'][0]);
  }
}
