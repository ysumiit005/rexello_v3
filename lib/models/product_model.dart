class ProductModel {
  final String image, title, weightNDiameter, apiUrl, type;
  final int id;

  ProductModel({
    required this.id,
    required this.type,
    required this.image,
    required this.title,
    required this.weightNDiameter,
    required this.apiUrl,
  });
}

// ignore: non_constant_identifier_names
List<ProductModel> products_list = [
  ProductModel(
    id: 1,
    type: 'castors',
    title: "LIGHT DUTY",
    weightNDiameter: "5 to 65 KG  |   25mm - 10mm",
    image: "assets/images/by_weights/light_duty/FR.webp",
    apiUrl:
        'https://rexello.com/api/get_product_seriesdata_api/lightduty_series.php',
    
  ),
  ProductModel(
    id: 2,
    type: 'castors',
    title: "MEDIUM DUTY",
    weightNDiameter: "40 to 820 KG  |  63mm - 200mm",
    image: "assets/images/by_weights/medium_duty/MRN.webp",
    apiUrl:
        'https://rexello.com/api/get_product_seriesdata_api/mediumduty_series.php',
  ),
  ProductModel(
    id: 3,
    type: 'castors',
    title: "HEAVY DUTY",
    weightNDiameter: "200 to 1800 KG  |  100mm - 400mm",
    image: "assets/images/by_weights/heavy_duty/AR.webp",
    apiUrl:
        'https://rexello.com/api/get_product_seriesdata_api/heavyduty_series.php',
  ),
  ProductModel(
    id: 4,
    type: 'castors',
    title: "SUPER HEAVY DUTY",
    weightNDiameter: "500 to 10000 KG  |  150mm - 525mm",
    image: "assets/images/by_weights/super_heavy_duty/RLT TW.webp",
    apiUrl:
        'https://rexello.com/api/get_product_seriesdata_api/superheavyduty_series.php',
  ),
  ProductModel(
    id: 5,
    type: 'wheels',
    title: "WHEELS",
    weightNDiameter: "0 to 1100 KG  |  25mm - 400mm",
    image: "assets/images/wheels/CTPW.png",
    apiUrl:
        'https://rexello.com/api/get_product_seriesdata_api/wheel_series.php',
  ),
  ProductModel(
    id: 6,
    type: 'trolleys',
    title: "PLATFORM TROLLEYS",
    weightNDiameter: "150 to 1000 KG",
    image: "assets/images/platform_trolleys/PLAT S 9060.webp",
    apiUrl:
        'https://rexello.com/api/get_product_seriesdata_api/platformtrolleys_series.php',
  ),
  ProductModel(
    id: 7,
    type: 'trolleys',
    title: "OTHER TROLLEYS",
    weightNDiameter: "150 to 1000 KG",
    image: "assets/images/other_trolleys/cyl300.webp",
    apiUrl:
        'https://rexello.com/api/get_product_seriesdata_api/othertrolleys_series.php',
  ),
  ProductModel(
    id: 8,
    type: 'others',
    title: "OTHER PRODUCTS",
    weightNDiameter: "40 to 820 KG  |  63mm - 200mm",
    image: "assets/images/other_products/ball transfer.webp",
    apiUrl:
        'https://rexello.com/api/get_product_seriesdata_api/otherproducts_series.php',
  ),
];
