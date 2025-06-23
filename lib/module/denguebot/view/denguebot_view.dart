import 'package:flutter/material.dart';
import '../controller/denguebot_controller.dart';

class DenguebotView extends StatefulWidget {
  const DenguebotView({super.key});

  @override
  State<DenguebotView> createState() => _DenguebotViewState();
}

class _DenguebotViewState extends State<DenguebotView> {
  final DengueBotController controller = DengueBotController();
  final List<_ChatMessage> messages = [];
  final ScrollController _scrollController = ScrollController();
  bool _showRestart = false;

  @override
  void initState() {
    super.initState();
    _showWelcome();
  }

  void _showWelcome() {
    messages.clear();
    controller.state.currentQuestion = 0; // Asegura que siempre inicia en 0
    _showRestart = false;
    messages.add(_ChatMessage(controller.questionnaire[0].text, _Sender.assistant));
    setState(() {});
    _scrollToBottom();
  }

  void _startQuiz() {
    controller.reset();
    messages.clear();
    _showRestart = false;
    messages.add(_ChatMessage("Comenzando el cuestionario...", _Sender.system));
    setState(() {});
    _scrollToBottom();
    Future.delayed(const Duration(milliseconds: 600), () {
      controller.state.currentQuestion = 1; // Salta la bienvenida y muestra la primera pregunta real
      _showNextQuestion();
    });
  }

  void _showNextQuestion() {
    if (controller.state.currentQuestion >= controller.questionnaire.length) {
      _showResult();
      return;
    }
    final q = controller.currentQ;
    messages.add(_ChatMessage(q.text, _Sender.assistant));
    setState(() {});
    _scrollToBottom();
  }

  void _onOptionSelected(int index) {
    final q = controller.currentQ;
    messages.add(_ChatMessage(q.options![index].text, _Sender.user));
    controller.answerCurrent(index);
    setState(() {});
    _scrollToBottom();
    if (!controller.isFinished) {
      Future.delayed(const Duration(milliseconds: 600), _showNextQuestion);
    } else {
      Future.delayed(const Duration(milliseconds: 600), _showResult);
    }
  }

  void _showResult() {
    messages.add(_ChatMessage("Analizando sus respuestas...", _Sender.system));
    setState(() {});
    _scrollToBottom();
    Future.delayed(const Duration(milliseconds: 1000), () {
      messages.add(_ChatMessage("*************************\n*   RESULTADO FINAL   *\n*************************", _Sender.assistant));
      setState(() {});
      _scrollToBottom();
      Future.delayed(const Duration(milliseconds: 1000), () {
        messages.add(_ChatMessage(controller.getResultMessage(), controller.state.hasAlarm ? _Sender.urgent : _Sender.assistant));
        _scrollToBottom();

        Future.delayed(const Duration(milliseconds: 2000), () {
          setState(() {
            _showRestart = true;
          });
        });
      });
    });
  }

  void _restart() {
    controller.reset();
    _showWelcome();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isQuizStarted = controller.state.currentQuestion > 0 || controller.isFinished;
    final showOptions = !controller.isFinished &&
        controller.state.currentQuestion > 0 &&
        controller.state.currentQuestion < controller.questionnaire.length;
    final q = showOptions ? controller.currentQ : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dengue Bot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, i) => _MessageBubble(messages[i]),
            ),
          ),
          if (!isQuizStarted)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: ElevatedButton(
                  onPressed: _startQuiz,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  child: const Text('Iniciar', style: TextStyle(fontSize: 18)),
                ),
              ),
            ),
          if (showOptions && q != null && q.options != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Wrap(
                spacing: 12,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  for (int i = 0; i < q.options!.length; i++)
                    ElevatedButton(
                      onPressed: () => _onOptionSelected(i),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[100],
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(q.options![i].text),
                    ),
                ],
              ),
            ),
          if (controller.isFinished && _showRestart)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: ElevatedButton(
                onPressed: _restart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Reiniciar Cuestionario', style: TextStyle(fontSize: 16)),
              ),
            ),
        ],
      ),
    );
  }
}

enum _Sender { assistant, user, system, urgent }

class _ChatMessage {
  final String text;
  final _Sender sender;
  _ChatMessage(this.text, this.sender);
}

class _MessageBubble extends StatelessWidget {
  final _ChatMessage msg;
  const _MessageBubble(this.msg);

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    Alignment align;
    switch (msg.sender) {
      case _Sender.user:
        bg = Colors.blue[700]!;
        fg = Colors.white;
        align = Alignment.centerRight;
        break;
      case _Sender.assistant:
        bg = Colors.grey[200]!;
        fg = Colors.black;
        align = Alignment.centerLeft;
        break;
      case _Sender.system:
        bg = Colors.grey[100]!;
        fg = Colors.black87;
        align = Alignment.center;
        break;
      case _Sender.urgent:
        bg = Colors.red[700]!;
        fg = Colors.white;
        align = Alignment.centerLeft;
        break;
    }
    return Align(
      alignment: align,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          msg.text,
          style: TextStyle(color: fg, fontWeight: msg.sender == _Sender.urgent ? FontWeight.bold : FontWeight.normal),
        ),
      ),
    );
  }
}
