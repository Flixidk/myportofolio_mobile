import 'package:json_annotation/json_annotation.dart';

part 'experience.g.dart';

// Portfolio experience synchronized with the DRF API.
@JsonSerializable(fieldRename: FieldRename.snake)
class Experience {
  @JsonKey(includeToJson: false)
  final String? id;

  final String title;
  final String description;
  final String category;
  final DateTime startedAt;
  final DateTime? endedAt;

  @JsonKey(includeToJson: false)
  final int starCount;

  @JsonKey(includeToJson: false)
  final bool isStarred;

  @JsonKey(includeToJson: false)
  final String starredByNames;

  const Experience({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.startedAt,
    this.endedAt,
    this.starCount = 0,
    this.isStarred = false,
    this.starredByNames = '',
  });

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}
