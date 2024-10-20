import 'package:fitcal/common_widgets/app_name_widget.dart';
import 'package:fitcal/screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Redirecionar para HomePage após 3 segundos
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final nav = Navigator.of(context);
        await Future.delayed(const Duration(seconds: 3));
        nav.pushReplacement(
          PageTransition(
            child: const HomePage(),
            type: PageTransitionType.rightToLeft,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 15, 15, 15),
              Color.fromARGB(255, 143, 141, 141)
            ],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppNameWidget(
                greenTitleColor: Colors.white,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Calculadora de Calorias',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CircularProgressIndicator(
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
