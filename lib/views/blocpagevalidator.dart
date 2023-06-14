import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validation_with_bloc/blocs/validatorBloc/signinbloc.dart';
import 'package:validation_with_bloc/blocs/validatorBloc/signinevent.dart';
import 'package:validation_with_bloc/blocs/validatorBloc/signinstate.dart';

// ignore: must_be_immutable
class BlocPageValidator extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  BlocPageValidator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("bloc validator"),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    BlocBuilder<SigninBloc, SignInState>(
                      builder: (context, state) {
                        if (state is SignInErrorState) {
                          return Text(state.error,
                              style: const TextStyle(color: Colors.red));
                        } else {
                          return Container();
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: emailController,
                      onChanged: (val) {
                        BlocProvider.of<SigninBloc>(context).add(
                            SignInTextChangedEvent(
                                emailController.text, passController.text));
                      },
                      decoration:
                          const InputDecoration(hintText: "Enter Email"),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: passController,
                      onChanged: (val) {
                        BlocProvider.of<SigninBloc>(context).add(
                            SignInTextChangedEvent(
                                emailController.text, passController.text));
                      },
                      decoration:
                          const InputDecoration(hintText: "Enter Password"),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100.0),
                      child: BlocBuilder<SigninBloc, SignInState>(
                        builder: (context, state) {
                          if (state is SignInLoadingState) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => (state is SignInValidState)
                                        ? Colors.blue
                                        : Colors.grey)),
                            onPressed: () {
                              if (state is SignInValidState) {
                                BlocProvider.of<SigninBloc>(context).add(
                                    SignInSubmittedEvent(emailController.text,
                                        passController.text));
                              }
                            },
                            child: const Text(
                              "Login With Bloc",
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
