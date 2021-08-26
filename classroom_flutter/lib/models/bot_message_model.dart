enum BotResponseType { BOT, HUMEN }

class BotMessageModel {
  final String message;
  final BotResponseType type;

  BotMessageModel({required this.message, required this.type});
}
