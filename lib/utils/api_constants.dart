// const String baseURL = 'http://172.20.10.4:8000';
const String baseURL = 'http://taego.pythonanywhere.com';


class ApiConstants {
  static const String leagueList = '${baseURL}/api/leagues/';
  static const String teamList = '${baseURL}/api/teams/';
  static const String fixtureList = '${baseURL}/api/fixtures/';
  static const String userList = '${baseURL}/api/users/';
  static const String leaguePost = '${baseURL}/api/leagues/';
  static const String fixturePost = '${baseURL}/api/fixtures/';
  static const String teamPost = '${baseURL}/api/teams/';
  static const String leagueUpdate = '${baseURL}/api/leagues/';
  static const String fixtureUpdate = '${baseURL}/api/fixtures/';
  static const String teamUpdate = '${baseURL}/api/teams/';
  static const String loginUser = '${baseURL}/api-auth/login/';
  static const String registerUser = '${baseURL}/api/users/';
  static const String playerInvitation = '${baseURL}/team/invitation/';
}