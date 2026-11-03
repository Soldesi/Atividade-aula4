import 'package:flutter/material.dart';

import '../models/item_cardapio.dart';
import '../utils/formatar_valor.dart';
import 'tela_sobremesa.dart';

class TelaBebida extends StatefulWidget {
  final ItemCardapio prato;

  const TelaBebida({super.key, required this.prato});

  @override
  State<TelaBebida> createState() => _TelaBebidaState();
}

class _TelaBebidaState extends State<TelaBebida> {
  static const List<ItemCardapio> opcoes = [
    ItemCardapio('Suco de laranja', 9.00),
    ItemCardapio('Refrigerante', 7.50),
    ItemCardapio('Água mineral', 4.00),
    ItemCardapio('Cerveja artesanal', 16.00),
  ];

  ItemCardapio? selecionado;

  void avancar() {
    final bebida = selecionado;
    if (bebida == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TelaSobremesa(prato: widget.prato, bebida: bebida),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('2/5 - Bebida')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Escolha a bebida:'),
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
