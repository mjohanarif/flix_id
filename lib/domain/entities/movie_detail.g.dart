// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MovieDetailImpl _$$MovieDetailImplFromJson(Map<String, dynamic> json) =>
    _$MovieDetailImpl(
      id: json['id'] as int,
      title: json['title'] as String,
      posterPath: json['poster_path'] as String?,
      overview: json['overview'] as String,
      backDrop: json['backdrop_path'] as String?,
      runtime: json['runtime'] as int,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      genres: parse(json['genres']),
    );

Map<String, dynamic> _$$MovieDetailImplToJson(_$MovieDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'poster_path': instance.posterPath,
      'overview': instance.overview,
      'backdrop_path': instance.backDrop,
      'runtime': instance.runtime,
      'vote_average': instance.voteAverage,
      'genres': instance.genres,
    };
