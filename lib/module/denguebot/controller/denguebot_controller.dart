import '../model/denguebot_model.dart';

class DengueBotController {
  final DengueBotState state = DengueBotState();

  final List<Pregunta> questionnaire = [
    Pregunta(
      id: "welcome",
      text: "Bienvenido al Asistente de Diagnóstico de Dengue. Este asistente te hará unas preguntas para evaluar tus síntomas. Presiona 'Iniciar' para comenzar.",
      isMessage: true,
    ),
    Pregunta(
      id: "fiebre",
      text: "1. ¿Tiene fiebre actualmente o en los últimos días?",
      options: [
        Opcion(value: 1, text: "Sí"),
        Opcion(value: 2, text: "No"),
      ],
    ),
    Pregunta(
      id: "dolorCabeza",
      text: "2. ¿Ha tenido dolor de cabeza muy intenso?",
      options: [
        Opcion(value: 1, text: "Sí"),
        Opcion(value: 2, text: "No"),
      ],
    ),
    Pregunta(
      id: "dolorMuscular",
      text: "3. ¿Siente dolores fuertes en músculos o articulaciones?",
      options: [
        Opcion(value: 1, text: "Sí"),
        Opcion(value: 2, text: "No"),
      ],
    ),
    Pregunta(
      id: "dolorOcular",
      text: "4. ¿Siente dolor detrás de los ojos al moverlos o mirar?",
      options: [
        Opcion(value: 1, text: "Sí"),
        Opcion(value: 2, text: "No"),
      ],
    ),
    Pregunta(
      id: "nauseas",
      text: "5. ¿Ha tenido náuseas o vómitos?",
      options: [
        Opcion(value: 1, text: "Sí"),
        Opcion(value: 2, text: "No"),
      ],
    ),
    Pregunta(
      id: "rash",
      text: "6. ¿Ha notado sarpullido o erupciones en la piel?",
      options: [
        Opcion(value: 1, text: "Sí"),
        Opcion(value: 2, text: "No"),
      ],
    ),
    Pregunta(
      id: "dolorAbdomen",
      text: "7. ¿Tiene dolor abdominal muy fuerte?",
      options: [
        Opcion(value: 1, text: "Sí"),
        Opcion(value: 2, text: "No"),
      ],
    ),
    Pregunta(
      id: "sangrado",
      text: "8. ¿Ha notado algún sangrado inusual?",
      options: [
        Opcion(value: 1, text: "Sí"),
        Opcion(value: 2, text: "No"),
      ],
    ),
    Pregunta(
      id: "debilidad",
      text: "9. ¿Se siente extremadamente débil, somnoliento/a o muy inquieto/a?",
      options: [
        Opcion(value: 1, text: "Sí"),
        Opcion(value: 2, text: "No"),
      ],
    ),
    Pregunta(
      id: "dificultadRespirar",
      text: "10. ¿Tiene dificultad para respirar o respiración muy acelerada?",
      options: [
        Opcion(value: 1, text: "Sí"),
        Opcion(value: 2, text: "No"),
      ],
    ),
    Pregunta(
      id: "zonaRiesgo",
      text: "11. ¿Vive o viajó recientemente en una zona con casos de dengue?",
      options: [
        Opcion(value: 1, text: "Sí"),
        Opcion(value: 2, text: "No"),
        Opcion(value: 3, text: "No sabe"),
      ],
    ),
  ];

  void reset() {
    state.currentQuestion = 0;
    state.answers.clear();
    state.sintomasIniciales = 0;
    state.signosAlarma = 0;
    state.probableDengue = false;
    state.finished = false;
    state.hasAlarm = false;
  }

  Pregunta get currentQ => questionnaire[state.currentQuestion];

  Pregunta get nextQ => 
      (state.currentQuestion + 1 < questionnaire.length) 
      ? questionnaire[state.currentQuestion + 1] 
      : Pregunta(id: "end", text: "Cuestionario finalizado.", isMessage: true)
  ;

  bool get isFinished => state.finished;

  void answerCurrent(int optionIndex) {
    final q = questionnaire[state.currentQuestion];
    state.answers[q.id] = q.options![optionIndex].value;
    state.currentQuestion++;
    if (state.currentQuestion >= questionnaire.length) {
      _calculateResults();
      state.finished = true;
    }
  }

  void _calculateResults() {
    final a = state.answers;
    if (a['dolorCabeza'] == 1) state.sintomasIniciales++;
    if (a['dolorMuscular'] == 1) state.sintomasIniciales++;
    if (a['dolorOcular'] == 1) state.sintomasIniciales++;
    if (a['nauseas'] == 1) state.sintomasIniciales++;
    if (a['rash'] == 1) state.sintomasIniciales++;

    if (a['dolorAbdomen'] == 1) state.signosAlarma++;
    if (a['sangrado'] == 1) state.signosAlarma++;
    if (a['debilidad'] == 1) state.signosAlarma++;
    if (a['dificultadRespirar'] == 1) state.signosAlarma++;

    state.probableDengue = (a['fiebre'] == 1 && state.sintomasIniciales >= 2);
    state.hasAlarm = state.signosAlarma > 0;
  }

  String getResultMessage() {
    if (state.hasAlarm) {
      return "[!] SIGNOS DE ALARMA DETECTADOS: POSIBLE DENGUE GRAVE\n    --> BUSQUE ATENCIÓN MÉDICA DE INMEDIATO <--";
    } else if (state.probableDengue) {
      return "[!] POSIBLE DENGUE NO GRAVE\n    Acuda a evaluación médica lo antes posible.";
    } else {
      return "[ ] POCO PROBABLE DENGUE\n    Si sus síntomas persisten o empeoran, consulte con un médico.";
    }
  }
}