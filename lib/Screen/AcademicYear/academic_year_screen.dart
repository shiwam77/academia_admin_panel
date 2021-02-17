import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Model/academic_year_model.dart';
import 'package:academia_admin_panel/Screen/Api/api_end_point.dart';
import 'package:academia_admin_panel/Screen/DashBoard/dashboard.dart';
import 'package:academia_admin_panel/Screen/login.dart';
import 'package:academia_admin_panel/error.dart';
import 'package:academia_admin_panel/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_page/search_page.dart';
import 'package:sentry/sentry.dart';


class AcademicYearPage extends StatefulWidget {
  final String userId;
  AcademicYearPage(this.userId);
  @override
  _AcademicYearPageState createState() => _AcademicYearPageState();
}

class _AcademicYearPageState extends State<AcademicYearPage> {
  final _formKey = GlobalKey<FormState>();
  ScrollController _controller = ScrollController();
  GetAcademicYear getIgYears =  GetAcademicYear();
  bool isEditable = false;
  bool isReadOnly = true;
  String yearEditValue;
  // ignore: deprecated_member_use
  List<AcademicYearModel> getListOfYears =[];
  TextEditingController _yearEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(getIgYears.results);
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Academic Year",style: TextStyle(
                fontFamily: 'ProductSans',
                color: AppColors.textColorBlackBlue,
                fontSize: MediaQuery.of(context).size.width * .025,
                fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                yearInputSection(),


                SizedBox(width: 4,),

                yearListViewSection()

              ],
            ),
          ],
        ));
  }


  Widget yearInputSection(){
    return  boxContainer(
        height: MediaQuery.of(context).size.height * .6 ,
        leftRadius: 30,
        context: context,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Enter Year",style: TextStyle(
                    fontFamily: 'ProductSans',
                    color: AppColors.indigo700,
                    fontSize: MediaQuery.of(context).size.width * .025,
                    fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 20,),
                TextFormField(
                  controller: _yearEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(20.0))
                    ),
                    hintText: "Enter your academic year",

                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter year';
                    }
                    return null;
                  },

                ),
                SizedBox(height: 40,),
                InkWell(
                  onTap: () async{
                    AcademicYearModel newYear =  AcademicYearModel(year: int.parse(_yearEditingController.text),userId: widget.userId);
                    if(_formKey.currentState.validate()){
                      try{
                        var response =  await createAcademicYear(newYear.toJson());
                        if(response["httpStatusCode"] == 201){
                          newYear.id = response["responseJson"]["data"]["id"];
                          setState(() {
                            getListOfYears.add(newYear);
                            print(getListOfYears.length);
                            _yearEditingController.clear();
                          });
                        }
                        else if(response["httpStatusCode"] == 500){
                          String message = response["responseJson"]['message'];
                          showToast(context, message);
                        }
                      }
                      catch(error){
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Something went wrong!'),
                            ));
                      }
                    }
                  },
                  child: Container(
                    height: 60,
                    //width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.blue,
                    ),
                    child: Text("Add",style: TextStyle(
                        fontFamily: 'ProductSans',
                        color: AppColors.white,
                        fontSize: MediaQuery.of(context).size.width * .015,
                        fontWeight: FontWeight.bold
                    )),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  Widget yearListViewSection(){
    return boxContainer(
      height: MediaQuery.of(context).size.height * .6 ,
      rightRadius: 30,
      context: context,
      child:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100,vertical: 20),
              child: SizedBox(
                height: 43,
                child: TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.appBackgroundColor,
                      focusColor: AppColors.white,
                      hoverColor: AppColors.appBackgroundColor,
                      contentPadding: EdgeInsets.only(top: 5,left: 10),
                      suffixIcon: GestureDetector(
                          onTap: (){
                            print("searching...");
                            showSearch(
                              context: context,
                              delegate: SearchPage<AcademicYearModel>(
                                items: getListOfYears,
                                searchLabel: 'Search people',
                                suggestion: Center(
                                  child: Text('Filter people by name, surname or age'),
                                ),
                                failure: Center(
                                  child: Text('No person found :('),
                                ),
                                filter: (person) => [
                                  person.year.toString()
                                ],
                                builder: (person) => ListTile(
                                  title: Text(person.year.toString()),
                                  subtitle: Text(person.year.toString()),
                                  trailing: Text('${person.year.toString()} yo'),
                                ),
                              ),
                            );
                            },
                          child: Icon(Icons.search_rounded,color: AppColors.indigo700,)),
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(color: AppColors.transparent)
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                        borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                        borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                      ),
                      hintText: "search"
                  ),
                ),
              ),
            ),

            getListOfYears.isEmpty  ? FutureBuilder(
              future: getAcademicAllYears(userId:widget.userId),
                builder: (context,snapshot){
                print("future");
                if(snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data != null){
                  getIgYears = GetAcademicYear.fromJson(snapshot.data);
                  if(getIgYears != null){
                    getListOfYears = getIgYears.data;

                    return yearListViewBuilder( getIgYears, getListOfYears,);
                  }
                  return Text("null");
                }
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Text("loading");
                }
                if(snapshot.hasError){
                  return Text(snapshot.error.toString());
                }
                return Text("loading");
            }) : yearListViewBuilder( getIgYears, getListOfYears,),


          ],
        ),
      ),
    );
  }

  Widget yearListViewBuilder( GetAcademicYear getIgYears,
  List<AcademicYearModel> getYears,){
    List<AcademicYearModel> reverseYearList =new List.from(getYears.reversed);


    if(getYears.length > 0){
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("New",style: TextStyle(
              fontFamily: 'ProductSans',
              color: AppColors.indigo700,
              fontSize: 30,
              fontWeight: FontWeight.bold
          ),),

          Padding(
            padding: const EdgeInsets.only(right: 40,top: 10),
            child: InkWell(
              onTap: (){
                String id = getYears[getYears.length - 1].id;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DashBoardPage(id,getYears[getYears.length - 1].year)
                    )
                );
              },
              splashColor: AppColors.appBackgroundColor,
              focusColor: AppColors.appBackgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.indigo700
                        ),
                      ),
                      SizedBox(width: 30,),
                      Container(
                        width: 160,
                        height: 60,
                        alignment: Alignment.center,
                        decoration: !isReadOnly ? BoxDecoration(
                          border:Border.all(
                            color: AppColors.indigo700, //                   <--- border color
                            width: 2.0,
                          ),
                        ):BoxDecoration(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          child: EditableText(
                            cursorHeight: 40,
                            autofocus: isEditable,
                            readOnly: isReadOnly,
                             cursorColor: AppColors.indigo700,
                            style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  color: AppColors.textColorBlack,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold
                              ),
                             focusNode: FocusNode(),
                             backgroundCursorColor: AppColors.blackeyGray,
                             controller: TextEditingController(text:"${getYears[getYears.length - 1].year}"),

                            onSubmitted: (value){
                              String id = getYears[getYears.length - 1].id;
                              AcademicYearModel updateYear = AcademicYearModel(year:int.parse(value),userId:widget.userId,id: id);
                               updateAcademicYear(id,updateYear.toJson()).then((apiResponse) {

                                print("apiResponse");
                                print(apiResponse);
                                if(apiResponse["httpStatusCode"] == 200){
                                  setState(() {
                                    getListOfYears.removeAt(getYears.length - 1);
                                    getListOfYears.add(updateYear);
                                    isReadOnly = true;
                                  });
                                }

                              }).catchError((error, stackTracke) {

                                if (error is ApiError) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(error.dioErrorMsg.toString()),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Something went wrong!,'),
                                    ),
                                  );
                                  //logger.e(error);
                                }
                              });
                            },

                          ),
                        ),
                      ),

                    ],

                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap: () async{

                            setState(() {
                              isEditable = true;
                              isReadOnly = false;
                            });
                          },
                          child: Icon(Icons.edit,size: 33,)),
                      SizedBox(width: 40,),
                      InkWell(
                          onTap: ()  {
                            String id = getYears[getYears.length - 1].id;
                            print(getYears[getYears.length - 1].id);

                            deleteAcademicYear(id).then((apiResponse) {
                              print("apiResponse");
                               print(apiResponse);
                               if(apiResponse["httpStatusCode"] == 204){
                                 setState(() {
                                   getYears.removeAt(getYears.length - 1);
                                 });
                               }

                            }).catchError((error, stackTracke) {

                              if (error is ApiError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(
                                    content: Text(error.dioErrorMsg.toString()),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Something went wrong!,'),
                                  ),
                                );
                                //logger.e(error);
                              }
                            });

                          },
                          child: Icon(Icons.delete,size: 33,)),
                    ],
                  )
                ],
              ),
            ),
          ),

          Divider(
            color: AppColors.gray,
            thickness: 2,
          ),

          SizedBox(height: 20,),
          Text("Previous",style: TextStyle(
              fontFamily: 'ProductSans',
              color: AppColors.indigo700,
              fontSize: 30,
              fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 10,),

          Expanded(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 120),
            child: Scrollbar(
              controller: _controller,
              child: Padding(
                padding: const EdgeInsets.only(right: 40),
                child: ListView.builder(
                    controller: _controller,
                    itemCount: reverseYearList.length,
                    itemBuilder: (context,index){
                      if(index == 0){
                        return SizedBox();
                      }
                      return Container(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.indigo700
                                  ),
                                ),
                                SizedBox(width: 30,),


                                Text("${reverseYearList[index].year}",style: TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: AppColors.textColorBlack,
                                    fontSize: 25,
                                    fontWeight: FontWeight.normal
                                ),),
                              ],

                            ),

                            InkWell(
                                onTap: () async {
                                  String id = getYears[index].id;
                                  print(getYears[index].id);

                                  deleteAcademicYear(id).then((apiResponse) {
                                    print("apiResponse");
                                    print(apiResponse);
                                    if(apiResponse["httpStatusCode"] == 204){
                                      setState(() {
                                        getYears.removeAt(index);
                                      });
                                    }

                                  }).catchError((error, stackTracke) {

                                    if (error is ApiError) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(error.dioErrorMsg.toString()),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Something went wrong!,'),
                                        ),
                                      );
                                      //logger.e(error);
                                    }
                                  });

                                },
                                child: Icon(Icons.delete,size: 25,)),
                          ],
                        ),
                      );
                    }),
              ),
            ),
          )),

          SizedBox(height: 20,),
        ],
      ),
    );
  }
    return Expanded(
      child: Center(child: Text("null"),),
    );
  }
}



