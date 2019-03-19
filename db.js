const DB_USER = "";
const DB_PASSWORD = "";
const DB_DATABASE = "";
const DB_HOST = "";
const DB_PORT = ""; // defaults to 3306
const DB_OPTIONS = ""; // optional

const mysqlConnectionString = "mysql://" + DB_USER + ":" + DB_PASSWORD + "@" + DB_HOST + (DB_PORT ? ":" + DB_PORT : "") + "/" + DB_DATABASE + "?" + DB_OPTIONS;

module.exports = mysqlConnectionString;
