import 'package:flutter/material.dart';

class DaysScreen extends StatefulWidget {
  const DaysScreen({Key? key}) : super(key: key);

  @override
  _DaysScreenState createState() => _DaysScreenState();
}

class _DaysScreenState extends State<DaysScreen> {
  final TextEditingController _controller = TextEditingController();
  String _day = "";

  void _checkDay() {
    final int? dayNumber = int.tryParse(_controller.text);
    if (dayNumber != null && dayNumber >= 1 && dayNumber <= 7) {
      switch (dayNumber) {
        case 1:
          _day = "Senin";
          break;
        case 2:
          _day = "Selasa";
          break;
        case 3:
          _day = "Rabu";
          break;
        case 4:
          _day = "Kamis";
          break;
        case 5:
          _day = "Jumat";
          break;
        case 6:
          _day = "Sabtu";
          break;
        case 7:
          _day = "Minggu";
          break;
        default:
          _day = "";
      }
    } else {
      _day = "Input tidak valid, masukkan angka antara 1 dan 7.";
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Days Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Masukkan Nomor Hari (1-7)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _checkDay,
              child: const Text('Cek Hari'),
            ),
            const SizedBox(height: 16),
            Text(
              _day.isEmpty ? '' : 'Hari yang Anda pilih adalah: $_day',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}