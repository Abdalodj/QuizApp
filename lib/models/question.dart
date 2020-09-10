class Question {
  String question;
  bool response;
  String explaination;
  String imagePath;

  Question(
      String question, bool response, String explaination, String imagePath) {
    this.question = question;
    this.response = response;
    this.explaination = explaination;
    this.imagePath = imagePath;
  }

  Question.fromJson(Map<String, dynamic> json) {
    this.question = question;
    this.response = response;
    this.explaination = explaination;
    this.imagePath = imagePath;
  }

  List<Question> listQuestions() {
    return null;
  }
}
