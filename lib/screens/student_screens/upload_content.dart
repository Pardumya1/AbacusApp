import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../tutor_screens/tutor_login_screen.dart';

class UploadContent extends StatefulWidget {
  static const String routeName = '/UploadContent';

  @override
  State<StatefulWidget> createState() => _UploadContent();
}

class _UploadContent extends State<UploadContent> {
  var currentSelectedValue;
  var currentSelectedLearningValue;
  late int level;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController scoreController = new TextEditingController();
  final TextEditingController titleController = new TextEditingController();
  final TextEditingController descriptionController =
      new TextEditingController();

  final TextEditingController QuestionFieldController =
      new TextEditingController();
  final TextEditingController questionController = new TextEditingController();
  final TextEditingController timeController = new TextEditingController();
  final Pwdfocus = FocusNode();
  final ConfirmPwdfocus = FocusNode();
  final Emailfocus = FocusNode();
  final Scorefocus = FocusNode();
  final Titlefocus = FocusNode();
  final Descriptionfocus = FocusNode();
  final QuestionFieldfocus = FocusNode();
  final Questionfocus = FocusNode();
  final Timefocus = FocusNode();
  List<String> level_modes = [];
  bool isLoading = false;

  late String _title, _score, _description, _question, _timeVal, _questionfield;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    level_modes.add("Level 1");
    level_modes.add("Level 2");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "images/background.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.dark),
            title: const Text("Upload Content"),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  'images/back.png',
                  width: 14,
                  height: 14,
                  // fit: BoxFit.fill,
                ),
              ),
            ),
            titleTextStyle: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Color(0xFF47473F),
                fontFamily: "Montserrat"),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Container(
            child: SafeArea(child: inputFields()),
          ),
        ),
      ],
    );
  }

  inputFields() {
    return new Form(
      key: _formKey,
      child: Expanded(
        child: Container(
          margin: EdgeInsets.only(top: 40, bottom: 10, left: 30, right: 30),
          child: new SingleChildScrollView(
            child: Column(
              children: <Widget>[
                /*  Title  */
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Title",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Montserrat-Bold',
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 0.0, bottom: 5.0),
                    child: Material(
                      elevation: 1.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          side: BorderSide(color: Colors.white)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 5.0),
                        child: TextFormField(
                          autofocus: false,
                          focusNode: Titlefocus,
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(fontFamily: "Montserrat"),
                          controller: titleController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          validator: (val) {
                            if (val!.length == 0)
                              return "Please enter title";
                            else
                              return null;
                          },
                          onSaved: (val) => _title = val!,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context)
                                .requestFocus(Descriptionfocus);
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Please enter title",
                              hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: "Montserrat")),
                        ),
                      ),
                    )),

                /*  Level  */
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 15),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Level",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Montserrat-Bold',
                        color: Color(0xff063464),
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                ),
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 0, bottom: 10),
                  child: Material(
                      elevation: 1.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          side: BorderSide(color: Colors.white)),
                      child: dropDownLearning()),
                ),

                /*  Description/Rules   */
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 15),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Description/Rules",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Montserrat-Bold',
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 0.0, bottom: 5.0),
                    child: Material(
                      elevation: 1.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          side: BorderSide(color: Colors.white)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 5.0),
                        child: TextFormField(
                          autofocus: false,
                          focusNode: Descriptionfocus,
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(fontFamily: "Montserrat"),
                          controller: descriptionController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          validator: (val) {
                            if (val!.length == 0)
                              return "Please enter description";
                            else
                              return null;
                          },
                          onSaved: (val) => _description = val!,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).requestFocus(Questionfocus);
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Please enter a description",
                              hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: "Montserrat")),
                        ),
                      ),
                    )),

                /*  Question and Time */
                new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Flexible(
                        flex: 1,
                        child: Container(
                          margin:
                              EdgeInsets.only(top: 20, bottom: 15, right: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Total Question",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Montserrat-Bold',
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        ),
                      ),
                      new Flexible(
                        flex: 1,
                        child: Container(
                          margin:
                              EdgeInsets.only(top: 20, bottom: 15, left: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Total Time",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Montserrat-Bold',
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        ),
                      )
                    ]),
                new Row(
                  children: <Widget>[
                    new Flexible(
                      flex: 1,
                      child: Padding(
                          padding:
                              EdgeInsets.only(top: 0.0, bottom: 5.0, right: 10),
                          child: Material(
                            elevation: 1.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                side: BorderSide(color: Colors.white)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 5.0),
                              child: TextFormField(
                                autofocus: false,
                                focusNode: Questionfocus,
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(fontFamily: "Montserrat"),
                                controller: questionController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                validator: (val) {
                                  if (val!.length == 0)
                                    return "Please enter total question value";
                                  else
                                    return null;
                                },
                                onSaved: (val) => _question = val!,
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context)
                                      .requestFocus(Timefocus);
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Total question value",
                                    hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: "Montserrat")),
                              ),
                            ),
                          )),
                    ),
                    new Flexible(
                      flex: 1,
                      child: Padding(
                          padding:
                              EdgeInsets.only(top: 0.0, bottom: 5.0, left: 10),
                          child: Material(
                            elevation: 1.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                side: BorderSide(color: Colors.white)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 5.0),
                              child: TextFormField(
                                autofocus: false,
                                focusNode: Questionfocus,
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(fontFamily: "Montserrat"),
                                controller: questionController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                validator: (val) {
                                  if (val!.length == 0)
                                    return "Please enter total question value";
                                  else
                                    return null;
                                },
                                onSaved: (val) => _question = val!,
                                onFieldSubmitted: (v) {
                                  FocusScope.of(context)
                                      .requestFocus(Scorefocus);
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Total question value",
                                    hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: "Montserrat")),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),

                /*    Score of each Question    */
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 15),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Score of each Question",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Montserrat-Bold',
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.0, bottom: 10.0),
                  child: Material(
                    elevation: 1.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      side: BorderSide(color: Colors.white),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 5.0),
                      child: TextFormField(
                        autofocus: false,
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(fontFamily: "Montserrat"),
                        focusNode: Scorefocus,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        controller: scoreController,
                        validator: (val) {
                          if (val!.length == 0)
                            return "Please enter a score";
                          else
                            return null;
                        },
                        onFieldSubmitted: (v) {
                          FocusScope.of(context)
                              .requestFocus(QuestionFieldfocus);
                        },
                        onSaved: (val) => _score = val!,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Please enter a score",
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: "Montserrat")),
                      ),
                    ),
                  ),
                ),

                /*    Question Type   */
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Question Type",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Montserrat-Bold',
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                ),
                new Row(
                  children: <Widget>[
                    new Flexible(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(right: 10, top: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 20, left: 15, right: 15, bottom: 20),
                                child: Image.asset(
                                  'images/untick_level.png',
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.fill,
                                  color: Color(0xFF009148),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 20, left: 0, right: 10, bottom: 20),
                                child: Text("Text",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 16.0,
                                        color: Colors.black,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w600)),
                              )
                            ]),
                      ),
                    ),
                    new Flexible(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(left: 10, top: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 20, left: 15, right: 15, bottom: 20),
                                child: Image.asset(
                                  'images/untick_level.png',
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.fill,
                                  color: Color(0xFFC6D1CC),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 20, left: 0, right: 10, bottom: 20),
                                child: Text("Image",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 16.0,
                                        color: Colors.black,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w600)),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
                1 == 1
                    ? Column(children: <Widget>[
                        /*  Question  */
                        Container(
                          margin: EdgeInsets.only(top: 20, bottom: 0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Question",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Montserrat-Bold',
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 15.0, bottom: 5.0),
                            child: Material(
                              elevation: 1.0,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  side: BorderSide(color: Colors.white)),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 5.0),
                                child: TextFormField(
                                  autofocus: false,
                                  focusNode: QuestionFieldfocus,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: TextStyle(fontFamily: "Montserrat"),
                                  controller: QuestionFieldController,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  validator: (val) {
                                    if (val!.length == 0)
                                      return "Please input a question";
                                    else
                                      return null;
                                  },
                                  onSaved: (val) => _questionfield = val!,
                                  onFieldSubmitted: (v) {
                                    FocusScope.of(context)
                                        .requestFocus(Questionfocus);
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Please input a question",
                                      hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: "Montserrat")),
                                ),
                              ),
                            )),

                        /*  Answer  */
                        Container(
                          margin: EdgeInsets.only(top: 20, bottom: 0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Answer",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Montserrat-Bold',
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 15.0, bottom: 5.0),
                            child: Material(
                              elevation: 1.0,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  side: BorderSide(color: Colors.white)),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 5.0),
                                child: TextFormField(
                                  autofocus: false,
                                  focusNode: QuestionFieldfocus,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: TextStyle(fontFamily: "Montserrat"),
                                  controller: QuestionFieldController,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  validator: (val) {
                                    if (val!.length == 0)
                                      return "Please input a answer";
                                    else
                                      return null;
                                  },
                                  onSaved: (val) => _questionfield = val!,
                                  onFieldSubmitted: (v) {
                                    FocusScope.of(context)
                                        .requestFocus(Questionfocus);
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Please input a answer",
                                      hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: "Montserrat")),
                                ),
                              ),
                            )),
                      ])
                    : (Column(children: <Widget>[
                      /*  Question  */
                        Container(
                          margin: EdgeInsets.only(top: 20, bottom: 0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Question",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Montserrat-Bold',
                                color: Color(0xff063464),
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        ),

                        /*  Answer  */
                        Container(
                          margin: EdgeInsets.only(top: 20, bottom: 0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Answer",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Montserrat-Bold',
                                color: Color(0xff063464),
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 15.0, bottom: 5.0),
                            child: Material(
                              elevation: 1.0,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  side: BorderSide(color: Colors.white)),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 5.0),
                                child: TextFormField(
                                  autofocus: false,
                                  focusNode: QuestionFieldfocus,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: TextStyle(fontFamily: "Montserrat"),
                                  controller: QuestionFieldController,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  validator: (val) {
                                    if (val!.length == 0)
                                      return "Please input a answer";
                                    else
                                      return null;
                                  },
                                  onSaved: (val) => _questionfield = val!,
                                  onFieldSubmitted: (v) {
                                    FocusScope.of(context)
                                        .requestFocus(Questionfocus);
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Please input a answer",
                                      hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: "Montserrat")),
                                ),
                              ),
                            )),
                      ])),

                /*  Submit Button  */
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  width: 320.0,
                  height: 50.0,
                  child: ElevatedButton(

                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF063464),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              side: const BorderSide(color: Color(0xFF063464))),
                          elevation: 6.0
                      ),

                      child: Text(
                        "Submit",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 18.0,
                            color: Colors.white),
                      ),
                      onPressed: () {}),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  dropDownLearning() {
    return Stack(
      children: <Widget>[dropDownMode()],
    );
  }

  dropDownMode() {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 10.0, right: 5.0),
              child: FormField<dynamic>(
                builder: (FormFieldState<dynamic> state) {
                  return InputDecorator(
                    decoration: InputDecoration.collapsed(hintText: ''),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text("Please select a level"),
                        dropdownColor: Colors.white,
                        value: currentSelectedLearningValue,
                        isDense: true,
                        onChanged: (newValue) {
                          setState(() {
                            currentSelectedLearningValue = newValue;
                          });
                        },
                        items: level_modes.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  dropDownLearningImg() {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                'images/learning_icon.png',
                width: 21,
                height: 21,
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ],
    );
  }

  dropDownInstImg() {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                'images/institute_icon.png',
                width: 20,
                height: 20,
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
