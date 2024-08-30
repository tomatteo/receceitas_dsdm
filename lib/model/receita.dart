class Receita {
  final int id;
  final String nome;
  final String image;
  final String modopreparo;
  final String ingredientes;

  Receita({
    required this.id,
    required this.nome,
    required this.image,
    required this.modopreparo,
    required this.ingredientes,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'nome': nome,
      'image': image,
      'modopreparo': modopreparo,
      'ingredientes': ingredientes,
    };
  }

  // Adicionando o método fromMap
  factory Receita.fromMap(Map<String, dynamic> map) {
    return Receita(
      id: map['id'],
      nome: map['nome'],
      image: map['image'],
      modopreparo: map['modopreparo'],
      ingredientes: map['ingredientes'],
    );
  }

  @override
  String toString() {
    return 'Receita: {ID:$id, Nome: $nome, Image: $image, Modopreparo $modopreparo, Ingredientes $ingredientes}';
  }
}
