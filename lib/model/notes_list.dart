class NotesList {
  List<String>? note;
  String? commented;
  String? creation;

  NotesList({this.note, this.commented, this.creation});

  NotesList.fromJson(Map<String, dynamic> json) {
    note = json['note'].cast<String>();
    commented = json['commented'];
    creation = json['creation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['note'] = this.note;
    data['commented'] = this.commented;
    data['creation'] = this.creation;
    return data;
  }
}
