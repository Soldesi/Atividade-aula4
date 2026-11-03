import 'package:flutter/material.dart';

import '../models/item_cardapio.dart';
import '../utils/formatar_valor.dart';
import 'tela_bebida.dart';

class TelaPratoPrincipal extends StatefulWidget {
  const TelaPratoPrincipal({super.key});

  @override
  State<TelaPratoPrincipal> createState() => _TelaPratoPrincipalState();
}

class _TelaPratoPrincipalState extends State<TelaPratoPrincipal> {
  static const List<ItemCardapio> opcoes = [
    ItemCardapio('Feijoada completa', 42.90),
    ItemCardapio('Filé de frango grelhado', 34.50),
    ItemCardapio('Lasanha à bolonhesa', 38.00),
    ItemCardapio('Risoto de cogumelos', 45.00),
  ];

  ItemCardapio? selecionado;

  void avancar() {
    final prato = selecionado;
    if (prato == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaBebida(prato: prato)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('1/5 - Prato principal')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Escolha o prato principal:'),
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
            ElevatedButton(
              onPressed: selecionado == null ? null : avancar,
              child: const Text('Avançar'),
            ),
          ],
        ),
      ),
    );
  }
}
