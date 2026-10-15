class ProdutosModel {
  int _id = 0;
  String _nome;
  double _quantidade;
  String _categoria;
  double _estoqueMinimo;

  ProdutosModel(Object? element, {
    int? id,
    required String nome,
    required double quantidade,
    required String categoria,
    required double estoqueMinimo,
  })  : _id = id ?? 0,
        _nome = nome,
        _quantidade = quantidade,
        _categoria = categoria,
        _estoqueMinimo = estoqueMinimo;

  int getId() => _id;
  void setId(int id) => _id = id;

  String getNome() => _nome;
  void setNome(String nome) => _nome = nome;

  double getQuantidade() => _quantidade;
  void setQuantidade(double quantidade) => _quantidade = quantidade;

  String getCategoria() => _categoria;
  void setCategoria(String categoria) => _categoria = categoria;

  double getEstoqueMinimo() => _estoqueMinimo;
  void setEstoqueMinimo(double estoqueMinimo) => _estoqueMinimo = estoqueMinimo;
}
