import 'package:flutter/material.dart';
import 'package:sacola_na_mao/models/produtos_model.dart';
import 'package:sacola_na_mao/repositories/produtos_repository.dart';

class CardListaCompraComponent extends StatefulWidget {
  final ProdutosModel produto;

  const CardListaCompraComponent({
    super.key,
    required this.produto,
  });

  @override
  State<CardListaCompraComponent> createState() =>
      _CardListaCompraComponentState();
}

class _CardListaCompraComponentState extends State<CardListaCompraComponent> {
  var repo = ProdutosRepositorySQLite();

  @override
  Widget build(BuildContext context) {
    final int quantidadeAbaixo = widget.produto.getEstoqueMinimo().toInt() -
        widget.produto.getQuantidade().toInt();

    if (quantidadeAbaixo <= 0) {
      return const SizedBox.shrink();
    }

    return Card(
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Comprar:\n$quantidadeAbaixo unidades',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.produto.getNome(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        widget.produto.getCategoria(),
                        style: TextStyle(color: Colors.grey[500]),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    flex: 1,
                    child: IconButton(
                        onPressed: () async {
                          widget.produto.setQuantidade(
                              (widget.produto.getQuantidade().toInt() +
                                  quantidadeAbaixo).toDouble());

                          await repo.atualizarProduto(widget.produto);
                          setState(() {});
                        },
                        icon: const Icon(Icons.add_shopping_cart)))
              ],
            )));
  }
}
