import 'dart:convert';

import 'package:fitcal/common_widgets/custom_button.dart';
import 'package:fitcal/model/calculo_model.dart';
import 'package:fitcal/screens/home/widgets/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common_widgets/app_name_widget.dart';
import '../history/history_page.dart';
import '../result/result_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formkey = GlobalKey<FormState>();

  Calculo calculo = Calculo();

  String nivelAtividadeSelecionado = '';
  String generoSelecionado = '';
  String objetivoSelecionado = '';

  final List<String> nivelAtividade = [
    'Sedentário',
    'Levemente Ativo',
    'Moderadamente',
    'Ativo',
    'Muito Ativo',
  ];
  final List<String> genero = [
    'Masculino',
    'Feminino',
  ];
  final List<String> objetivo = [
    'Perda de Peso',
    'Ganho de Peso',
  ];

  final TextEditingController tedPeso = TextEditingController();
  final TextEditingController tedAltura = TextEditingController();
  final TextEditingController tedIdade = TextEditingController();

  Future<void> salvarCalculo(
      double tmb, double calorias, double sugestao) async {
    final prefs = await SharedPreferences.getInstance();

    // Criar um mapa para armazenar os dados
    Map<String, dynamic> calculoData = {
      'tmb': tmb,
      'calorias': calorias,
      'sugestao': sugestao,
      'data': DateTime.now()
          .toIso8601String(), // Para rastrear quando o cálculo foi feito
    };

    // Salvar os dados como uma lista no SharedPreferences
    List<String> historico = prefs.getStringList('historico') ?? [];
    historico.add(json.encode(calculoData));
    await prefs.setStringList('historico', historico);
  }

  void limparCampos() {
    // Limpa os TextEditingControllers dos campos de texto
    tedAltura.clear();
    tedPeso.clear();
    tedIdade.clear();

    // Reseta as seleções para os valores iniciais
    setState(() {
      generoSelecionado = ''; // Resetando para um valor padrão
      nivelAtividadeSelecionado = ''; // Limpa o nível de atividade selecionado
      objetivoSelecionado = ''; // Resetando para um valor padrão
    });
  }

  void realizarCalculo() {
    // Criação do objeto de cálculo
    Calculo calculo = Calculo(
      altura: int.parse(tedAltura.text),
      genero: generoSelecionado,
      idade: int.parse(tedIdade.text),
      nivelatividade: TipoNivelAtividade.values.elementAt(
        nivelAtividade.indexOf(nivelAtividadeSelecionado),
      ),
      objetivo: objetivoSelecionado,
      peso: double.tryParse(tedPeso.text) ?? 0,
    );

    // Aqui você pode realizar o cálculo com o objeto 'calculo'
    double tmb = calculo.taxaMetabolicaBasal();
    double calorias = calculo.quantidadeCalorias();
    double sugestao =
        (calorias * (calculo.objetivo == "Perda de Peso" ? 1.15 : 0.80));

    // Salvar os dados no SharedPreferences
    salvarCalculo(tmb, calorias, sugestao);

    //Navegar para a tela de resultado
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeft,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 300),
        child: ResultPage(
          calculo: calculo,
        ),
      ),
    );

    // Limpa os campos e as seleções após o cálculo
    limparCampos();
  }

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
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Espaço entre o topo e o botão
          children: [
            const Text(
              'Calculadora de Calorias',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              // Nagegar para a tela de historico
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  duration: const Duration(milliseconds: 300),
                                  reverseDuration:
                                      const Duration(milliseconds: 300),
                                  child: const HistoryPage(),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.folder_outlined,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                          const Text(
                            'Histórico',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      )
                    ]),
                    FormWidget(
                      formkey: formkey,
                      tedPeso: tedPeso,
                      tedAltura: tedAltura,
                      tedIdade: tedIdade,
                      genero: genero,
                      nivelAtividade: nivelAtividade,
                      nivelAtividadeSelecionado: nivelAtividadeSelecionado,
                      objetivoSelecionado: objetivoSelecionado,
                      generoSelecionado: generoSelecionado,
                      objetivo: objetivo,
                      onNivelAtividadeChanged: (String? value) {
                        setState(() {
                          nivelAtividadeSelecionado = value!;
                        });
                      },
                      onGeneroChanged: (String? value) {
                        setState(() {
                          generoSelecionado = value!;
                        });
                      },
                      onObjetivoChanged: (String? value) {
                        setState(() {
                          objetivoSelecionado = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            WidgetButtonCalcularCalorias(
              label: 'Calcular Calorias',
              onPressed: () {
                if (!formkey.currentState!.validate()) {
                  return;
                }
                realizarCalculo();
              },
            ),
          ],
        ),
      ),
    );
  }
}
