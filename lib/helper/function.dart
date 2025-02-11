String weatherDescriptionIcon(String description) {
  print("description = $description");
  if (description.toLowerCase().contains("cloud") ||
      description.toLowerCase().contains("nuage")) {
    return 'assets/cloud_icon.png'; // Icône pour un ciel nuageux
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
