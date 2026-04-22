import 'package:flutter/material.dart';

import 'produtos_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Minha pagina inicial'),
      //   centerTitle: true,
      // ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        children: [
          Container(
            color: Colors.red,
            child: const Text('p1'),
          ),
          const ProdutosPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Início',
              tooltip: 'Pagina de início com as informações dos produtos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Produtos',
              tooltip: 'Pagina de cadastro de produtos e categorias'),
        ],
        currentIndex: _selectedIndex,
        onTap: (value) => setState(() {
          _pageController.jumpToPage(value);
        }),
      ),
    );
  }
}
