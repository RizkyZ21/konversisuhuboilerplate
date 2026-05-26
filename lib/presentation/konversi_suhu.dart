import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/suhu/suhu_bloc.dart';
import '../bloc/suhu/suhu_event.dart';
import '../bloc/suhu/suhu_state.dart';

class KonversiSuhu extends StatelessWidget {
  KonversiSuhu({super.key});

  final TextEditingController suhuController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SuhuBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Konversi Suhu",
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    controller: suhuController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Masukkan Suhu",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  BlocBuilder<SuhuBloc, SuhuState>(
                    builder: (context, state) {
                      return DropdownButton<String>(
                        value: state.satuan,
                        items: ["Celsius", "Fahrenheit", "Reamur", "Kelvin"]
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          context.read<SuhuBloc>().add(
                                SetSatuanEvent(
                                  value!,
                                ),
                              );
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<SuhuBloc>().add(
                            KonversiEvent(
                              suhuController.text,
                            ),
                          );
                    },
                    child: const Text(
                      "Konversi",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<SuhuBloc, SuhuState>(
                    builder: (context, state) {
                      return Text(
                        state.hasil,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
