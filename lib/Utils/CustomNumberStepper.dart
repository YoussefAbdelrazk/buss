import 'package:flutter/material.dart';

class CustomNumberStepper extends StatefulWidget {
  final int value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  const CustomNumberStepper({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  _CustomNumberStepperState createState() => _CustomNumberStepperState();
}

class _CustomNumberStepperState extends State<CustomNumberStepper> {
  int _currentValue = 0;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  void _increment() {
    if (_currentValue < widget.max) {
      setState(() => _currentValue++);
      widget.onChanged(_currentValue);
    }
  }

  void _decrement() {
    if (_currentValue > widget.min) {
      setState(() => _currentValue--);
      widget.onChanged(_currentValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove, size: 18.0),
          onPressed: _decrement,
          constraints: const BoxConstraints(minWidth: 35.0, minHeight: 35.0),
        ),
        Text('$_currentValue', style: const TextStyle(fontSize: 16.0)),
        IconButton(
          icon: const Icon(Icons.add, size: 18.0),
          onPressed: _increment,
          constraints: const BoxConstraints(minWidth: 35.0, minHeight: 35.0),
        ),
      ],
    );
  }
}
