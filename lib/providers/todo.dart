class Todo {
  final String? _id;
  final String? _createdAt;
  final String? _authorId;
  final String? _text;
  bool _isCompleted = false;

  Todo(this._id, this._createdAt, this._authorId, this._text);

  String? get text {
    return _text;
  }

  void switchCompleted() {
    _isCompleted = !_isCompleted;
  }
}
