class WeatherModel {
  var temp;
  var long;
  var lat;
  var humidity;
  var pressure;
  String icon;
  String name;
  String description;

  WeatherModel(this.temp, this.long, this.lat, this.humidity, this.pressure,
      this.name, this.description, this.icon);

  factory WeatherModel.fromJson(Map<String, dynamic> jsonData) {
    //print("Inside factory method: $jsonData");
    return WeatherModel(
        jsonData['main']['temp'],
        jsonData['coord']['lon'],
        jsonData['coord']['lat'],
        jsonData['main']['humidity'],
        jsonData['main']['pressure'],
        jsonData['name'],
        jsonData['weather'][0]['description'],
        jsonData['weather'][0]['icon']);
  }
}
