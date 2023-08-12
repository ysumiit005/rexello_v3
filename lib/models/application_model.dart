class ApplicationModel {
  final String? image, title, webUrl, type, apiUrl;
  final String? castorApiUrl, trolleyApiUrl, wheelApiUrl, otherApiUrl;
  final int id;

  ApplicationModel({
    required this.id,
    required this.image,
    required this.title,
    required this.webUrl,
    required this.type,
    required this.apiUrl,
    this.castorApiUrl,
    this.trolleyApiUrl,
    this.wheelApiUrl,
    this.otherApiUrl,
  });
}


// ignore: non_constant_identifier_names
List<ApplicationModel> applications_list = [
  ApplicationModel(
    id: 1,
    type: 'Hospitals',
    title: "HOSPITALS",
    image: "assets/images/Applications/hospital.png",
    webUrl: 'https://rexello.com/hospital/hospital',
    apiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=1&product_type=castor",
    castorApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=1&product_type=castors",
    trolleyApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=1&product_type=trolleys",
    wheelApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=1&product_type=wheels",
    otherApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=1&product_type=others",
  ),
  //castor link

  // trolley link
  // wheels link
  // others
  ApplicationModel(
    id: 2,
    type: 'Manufacturing',
    title: "MANUFACTURERS",
    image: "assets/images/Applications/manuf.png",
    webUrl: 'https://rexello.com/manufacturer/manufacturer',
    apiUrl: "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=2",
    castorApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=2&product_type=castors",
    trolleyApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=2&product_type=trolleys",
    wheelApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=2&product_type=wheels",
    otherApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=2&product_type=others",
  ),
  ApplicationModel(
    id: 3,
    type: 'Shopping Malls',
    title: "SHOPPING MALLS",
    image: "assets/images/Applications/shopping.png",
    webUrl: 'https://rexello.com/shopping_mall/shopping',
    apiUrl: "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=3",
    castorApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=3&product_type=castors",
    trolleyApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=3&product_type=trolleys",
    wheelApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=3&product_type=wheels",
    otherApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=3&product_type=others",
  ),
  ApplicationModel(
    id: 4,
    type: 'Airports',
    title: "AIR PORTS",
    image: "assets/images/Applications/airport.png",
    webUrl: 'https://rexello.com/airport_applications/airport',
    apiUrl: "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=4",
    castorApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=4&product_type=castors",
    trolleyApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=4&product_type=trolleys",
    wheelApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=4&product_type=wheels",
    otherApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=4&product_type=others",
  ),
  ApplicationModel(
    id: 5,
    type: 'Fire Depratments',
    title: "FIRE DEPARTMENTS",
    image: "assets/images/Applications/fire.png",
    webUrl: 'https://rexello.com/fire_department/fire',
    apiUrl: "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=5",
    castorApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=5&product_type=castors",
    trolleyApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=5&product_type=trolleys",
    wheelApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=5&product_type=wheels",
    otherApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=5&product_type=others",
  ),
  ApplicationModel(
    id: 6,
    type: 'Harbours',
    title: "HARBOURS",
    image: "assets/images/Applications/shipp.png",
    webUrl: 'https://rexello.com/harbour/harbour',
    apiUrl: "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=6",
    castorApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=6&product_type=castors",
    trolleyApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=6&product_type=trolleys",
    wheelApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=6&product_type=wheels",
    otherApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=6&product_type=others",
  ),
  ApplicationModel(
    id: 7,
    type: 'Bridges & Road Constructions',
    title: "BRIDGE ROAD CONSTRUCTION",
    image: "assets/images/Applications/road.png",
    webUrl: 'https://rexello.com/bridge_road_construction/bridge',
    apiUrl: "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=7",
    castorApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=7&product_type=castors",
    trolleyApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=7&product_type=trolleys",
    wheelApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=7&product_type=wheels",
    otherApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=7&product_type=others",
  ),
  ApplicationModel(
    id: 8,
    type: 'Waste Treatent Plants',
    title: "WASTE WATER TREATMENT PLANT",
    image: "assets/images/Applications/water.png",
    webUrl: 'https://rexello.com/waste_water_treatment/wastewater',
    apiUrl: "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=8",
    castorApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=8&product_type=castors",
    trolleyApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=8&product_type=trolleys",
    wheelApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=8&product_type=wheels",
    otherApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=8&product_type=others",
  ),
  ApplicationModel(
    id: 9,
    type: 'Recycling',
    title: "RECYCLING",
    image: "assets/images/Applications/recycle.png",
    webUrl: 'https://rexello.com/recycling/recycling',
    apiUrl: "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=9",
    castorApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=9&product_type=castors",
    trolleyApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=9&product_type=trolleys",
    wheelApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=9&product_type=wheels",
    otherApiUrl:
        "https://rexello.com/api/get_application_seriesdata_api/get_application_api.php?application_type=9&product_type=others",
  ),
];
