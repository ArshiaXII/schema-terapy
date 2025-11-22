import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../core/theme/app_theme.dart';
import '../l10n/app_localizations.dart';
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
    // This will be set in build() with proper context
  }

  String _buildGreetingMessage(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final score = widget.schemaScores[widget.schema.id]?.toStringAsFixed(1) ?? 'N/A';

    return '''${l10n.schemaGreeting(widget.schema.nameEn)}

${l10n.basedOnTestResults(score)}

${l10n.feelFreeToAsk}
• ${l10n.whatThisSchemaMeans}
• ${l10n.howItAffectsYou}
• ${l10n.whereItComesFrom}
• ${l10n.howToHealFromIt}

${l10n.whatWouldYouLikeToKnow}''';
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
    final l10n = AppLocalizations.of(context)!;

    // Add initial greeting if conversation is empty
    if (_chatService.conversationHistory.isEmpty) {
      _chatService.conversationHistory.add(
        ChatMessage(
          text: _buildGreetingMessage(context),
          isUser: false,
          timestamp: DateTime.now(),
        ),
      );
    }

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
          _buildSchemaInfoBar(context, l10n),

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
          _buildInputField(context, isSmallScreen, l10n),
        ],
      ),
    );
  }

  Widget _buildSchemaInfoBar(BuildContext context, AppLocalizations l10n) {
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
                  l10n.yourScore,
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
              _getSeverityLabel(widget.schemaScores[widget.schema.id] ?? 0, l10n),
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

  Widget _buildInputField(BuildContext context, bool isSmallScreen, AppLocalizations l10n) {
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
                hintText: l10n.askMeAnything,
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

  String _getSeverityLabel(double score, AppLocalizations l10n) {
    if (score <= 2) return l10n.low;
    if (score <= 3) return l10n.moderate;
    if (score <= 4) return l10n.significant;
    if (score <= 5) return l10n.high;
    return l10n.veryHigh;
  }
}

