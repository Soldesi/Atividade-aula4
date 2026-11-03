import 'package:flutter/material.dart';

import '../models/item_cardapio.dart';
import 'tela_finalizacao.dart';

class TelaPagamento extends StatefulWidget {
  final ItemCardapio prato;
  final ItemCardapio bebida;
  final ItemCardapio sobremesa;

  const TelaPagamento({
    super.key,
    required this.prato,
    required this.bebida,
    required this.sobremesa,
  });

  @override
  State<TelaPagamento> createState() => _TelaPagamentoState();
}

class _TelaPagamentoState extends State<TelaPagamento> {
  static const List<String> opcoes = [
    'Pix',
    'Cartão de crédito',
    'Cartão de débito',
    'Dinheiro',
  ];

  String? selecionada;

  void finalizar() {
    final pagamento = selecionada;
    if (pagamento == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaFinalizacao(
          prato: widget.prato,
          bebida: widget.bebida,
          sobremesa: widget.sobremesa,
          pagamento: pagamento,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('4/5 - Forma de pagamento')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Escolha a forma de pagamento:'),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  for (final forma in opcoes)
                    ListTile(
                      leading: Icon(
                        selecionada == forma
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                      ),
                      title: Text(forma),
                      selected: selecionada == forma,
                      onTap: () => setState(() => selecionada = forma),
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
                  onPressed: selecionada == null ? null : finalizar,
                  child: const Text('Finalizar pedido'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
