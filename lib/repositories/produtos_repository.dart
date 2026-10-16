import 'package:sacola_na_mao/models/produtos_model.dart';
import 'package:sacola_na_mao/repositories/database_repository.dart';

abstract class ProdutosRepository {
  Future<List<ProdutosModel>> listProdutos();
  Future<void> adicionarProduto(ProdutosModel produto);
  Future<void> atualizarProduto(ProdutosModel produto);
  Future<void> deletarProduto(int id);
}

class ProdutosRepositorySQLite implements ProdutosRepository {
  @override
  Future<List<ProdutosModel>> listProdutos() async {
    List<ProdutosModel> produtos = [];

    var db = await DatabaseRepository().getDatabase();
    if (db == null) return [];
    var result = await db.rawQuery('SELECT * FROM produtos ORDER BY nome ASC');

    for (var element in result) {
      produtos.add(ProdutosModel(element,
        id: element['id'] as int,
        nome: element['nome'] as String,
        quantidade: (element['quantidade'] as num).toDouble(),
        categoria: element['categoria'] as String,
        estoqueMinimo: (element['estoqueMinimo'] as num).toDouble(),
      ));
    }

    return produtos;
  }

  @override
  Future<void> adicionarProduto(ProdutosModel produto) async {
    var db = await DatabaseRepository().getDatabase() ;
    await db?.insert('produtos', {
      'nome': produto.getNome(),
      'quantidade': produto.getQuantidade(),
      'categoria': produto.getCategoria(),
      'estoqueMinimo': produto.getEstoqueMinimo(),
    });
  }

  @override
  Future<void> atualizarProduto(ProdutosModel produto) async {
    var db = await DatabaseRepository().getDatabase() ;
    await db?.update(
      'produtos',
      {
        'nome': produto.getNome(),
        'quantidade': produto.getQuantidade(),
        'categoria': produto.getCategoria(),
        'estoqueMinimo': produto.getEstoqueMinimo(),
      },
      where: 'id = ?',
      whereArgs: [produto.getId()],
    );
  }

  @override
  Future<void> deletarProduto(int id) async {
    var db = await DatabaseRepository().getDatabase() ;
    await db?.delete(
      'produtos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}