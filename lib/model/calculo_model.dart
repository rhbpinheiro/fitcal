enum TipoNivelAtividade {
  sedentario,
  levementeAtivo,
  moderadamente,
  ativo,
  muitoAtivo,
}

class Calculo {
  double? peso;
  int? altura;
  int? idade;
  String? genero;
  TipoNivelAtividade? nivelatividade;
  String? objetivo;

  Calculo({
    this.altura,
    this.genero,
    this.idade,
    this.nivelatividade,
    this.objetivo,
    this.peso,
  });

  double taxaMetabolicaBasal() {
    double tmb = 0.00;

    if (genero == "Masculino") {
      tmb = 88.362 + (13.397 * peso!) + (4.799 * altura!) - (5.677 * idade!);
    } else {
      tmb = 447.593 + (9.247 * peso!) + (3.098 * altura!) - (4.330 * idade!);
    }

    return tmb;
  }

  double quantidadeCalorias() {
    List<double> fatorAtividadeFisica = [
      1.2, //sedentario
      1.375, //levementeAtivo
      1.55, //moderadamente
      1.55, //ativo
      1.725, //muito ativo
    ];

    return taxaMetabolicaBasal() * fatorAtividadeFisica[nivelatividade!.index];
  }
}
