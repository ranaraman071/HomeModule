import 'package:database_task/data/providers/databse_list_bloc/filter_box_detail/filter_box_detail_event.dart';
import 'package:database_task/data/providers/databse_list_bloc/filter_box_detail/filter_box_detail_state.dart';
import 'package:database_task/presentation/widgets/queries.dart';
import 'package:database_task/utils/database_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterDataBloc extends Bloc<FilterEvent, FilterDataLoadeddState> {
  FilterDataBloc() : super(FilterDataLoadeddState(
            countriesData: [],
            citiesData: [],
            citiesCopiesData: [],
            regions: [],
            selectcountriesData: [],
            cityFilterMap: [],
            countryFilterMap: [],
            regionFilterMap: [])) {

    on<FetchFilterDataEvent>(_onFetchFilterData);

    on<FetchDataWithRegionEvent>(_fetchFilterWithRegion);

  }

  // Funtion to display option on filter box
  Future<void> _onFetchFilterData(FetchFilterDataEvent event, Emitter<FilterDataLoadeddState> emit) async {
    List<Map<String, dynamic>> cityFilterMap = [];
    List<Map<String, dynamic>> countryFilterMap = [];
    List<Map<String, dynamic>> regionFilterMap = [];

    try {
      var countriesData = await DatabaseHelper.fetchDataWithQuery(SqlQry.countriesData);
      var regionData = await DatabaseHelper.fetchDataWithQuery(SqlQry.regionData);
      var uniqueCities = await DatabaseHelper.fetchDataWithQuery(SqlQry.uniqueCities);
      var multiCities = await DatabaseHelper.fetchDataWithQuery(SqlQry.multiCities);
      var citiesData = [...uniqueCities, ...multiCities];
      List<String> uniqueCitiesName = [];

      for (var data in uniqueCities) {uniqueCitiesName.add(data["city"]);}

      List<String> countries = countriesData.map<String>((e) => e["country"].toString()).toList();
      List<String> cities = citiesData.map<String>((e) => e["city"].toString()).toList();
      List<String> regions = regionData.map<String>((e) => e["region"].toString()).toList();

     // Get All Countries Count
      String resultCountry = countries.map((country) => "'${country.toString().split(',')[0]}'").join(",");
      var countryFilter = await DatabaseHelper.fetchDataWithQuery("${SqlQry.commonCountryQry}country IN ($resultCountry) GROUP BY country, region");
      for (var data in countryFilter) {
        Map<String, dynamic> countryData = {
          'country': data['country'].toString(),
          'countryCount': int.parse(data['countryCount'].toString())
        };
        bool containsRegion = countryFilterMap.any((map) => map['country'] == data['country'].toString());
        if (containsRegion) {
          for (var map in countryFilterMap) {
            if (map['country'] == data['country'].toString()) {
              map['countryCount'] += data['countryCount'];
              break;  // Exit the loop after updating the region
            }
          }
        }else{countryFilterMap.add(countryData);}
      }

      // Get All Cities Count
      String resultCity = cities.map((city) => "'${city.split(',')[0]}'").join(",");
      var cityFilter = await DatabaseHelper.fetchDataWithQuery("${SqlQry.commonCityQry}city IN ($resultCity) GROUP BY city, country, region");
       for (var data in cityFilter) {
        Map<String, dynamic> cityData = {
          'city': data['city'].toString(),
          'cityCount': int.parse(data['cityCount'].toString()),
          'country': data['country'].toString()
        };
        cityFilterMap.add(cityData);
      }

    // Get All regions Count
      String resultRegion = regions.map((region) => "'${region.toString().trim()}'").join(",");
      var regionFilter = await DatabaseHelper.fetchDataWithQuery("${SqlQry.commonRegionQry}region IN ($resultRegion) GROUP BY country, region");
      for (var data in regionFilter) {
        Map<String, dynamic> regionData = {
          'region': data['region'].toString(),
          'regionCount': int.parse(data['regionCount'].toString())
        };
        bool containsRegion = regionFilterMap.any((map) => map['region'] == data['region'].toString());
        if (containsRegion) {
          for (var map in regionFilterMap) {
            if (map['region'] == data['region'].toString()) {
              map['regionCount'] += data['regionCount'];
              break;  // Exit the loop after updating the region
            }
          }
        }else{regionFilterMap.add(regionData);}
      }

      emit(FilterDataLoadeddState(
          countriesData: countries, citiesData: cities,
          citiesCopiesData: uniqueCitiesName, regions: regions,
          selectcountriesData: [], cityFilterMap: cityFilterMap,
          countryFilterMap: countryFilterMap, regionFilterMap: regionFilterMap)); // Emit the loaded state with data
    } catch (e) {}
  }

  // Funtion to display Buisiness count
  Future<void> _fetchFilterWithRegion(FetchDataWithRegionEvent event, Emitter<FilterDataLoadeddState> emit) async {
    print(event.name);
    List country=[];
    // String result = event.name.map((city) => "'${city.split(',')[0]}'").join(",");
    String result = event.name.map((cityData) {
      List<String> cityParts = cityData.split(",");
      cityParts.length > 1 ? country.add(cityParts[1].toString()) : [];
      return "'${cityParts[0]}'";}).join(",");
    String countryResult  = country.isNotEmpty ? "'${country.join("','")}'" : "";

    if (result == "") {
      List<Map<String, dynamic>> cityFilterMap = [];
      List<Map<String, dynamic>> countryFilterMap = [];
      List<Map<String, dynamic>> regionFilterMap = [];

      // Get All Countries Count
      String resultCountry = state.countriesData.map((country) => "'${country.toString().split(',')[0]}'").join(",");
      var countryFilter = await DatabaseHelper.fetchDataWithQuery("${SqlQry.commonCountryQry}country IN ($resultCountry) GROUP BY country, region");
      for (var data in countryFilter) {
        Map<String, dynamic> countryData = {
          'country': data['country'].toString(),
          'countryCount': int.parse(data['countryCount'].toString())
        };
        bool containsRegion = countryFilterMap.any((map) => map['country'] == data['country'].toString());
        if (containsRegion) {
          for (var map in countryFilterMap) {
            if (map['country'] == data['country'].toString()) {
              map['countryCount'] += data['countryCount'];
              break;  // Exit the loop after updating the region
            }
          }
        }else{countryFilterMap.add(countryData);}
      }
      String resultCity = state.citiesData.map((city) => "'${city.toString().split(',')[0].trim()}'").join(",");
      print(resultCity);
      var cityFilter = await DatabaseHelper.fetchDataWithQuery("SELECT (SELECT COUNT(city) FROM td t2 WHERE t2.city = t1.city AND t2.country = t1.country AND t2.region = t1.region) AS cityCount, t1.city AS city, t1.country, t1.region FROM td t1 WHERE t1.city IN ($resultCity) GROUP BY t1.country, t1.region, t1.city;");
       for (var data in cityFilter) {
        Map<String, dynamic> cityData = {
          'city': data['city'].toString(),
          'cityCount': int.parse(data['cityCount'].toString()),
          'country': data['country'].toString()
        };
          cityFilterMap.add(cityData);
      }

      // Get All regions Count
      String resultRegion = state.regions.map((region) => "'${region.toString().trim()}'").join(",");
      var regionFilter = await DatabaseHelper.fetchDataWithQuery("${SqlQry.commonRegionQry}region IN ($resultRegion) GROUP BY country, region");
      for (var data in regionFilter) {
        Map<String, dynamic> regionData = {
          'region': data['region'].toString(),
          'regionCount': int.parse(data['regionCount'].toString())
        };
        bool containsRegion = regionFilterMap.any((map) => map['region'] == data['region'].toString());
        if (containsRegion) {
          for (var map in regionFilterMap) {
            if (map['region'] == data['region'].toString()) {
              map['regionCount'] += data['regionCount'];
              break;  // Exit the loop after updating the region
            }
          }
        }else{regionFilterMap.add(regionData);}
      }
      emit(FilterDataLoadeddState(countriesData: state.countriesData, citiesData: state.citiesData, citiesCopiesData: state.citiesCopiesData, regions: state.regions, selectcountriesData: [], cityFilterMap: cityFilterMap, countryFilterMap: countryFilterMap, regionFilterMap: regionFilterMap));


    } else if (event.region == "region") {
      var regionFilter = await DatabaseHelper.fetchDataWithQuery("${SqlQry.commonRegionQry}region IN ($result) GROUP BY region");
      var countryFilter = await DatabaseHelper.fetchDataWithQuery("${SqlQry.commonCountryQry}region IN ($result) GROUP BY country, region");
      var cityFilter = await DatabaseHelper.fetchDataWithQuery("${SqlQry.commonCityQry}region IN ($result) GROUP BY city, country, region");
      emit(FilterDataLoadeddState(
          countriesData: state.countriesData, citiesData: state.citiesData,
          citiesCopiesData: state.citiesCopiesData, regions: state.regions,
          selectcountriesData: state.selectcountriesData, cityFilterMap: cityFilter,
          countryFilterMap: countryFilter, regionFilterMap: regionFilter));
    } else if (event.region == "country") {
      var regionFilter = await DatabaseHelper.fetchDataWithQuery("${SqlQry.commonRegionQry}country IN ($result) GROUP BY region");
      var countryFilter = await DatabaseHelper.fetchDataWithQuery("${SqlQry.commonCountryQry}country IN ($result) GROUP BY country, region");
      var cityFilter = await DatabaseHelper.fetchDataWithQuery("${SqlQry.commonCityQry}country IN ($result) GROUP BY city, country, region");
      emit(FilterDataLoadeddState(
          countriesData: state.countriesData, citiesCopiesData: state.citiesCopiesData,
          citiesData: state.citiesData, regions: state.regions,
          selectcountriesData: state.selectcountriesData, cityFilterMap: cityFilter,
          countryFilterMap: countryFilter, regionFilterMap: regionFilter));
    } else if (event.region == "city") {
      var regionFilter = await DatabaseHelper.fetchDataWithQuery("${SqlQry.commonRegionQry}city IN ($result) GROUP BY region");
      List<Map<String, dynamic>> countryFilter = [];
      for (var data in event.name) {
        List<String> countryParts = data.split(",");
        String tempCity = countryParts[0] ;
        String tempCountry = countryParts[1] ;
        var tempData = await DatabaseHelper.fetchDataWithQuery("${SqlQry.commonCountryQry}city IN ('$tempCity') AND country IN ('$tempCountry') GROUP BY country, region");
        if(tempData.length !=0) {countryFilter.add(tempData[0]);}
      }
      var tempCountryFilter = removeDuplicatesAndCount(countryFilter);
      countryFilter = tempCountryFilter;
      var cityFilter = await DatabaseHelper.fetchDataWithQuery("${SqlQry.commonCityQry}city IN ($result)${countryResult == ''?"":" AND country IN ($countryResult)"} GROUP BY city, country, region");
      print(countryFilter);
      emit(FilterDataLoadeddState(
          countriesData: state.countriesData, citiesCopiesData: state.citiesCopiesData,
          citiesData: state.citiesData, regions: state.regions,
          selectcountriesData: state.selectcountriesData, cityFilterMap: cityFilter,
          countryFilterMap:countryFilter, regionFilterMap:regionFilter));
    }
  }

  // Remove duplicate Value
  List<Map<String, dynamic>> removeDuplicatesAndCount(List<Map<String, dynamic>> countries) {
    Map<String, Map<String, dynamic>> resultMap = {};
    for (var country in countries) {
      String countryKey = country['country'];
      if (resultMap.containsKey(countryKey)) {resultMap[countryKey]!['countryCount'] += 1;}
      else {resultMap[countryKey] = {...country, 'countryCount': 1};}
    }
    return resultMap.values.toList();
  }
}
