class upcomingTestModel {

  final String id;
  final String TestName;
  final String Level;
  final String Image;
  final String StartDate;
  final String Status;
  final String Time;
  final String Start_Time;
  final String End_Time;
  final String TestDuration;
  final String testStatus;
  final List questionList;

  upcomingTestModel(
      this.id,
      this.TestName,
      this.Level,
      this.Image,
      this.StartDate,
      this.Status,
      this.Time,
      this.Start_Time,
      this.End_Time,
      this.TestDuration,
      this.testStatus,
      this.questionList);
}


class questionsListModel {

  final String id;
  final String StudentTest_id;
  final String Question;
  final String Image;
  final String Marks;

  questionsListModel(
      this.id,
      this.StudentTest_id,
      this.Question,
      this.Image,
      this.Marks,
      );
}

