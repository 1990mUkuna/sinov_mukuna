// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArtistModelAdapter extends TypeAdapter<ArtistModel> {
  @override
  final int typeId = 2;

  @override
  ArtistModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArtistModel(
      id: fields[0] as String,
      name: fields[1] as String,
      popularity: fields[2] as int,
      images: (fields[3] as List).cast<String>(),
      genres: (fields[4] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ArtistModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.popularity)
      ..writeByte(3)
      ..write(obj.images)
      ..writeByte(4)
      ..write(obj.genres);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArtistModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
