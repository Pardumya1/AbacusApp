

class LevelModel {

  final String id;
  final String levelGUID;
  final String levelCode;
  final String streamName;
  final String status;
  final String sortOrder;
  final String syncflag;
  final String totalMarks;
  final String eligibilityMarks;
  final String programShortName;
  final String monthslnTerm;
  final String masterLevelItemCode;

  LevelModel(
      this.id,
      this.levelGUID,
      this.levelCode,
      this.streamName,
      this.status,
      this.sortOrder,
      this.syncflag,
      this.totalMarks,
      this.eligibilityMarks,
      this.programShortName,
      this.monthslnTerm,
      this.masterLevelItemCode);
}
