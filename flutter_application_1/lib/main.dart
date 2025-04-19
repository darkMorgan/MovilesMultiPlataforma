import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const CalculadoraPage(),
    );
  }
}

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});

  @override
  State<CalculadoraPage> createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  String _pantalla = '0';
  String _expresion = '';
  double _num1 = 0;
  String _operador = '';
  bool _esperandoSegundoNumero = false;
  bool _mostrarResultado = false;

  void _presionarBoton(String texto) {
    setState(() {
      if (texto == 'C') {
        _pantalla = '0';
        _expresion = '';
        _num1 = 0;
        _operador = '';
        _esperandoSegundoNumero = false;
        _mostrarResultado = false;
      } else if (texto == '+' || texto == '-' || texto == 'x' || texto == '/') {
        _num1 = double.parse(_pantalla);
        _operador = texto;
        _esperandoSegundoNumero = true;
        _expresion = '$_pantalla $texto ';
      } else if (texto == '=') {
        double num2 = double.parse(_pantalla);
        double resultado = 0;

        switch (_operador) {
          case '+':
            resultado = _num1 + num2;
            break;
          case '-':
            resultado = _num1 - num2;
            break;
          case 'x':
            resultado = _num1 * num2;
            break;
          case '/':
            resultado = num2 != 0 ? _num1 / num2 : 0;
            break;
        }

        _pantalla = resultado.toStringAsFixed(2);
        _expresion += '$num2 =';
        _operador = '';
        _esperandoSegundoNumero = false;
        _mostrarResultado = true;
      } else {
        if (_pantalla == '0' || _esperandoSegundoNumero || _mostrarResultado) {
          _pantalla = texto;
          _esperandoSegundoNumero = false;
          _mostrarResultado = false;
        } else {
          _pantalla += texto;
        }

        if (!_esperandoSegundoNumero && _operador.isEmpty) {
          _expresion = _pantalla;
        } else if (_operador.isNotEmpty) {
          _expresion = '$_num1 $_operador $_pantalla';
        }
      }
    });
  }

  Widget _crearBoton(String texto, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => _presionarBoton(texto),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(24),
            backgroundColor: Colors.grey[200],
            foregroundColor: Colors.black,
          ),
          child: Text(
            texto,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
      ),
      body: Column(
        children: [
          // Expresión
          Container(
            width: double.infinity,
            color: Colors.black,
            padding: const EdgeInsets.only(top: 40, right: 24, bottom: 8),
            alignment: Alignment.bottomRight,
            child: Text(
              _expresion,
              style: const TextStyle(color: Colors.white70, fontSize: 24),
            ),
          ),
          // Resultado
          Container(
            width: double.infinity,
            color: Colors.black,
            padding: const EdgeInsets.only(right: 24, bottom: 24),
            alignment: Alignment.bottomRight,
            child: Text(
              _pantalla,
              style: const TextStyle(color: Colors.white, fontSize: 48),
            ),
          ),
          // Botones
          Row(
            children: [
              _crearBoton('7'),
              _crearBoton('8'),
              _crearBoton('9'),
              _crearBoton('/'),
            ],
          ),
          Row(
            children: [
              _crearBoton('4'),
              _crearBoton('5'),
              _crearBoton('6'),
              _crearBoton('x'),
            ],
          ),
          Row(
            children: [
              _crearBoton('1'),
              _crearBoton('2'),
              _crearBoton('3'),
              _crearBoton('-'),
            ],
          ),
          Row(
            children: [
              _crearBoton('0', flex: 2),
              _crearBoton('.'),
              _crearBoton('+'),
            ],
          ),
          Row(
            children: [
              _crearBoton('C'),
              _crearBoton('='),
            ],
          ),
        ],
      ),
    );
  }
}
