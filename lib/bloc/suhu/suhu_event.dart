abstract class SuhuEvent {}

class SetSatuanEvent extends SuhuEvent {
  final String satuan;
  SetSatuanEvent(this.satuan);
}

class KonversiEvent extends SuhuEvent {
  final String input;
  KonversiEvent(this.input);
}
