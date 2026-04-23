import 'package:flutter/material.dart';

import 'components/card_produtos_component.dart';

class ProdutosPage extends StatefulWidget {
  const ProdutosPage({super.key});

  @override
  State<ProdutosPage> createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: (value) => 
                setState(() {
                  print(value);
                }),
              decoration: const InputDecoration(
                label: Text('Pesquisar produto'),
                prefixIcon: Icon(Icons.search)
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const CardProdutosComponent(),
          ],
        ),
      ),
    );
  }
}
