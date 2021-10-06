class PublicJob {
  String title, description, category, experience, payment;

  PublicJob(
      {required this.title,
      required this.description,
      required this.payment,
      required this.category,
      required this.experience});

  factory PublicJob.fromJson(Map<String, dynamic> map) {
    return PublicJob(
        title: map['title'],
        description: map['description'],
        payment: map['payment'],
        category: map['category'],
        experience: map['experience']);
  }
}
