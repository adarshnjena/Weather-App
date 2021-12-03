String backgroundImage(int dt, int sunset, int sunrise) {
  String home;
  if (dt < sunset && dt > sunrise) {
    home = 'images/Home-Day.png';
  } else {
    home = 'images/Home-Night.png';
  }
  return home;
}

class WeatherModel {
  String getWeatherImg(int condition, int dt, int sunset, int sunrise) {
    if (dt < sunset && dt > sunrise) {
      if (condition < 300) {
        return 'images/Day Storm.png';
      } else if (condition < 400) {
        return 'images/Day Rain.png';
      } else if (condition < 600) {
        return 'images/Day Rain.png';
      } else if (condition < 700) {
        return 'images/Day Snow.png';
      } else if (condition < 800) {
        return 'images/Day Wind.png';
      } else if (condition == 800) {
        return 'images/Day Sun.png';
      } else if (condition <= 804) {
        return 'images/Day Clouds.png';
      } else {
        return '‍images/Day Sun.png';
      }
    } else {
      if (condition < 300) {
        return 'images/Night Storm.png';
      } else if (condition < 400) {
        return 'images/Night Rain.png';
      } else if (condition < 600) {
        return 'images/Night Rain.png';
      } else if (condition < 700) {
        return 'images/Night Snow.png';
      } else if (condition < 800) {
        return 'images/Night Wind.png';
      } else if (condition == 800) {
        return 'images/Night Moon.png';
      } else if (condition <= 804) {
        return 'images/Night Clouds.png';
      } else {
        return '‍images/Day Sun.png';
      }
    }
  }

  String getMessage(int temp) {
    if (temp > 37) {
      return 'It\'s 🍦 time';
    } else if (temp > 32) {
      return 'Time for shorts and 👕';
    } else if (temp < 30) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
