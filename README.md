# FitCal

FitCal é um aplicativo Flutter desenvolvido para calcular a Taxa Metabólica Basal (TMB) e sugerir calorias com base em dados do usuário. O aplicativo também armazena o histórico de cálculos para futuras consultas.

![Logo do FitCal](assets/images/Calculadora.png)

## Índice

- [Instalação](#instalação)
- [Dependências](#dependências)
- [Instruções de Uso](#instruções-de-uso)
- [Contribuindo](#contribuindo)
- [Licença](#licença)

## Instalação

## Pré-requisitos

Antes de iniciar, certifique-se de ter as seguintes ferramentas instaladas:

- **Flutter SDK** (versão mínima: `3.24.3`)
- **Dart SDK** (incluso com Flutter)
- **Android Studio** ou **Visual Studio Code**
- **Emulador Android** ou **dispositivo físico** para rodar o aplicativo

## Passos de Instalação

1. Clone este repositório:

   ```bash
   git clone https://github.com/rhbpinheiro/fitcal.git

   ```

2. Navegue até a pasta do projeto:
   ...bash
   cd fitcal
   ...

3. Instale as dependências:
   ...bash
   flutter pub get
   ...

4. Execute o projeto:
   ...bash
   flutter run
   ...

## Dependências

O projeto utiliza as seguintes dependências:
...yalm
dependencies:
flutter:
sdk: flutter
cupertino_icons: ^1.0.8
brasil_fields: ^1.15.0
shared_preferences: ^2.3.2
http: ^1.2.2
page_transition: ^2.0.9
...

Essas bibliotecas são usadas para funcionalidades como navegação de páginas, persistência de dados localmente e manipulação de campos brasileiros.

## Intruções de uso

Funcionalidades

- Cálculo de TMB e Calorias: Insira seus dados para calcular a Taxa Metabólica Basal (TMB) e receber sugestões de calorias.
- Histórico de Cálculos: Acompanhe o histórico de cálculos realizados, podendo excluir cálculos individualmente ou todo o histórico.
- Interface Intuitiva: O aplicativo possui uma interface simples que facilita o uso para todos os usuários.

## Como Usar

Abra o aplicativo.

- Preencha os dados solicitados para calcular a TMB.
- Visualize o resultado diretamente na tela.
- Navegue até a tela de Histórico para ver seus cálculos anteriores.
- Use o botão de Excluir para remover um cálculo específico ou todo o histórico.

## Contribuindo

Contribuições são bem-vindas! Sinta-se à vontade para enviar pull requests ou relatar issues.

Passos para contribuir:

1. Faça um fork deste repositório.

2. Crie uma nova branch com sua feature:
   ...bash
   git checkout -b minha-feature
   ...

3. Faça as modificações necessárias e faça o commit:
   ...bash
   git commit -m "Descrição da feature"
   ...

4. Envie as alterações para o seu repositório:
   ...bash
   git push origin minha-feature
   ...

5. Abra um pull request para o repositório original.

## Licença

- Este projeto está licenciado sob a licença MIT. Consulte o arquivo [LICENSE](./LICENSE) para mais detalhes.

##

- [Documentação Flutter](https://docs.flutter.dev/)
- [Laboratório: Escreva seu primeiro app Flutter](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Exemplos úteis de Flutter](https://docs.flutter.dev/cookbook)
