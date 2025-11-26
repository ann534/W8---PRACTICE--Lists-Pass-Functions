import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TempConverter()));

/// BONUS - Advanced Temperature Converter
/// Features:
/// - TextEditingController to manage input
/// - Live conversion with validation
/// - Switch between Celsius/Fahrenheit modes
/// - Error handling for invalid input

class TempConverter extends StatefulWidget {
  const TempConverter({super.key});

  @override
  State<TempConverter> createState() => _TempConverterState();
}

class _TempConverterState extends State<TempConverter> {
  final TextEditingController _controller = TextEditingController();
  double? result;
  String? errorMessage;
  bool convertToFahrenheit = true; // true = C to F, false = F to C

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void convert() {
    setState(() {
      errorMessage = null;
      final input = double.tryParse(_controller.text);

      if (_controller.text.isEmpty) {
        errorMessage = 'Please enter a temperature';
        result = null;
      } else if (input == null) {
        errorMessage = 'Please enter a valid number';
        result = null;
      } else {
        // Convert based on mode
        if (convertToFahrenheit) {
          result = input * 9 / 5 + 32; // Celsius to Fahrenheit
        } else {
          result = (input - 32) * 5 / 9; // Fahrenheit to Celsius
        }
      }
    });
  }

  void switchMode() {
    setState(() {
      convertToFahrenheit = !convertToFahrenheit;
      _controller.clear();
      result = null;
      errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BONUS - Temperature Converter'),
        backgroundColor: Colors.orange[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Mode selector
            Card(
              color: Colors.orange[50],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Conversion Mode',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange[900],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Celsius → Fahrenheit',
                          style: TextStyle(
                            fontWeight: convertToFahrenheit
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        Switch(
                          value: !convertToFahrenheit,
                          onChanged: (val) => switchMode(),
                          activeColor: Colors.orange[700],
                        ),
                        Text(
                          'Fahrenheit → Celsius',
                          style: TextStyle(
                            fontWeight: !convertToFahrenheit
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Input field
            TextField(
              controller: _controller,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText:
                    convertToFahrenheit ? 'Celsius (°C)' : 'Fahrenheit (°F)',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.thermostat),
                errorText: errorMessage,
              ),
              onSubmitted: (_) => convert(),
            ),
            const SizedBox(height: 20),

            // Convert button
            ElevatedButton.icon(
              onPressed: convert,
              icon: const Icon(Icons.calculate),
              label: const Text(
                'CONVERT',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 30),

            // Result display
            if (result != null)
              Card(
                elevation: 4,
                color: Colors.green[50],
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Icon(Icons.check_circle,
                          color: Colors.green, size: 50),
                      const SizedBox(height: 10),
                      Text(
                        convertToFahrenheit ? 'Fahrenheit' : 'Celsius',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        '${result!.toStringAsFixed(2)}°${convertToFahrenheit ? 'F' : 'C'}',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 30),

            // Conversion formula reference
            Card(
              color: Colors.grey[100],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Conversion Formulas:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('• C to F: (C × 9/5) + 32',
                        style: TextStyle(color: Colors.grey[700])),
                    Text('• F to C: (F - 32) × 5/9',
                        style: TextStyle(color: Colors.grey[700])),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
