import 'package:dojo_flutter_firebase/model/tarefa.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          else {
            return ListView.builder(
              padding: EdgeInsets.all(5),
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                //return Text(snapshot.data.documents[index]["nome"]);

                return CheckboxListTile(
                  title: Text(snapshot.data.documents[index]["nome"]),
                  value: snapshot.data.documents[index]["feito"],
                  secondary: CircleAvatar(
                    child: Icon(snapshot.data.documents[index]["feito"] ? Icons.check : Icons.close),
                  ),
                  onChanged: (marcou) {
                    setState(() {
                      var tarefaSelecionada = snapshot.data.documents[index];
                      var tarefaFeita = !snapshot.data.documents[index]["feito"];
                      Firestore.instance.collection("usuarios").document(widget.usuarioLogadoId).collection("tarefas").document(tarefaSelecionada.documentID).updateData({"feito": tarefaFeita});
                    });
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<QuerySnapshot> _recuperarTarefas() {
    return Firestore.instance.collection("usuarios").document(widget.usuarioLogadoId).collection("tarefas").orderBy("dataInclusao").getDocuments();
  }
}
