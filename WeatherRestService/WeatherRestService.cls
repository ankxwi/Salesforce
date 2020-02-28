public class WeatherRestService {
	public static void getWeather(String city){
        
	String key = 'daf8e59de26d0cd88adc3c7edfab348f';

        HttpRequest request = new HttpRequest();
        request.setEndpoint('http://api.weatherstack.com/current?access_key='+ key +'&query='+city);
        request.setMethod('GET');
        request.setTimeout(60000);
        
        HttpResponse response = new Http().send(request);
        Weath w = (Weath)JSON.deserialize(response.getBody(), Weath.class);

        System.debug('Localtime: ' + w.location.localtime);
        System.debug('Сity: ' + w.location.name);        
        System.debug('Temperature: ' + w.current.temperature + '\u00B0' + 'C');
        System.debug('Weather descriptions: ' + w.current.weather_descriptions);
	System.debug('Wind speed: ' + w.current.wind_speed + ' km/h');
        System.debug('Pressure: ' + w.current.pressure + 'milliBar');        
    }

    public class Weath {
		public Location location;
		public Current current;
    }  

    public class Location {
		public String name;
		public String country;
		public String region;
		public String lat;
		public String lon;
		public String timezone_id;
		public String localtime;
		public Integer localtime_epoch;
		public String utc_offset;
	} 
       
	public class Current {
		public String observation_time;
		public Integer temperature;
		public Integer weather_code;
		public List<String> weather_icons;
		public List<String> weather_descriptions;
		public Integer wind_speed;
		public Integer wind_degree;
		public String wind_dir;
		public Integer pressure;
		public Integer precip;
		public Integer humidity;
		public Integer cloudcover;
		public Integer feelslike;
		public Integer uv_index;
		public Integer visibility;
		public String is_day;
	}
}
