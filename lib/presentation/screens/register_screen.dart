import 'package:bloc_exercises/presentation/blocs/register/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro"),
      ),
      body:
          BlocProvider(create: (_) => RegisterCubit(), child: _RegisterView()),
    );
  }
}

class _RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final registerCubit = context.watch<RegisterCubit>();
    final username = registerCubit.state.username;
    final password = registerCubit.state.password;
    final email = registerCubit.state.email;
    final isValid = registerCubit.state.isValid;

    return Form(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const FlutterLogo(size: 100),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                      label: "Nombre de usuario",
                      onChanged: context.read<RegisterCubit>().usernameChanged,
                      errorMessage: username.errorMessage,
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                        label: "Correo electronico",
                        onChanged: context.read<RegisterCubit>().emailChanged,
                        errorMessage: email.errorMessage,
                    ),
                    const SizedBox(height: 15),
                    CustomTextFormField(
                        label: "Contraseña",
                        obscureText: true,
                        onChanged:
                            context.read<RegisterCubit>().passwordChanged,
                        errorMessage: password.errorMessage),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: FilledButton.tonalIcon(
              onPressed: isValid ? () => context.read<RegisterCubit>().onSubmit() : null,
              icon: const Icon(Icons.save),
              label: const Text("Crear usuario"),
              style: FilledButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
