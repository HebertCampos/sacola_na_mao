import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sacola_na_mao/models/produtos_model.dart';
import 'package:sacola_na_mao/repositories/produtos_repository.dart';

class CardProdutosComponent extends StatefulWidget {
  final ProdutosModel produto;
  final Function(ProdutosModel) onDelete;
  final Function(ProdutosModel) onEdit;

  const CardProdutosComponent({
    super.key, 
    required this.produto, 
    required this.onDelete, 
    required this.onEdit,
  });

  @override
  State<CardProdutosComponent> createState() => _CardProdutosComponentState();
}

class _CardProdutosComponentState extends State<CardProdutosComponent> {
  var repo = ProdutosRepositorySQLite();

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(widget.produto.getId().toString()),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => widget.onEdit(widget.produto),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Editar',
          ),
          SlidableAction(
            onPressed: (context) => widget.onDelete(widget.produto),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Excluir',
          ),
        ],
      ),
      child: Card(
        color: widget.produto.getQuantidade().toInt() <
                widget.produto.getEstoqueMinimo()
            ? Colors.red[100]
            : Colors.blue[100],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Minimo'),
                    Text(widget.produto.getEstoqueMinimo().toInt().toString()),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  flex: 5,
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
                  )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    const Text('Estoque'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () async {
                              if (widget.produto.getQuantidade().toInt() > 0) {
                                widget.produto.setQuantidade(
                                    widget.produto.getQuantidade().toInt() - 1);

                                await repo.atualizarProduto(widget.produto);
                              }
                              setState(() {});
                            },
                            icon: const Icon(Icons.remove)),
                        Text(widget.produto.getQuantidade().toInt().toString()),
                        IconButton(
                            onPressed: () async {
                              widget.produto.setQuantidade(
                                  widget.produto.getQuantidade().toInt() + 1);
                              await repo.atualizarProduto(widget.produto);
                              setState(() {});
                            },
                            icon: const Icon(Icons.add))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
