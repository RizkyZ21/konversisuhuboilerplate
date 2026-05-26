import 'package:flutter_bloc/flutter_bloc.dart';
import 'suhu_event.dart';
import 'suhu_state.dart';

class SuhuBloc extends Bloc<SuhuEvent, SuhuState> {
  SuhuBloc()
      : super(
          SuhuState(
            satuan: "Celsius",
            hasil: "",
          ),
        ) {
    on<SetSatuanEvent>((event, emit) {
      emit(
        state.copyWith(
          satuan: event.satuan,
        ),
      );
    });

    on<KonversiEvent>((event, emit) {
      final suhu = double.tryParse(
        event.input,
      );

      if (suhu == null) {
        emit(
          state.copyWith(
            hasil: "Input tidak valid",
          ),
        );

        return;
      }

      double c;
      double f;
      double r;
      double k;

      String hasil;

      switch (state.satuan) {
        case "Celsius":
          c = suhu;
          f = (c * 9 / 5) + 32;
          r = c * 4 / 5;
          k = c + 273.15;

          hasil = "Fahrenheit: ${f.toStringAsFixed(2)}\n"
              "Reamur: ${r.toStringAsFixed(2)}\n"
              "Kelvin: ${k.toStringAsFixed(2)}";

          break;

        case "Fahrenheit":
          c = (suhu - 32) * 5 / 9;
          f = suhu;
          r = c * 4 / 5;
          k = c + 273.15;

          hasil = "Celsius: ${c.toStringAsFixed(2)}\n"
              "Reamur: ${r.toStringAsFixed(2)}\n"
              "Kelvin: ${k.toStringAsFixed(2)}";

          break;

        case "Reamur":
          c = suhu * 5 / 4;
          f = (c * 9 / 5) + 32;
          r = suhu;
          k = c + 273.15;

          hasil = "Celsius: ${c.toStringAsFixed(2)}\n"
              "Fahrenheit: ${f.toStringAsFixed(2)}\n"
              "Kelvin: ${k.toStringAsFixed(2)}";

          break;

        default:
          c = suhu - 273.15;
          f = (c * 9 / 5) + 32;
          r = c * 4 / 5;
          k = suhu;

          hasil = "Celsius: ${c.toStringAsFixed(2)}\n"
              "Fahrenheit: ${f.toStringAsFixed(2)}\n"
              "Reamur: ${r.toStringAsFixed(2)}";
      }

      emit(
        state.copyWith(
          hasil: hasil,
        ),
      );
    });
  }
}
