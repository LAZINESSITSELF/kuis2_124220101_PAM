import 'package:flutter/material.dart';

enum TimeZone { WIB, WITA, WIT }

class TimeZoneScreen extends StatefulWidget {
  const TimeZoneScreen({Key? key}) : super(key: key);

  @override
  _TimeZoneScreenState createState() => _TimeZoneScreenState();
}

class _TimeZoneScreenState extends State<TimeZoneScreen> {
  TimeOfDay? _selectedTime;
  TimeZone? _selectedTimeZone;
  String? _wibTime;
  String? _witaTime;
  String? _witTime;

  void _convertTime() {
    if (_selectedTime != null && _selectedTimeZone != null) {
      final now = DateTime.now();
      final localTime = DateTime(
        now.year,
        now.month,
        now.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      DateTime baseTime;
      switch (_selectedTimeZone) {
        case TimeZone.WIB:
          baseTime = localTime.toUtc().add(const Duration(hours: 7));
          break;
        case TimeZone.WITA:
          baseTime = localTime.toUtc().add(const Duration(hours: 8));
          break;
        case TimeZone.WIT:
          baseTime = localTime.toUtc().add(const Duration(hours: 9));
          break;
        default:
          baseTime = localTime;
      }

      setState(() {
        _wibTime = _formatTime(baseTime.subtract(const Duration(hours: 7)));
        _witaTime = _formatTime(baseTime.subtract(const Duration(hours: 8)));
        _witTime = _formatTime(baseTime.subtract(const Duration(hours: 9)));
      });
    }
  }

  String _formatTime(DateTime dateTime) {
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _convertTime();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Zone Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Pilih Zona Waktu untuk Input',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            RadioListTile<TimeZone>(
              title: const Text('WIB'),
              value: TimeZone.WIB,
              groupValue: _selectedTimeZone,
              onChanged: (TimeZone? value) {
                setState(() {
                  _selectedTimeZone = value;
                  _convertTime();
                });
              },
            ),
            RadioListTile<TimeZone>(
              title: const Text('WITA'),
              value: TimeZone.WITA,
              groupValue: _selectedTimeZone,
              onChanged: (TimeZone? value) {
                setState(() {
                  _selectedTimeZone = value;
                  _convertTime();
                });
              },
            ),
            RadioListTile<TimeZone>(
              title: const Text('WIT'),
              value: TimeZone.WIT,
              groupValue: _selectedTimeZone,
              onChanged: (TimeZone? value) {
                setState(() {
                  _selectedTimeZone = value;
                  _convertTime();
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: const Text('Pilih Waktu'),
            ),
            const SizedBox(height: 16),
            if (_selectedTime != null && _selectedTimeZone != null) ...[
              Text(
                'Waktu yang Dipilih: ${_selectedTime!.format(context)} di ${_selectedTimeZone.toString().split('.').last}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              Text(
                'WIB: $_wibTime',
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                'WITA: $_witaTime',
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                'WIT: $_witTime',
                style: const TextStyle(fontSize: 18),
              ),
            ] else
              const Text(
                'Pilih zona waktu dan waktu terlebih dahulu.',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}