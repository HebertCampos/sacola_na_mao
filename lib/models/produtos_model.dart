class ProdutosModel {
  String _nome;
  double _quantidade;
  String _categoria;

  ProdutosModel({
    required String nome,
    required double quantidade,
    required String categoria,
  })  : _nome = nome,
        _quantidade = quantidade,
        _categoria = categoria;

  String getNome() => _nome;
  void setNome(String nome) => _nome = nome;

  double getQuantidade() => _quantidade;
  void setQuantidade(double quantidade) => _quantidade = quantidade;

  String getCategoria() => _categoria;
  void setCategoria(String categoria) => _categoria = categoria;
}
