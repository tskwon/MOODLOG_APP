import 'package:flutter/material.dart';

class EmotionAnalysisWidget extends StatelessWidget {
  EmotionAnalysisWidget({super.key});

  final List<Map<String, String>> emotions = [
    {'label': '행복', 'path': 'images/happy.jpg'},
    {'label': '기쁨', 'path': 'images/joy.jpg'},
    {'label': '불행', 'path': 'images/mad.jpg'},
    {'label': '슬픔', 'path': 'images/sad.jpg'},
    {'label': '불행', 'path': 'images/unhappy.jpg'},
  ];

  final List<double> dataPoints = [0.8, 0.6, 0.4, 0.9, 0.3, 0.7]; // 예제 데이터

  @override
  Widget build(BuildContext context) {
    final double chartHeight = MediaQuery.of(context).size.height * 0.4;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Emotion Icons and Labels
        Padding(
          padding: const EdgeInsets.only(left: 16.0), // 왼쪽 여백 추가
          child: SizedBox(
            width: 60, // 이미지 열의 너비 조정
            child: Stack(
              children: emotions.asMap().entries.map((entry) {
                final index = entry.key;
                final emotion = entry.value;
                final double position =
                    chartHeight / (emotions.length + 1) * (index + 1);

                return Positioned(
                  top: position - 20, // 이미지 중앙 배치
                  child: Image.asset(
                    emotion['path']!,
                    width: 40,
                    height: 40,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(width: 20), // 이미지와 그래프 간 간격
        // Emotion Graph
        Expanded(
          child: CustomPaint(
            size: Size(MediaQuery.of(context).size.width, chartHeight),
            painter: EmotionGraphPainter(dataPoints, chartHeight),
          ),
        ),
      ],
    );
  }
}

class EmotionGraphPainter extends CustomPainter {
  final List<double> dataPoints;
  final double chartHeight;

  EmotionGraphPainter(this.dataPoints, this.chartHeight);

  @override
  void paint(Canvas canvas, Size size) {
    final axisPaint = Paint()..color = Colors.grey;
    final linePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final pointPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final double stepX = size.width / (dataPoints.length - 1);
    final double maxY = 1.0;
    final double stepY = chartHeight / (dataPoints.length + 1);

    // Draw horizontal lines
    for (int i = 0; i <= 5; i++) {
      final y = size.height - (i * size.height / 5);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), axisPaint);
    }

    // Draw data line
    final path = Path();
    for (int i = 0; i < dataPoints.length; i++) {
      final x = i * stepX;
      final y = size.height - (dataPoints[i] / maxY * size.height);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }

      // Adjust point alignment to match icon center
      final iconY = stepY * (i + 1);
      canvas.drawCircle(Offset(x, iconY), 4, pointPaint);
    }

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
