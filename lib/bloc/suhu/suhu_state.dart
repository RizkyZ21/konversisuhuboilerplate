class SuhuState {
  final String satuan;
  final String hasil;

  SuhuState({this.satuan = "Celsius", this.hasil = ""});

  SuhuState copyWith({String? satuan, String? hasil}) {
    return SuhuState(satuan: satuan ?? this.satuan, hasil: hasil ?? this.hasil);
  }
}
