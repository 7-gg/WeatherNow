String weatherDescriptionIcon(String description) {
  // print("description = $description");
  if (description.toLowerCase().contains("wind") ||
      description.toLowerCase().contains("vent")) {
    return 'assets/wind_icon.png'; // Icône pour un ciel nuageux
  }
  if (description.toLowerCase().contains("cloud") ||
      description.toLowerCase().contains("nuage")) {
    return 'assets/cloud_icon.png'; // Icône
  } else if (description.toLowerCase().contains("storm") ||
      description.toLowerCase().contains("orage")) {
    return 'assets/storm_icon.png'; // Icône pour un ciel orageux
  } else if (description.toLowerCase().contains("sun") ||
      description.toLowerCase().contains("ensoleillé")) {
    return 'assets/sun_icon.png'; // Icône pour un ciel ensoleillé
  } else if (description.toLowerCase().contains("rain") ||
      description.toLowerCase().contains("pluie")) {
    return 'assets/rain_icon.png'; // Icône pour un ciel pluvieux
  } else {
    return 'assets/sun_icon.png'; // Icône par défaut
  }
}

String weatherDescriptionImage(String description) {
  // print("description = $description");
  if (description.toLowerCase().contains("wind") ||
      description.toLowerCase().contains("vent")) {
    return 'assets/wind.jpg'; // Icône pour un ciel
  }
  if (description.toLowerCase().contains("cloud") ||
      description.toLowerCase().contains("nuage")) {
    return 'assets/cloud.jpg'; // Icône pour un ciel nuageux
  } else if (description.toLowerCase().contains("storm") ||
      description.toLowerCase().contains("orage")) {
    return 'assets/storm.jpg'; // Icône pour un ciel orageux
  } else if (description.toLowerCase().contains("sun") ||
      description.toLowerCase().contains("ensoleillé")) {
    return 'assets/sunny.jpg'; // Icône pour un ciel ensoleillé
  } else if (description.toLowerCase().contains("rain") ||
      description.toLowerCase().contains("pluie")) {
    return 'assets/rain.jpg'; // Icône pour un ciel pluvieux
  } else {
    return 'assets/clear.jpg'; // Icône par défaut
  }
}
