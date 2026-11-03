import 'package:flutter/material.dart';

import '../models/item_cardapio.dart';
import '../utils/formatar_valor.dart';
import 'tela_pagamento.dart';

class TelaSobremesa extends StatefulWidget {
  final ItemCardapio prato;
  final ItemCardapio bebida;

  const TelaSobremesa({super.key, required this.prato, required this.bebida});

  @override
  State<TelaSobremesa> createState() => _TelaSobremesaState();
}

class _TelaSobremesaState extends State<TelaSobremesa> {
  static const List<ItemCardapio> opcoes = [
    ItemCardapio('Pudim de leite', 12.00),
    ItemCardapio('Mousse de maracujá', 11.50),
    ItemCardapio('Petit gâteau', 18.00),
    ItemCardapio('Sorvete de creme', 10.00),
  ];

  ItemCardapio? selecionado;

  void avancar() {
    final sobremesa = selecionado;
    if (sobremesa == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaPagamento(
          prato: widget.prato,
          bebida: widget.bebida,
          sobremesa: sobremesa,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('3/5 - Sobremesa')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Escolha a sobremesa:'),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  for (final item in opcoes)
                    ListTile(
                      leading: Icon(
                        selecionado == item
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                      ),
                      title: Text(item.nome),
                      trailing: Text(formatarValor(item.valor)),
                      selected: selecionado == item,
                      onTap: () => setState(() => selecionado = item),
                    ),
                ],
              ),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Voltar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (rota) => rota.isFirst);
                  },
                  child: const Text('Voltar ao início'),
                ),
                ElevatedButton(
                  onPressed: selecionado == null ? null : avancar,
                  child: const Text('Avançar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
