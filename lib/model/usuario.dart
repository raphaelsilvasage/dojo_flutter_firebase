import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dojo_flutter_firebase/model/tarefa.dart';

class Usuario {
  String id;
  int idade;
  String nome;

  Map<String, dynamic> dadosUsuario = Map();
  List<Tarefa> tarefas;

  Usuario({this.id, this.idade, this.nome, this.tarefas});

  Usuario.fromDocument(DocumentSnapshot documento) {
    this.id = documento.documentID;
    this.idade = documento.data["idade"];
    this.nome = documento.data["nome"];
  }
}
