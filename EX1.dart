import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Ex1Page()));

class Ex1Page extends StatelessWidget {
  final List<String> colors = ['red', 'blue', 'green', 'yellow', 'purple'];
  List<Widget> getLabels() {
    return colors
        .map((c) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(c,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EX1 - Loops')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('For-loop:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < colors.length; i++)
                Text('${i + 1}. ${colors[i]}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 20),
          const Text('.map() and spread:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...colors
              .map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text('• $item',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ))
              .toList(),
          const SizedBox(height: 20),
          const Text('Dedicated function:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...getLabels(),
        ],
      ),
    );
  }
}
