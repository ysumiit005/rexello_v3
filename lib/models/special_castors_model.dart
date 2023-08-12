class SpecialCastorsModel {
  final String apiUrl, type, title, image;

  SpecialCastorsModel({
    required this.apiUrl,
    required this.type,
    required this.title,
    required this.image,
  });
}

// ignore: non_constant_identifier_names
List<SpecialCastorsModel> sp_castor_list = [
  SpecialCastorsModel(
    type: 'castors',
    title: 'Spring Loaded',
    apiUrl: 'https://rexello.com/api/get_product_seriesdata_api/specialcastor_series.php?spring_loaded=1',
    image: 'https://5.imimg.com/data5/QC/BS/QA/SELLER-4017279/spring-loaded-caster-500x500.jpg',
  ),
  SpecialCastorsModel(
    type: 'castors',
    title: 'Stainless Steel',
    apiUrl: 'https://rexello.com/api/get_product_seriesdata_api/specialcastor_series.php?stainless_steel=1',
    image: 'https://5.imimg.com/data5/TP/YB/MY-48822283/stainless-steel-casters-500x500.jpg',
  ),
  SpecialCastorsModel(
    type: 'castors',
    title: 'Jack',
    apiUrl: 'https://rexello.com/api/get_product_seriesdata_api/specialcastor_series.php?jack_castor=1',
    image: 'https://5.imimg.com/data5/BN/KV/MY-4480467/metal-jack-caster-wheel-500x500.jpg',
  ),
  SpecialCastorsModel(
    type: 'castors',
    title: 'Track',
    apiUrl: 'https://rexello.com/api/get_product_seriesdata_api/specialcastor_series.php?track_castor=1',
    image: 'https://4.imimg.com/data4/WU/WU/MY-3709629/square-groove-track-caster-500x500.jpg',
  ),
  SpecialCastorsModel(
    type: 'castors',
    title: 'Twin',
    apiUrl: 'https://rexello.com/api/get_product_seriesdata_api/specialcastor_series.php?twin_wheel_castor=1',
    image: 'https://5.imimg.com/data5/SELLER/Default/2022/5/WK/JT/GS/5986358/pioneer-heavy-duty-twin-castors-500x500.jpg',
  ),
  SpecialCastorsModel(
    type: 'castors',
    title: 'Leveller',
    apiUrl: 'https://rexello.com/api/get_product_seriesdata_api/specialcastor_series.php?leveler_castors=1',
    image: 'https://www.tai-sam.com/proimages/pb/product/pro09/TF-03-TF-04/Adjustable-Leveling-Caster-TF-03-TF-04-1.jpg',
  ),
];
