import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  final List<Map<String, dynamic>> _faqButtons = [
    {"text": "Cuenta", "icon": Icons.account_circle},
    {"text": "Aventón", "icon": Icons.directions_car},
    {"text": "Recompensas", "icon": Icons.star},
    {"text": "Seguridad", "icon": Icons.shield},
  ];

  void _sendMessage(String message) {
    if (message.trim().isEmpty) return;

    setState(() {
      _messages.add({
        "text": message,
        "isUser": true,
      });
    });
    _messageController.clear();

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _messages.add({
          "text": "Recibí tu mensaje: $message",
          "isUser": false,
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFCC00),
        title: Row(
          children: [
            const Icon(Icons.android, color: Color(0xFF003399), size: 32),
            const SizedBox(width: 8),
            const Text(
              "Nando",
              style: TextStyle(
                color: Color(0xFF003399),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            const Text(
              "UGMAVENTÓN",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDDEFFF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "¡Hola, soy Nando! 👋 Seré tu asistente virtual.",
                          style: TextStyle(color: Colors.black87),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "¿En qué puedo ayudarte hoy? Estos son algunos temas:",
                          style: TextStyle(color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Preguntas frecuentes
                  ..._faqButtons.map((button) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ElevatedButton.icon(
                        icon: Icon(button["icon"], size: 24, color: Colors.white),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF003399),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                        ),
                        label: Text(
                          button["text"],
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        onPressed: () {
                          _sendMessage(button["text"]);
                        },
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 16),
                  // Mensajes del chat
                  ..._messages.map((message) {
                    bool isUser = message["isUser"];
                    return Align(
                      alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isUser
                              ? const Color(0xFF003399)
                              : const Color(0xFFDDEFFF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          message["text"],
                          style: TextStyle(
                            color: isUser ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          // Barra de entrada de texto
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.emoji_emotions),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: "Escribe un mensaje",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFF003399)),
                  onPressed: () {
                    _sendMessage(_messageController.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFFFFCC00),
        unselectedItemColor: const Color(0xFF003399),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.android), label: "Bot"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }
}
