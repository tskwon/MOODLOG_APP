class Emotion {
  final String userId; // 추가
  final String emotion; // selectedEmotion -> emotion
  final String text; // diaryText -> text
  final DateTime date; // currentDate -> date

  Emotion({
    required this.userId,
    required this.emotion,
    required this.text,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'emotion': emotion,
      'text': text,
      'date': date.toIso8601String(),
    };
  }
}
