String weatherDescriptionIcon(String description) {
  // print("description = $description");
  if (description.toLowerCase().contains("wind") ||
      description.toLowerCase().contains("vent")) {
    return 'assets/images/wind_icon.png'; // Icône pour un ciel nuageux
  } else if (description.toLowerCase().contains("cloud") ||
      description.toLowerCase().contains("nuage")) {
    return 'assets/images/cloud_icon.png'; // Icône
  } else if (description.toLowerCase().contains("storm") ||
      description.toLowerCase().contains("orage")) {
    return 'assets/images/storm_icon.png'; // Icône pour un ciel orageux
  } else if (description.toLowerCase().contains("sun") ||
      description.toLowerCase().contains("ensoleillé")) {
    return 'assets/images/sun_icon.png'; // Icône pour un ciel ensoleillé
  } else if (description.toLowerCase().contains("rain") ||
      description.toLowerCase().contains("pluie")) {
    return 'assets/images/rain_icon.png'; // Icône pour un ciel pluvieux
  } else {
    return 'assets/images/sun_icon.png'; // Icône par défaut
  }
}

String weatherDescriptionImage(String description) {
  // print("description = $description");
  if (description.toLowerCase().contains("wind") ||
      description.toLowerCase().contains("vent")) {
    return 'assets/images/wind.jpg'; // Icône pour un ciel
  } else if (description.toLowerCase().contains("cloud") ||
      description.toLowerCase().contains("nuage")) {
    return 'assets/images/cloud.jpg'; // Icône pour un ciel nuageux
  } else if (description.toLowerCase().contains("storm") ||
      description.toLowerCase().contains("orage")) {
    return 'assets/images/storm.jpg'; // Icône pour un ciel orageux
  } else if (description.toLowerCase().contains("sun") ||
      description.toLowerCase().contains("ensoleillé")) {
    return 'assets/images/sunny.jpg'; // Icône pour un ciel ensoleillé
  } else if (description.toLowerCase().contains("rain") ||
      description.toLowerCase().contains("pluie")) {
    return 'assets/images/rain.jpg'; // Icône pour un ciel pluvieux
  } else {
    return 'assets/images/clear.jpg'; // Icône par défaut
  }
}
