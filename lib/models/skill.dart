import 'package:json_annotation/json_annotation.dart';

part 'skill.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Skill {
  @JsonKey(includeToJson: false)
  final String? id;

  final String title;
  final String description;
  final String category;
  final String iconPath;

  @JsonKey(includeToJson: false)
  final int endorseCount;

  @JsonKey(includeToJson: false)
  final bool isEndorsed;

  @JsonKey(includeToJson: false)
  final String endorsedByNames;

  const Skill({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.iconPath,
    this.endorseCount = 0,
    this.isEndorsed = false,
    this.endorsedByNames = '',
  });

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);

  Map<String, dynamic> toJson() => _$SkillToJson(this);
} 