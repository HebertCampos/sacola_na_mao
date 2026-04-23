import 'package:flutter/material.dart';
import 'package:sacola_na_mao/models/produtos_model.dart';

import 'components/card_produtos_component.dart';

class ProdutosPage extends StatefulWidget {
  const ProdutosPage({super.key});

  @override
  State<ProdutosPage> createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {
  TextEditingController searchController = TextEditingController();

  final List<ProdutosModel> _produtos = [
    ProdutosModel(nome: 'Arroz', quantidade: 2, categoria: 'Grãos', estoqueMinimo: 1),
    ProdutosModel(nome: 'Biscoito Maizena', quantidade: 3, categoria: 'Lanche', estoqueMinimo: 4),
    ProdutosModel(nome: 'Feijão', quantidade: 30, categoria: 'Grãos', estoqueMinimo: 5),
    ProdutosModel(nome: 'Macarrão', quantidade: 25, categoria: 'Massas', estoqueMinimo: 8),
    ProdutosModel(nome: 'Óleo', quantidade: 100, categoria: 'Temperos', estoqueMinimo: 20),
    ProdutosModel(nome: 'Sal', quantidade: 5, categoria: 'Temperos', estoqueMinimo: 10),
  ];

  List<ProdutosModel> _produtosFiltrados = [];

  @override
  void initState(){
    super.initState();
    _produtosFiltrados = List.from(_produtos);
  }

  void _filtrarProdutos(String termo) {
    setState(() {
      _produtosFiltrados = _produtos
          .where((produto) =>
              produto.getNome().toLowerCase().contains(termo.toLowerCase()) ||
              produto.getCategoria().toLowerCase().contains(termo.toLowerCase()))
          .toList();
    });
  }


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
              onChanged: _filtrarProdutos,
              decoration: const InputDecoration(
                label: Text('Pesquisar produto'),
                prefixIcon: Icon(Icons.search)
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(child: ListView.builder(
              itemCount: _produtosFiltrados.length,
              itemBuilder: (context, index){
                return CardProdutosComponent(produto: _produtosFiltrados[index],);
              }
              )),
          ],
        ),
      ),
    );
  }
}
