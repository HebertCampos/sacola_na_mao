import 'package:flutter/material.dart';
import 'package:sacola_na_mao/models/produtos_model.dart';
import 'package:sacola_na_mao/pages/components/search_produtos_components.dart';
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

  var produtosRepository = ProdutosRepositorySQLite();
  List<ProdutosModel> _listaProdutos = [];

  Future<void> _carregarProdutos() async {
    _listaProdutos = await produtosRepository.listProdutos();
    setState(() {});
  }

  _salvarProduto({ProdutosModel? produtoEditando}) async {
    String nome = nomeProdutoController.text;
    double quantidade = double.tryParse(quantidadeProdutoController.text) ?? 0;
    String categoria = categoriaProdutoController.text;
    double estoqueMinimo = double.tryParse(estoqueProdutoController.text) ?? 0;

    if (produtoEditando == null) {
      // Adicionar novo
      await produtosRepository.adicionarProduto(ProdutosModel(null,
          nome: nome,
          quantidade: quantidade,
          categoria: categoria,
          estoqueMinimo: estoqueMinimo));
    } else {
      // Atualizar existente
      produtoEditando.setNome(nome);
      produtoEditando.setQuantidade(quantidade);
      produtoEditando.setCategoria(categoria);
      produtoEditando.setEstoqueMinimo(estoqueMinimo);
      await produtosRepository.atualizarProduto(produtoEditando);
    }

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
    _carregarProdutos().then((_) {
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
                produto
                    .getCategoria()
                    .toLowerCase()
                    .contains(termo.toLowerCase()))
            .toList();
      }
    });
  }

  void _abrirDialogo({ProdutosModel? produto}) {
    if (produto != null) {
      nomeProdutoController.text = produto.getNome();
      quantidadeProdutoController.text = produto.getQuantidade().toString();
      categoriaProdutoController.text = produto.getCategoria();
      estoqueProdutoController.text = produto.getEstoqueMinimo().toString();
    } else {
      nomeProdutoController.clear();
      quantidadeProdutoController.clear();
      categoriaProdutoController.clear();
      estoqueProdutoController.clear();
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:
                Text(produto == null ? 'Adicionar Produto' : 'Editar Produto'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nomeProdutoController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Nome do produto',
                  ),
                ),
                TextField(
                    controller: quantidadeProdutoController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Quantidade atual do produto')),
                TextField(
                    controller: categoriaProdutoController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        labelText: 'Categoria do produto')),
                TextField(
                    controller: estoqueProdutoController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Estoque mínimo do produto')),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () => _salvarProduto(produtoEditando: produto),
                child: const Text('Salvar'),
              ),
            ],
          );
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
            SearchProdutosComponent(
              controller: searchController,
              onChanged: _filtrarProdutos,
              onClear: () {
                searchController.clear();
                _filtrarProdutos('');
              },
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
                    onDelete: (produto) async {
                      await produtosRepository.deletarProduto(produto.getId());
                      _listaProdutos = await produtosRepository.listProdutos();
                      _produtosFiltrados = List.from(_listaProdutos);
                      setState(() {});
                    },
                    onEdit: (produto) {
                      _abrirDialogo(produto: produto);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _abrirDialogo();
        },
        tooltip: 'Adicionar novo produto',
        child: const Icon(Icons.add),
      ),
    );
  }
}
