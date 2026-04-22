import 'package:flutter/material.dart';

class CardProdutosComponent extends StatefulWidget {
  const CardProdutosComponent({super.key});

  @override
  State<CardProdutosComponent> createState() => _CardProdutosComponentState();
}

class _CardProdutosComponentState extends State<CardProdutosComponent> {
  int _qtdEstoque = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Minimo'),
                          Text('1'),
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
                            const Text("Nome produto", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                            Text('Categoria produto', style: TextStyle(color: Colors.grey[500]),)
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