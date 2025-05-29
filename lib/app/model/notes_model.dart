class NotesModel {
  String? id;
  String? userId;
  String? notesTitle;
  String? notesDetail;
  String? coverImage;
  String? supertiveFile;

  NotesModel(
      {this.id,
      this.userId,
      this.notesTitle,
      this.notesDetail,
      this.coverImage,
      this.supertiveFile});

  NotesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_Id'];
    notesTitle = json['notesTitle'];
    notesDetail = json['notesDetail'];
    coverImage = json['coverImage'];
    supertiveFile = json['supertiveFile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_Id'] = this.userId;
    data['notesTitle'] = this.notesTitle;
    data['notesDetail'] = this.notesDetail;
    data['coverImage'] = this.coverImage;
    data['supertiveFile'] = this.supertiveFile;
    return data;
  }
}
