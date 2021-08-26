class BotResponseModel {
  BotResponseModel({
     this.id,
    required this.text,
    required this.searchText,
    required this.conversation,
    required this.persona,
    required this.tags,
    required this.inResponseTo,
    required this.searchInResponseTo,
    required this.createdAt,
  });
  late final Null id;
  late final String text;
  late final String searchText;
  late final String conversation;
  late final String persona;
  late final List<dynamic> tags;
  late final String inResponseTo;
  late final String searchInResponseTo;
  late final String createdAt;
  
  BotResponseModel.fromJson(Map<String, dynamic> json){
    id = null;
    text = json['text'];
    searchText = json['search_text'];
    conversation = json['conversation'];
    persona = json['persona'];
    tags = List.castFrom<dynamic, dynamic>(json['tags']);
    inResponseTo = json['in_response_to'];
    searchInResponseTo = json['search_in_response_to'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['text'] = text;
    _data['search_text'] = searchText;
    _data['conversation'] = conversation;
    _data['persona'] = persona;
    _data['tags'] = tags;
    _data['in_response_to'] = inResponseTo;
    _data['search_in_response_to'] = searchInResponseTo;
    _data['created_at'] = createdAt;
    return _data;
  }
}