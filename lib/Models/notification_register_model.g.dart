part of 'notification_register_model.dart';

class NotificationRegisterModelAdapter
    extends TypeAdapter<NotificationRegisterModel> {
  @override
  final int typeId = 1;

  @override
  NotificationRegisterModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationRegisterModel(
      id: fields[0] as int,
      time: fields[1] as String,
      repeatType: fields[2] as String,
      isReminderEnabled: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationRegisterModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.repeatType)
      ..writeByte(3)
      ..write(obj.isReminderEnabled);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationRegisterModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
