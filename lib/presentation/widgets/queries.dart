class SqlQry{
  static const countriesData = "SELECT count(country) as countryCount, country  FROM td group by country";
  static const regionData = "SELECT count(region) as reginCount, region FROM td GROUP BY region";
  //static const uniqueCities = "SELECT count(city) as cityCount, city FROM td group by city HAVING COUNT(city) = 1";
  static const uniqueCities = "SELECT count(city) as cityCount, city || ',' || country AS city FROM td group by city HAVING COUNT(city) = 1";
  static const multiCities = "SELECT count(city) as cityCount, city || ',' || country AS city FROM td WHERE city IN (SELECT city FROM td GROUP BY city HAVING COUNT(city) > 1) GROUP BY city, country ORDER BY city;";


  static const commonRegionQry = "SELECT count(region) AS regionCount, region FROM td WHERE ";
  static const commonCountryQry = "SELECT count(country) AS countryCount, country, region FROM td WHERE ";
  static const commonCityQry = "SELECT count(city) As cityCount, city, country, region FROM td WHERE ";

}



