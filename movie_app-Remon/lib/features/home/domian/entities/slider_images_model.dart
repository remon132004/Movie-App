class SliderImagesModel {
  List<String> imageUrl;

  SliderImagesModel(this.imageUrl);

  factory SliderImagesModel.fromJson(Map<String, dynamic> json) =>
      SliderImagesModel(((json['results'] as List).map(
        (e) => (e['poster_path']as String)??'',
      )).toList());
}
