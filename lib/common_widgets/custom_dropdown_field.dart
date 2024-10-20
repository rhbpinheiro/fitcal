import 'package:flutter/material.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final String label;
  final List<T> items;
  final T? selectedValue;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;
  final Color? dropdownColor;
  final Color? iconColor;
  final TextStyle? textStyle;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.validator,
    this.dropdownColor = const Color(0xFF424242), // Cor padrão do dropdown (cinza escuro)
    this.iconColor = Colors.white,
    this.textStyle = const TextStyle(color: Colors.white),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: textStyle), // Exibe o label do dropdown
        DropdownButtonFormField<T>(
          value: selectedValue != null && items.contains(selectedValue)
              ? selectedValue
              : null, // Verifica se o valor selecionado está nos itens
          iconEnabledColor: iconColor, // Cor do ícone
          style: textStyle, // Estilo do texto
          dropdownColor: dropdownColor, // Cor de fundo do dropdown
          decoration: const InputDecoration(
            enabledBorder:  UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white), // Cor da borda inativa
            ),
            focusedBorder:  UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white), // Cor da borda focada
            ),
          ),
          items: items.map<DropdownMenuItem<T>>((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(item.toString(), style: textStyle), // Texto branco
            );
          }).toList(),
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }
}
