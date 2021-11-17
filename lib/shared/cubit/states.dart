abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppNavigationBarState extends AppStates {}

class AppCreateDataBaseState extends AppStates {}

class AppInsertToDataBaseState extends AppStates {}

class AppGetDataFromDataBaseState extends AppStates {}

class AppUpdateDataBaseState extends AppStates {}

class AppGetDatabaseLoadingState extends AppStates {}

class AppUpdateErrorDataBaseState extends AppStates {
  final String error;

  AppUpdateErrorDataBaseState(this.error);
}

class AppDeleteDatabaseState extends AppStates {}


class AppChangeIconState extends AppStates {}
