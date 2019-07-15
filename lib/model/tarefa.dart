class Tarefa {
  String id;
  String nome;
  bool feito;

  Tarefa({this.id, this.nome, this.feito});

  Tarefa.fromMap(Map<String, dynamic> data) {
    this.id = data["id"];
    this.nome = data["nome"];
    this.feito = data["feito"];
  }
}
