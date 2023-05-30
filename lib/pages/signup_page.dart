import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 7, 27, 36),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    'Regístrate en\nBeatSleuth',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text('Nombre',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                const SizedBox(height: 10),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blueGrey[700],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                      hintText: 'Introduce tu nombre',
                      hintStyle: TextStyle(color: Colors.grey[300])),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Correo electrónico',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blueGrey[700],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                      hintText: 'Introduce tu correo electrónico',
                      hintStyle: TextStyle(color: Colors.grey[300])),
                ),
                const SizedBox(height: 15),
                const Text('Contraseña',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                const SizedBox(height: 10),
                TextField(
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blueGrey[700],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                      hintText: 'Introduce tu contraseña',
                      hintStyle: TextStyle(color: Colors.grey[300])),
                ),
                const SizedBox(height: 15),
                const Text('Confirmar contraseña',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                const SizedBox(height: 10),
                TextField(
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blueGrey[700],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                      hintText: 'Confirma tu contraseña',
                      hintStyle: TextStyle(color: Colors.grey[300])),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 190, 131, 56),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('REGISTRARSE'),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward)
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
