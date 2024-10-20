import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common_widgets/app_name_widget.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Future<List<Map<String, dynamic>>> carregarHistorico() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> historico = prefs.getStringList('historico') ?? [];
    return historico
        .map((item) => json.decode(item) as Map<String, dynamic>)
        .toList();
  }

  Future<void> excluirHistorico() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('historico'); // Remove o histórico
    setState(() {}); // Atualiza a tela
  }

  Future<void> excluirCalculo(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> historico = prefs.getStringList('historico') ?? [];

    // Remove o cálculo específico
    historico.removeAt(index);
    await prefs.setStringList('historico', historico);
    setState(() {}); // Atualiza a tela
  }

  String formatarData(String dataString) {
    DateTime data = DateTime.parse(dataString);
    String dia = data.day.toString().padLeft(2, '0');
    String mes = data.month.toString().padLeft(2, '0');
    String ano = data.year.toString();
    return '$dia/$mes/$ano';
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        elevation: 0,
        title: const AppNameWidget(
          greenTitleColor: Colors.white,
        ),
        centerTitle: true,
        actions: [
          // Botão de excluir histórico visível apenas se houver histórico salvo
          FutureBuilder<List<Map<String, dynamic>>>(
            future: carregarHistorico(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    // Excluir o histórico com um alerta de confirmação
                    bool? confirmacao = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Excluir Histórico'),
                        content: const Text(
                            'Você tem certeza que deseja excluir todo o histórico?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('Excluir'),
                          ),
                        ],
                      ),
                    );

                    if (confirmacao == true) {
                      await excluirHistorico();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Histórico excluído com sucesso!')),
                      );
                    }
                  },
                );
              }
              return const SizedBox
                  .shrink(); // Retorna um widget vazio se não houver histórico
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: carregarHistorico(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum cálculo encontrado.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          final historico = snapshot.data!;
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Histórico de Cálculos',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: historico.length,
                  itemBuilder: (context, index) {
                    final calculo = historico[index];
                    return Card(
                      color: Colors.grey.shade800,
                      margin: const EdgeInsets.all(10),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'TMB: ${calculo['tmb'].toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Calorias: ${calculo['calorias'].toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Sugestão: ${calculo['sugestao'].toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Data: ${formatarData(calculo['data'])}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                // Confirmar a exclusão do cálculo
                                bool? confirmacao = await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Excluir Cálculo'),
                                    content: const Text(
                                        'Você tem certeza que deseja excluir este cálculo?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: const Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: const Text('Excluir'),
                                      ),
                                    ],
                                  ),
                                );

                                if (confirmacao == true) {
                                  await excluirCalculo(index);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Cálculo excluído com sucesso!')),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
