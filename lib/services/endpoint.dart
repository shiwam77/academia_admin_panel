class Api {
  static const apiVNone = "";
  static const apiV1 = "/v1";
  static const apiV2 = "/v2";

  static String get apiHostedUrl {
    return "http://127.0.0.1:3000";
  }
}

class AuthApi {

  static String get  apiView {
    return Api.apiHostedUrl +"/auth";
  }

  static String get login {
    return apiView + Api.apiV1 + "/login";
  }

  static String get signUp {
    return apiView + Api.apiV1 + "/signup";
  }

  static String get forgoPassword {
    return apiView + Api.apiV1 + "/forgotPassword";
  }

  static String get resetPassword {
    return apiView + Api.apiV1 + "/resetPassword";
  }
  static String get updateUser {
    return "/{:Id}/updateUser";
  }

  static String get deleteUser {
    return "/{:Id}/deleteUser";
  }
}

class AcademicYearApi{
  static String get academicAllYear{
    return "/{:Id}/getAllYears";
  }

  static String get createYear{
    return '/createYear';
  }

  static String get updateYear{
    return '/{:Id}/updateYear';
  }

  static String get deleteYear{
    return '/{:Id}/deleteYear';
  }
}

class AcademicClassApi{
  static String get academicClasses{
    return "/{:Id}/getAllClasses";
  }

  static String get createClass{
    return '/createClass';
  }

  static String get updateClass{
    return '/{:Id}/updateClass';
  }

  static String get deleteClass{
    return '/{:Id}/deleteClass';
  }
}

class AcademicSubjectApi{
  static String get academicSubjects{
    return "/{:Id}/getAllSubjects";
  }

  static String get createSubject{
    return '/createSubject';
  }

  static String get updateSubject{
    return '/{:Id}/updateSubject';
  }

  static String get deleteSubject{
    return '/{:Id}/deleteSubject';
  }
}

class AcademicStudentApi{
  static String get academicStudents{
    return "/{:Id}/getAllStudents";
  }

  static String get createStudent{
    return '/createStudent';
  }

  static String get updateStudent{
    return '/{:Id}/updateStudent';
  }

  static String get deleteStudent{
    return '/{:Id}/deleteStudent';
  }
}

class AcademicHomeTaskApi{
  static String get academicTask{
    return "/{:Id}/getAllHomeTasks";
  }

  static String get createTask{
    return '/createHomeTasks';
  }

  static String get updateTask{
    return '/{:Id}/updateHomeTasks';
  }

  static String get deleteTask{
    return '/{:Id}/deleteHomeTasks';
  }
}
class AcademicHomeTutorApi{
  static String get academicTutor{
    return "/{:Id}/getAllTutor";
  }

  static String get createTutor{
    return '/createTutor';
  }

  static String get updateTutor{
    return '/{:Id}/updateTutor';
  }

  static String get deleteTutor{
    return '/{:Id}/deleteTutor';
  }
}