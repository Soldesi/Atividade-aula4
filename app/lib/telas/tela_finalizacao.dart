import 'package:flutter/material.dart';

import '../models/item_cardapio.dart';
import '../utils/formatar_valor.dart';
import 'tela_prato_principal.dart';

class TelaFinalizacao extends StatelessWidget {
  final ItemCardapio prato;
  final ItemCardapio bebida;
  final ItemCardapio sobremesa;
  final String pagamento;

  const TelaFinalizacao({
    super.key,
    required this.prato,
    required this.bebida,
    required this.sobremesa,
    required this.pagamento,
  });

  Widget linhaItem(String titulo, ItemCardapio item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text('$titulo: ${item.nome}')),
          Text(formatarValor(item.valor)),
        ],
      ),
    );
  }

  void novoPedido(BuildContext context) {
    // Remove todas as rotas e recomeça na primeira tela, sem seleções.
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const TelaPratoPrincipal()),
      (rota) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = prato.valor + bebida.valor + sobremesa.valor;

    // PopScope bloqueia o botão voltar do sistema nesta tela.
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('5/5 - Resumo do pedido'),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              linhaItem('Prato', prato),
              linhaItem('Bebida', bebida),
              linhaItem('Sobremesa', sobremesa),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    formatarValor(total),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text('Pagamento: $pagamento'),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => novoPedido(context),
                child: const Text('Novo pedido'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
