import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../core/theme/app_theme.dart';
import '../models/schema_therapy_data.dart';
import '../services/schema_chat_service.dart';

/// Schema-specific chat screen
class SchemaChatScreen extends StatefulWidget {
  final SchemaTherapySchema schema;
  final Map<int, double> schemaScores;

  const SchemaChatScreen({
    super.key,
    required this.schema,
    required this.schemaScores,
  });

  @override
  State<SchemaChatScreen> createState() => _SchemaChatScreenState();
}

class _SchemaChatScreenState extends State<SchemaChatScreen> {
  late SchemaChatService _chatService;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _chatService = SchemaChatService(
      schemaScores: widget.schemaScores,
      schema: widget.schema,
    );
    
    // Add initial greeting
    _addInitialGreeting();
  }

  void _addInitialGreeting() {
    final greeting = '''Hello! I'm here to help you understand and work with ${widget.schema.nameEn}.

Based on your test results, your score for this schema is ${widget.schemaScores[widget.schema.id]?.toStringAsFixed(1) ?? 'N/A'}/6.

Feel free to ask me anything about:
• What this schema means
• How it affects you
• Where it comes from
• How to heal from it

What would you like to know?''';

    _chatService.conversationHistory.add(
      ChatMessage(
        text: greeting,
        isUser: false,
        timestamp: DateTime.now(),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    if (_messageController.text.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      await _chatService.getResponse(_messageController.text);
      _messageController.clear();
      
      // Scroll to bottom
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(widget.schema.nameEn),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Schema info bar
          _buildSchemaInfoBar(context),
          
          // Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
              itemCount: _chatService.conversationHistory.length,
              itemBuilder: (context, index) {
                final message = _chatService.conversationHistory[index];
                return _buildMessageBubble(context, message, isSmallScreen);
              },
            ),
          ),
          
          // Input field
          _buildInputField(context, isSmallScreen),
        ],
      ),
    );
  }

  Widget _buildSchemaInfoBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: widget.schema.color.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(
            color: widget.schema.color.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            widget.schema.icon,
            color: widget.schema.color,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Score',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  '${widget.schemaScores[widget.schema.id]?.toStringAsFixed(1) ?? 'N/A'}/6',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: widget.schema.color,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: widget.schema.color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              _getSeverityLabel(widget.schemaScores[widget.schema.id] ?? 0),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: widget.schema.color,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(
    BuildContext context,
    ChatMessage message,
    bool isSmallScreen,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment:
            message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isUser)
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.schema.color.withOpacity(0.2),
              ),
              child: Icon(
                widget.schema.icon,
                size: 16,
                color: widget.schema.color,
              ),
            ),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: message.isUser
                    ? widget.schema.color
                    : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: message.isUser
                    ? null
                    : Border.all(
                        color: widget.schema.color.withOpacity(0.2),
                        width: 1,
                      ),
                boxShadow: [
                  BoxShadow(
                    color: (message.isUser
                            ? widget.schema.color
                            : Colors.grey[300]!)
                        .withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: message.isUser ? Colors.white : Colors.grey[800],
                      height: 1.5,
                    ),
              ),
            ),
          ),
          if (message.isUser) const SizedBox(width: 8),
          if (message.isUser)
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              child: const Icon(
                CupertinoIcons.person_fill,
                size: 16,
                color: Colors.grey,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInputField(BuildContext context, bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              enabled: !_isLoading,
              decoration: InputDecoration(
                hintText: 'Ask me anything...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(
                    color: widget.schema.color,
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _isLoading ? null : _sendMessage,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _isLoading ? Colors.grey[300] : widget.schema.color,
              ),
              child: Center(
                child: _isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.grey[600]!,
                          ),
                        ),
                      )
                    : Icon(
                        CupertinoIcons.arrow_up,
                        color: Colors.white,
                        size: 20,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getSeverityLabel(double score) {
    if (score <= 2) return 'Low';
    if (score <= 3) return 'Moderate';
    if (score <= 4) return 'Significant';
    if (score <= 5) return 'High';
    return 'Very High';
  }
}

