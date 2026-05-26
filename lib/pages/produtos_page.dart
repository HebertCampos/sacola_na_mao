import 'package:flutter/material.dart';
import 'package:sacola_na_mao/models/produtos_model.dart';
import 'package:sacola_na_mao/repositories/produtos_repository.dart';

import 'components/card_produtos_component.dart';

class ProdutosPage extends StatefulWidget {
  const ProdutosPage({super.key});

  @override
  State<ProdutosPage> createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {
  TextEditingController searchController = TextEditingController();
  TextEditingController nomeProdutoController = TextEditingController();
  TextEditingController quantidadeProdutoController = TextEditingController();
  TextEditingController categoriaProdutoController = TextEditingController();
  TextEditingController estoqueProdutoController = TextEditingController();


  List<ProdutosModel> _produtosFiltrados = [];

  var produtosRepository = ProdutosRepository();
  List<ProdutosModel> _listaProdutos = [];

  Future<void> _carregarProdutos() async {
    _listaProdutos = await produtosRepository.listProdutos();
    setState(() {
    });
  }

  _salvarProduto() async{
    String nome = nomeProdutoController.text;
    double quantidade = double.tryParse(quantidadeProdutoController.text)??0;
    String categoria = categoriaProdutoController.text;
    double estoqueMinimo = double.tryParse(estoqueProdutoController.text)??0;

    await produtosRepository.adicionarProduto(ProdutosModel(nome: nome, quantidade: quantidade, categoria: categoria, estoqueMinimo: estoqueMinimo));

    nomeProdutoController.text = '';
    quantidadeProdutoController.text = '';
    categoriaProdutoController.text = '';
    estoqueProdutoController.text = '';

    _listaProdutos = await produtosRepository.listProdutos();
    _produtosFiltrados = List.from(_listaProdutos);
    
    if (mounted) {
      Navigator.of(context).pop();
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _carregarProdutos().then((_){
      _produtosFiltrados = List.from(_listaProdutos);
    });
  }

void _filtrarProdutos(String termo) {
  setState(() {
    if (termo.isEmpty) {
      _produtosFiltrados = List.from(_listaProdutos);
    } else {
      _produtosFiltrados = _listaProdutos
          .where((produto) =>
              produto.getNome().toLowerCase().contains(termo.toLowerCase()) ||
              produto.getCategoria().toLowerCase().contains(termo.toLowerCase()))
          .toList();
    }
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
                  prefixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _produtosFiltrados.length,
                itemBuilder: (context, index) {
                  return CardProdutosComponent(
                    produto: _produtosFiltrados[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
              title: const Text('Adicionar Produto'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nomeProdutoController,
                    decoration: const InputDecoration(
                      labelText: 'Nome do produto',
                    ),
                  ),
                  TextField(
                    controller: quantidadeProdutoController,
                    decoration: const InputDecoration(
                      labelText: 'Quantidade atual do produto'
                    )
                  ),
                  TextField(
                    controller: categoriaProdutoController,
                    decoration: const InputDecoration(
                      labelText: 'Categoria do produto'
                    )
                  ),
                  TextField(
                    controller: estoqueProdutoController,
                    decoration: const InputDecoration(
                      labelText: 'Estoque mínimo do produto'
                    )
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: _salvarProduto,
                  child: const Text('Salvar'),
                ),
              ],
            );
          });
        },
        tooltip: 'Adicionar novo produto',
        child: const Icon(Icons.add),
      ),
    );
  }
}
