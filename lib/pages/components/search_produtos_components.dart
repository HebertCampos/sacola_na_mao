import 'package:flutter/material.dart';

class SearchProdutosComponent extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const SearchProdutosComponent({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        label: const Text('Pesquisar produto'),
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          onPressed: onClear,
          icon: const Icon(Icons.clear),
        ),
      ),
    );
  }
}
