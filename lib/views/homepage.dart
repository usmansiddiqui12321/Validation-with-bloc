import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validation_with_bloc/blocs/validatorBloc/signinbloc.dart';
import 'package:validation_with_bloc/views/blocpagevalidator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => Colors.blue)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      // ! BLOC Provider => for Bloc to be availale in that specific Page
                      builder: (context) => BlocProvider(
                        create: (context) => SigninBloc(),
                        child: BlocPageValidator(),
                      ),
                    ));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: const Text(
                  "Login With Bloc",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
