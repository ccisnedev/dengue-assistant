class Opcion {
  final int value;
  final String text;
  Opcion({required this.value, required this.text});
}

class Pregunta {
  final String id;
  final String text;
  final List<Opcion>? options;
  final bool isMessage;

  Pregunta({
    required this.id,
    required this.text,
    this.options,
    this.isMessage = false,
  });
}

class DengueBotState {
  int currentQuestion = 0;
  Map<String, int> answers = {};
  int sintomasIniciales = 0;
  int signosAlarma = 0;
  bool probableDengue = false;
  bool finished = false;
  bool hasAlarm = false;
}