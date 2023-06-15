class Tables {

  static const COUNT = 'count';
  static const USER = 'user';

  static const TABLES =
  [
    "CREATE TABLE IF NOT EXISTS " +
        COUNT +
        "("
            "id TEXT PRIMARY KEY,"
            "access_token TEXT,"
            "refresh_token TEXT,"
            "token_type TEXT,"
            "expires_time TEXT,"
            "created_at TEXT,"
            "expires_in TEXT"
            ")",
    "CREATE TABLE IF NOT EXISTS " +
        USER +
        "("
            "id TEXT PRIMARY KEY,"
            "email TEXT,"
            "username TEXT,"
            "name TEXT,"
            "isOnline INTEGER(1),"
            "isActive INTEGER(1),"
            "lastTime TEXT,"
            "rol TEXT,"
            "latitude INTEGER,"
            "longitude INTEGER"
            ")"
  ];

}