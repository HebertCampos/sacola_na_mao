import 'package:flutter/material.dart';
import 'package:sacola_na_mao/models/produtos_model.dart';

class CardProdutosComponent extends StatefulWidget {
  final ProdutosModel produto;
  const CardProdutosComponent({super.key, required this.produto});

  @override
  State<CardProdutosComponent> createState() => _CardProdutosComponentState();
}

class _CardProdutosComponentState extends State<CardProdutosComponent> {
  late int _qtdEstoque = 0;

  @override
  void initState(){
    super.initState();
    _qtdEstoque = widget.produto.getQuantidade().toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _qtdEstoque < widget.produto.getEstoqueMinimo() ? Colors.red[100] : Colors.blue[100],
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
                            Text(widget.produto.getNome(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                            Text(widget.produto.getCategoria(), style: TextStyle(color: Colors.grey[500]),)
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
                                  onPressed: () {
                                    setState(() {
                                      if (_qtdEstoque > 0) {
                                        _qtdEstoque--;
                                      }
                                    });
                                  },
                                  icon: const Icon(Icons.remove)),
                              Text(_qtdEstoque.toString()),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _qtdEstoque++;
                                    });
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
            );
  }
}