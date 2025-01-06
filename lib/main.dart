import 'package:flutter/material.dart';
import 'package:string_similarity/string_similarity.dart';

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
  bool _isWaitingForResponse = false;
  final Map<String, List<String>> _faqResponses = {
    "Cuenta": [
      "¿Cómo puedo registrarme en UGMAventón?",
      "¿Cómo puedo recuperar mi contraseña?",
      "¿Qué necesito para cambiar de una cuenta de pasajero a conductor?",
      "¿Qué necesito para cambiar de una cuenta de conductor a pasajero?"
    ],
    "Aventón": [
      "¿Cómo puedo ofertar un aventón?",
      "¿Cómo puedo aceptar un aventón?",
      "¿Puedo cancelar una oferta de aventón?",
      "¿Cómo puedo cancelar un aventón?",
      "¿Qué hago si mi conductor/pasajero no se presenta?"
    ],
    "Recompensas": [
      "¿Cómo funcionan las recompensas para un conductor en UGMAventón?",
      "¿Qué hago si no estoy satisfecho con el servicio?"
    ],
    "Seguridad": [
      "¿Es seguro usar UGMAventón?",
      "¿Cómo reporto un problema o comportamiento inapropiado?",
      "¿Cómo puedo reportar un objeto perdido?"
    ],
  };

  final Map<String, String> _faqAnswers = {
    "¿Cómo puedo registrarme en UGMAventón?": "Para registrarte en la aplicación, debes ingresar tu correo y crear una contraseña segura. Una vez verificado el correo, debes proporcionar tu cédula de identidad, el carnet vigente de la universidad y una captura de pantalla de la inscripción del sistema Ternanet, luego sigue las instrucciones para verificar tu identidad y elegir el modo con el que se creará tu cuenta.",
    "¿Cómo puedo recuperar mi contraseña?": "En caso de haber olvidado la contraseña de tu cuenta debes darle click al enlace del login, el cual te llevará a una pantalla dónde debes ingresar el correo con el cual te registraste. Ya verificada la información proporcionada, te llegará al correo un enlace con el cuál podrás crear una nueva contraseña. ¡Asegúrate de recordarla y que cumpla con los estándares de seguridad!",
    "¿Qué necesito para cambiar de una cuenta de pasajero a conductor?": "Para cambiar tu cuenta de pasajero a conductor solo es necesario que proporciones tu licencia de conducir y certificado médico. Una vez el equipo de UGMAventón confirme tu información podrás empezar a ofertar viajes. ¡Así de fácil!",
    "¿Qué necesito para cambiar de una cuenta de conductor a pasajero?": "Para cambiar tu cuenta de conductor a pasajero no es necesario que proporciones información adicional. Una vez creada tu cuenta de conductor puedes pasar de esta a una cuenta de pasajero sin problemas. ¿Qué esperas para comenzar a usar UGMAventón?",
    "¿Cómo puedo ofertar un aventón?": "Para ofrecer un aventón debes ir a la pantalla de inicio, marcar el punto de origen, el destino y la ruta que tomarás, por último selecciona la hora de salida y listo. Dándole click al botón subir oferta, se publicará la información del aventón a todos los pasajeros cercanos interesados. ¿Qué esperas para empezar a dar aventones?",
    "¿Cómo puedo aceptar un aventón?": "Las ofertas disponibles aparecerán listadas en la pantalla de inicio, si te interesa un aventón en específico solo debes darle click el botón aceptar oferta, y al conductor se le notificará para que terminen de gestionar el aventón. ¡No te preocupes más por cómo te trasladarás a la universidad!",
    "¿Puedo cancelar una oferta de aventón?": "Sí, si eres un conductor y por algún motivo debes cancelar el aventón que ofertaste puedes hacerlo, sin embargo, recomendamos hacerlo con al menos 1 hora de anticipación para evitar penalizaciones en tu puntuación. Para cancelar la oferta debes ir a la página principal, darle click a tu aventón ofertado y luego clickear el botón cancelar oferta, te pedirá confirmación, selecciona la opción aceptar y listo, se habrá cancelado tu oferta de aventón.",
    "¿Cómo puedo cancelar un aventón?": "Si un aventón no te resulta conveniente puedes cancelarlo. Para ello es necesario que te comuniques con el conductor, de modo que este pueda actualizar el número de puestos disponibles en su vehículo. Recuerda hacerlo con anticipación, ese aventón podría ser de gran necesidad para otro estudiante.",
    "¿Qué hago si mi conductor/pasajero no se presenta?": "Si ha llegado la hora pautada para el aventón y el conductor o pasajero no se presenta pasados 5 minutos, debes ir a  la opción no se presentó en la app. El equipo de UGMAventón revisará la situación.",
    "¿Cómo funcionan las recompensas para un conductor en UGMAventón?": "En caso que desees recompensar a un conductor por un buen aventón puedes otorgarle puntos positivos una vez finalizado el viaje. Estos puntos se reflejarán en el perfil del conductor, aumentando su credibilidad y confiabilidad. Además, si quieres ir más allá, puedes donar una pequeña ayuda monetaria.",
    "¿Qué hago si no estoy satisfecho con el servicio?": "Si el aventón no ha ido del todo bien, puedes dejarle sugerencias al conductor una vez finalizado el viaje. Recuerda hacerlas desde el respeto y la cordialidad, UGMAventón se ha creado con la finalidad de integrar a los estudiantes y crear un espacio seguro para estos.",
    "¿Es seguro usar UGMAventón?": "Sí, todos los usuarios que se registran en la aplicación deben verificar su identidad y proporcionar sus respectivas credenciales universitarias. Además, UGMAventón tiene implementado un sistema de puntuaciones y reportes que facilita el aspecto de credibilidad y confiabilidad entre conductores y pasajeros.",
    "¿Cómo reporto un problema o comportamiento inapropiado?": "Para reportar un problema o comportamiento inapropiado debes ir al perfil del conductor/pasajero e ir a la sección de reportar un problema, allí describe la situación detalladamente. El equipo de UGMAventón evaluará la situación y tomará acciones de ser necesario.",
    "¿Cómo puedo reportar un objeto perdido?": "Puedes ponerte en contacto con tu conductor. Si no tienes los datos a mano accede al historial de viajes: En la aplicación, ve a 'Mis Viajes' y selecciona el viaje en el que crees haber perdido el objeto. Si el conductor encuentra tu objeto, te contactará a través de la aplicación para coordinar la devolución.Si después de 48 horas no has recibido respuesta, puedes solicitar ayuda adicional a través de 'Soporte' en el menú principal. Recuerda que es importante reportar objetos perdidos lo antes posible para aumentar las posibilidades de recuperarlos. La aplicación no se hace responsable por objetos perdidos, pero hará todo lo posible para facilitar su recuperación.",
  };

  final List<Map<String, dynamic>> _faqButtons = [
    {"text": "Cuenta", "icon": Icons.account_circle},
    {"text": "Aventón", "icon": Icons.directions_car},
    {"text": "Recompensas", "icon": Icons.star},
    {"text": "Seguridad", "icon": Icons.shield},
  ];

  String? _findMatch(String userInput) {
    final input = userInput.toLowerCase();

    // Buscar coincidencias en las preguntas específicas
    String? bestMatch;
    double bestSimilarity = 0.0;

    for (String question in _faqAnswers.keys) {
      final similarity = question.toLowerCase().similarityTo(input);
      if (similarity >= 0.5 && similarity > bestSimilarity) {
        bestMatch = question;
        bestSimilarity = similarity;
      }
    }

    return bestMatch;
  }

  void _showCarousel(String topic) {
    setState(() {
      // Actualizar los elementos del carrusel con las preguntas del tema seleccionado
      _currentCarouselItems = _faqResponses[topic] ?? [];

      // Ocultar la sección principal
      _showMainSection = false;

      // Verificar si hay mensajes previos o si el último mensaje es diferente
      bool shouldAddMessage = _messages.isEmpty ||
          _messages.last["text"] != "¿Qué dudas tienes con respecto a $topic?";

      // Agregar el mensaje solo si es necesario
      if (shouldAddMessage) {
        _messages.add({
          "text": "¿Qué dudas tienes con respecto a $topic?",
          "isUser": false,
        });
      }
    });

    // Hacer scroll hasta el final de la conversación
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

  void _goBackToMainSection() {
    setState(() {
      _messages.clear();
      _showMainSection = true; // Mostrar la sección principal
      _currentCarouselItems = []; // Limpiar carrusel
    });

    // Hacer scroll automático al final del chat
    _scrollToBottom();
  }

  final ScrollController _scrollController = ScrollController();

  void _sendMessage(String message) {
    if (message.trim().isEmpty) return;
    if (_isWaitingForResponse) return;
    _isWaitingForResponse = true;

    final String lowercaseMessage = message.toLowerCase();
    bool topicFound = false;

    // Verificar si es un tópico principal
    for (var button in _faqButtons) {
      if (lowercaseMessage.contains(button["text"].toString().toLowerCase())) {
        _showCarousel(button["text"].toString());
        topicFound = true;
        setState(() {
          _messages.add({
            "text": message,
            "isUser": true,
          });
        });
        break;
      }
    }

    if (!topicFound) {
      // Buscar coincidencia en preguntas específicas
      String? matchedQuestion = _findMatch(message);

      // Solo agregar el mensaje del usuario si no es una selección del carrusel
      if (!_currentCarouselItems.contains(message)) {
        setState(() {
          _messages.add({
            "text": message,
            "isUser": true,
          });
        });
      }

      if (matchedQuestion != null) {
        message = matchedQuestion;
        setState(() {
          _showMainSection = false;
        });
      } else {
        setState(() {
          _showMainSection = true;
          _currentCarouselItems = [];
        });
      }
    }

    _messageController.clear();

    // Obtener la respuesta para la pregunta
    String? response = _faqAnswers[message];

    // Agregar respuesta automática después de un breve delay
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        if (response != null) {
          _messages.add({
            "text": response,
            "isUser": false,
          });
        } else if (!topicFound) {
          _messages.add({
            "text": "Lo sentimos, tu problema parece ser un poco más complicado para mí. En caso de necesitar ayuda más específica puedes contactar al soporte técnico de UGMAventón: \nJuan Ventana: +58 213 789 8989 Margarita Puerta: +58 263 089 7359",
            "isUser": false,
          });
        }
        _isWaitingForResponse = false;
      });

      _scrollToBottom();
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
                  color: Color(0xFF003399),
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
                                  _sendMessage(
                                      item); // Enviar pregunta como mensaje
                                },
                              ),
                            );
                          }).toList(),
                          /*// Botón Volver
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
                        ),*/
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
                                ? Colors.grey[300]
                                : const Color(0xFFDDEFFF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: message["text"] is TextSpan // Verificar si es TextSpan
                              ? Text.rich(
                              message["text"] as TextSpan) // Usar Text.rich si es TextSpan
                              : Text(
                              message["text"] as String), // Usar Text si es String
                        ),
                      );
                    }).toList(),

                    // Mostrar el botón Volver siempre que haya mensajes o cuando no esté en la sección principal
                    if (_messages.isNotEmpty || !_showMainSection)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // Alinea los botones a los extremos
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: ElevatedButton(
                              onPressed: _goBackToMainSection,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 20),
                              ),
                              child: const Text(
                                "Volver",
                                style: TextStyle(
                                    color: Color(0xFF003399), fontSize: 16),
                              ),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              );
                            },
                            icon: const Icon(Icons.arrow_upward,
                                color: Color(0xFF003399)),
                            label: const Text(
                              "Arriba",
                              style: TextStyle(
                                  color: Color(0xFF003399), fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                            ),
                          ),
                        ],
                      ),
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
