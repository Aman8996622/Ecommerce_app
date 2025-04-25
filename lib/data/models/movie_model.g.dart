// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieAdapter extends TypeAdapter<Movie> {
  @override
  final int typeId = 0;

  @override
  Movie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Movie(
      adult: fields[0] as bool?,
      backdropPath: fields[1] as String?,
      id: fields[2] as int?,
      title: fields[3] as String?,
      originalTitle: fields[4] as String?,
      overview: fields[5] as String?,
      posterPath: fields[6] as String?,
      genreIds: (fields[7] as List?)?.cast<int>(),
      popularity: fields[8] as double?,
      releaseDate: fields[9] as DateTime?,
      mediaType: fields[10] as MediaType?,
      video: fields[11] as bool?,
      voteAverage: fields[12] as double?,
      voteCount: fields[13] as int?,
      name: fields[14] as String?,
      originalName: fields[15] as String?,
      firstAirDate: fields[16] as DateTime?,
      originCountry: (fields[17] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Movie obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.adult)
      ..writeByte(1)
      ..write(obj.backdropPath)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.originalTitle)
      ..writeByte(5)
      ..write(obj.overview)
      ..writeByte(6)
      ..write(obj.posterPath)
      ..writeByte(7)
      ..write(obj.genreIds)
      ..writeByte(8)
      ..write(obj.popularity)
      ..writeByte(9)
      ..write(obj.releaseDate)
      ..writeByte(10)
      ..write(obj.mediaType)
      ..writeByte(11)
      ..write(obj.video)
      ..writeByte(12)
      ..write(obj.voteAverage)
      ..writeByte(13)
      ..write(obj.voteCount)
      ..writeByte(14)
      ..write(obj.name)
      ..writeByte(15)
      ..write(obj.originalName)
      ..writeByte(16)
      ..write(obj.firstAirDate)
      ..writeByte(17)
      ..write(obj.originCountry);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
