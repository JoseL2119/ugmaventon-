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
  List<String> _currentCarouselItems = [];
  bool _showMainSection = true;

  final Map<String, List<String>> _faqResponses = {
    "Cuenta": [
      "¿Cómo crear una cuenta?",
      "¿Cómo recuperar mi contraseña?",
      "¿Cómo actualizar mis datos?"
    ],
    "Aventón": [
      "¿Cómo solicitar un aventón?",
      "¿Cómo ofrecer un aventón?",
      "¿Cómo ver mi historial de viajes?"
    ],
    "Recompensas": [
      "¿Cómo ver mis puntos acumulados?",
      "¿Cómo canjear premios?",
      "¿Cómo ver el ranking de usuarios?"
    ],
    "Seguridad": [
      "¿Cuáles son las políticas de seguridad?",
      "¿Cómo reportar un problema?",
      "¿Cómo contactar al soporte?"
    ],
  };

  final List<Map<String, dynamic>> _faqButtons = [
    {"text": "Cuenta", "icon": Icons.account_circle},
    {"text": "Aventón", "icon": Icons.directions_car},
    {"text": "Recompensas", "icon": Icons.star},
    {"text": "Seguridad", "icon": Icons.shield},
  ];

  final ScrollController _scrollController = ScrollController();

  void _sendMessage(String message) {
    if (message.trim().isEmpty) return;


    setState(() {
      _messages.add({
        "text": message,
        "isUser": true,
      });
      _messageController.clear();

      // Reaparecer la sección principal si el mensaje no corresponde a las opciones del carrusel
      if (!_faqResponses.keys.contains(message) && !_currentCarouselItems.contains(message)) {
        _showMainSection = true; // Mostrar la sección principal
        _currentCarouselItems = []; // Limpiar carrusel
      } else {
        _showMainSection = false; // Mantener solo el carrusel visible
      }
    });



    // Agregar respuesta automatica
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _messages.add({
          "text": "Recibí tu mensaje: $message",
          "isUser": false,
        });
      });

      // Hacer scroll automático al final del chat
      _scrollToBottom();
    });
  }

  void _showCarousel(String topic) {
    setState(() {
      _messages.clear();
      _currentCarouselItems = _faqResponses[topic] ?? [];
      _showMainSection = false;

      _messages.add({
        "text": "¿Qué dudas tienes con respecto a una $topic UGMAVENTÓN?",
        "isUser": false,
      });
    });

    // Hacer scroll automático al final del chat
    _scrollToBottom();
  }

  void _goBackToMainSection() {
    setState(() {
      _showMainSection = true; // Mostrar la sección principal
      _currentCarouselItems = []; // Limpiar carrusel
    });

    // Hacer scroll automático al final del chat
    _scrollToBottom();
  }

  void _scrollToBottom() {
    // Hacer scroll automático al final del chat sin mover el scroll hacia arriba
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
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
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mostrar sección principal si corresponde
                  if (_showMainSection)
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
                  if (_showMainSection) const SizedBox(height: 20),
                  if (_showMainSection)
                    ..._faqButtons.map((button) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ElevatedButton.icon(
                          icon:
                          Icon(button["icon"], size: 24, color: Colors.white),
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
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          onPressed: () {
                            _showCarousel(button["text"]);
                          },
                        ),
                      );
                    }).toList(),
                  // Mostrar las preguntas frecuentes en el carrusel
                  if (!_showMainSection)
                    Column(
                      children: [
                        ..._currentCarouselItems.map((item) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF003399),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 20),
                              ),
                              child: Text(
                                item,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              onPressed: () {
                                _sendMessage(item); // Enviar pregunta como mensaje
                              },
                            ),
                          );
                        }).toList(),
                        // Botón Volver
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: ElevatedButton(
                            onPressed: _goBackToMainSection,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF003399),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                            ),
                            child: const Text(
                              "Volver",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  // Mostrar mensajes
                  ..._messages.map((message) {
                    bool isUser = message["isUser"];
                    return Align(
                      alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: isUser
                              ? const Color(0xFFFFD700)
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          message["text"],
                          style: TextStyle(
                            color: isUser ? Colors.black : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      controller: _messageController,
                      onSubmitted: _sendMessage,
                      decoration: const InputDecoration(
                        hintText: "Escribe tu mensaje aquí",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    _sendMessage(_messageController.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
