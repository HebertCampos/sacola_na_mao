import 'package:sacola_na_mao/models/produtos_model.dart';

class ProdutosRepository{
  final List<ProdutosModel> _produtos = [];

  Future<List<ProdutosModel>> listProdutos() async {
    await Future.delayed(const Duration(microseconds: 200));
    return _produtos;
  }

  Future<void> adicionarProduto(ProdutosModel produto) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _produtos.add(produto);
  }
}