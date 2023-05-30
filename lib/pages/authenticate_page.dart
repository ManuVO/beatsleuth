import 'package:flutter/material.dart';

class AuthenticatePage extends StatefulWidget {
  @override
  _AuthenticatePageState createState() => _AuthenticatePageState();
}

class _AuthenticatePageState extends State<AuthenticatePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isRegistering = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      // Logo de la aplicación
      Container(
        height: MediaQuery.of(context).size.height * 0.25,
        child: Center(
          child: Image.asset(
            'assets/img/Spotify-PNG-Logo-1536x1534.png',
            height: MediaQuery.of(context).size.height * 0.125,
          ),
        ),
      ),
      // Formulario de inicio de sesión y registro
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(16),
          child: Column(children: [
            // TabBar
            TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              tabs: [Tab(text: 'Inicio de sesión'), Tab(text: 'Registro')],
            ),
            // Contenido del TabBarView
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Formulario de inicio de sesión
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(children: [
                      // Botón para iniciar sesión con Google
                      ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              'https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png',
                              height: 24,
                            ),
                            SizedBox(width: 8),
                            Text('Iniciar sesión con Google'),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Text('Iniciar sesión con correo electrónico y contraseña',
                          style: TextStyle(color: Colors.white)),
                      SizedBox(height: 16),
                      TextField(
                        controller: _emailController,
                        decoration:
                            InputDecoration(labelText: 'Correo electrónico'),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(labelText: 'Contraseña'),
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                            'Iniciar sesión con correo electrónico y contraseña'),
                      ),
                    ]),
                  ),
                  // Formulario de registro
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(children: [
                      TextField(
                        controller: _nameController,
                        decoration:
                            InputDecoration(labelText: 'Nombre de usuario'),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _emailController,
                        decoration:
                            InputDecoration(labelText: 'Correo electrónico'),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(labelText: 'Contraseña'),
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _confirmPasswordController,
                        decoration:
                            InputDecoration(labelText: 'Confirmar contraseña'),
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _isRegistering ? null : () => {},
                        child: Text(_isRegistering
                            ? 'Registrando...'
                            : 'Registrarse con correo electrónico y contraseña'),
                      )
                    ]),
                  )
                ],
              ),
            )
          ]),
        ),
      )
    ])));
  }
}
