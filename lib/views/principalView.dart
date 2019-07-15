import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PrincipalView extends StatefulWidget {
  final String usuarioLogadoId;
  PrincipalView(this.usuarioLogadoId);

  @override
  _PrincipalViewState createState() => _PrincipalViewState();
}

class _PrincipalViewState extends State<PrincipalView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase"),
        centerTitle: true,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: _recuperarTarefas(),
        builder: (context, snapshot) {
          return ListView.builder(
            padding: EdgeInsets.all(5),
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, indice) {
              return CheckboxListTile(
                title: Text(snapshot.data.documents[indice]["nome"]),
                value: snapshot.data.documents[indice]["feito"],
                secondary: GestureDetector(
                    child: CircleAvatar(
                      child: Icon(snapshot.data.documents[indice]["feito"] ? Icons.check : Icons.close),
                    ),
                    onTap: () {}),
                onChanged: (marcou) {
                  setState(() {
                    var tarefaSelecionada = snapshot.data.documents[indice];
                    var tarefaFeita = tarefaSelecionada["feito"];

                    Firestore.instance.collection("usuarios").document(widget.usuarioLogadoId).collection("tarefas").document(tarefaSelecionada.documentID).updateData({"feito": !tarefaFeita});
                  });
                },
              );
              //return Text("OI");
            },
          );
        },
      ),
    );
  }

  Future<QuerySnapshot> _recuperarTarefas() {
    return Firestore.instance.collection("usuarios").document(widget.usuarioLogadoId).collection("tarefas").orderBy("dataInclusao").getDocuments();
  }
}
