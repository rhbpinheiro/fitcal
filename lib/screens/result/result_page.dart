import 'package:fitcal/model/calculo_model.dart';
import 'package:flutter/material.dart';

import '../../common_widgets/app_name_widget.dart';
import '../../model/articles_model.dart';
import '../../repository/articlesrepository.dart';

class ResultPage extends StatelessWidget {
  final Calculo calculo;

  const ResultPage({super.key, required this.calculo});

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
      body: FutureBuilder(
        future: fetchArticles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Erro ao acessar a api,'
                ' tente em instantes',
              ),
            );
          }

          Articles articles = snapshot.data as Articles;

          double tmb = calculo.taxaMetabolicaBasal();
          double calorias = calculo.quantidadeCalorias();
          double sugestao =
              (calorias * (calculo.objetivo == "Perda de Peso" ? 1.15 : 0.80));

          // retira da lista o que não faz parte do objetivo

          // ignore: non_constant_identifier_names
          String objetivo_retirar = calculo.objetivo != "Perda de Peso"
              ? 'weight_loss'
              : 'weight_gain';

          articles.articles.removeWhere(
            (element) => element.goal == objetivo_retirar,
          );

          return Container(
            padding: const EdgeInsets.all(24),
            child: ListView(
              children: [
                const Text(
                  'Resultado e Dicas',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  color: Colors.grey.shade800,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 8,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        'Resultado',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'TMB: ${tmb.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Calorias dia: ${calorias.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Sugestão: ${sugestao.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.white,
                ),
                Card(
                  color: Colors.grey.shade800,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 8,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        'Dicas',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      Column(
                        children: articles.articles.map(
                          (artigo) {
                            return InkWell(
                              onTap: () {
                                showModalBottomSheet<Widget>(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Scaffold(
                                      backgroundColor: Colors.grey.shade900,
                                      appBar: AppBar(
                                        toolbarHeight: 80,
                                        backgroundColor: Colors.grey.shade900,
                                        elevation: 0,
                                        title: const AppNameWidget(
                                          greenTitleColor: Colors.white,
                                        ),
                                        centerTitle: true,
                                      ),
                                      body: Container(
                                        padding: const EdgeInsets.all(24),
                                        width: double.infinity,
                                        height: double.infinity,
                                        child: Text(
                                          artigo.content ?? '',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: ListTile(
                                title: Text(
                                  artigo.title!,
                                  style: const TextStyle(color: Colors.blue),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
