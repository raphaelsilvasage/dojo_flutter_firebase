import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dojo_flutter_firebase/helpers/navegacaoHelper.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _estaCarregando = false;
  final _controladorUsuario = TextEditingController();
  final _controladorSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: _estaCarregando
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: _controladorUsuario,
                    decoration: InputDecoration(labelText: "Usuário"),
                  ),
                  TextField(
                    controller: _controladorSenha,
                    decoration: InputDecoration(labelText: "Senha"),
                    obscureText: true,
                  ),
                  RaisedButton(
                    child: Text("LOGIN"),
                    onPressed: () async {
                      setState(() {
                        _estaCarregando = true;
                      });

                      await _efetuarLogin(_controladorUsuario.text, _controladorSenha.text);

                      setState(() {
                        _estaCarregando = false;
                      });
                    },
                  )
                ],
              ),
      ),
    );
  }

  Future<Null> _efetuarLogin(String usuario, String senha) async {
    //ACESSAR O FIREBASE
    QuerySnapshot usuarioEncontrado = await Firestore.instance.collection("usuarios").where("login", isEqualTo: usuario).getDocuments();
    if (usuarioEncontrado.documents.length > 0) {
      bool senhaValida = usuarioEncontrado.documents[0]["senha"] == senha;
      if (senhaValida) {
        //NAVEGAR PARA VIEW PRINCIPAL
        Navigator.of(context).pushNamed(NavegacaoHelper.rotaPrincipal, arguments: {"usuarioId" : usuarioEncontrado.documents[0].documentID});
      } else {
        _exibirAlerta("Senha inválida!");
      }
    } else {
      _exibirAlerta("Usuário não cadastrado");
    }
  }

  void _exibirAlerta(String mensagem) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Atenção"),
            content: Text(mensagem),
            actions: <Widget>[
              FlatButton(
                child: Text("Fechar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
