// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../common_widgets/custom_dropdown_field.dart';
import '../../../common_widgets/custom_input_field.dart';

class FormWidget extends StatefulWidget {
  final TextEditingController tedPeso;
  final TextEditingController tedAltura;
  final TextEditingController tedIdade;
  final GlobalKey<FormState> formkey;
  // final List<Map<String, dynamic>> generoOptions;
  final String generoSelecionado;
  final List<String> nivelAtividade;
  final List<String> genero;
  final List<String> objetivo;
  final String nivelAtividadeSelecionado;
  final String objetivoSelecionado;
  final ValueChanged<String?> onNivelAtividadeChanged;
  final ValueChanged<String?> onObjetivoChanged;
  final ValueChanged<String?> onGeneroChanged;
  const FormWidget({
    super.key,
    required this.tedPeso,
    required this.tedAltura,
    required this.tedIdade,
    required this.formkey,
    required this.generoSelecionado,
    required this.nivelAtividade,
    required this.nivelAtividadeSelecionado,
    required this.objetivoSelecionado,
    required this.onGeneroChanged,
    required this.onNivelAtividadeChanged,
    required this.onObjetivoChanged,
    required this.genero,
    required this.objetivo,
  });
  @override
  // ignore: library_private_types_in_public_api
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
      child: Column(
        children: [
          CustomFormField(
            controller: widget.tedPeso,
            label: 'Peso(Kg)',
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              PesoInputFormatter(),
            ],
            validator: (value) {
              if (value!.isEmpty) {
                return 'Peso obrigatório';
              }

              return null;
            },
          ),
          CustomFormField(
            controller: widget.tedAltura,
            label: 'Altura(cm)',
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              RealInputFormatter(moeda: false),
            ],
            validator: (value) {
              if (value!.isEmpty) {
                return 'Altura obrigatória';
              }
              int altura = int.tryParse(value) ?? 0;
              if (altura < 50 || altura > 220) {
                return 'Altura válida de 50cm a 220cm';
              }
              return null;
            },
          ),
          CustomFormField(
            controller: widget.tedIdade,
            label: 'Idade',
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Idade obrigatória';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          CustomDropdownField<String>(
            label: 'Gênero',
            items: widget.genero,
            selectedValue: widget.generoSelecionado,
            onChanged: widget.onGeneroChanged,
          ),
          const SizedBox(
            height: 15,
          ),
          CustomDropdownField<String>(
            label: 'Nível de Atividade',
            items: widget.nivelAtividade,
            selectedValue: widget.nivelAtividadeSelecionado,
            onChanged: widget.onNivelAtividadeChanged,
          ),
          const SizedBox(
            height: 15,
          ),
          CustomDropdownField<String>(
            label: 'Objetivo',
            items: widget.objetivo,
            selectedValue: widget.objetivoSelecionado,
            onChanged: widget.onObjetivoChanged,
          ),
        ],
      ),
    );
  }
}
