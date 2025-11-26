import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: HomeSwitcher()));

/// EX3 - Screen switching using state (Welcome → Temperature)
/// Component Diagram:
/// HomeSwitcher (StatefulWidget - owns state)
///   ├── WelcomeScreen (receives onStart callback)
///   └── TemperatureScreen (shown after START is pressed)
///
/// State is lifted up to HomeSwitcher which manages which screen to show

/// HomeSwitcher - Parent widget that manages screen state
class HomeSwitcher extends StatefulWidget {
  const HomeSwitcher({super.key});

  @override
  State<HomeSwitcher> createState() => _HomeSwitcherState();
}

class _HomeSwitcherState extends State<HomeSwitcher> {
  bool showTemperature = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showTemperature
          ? const TemperatureScreen()
          : WelcomeScreen(onStart: () {
              setState(() => showTemperature = true);
            }),
    );
  }
}

/// WelcomeScreen - Initial screen with START button
class WelcomeScreen extends StatelessWidget {
  final VoidCallback onStart;

  const WelcomeScreen({super.key, required this.onStart});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[700]!, Colors.blue[300]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.thermostat, size: 100, color: Colors.white),
            const SizedBox(height: 20),
            const Text(
              'Welcome to',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            const Text(
              'Temperature Converter',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: onStart,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue[700],
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ),
              ),
              child: const Text(
                'START',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// TemperatureScreen - Shows after START is pressed
class TemperatureScreen extends StatefulWidget {
  const TemperatureScreen({super.key});

  @override
  State<TemperatureScreen> createState() => _TemperatureScreenState();
}

class _TemperatureScreenState extends State<TemperatureScreen> {
  final TextEditingController _controller = TextEditingController();
  double? result;
  bool isCelsius = true;

  void convert() {
    final input = double.tryParse(_controller.text);
    if (input != null) {
      setState(() {
        result = isCelsius ? (input * 9 / 5 + 32) : ((input - 32) * 5 / 9);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
        backgroundColor: Colors.blue[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: isCelsius ? 'Celsius' : 'Fahrenheit',
                border: const OutlineInputBorder(),
                suffixIcon: const Icon(Icons.thermostat),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Celsius'),
                Switch(
                  value: !isCelsius,
                  onChanged: (val) {
                    setState(() {
                      isCelsius = !val;
                      result = null;
                      _controller.clear();
                    });
                  },
                ),
                const Text('Fahrenheit'),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: convert,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            if (result != null)
              Card(
                color: Colors.blue[50],
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    '${isCelsius ? 'Fahrenheit' : 'Celsius'}: ${result!.toStringAsFixed(2)}°',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
