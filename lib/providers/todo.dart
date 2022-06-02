class Todo {
  final String? _id;
  final String? _createdAt;
  final String? _authorId;
  final String? _text;
  bool _isCompleted = false;

  Todo(
      this._id, this._createdAt, this._authorId, this._text, this._isCompleted);

  String? get text {
    return _text;
  }

  String? get id {
    return _id;
  }

  String? get createdAt {
    return _createdAt;
  }

  String? get authorId {
    return _authorId;
  }

  bool get isCompleted {
    return _isCompleted;
  }

  void switchCompleted() async {
    _isCompleted = !_isCompleted;
    // _isCompleted = !_isCompleted;
    // final data = {'isCompleted': _isCompleted};
    // final user = FirebaseAuth.instance.currentUser;
    // final newData = await FirebaseFirestore.instance
    //     .collection('users/${user!.uid}/todos/$_id/todo')
    //     .doc(_id)
    //     .set(data);

    // notifyListeners();
  }
}
