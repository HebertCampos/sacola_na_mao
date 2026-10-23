import 'package:flutter/material.dart';
import 'package:sacola_na_mao/models/produtos_model.dart';
import 'package:sacola_na_mao/pages/components/card_lista_comprs_component.dart';
import 'package:sacola_na_mao/pages/components/search_produtos_components.dart';
import 'package:sacola_na_mao/repositories/produtos_repository.dart';

class ListaCompraPage extends StatefulWidget {
  const ListaCompraPage({super.key});

  @override
  State<ListaCompraPage> createState() => _ListaCompraPageState();
}

class _ListaCompraPageState extends State<ListaCompraPage> {
  TextEditingController searchController = TextEditingController();

  List<ProdutosModel> _produtosFiltrados = [];

  var produtosRepository = ProdutosRepositorySQLite();
  List<ProdutosModel> _listaProdutos = [];

  Future<void> _carregarProdutos() async {
    _listaProdutos = await produtosRepository.listProdutos();
    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Compra'),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(8),
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
                      return CardListaCompraComponent(
                          produto: _produtosFiltrados[index]);
                    },
                  ),
                ),
              ],
            )));
  }
}
