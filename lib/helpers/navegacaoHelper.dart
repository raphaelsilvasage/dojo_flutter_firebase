import 'package:dojo_flutter_firebase/views/loginView.dart';
import 'package:dojo_flutter_firebase/views/principalView.dart';
import 'package:flutter/material.dart';

class NavegacaoHelper {
  static const rotaRoot = "/";
  static const rotaPrincipal = "/principal";
  static const rotaLogin = "/login";

  static RouteFactory rotas() {
    return (settings) {
      final Map<String, dynamic> parametros = settings.arguments;
      Widget viewEncontrada;

      switch (settings.name) {
        case rotaRoot:
          viewEncontrada = LoginView();
          break;

        case rotaLogin:
          viewEncontrada = LoginView();
          break;

        case rotaPrincipal:
          String usuarioId = parametros != null ? parametros["usuarioId"] : null;
          viewEncontrada = PrincipalView(usuarioId);
          break;

        default:
          return null;
      }

      return MaterialPageRoute(builder: (BuildContext context) => viewEncontrada);
    };
  }

  static RouteFactory rotaNaoEncontrada() {
    return (settings) {
      String rotaNaoEncontrada = settings.name;
      return MaterialPageRoute(builder: (context) => _widgetRotaNaoEncontrada(rotaNaoEncontrada));
    };
  }

  static Widget _widgetRotaNaoEncontrada(String rotaNaoEncontrada) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text("Rota não encontrada"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: Text.rich(
          TextSpan(
            children: <TextSpan>[
              TextSpan(text: "A rota ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              TextSpan(text: "$rotaNaoEncontrada", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.yellow)),
              TextSpan(text: " não foi encontrada/definida", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
