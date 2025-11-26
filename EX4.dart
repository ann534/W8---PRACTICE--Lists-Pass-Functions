import 'package:flutter/material.dart';
import 'data/jokes.dart';

void main() => runApp(const MaterialApp(home: JokesPage()));

/// EX4 - Manage a list of jokes with single favorite selection
///
/// State Management:
/// - JokesPage stores favoriteId (lifted state up)
/// - ListView.builder for performance with many items
/// - IconButton toggles favorite:
///   * If user marks new favorite → replace favoriteId
///   * If user taps same favorite → unset it (toggle off)
///
/// Widget Responsibilities:
/// - JokesPage: owns state, builds list
/// - ListTile: displays joke with favorite button
/// - IconButton: triggers state change via callback

class JokesPage extends StatefulWidget {
  const JokesPage({super.key});

  @override
  State<JokesPage> createState() => _JokesPageState();
}

class _JokesPageState extends State<JokesPage> {
  int? favoriteId; // Only one favorite allowed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EX4 - Jokes Collection'),
        backgroundColor: Colors.purple[700],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.purple[50],
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.purple),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Tap the heart to mark your favorite joke!',
                    style: TextStyle(
                      color: Colors.purple[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                final joke = jokes[index];
                final isFav = joke.id == favoriteId;
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.purple[100],
                      child: Text(
                        '${joke.id}',
                        style: TextStyle(
                          color: Colors.purple[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      joke.text,
                      style: TextStyle(
                        fontSize: 14,
                        color: isFav ? Colors.purple[900] : Colors.black87,
                        fontWeight: isFav ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          // Toggle: un-favorite if same, else set new favorite
                          favoriteId = isFav ? null : joke.id;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
