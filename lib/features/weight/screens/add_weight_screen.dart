import 'package:flutter/material.dart';
import '../models/weight_model.dart';

class AddWeightScreen extends StatefulWidget {
  const AddWeightScreen({super.key});

  @override
  State<AddWeightScreen> createState() => _AddWeightScreenState();
}

class _AddWeightScreenState extends State<AddWeightScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fechaController = TextEditingController();
  final _pesoController = TextEditingController();

  @override
  void dispose() {
    _fechaController.dispose();
    _pesoController.dispose();
    super.dispose();
  }

  void _guardarPeso() {
    if (_formKey.currentState!.validate()) {
      final String fecha = _fechaController.text;
      final double peso = double.parse(_pesoController.text);

      final registroNuevo = WeightModel(fecha: fecha, pesoKilos: peso);

      Navigator.pop(context, registroNuevo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Peso'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _fechaController,
                decoration: const InputDecoration(
                  labelText: 'Fecha',
                  hintText: 'Ej. 12 de Noviembre',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La fecha debe contener algo.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _pesoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Peso (kg)',
                  hintText: 'Ej. 78.3',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El peso no debe de estar vacío';
                  }
                  final pesoParseado = double.tryParse(value);
                  if (pesoParseado == null || pesoParseado <= 0) {
                    return 'Ingresa un número válido, debe ser mayor que 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _guardarPeso,
                  child: const Text('Guardar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}