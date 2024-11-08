import 'package:flutter/material.dart';
import 'dart:math';

class PyramidScreen extends StatefulWidget {
  const PyramidScreen({Key? key}) : super(key: key);

  @override
  _PyramidScreenState createState() => _PyramidScreenState();
}

class _PyramidScreenState extends State<PyramidScreen> {
  final _sideController = TextEditingController();
  final _heightController = TextEditingController();

  double? _volume;
  double? _surfaceArea;

  void _calculate() {
    final side = double.tryParse(_sideController.text);
    final height = double.tryParse(_heightController.text);

    if (side != null && height != null) {
      // Menghitung volume
      setState(() {
        _volume = (1 / 3) * (side * side) * height;

        // Menghitung slant height (tinggi miring)
        double slantHeight = sqrt(pow(height, 2) + pow(side / 2, 2));

        // Menghitung luas permukaan
        double surfaceArea = (side * side) + 4 * (0.5 * side * slantHeight);
        _surfaceArea = surfaceArea;
      });
    } else {
      setState(() {
        _volume = null;
        _surfaceArea = null;
      });
    }
  }

  @override
  void dispose() {
    _sideController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pyramid Calculation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _sideController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Sisi Alas (cm)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Tinggi (cm)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calculate,
              child: const Text('Hitung Volume dan Luas Permukaan'),
            ),
            const SizedBox(height: 16),
            if (_volume != null && _surfaceArea != null) ...[
              Text(
                'Volume: ${_volume!.toStringAsFixed(2)} cm³',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                'Luas Permukaan: ${_surfaceArea!.toStringAsFixed(2)} cm²',
                style: const TextStyle(fontSize: 18),
              ),
            ] else if (_volume == null && _surfaceArea == null)
              const Text(
                'Masukkan sisi alas dan tinggi dengan benar untuk menghitung.',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}