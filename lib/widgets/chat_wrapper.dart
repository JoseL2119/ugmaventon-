// lib/widgets/chat_wrapper.dart
import 'package:flutter/material.dart';
import '../pages/chatbot.dart';

class ChatWrapper extends StatefulWidget {
  final Widget child;

  const ChatWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<ChatWrapper> createState() => _ChatWrapperState();
}

class _ChatWrapperState extends State<ChatWrapper> {
  bool _showChat = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Contenido principal de la app
        widget.child,

        // Botón flotante del chat
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            backgroundColor: const Color(0xFFFFCC00),
            onPressed: () {
              setState(() {
                _showChat = !_showChat;
              });
            },
            child: const Icon(Icons.android, color: Color(0xFF003399)),
          ),
        ),

        // Widget del chat con animación
        if (_showChat)
          _ChatTransition(
            onClose: () {
              setState(() {
                _showChat = false;
              });
            },
            child: ChatWidget(
              onClose: () {
                setState(() {
                  _showChat = false;
                });
              },
            ),
          ),
      ],
    );
  }
}

class _ChatTransition extends StatefulWidget {
  final VoidCallback onClose;
  final Widget child;

  const _ChatTransition({required this.onClose, required this.child});

  @override
  State<_ChatTransition> createState() => _ChatTransitionState();
}

class _ChatTransitionState extends State<_ChatTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Material(
        elevation: 8.0,
        borderRadius: BorderRadius.zero,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}