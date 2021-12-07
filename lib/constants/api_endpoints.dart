class ApiEndpoints{

  static const String searchFridgeItemsApi="https://savenote.herokuapp.com/getProductInfo";
  static const String  BASE_URL = "https://savenote.herokuapp.com/";
  static Uri  login    = Uri.parse(BASE_URL +'login') ;
  static Uri  register   = Uri.parse(BASE_URL +'signup');
  static Uri  forgotPassword = Uri.parse(BASE_URL +'forgotpasswd');
  static Uri  reset    = Uri.parse(BASE_URL +'auth/reset');
  static Uri  user     = Uri.parse(BASE_URL +'getUserData');
  static Uri  createHousehold     = Uri.parse(BASE_URL +'add_list_members');
  static Uri  addMember     = Uri.parse(BASE_URL +'addMembers');
  static Uri  getHousehold     = Uri.parse(BASE_URL +'getHouseholdById');
  static Uri  getWeeklyStatistics     = Uri.parse(BASE_URL +'getWeeklyStatistics');
  static Uri  getProductInfo     = Uri.parse(BASE_URL +'getProductInfo');
  static Uri  searchBarCode     = Uri.parse(BASE_URL +'searchBarCode');
  static Uri  addInventory     = Uri.parse(BASE_URL +'addInventory');
  static Uri  getInventory     = Uri.parse(BASE_URL +'getInventory');
}