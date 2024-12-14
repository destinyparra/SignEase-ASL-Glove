/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, override_on_non_overriding_member, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;


/** This is an auto generated class representing the SensorData type in your schema. */
class SensorData extends amplify_core.Model {
  static const classType = const _SensorDataModelType();
  final String id;
  final String? _translation;
  final String? _binaryState;
  final amplify_core.TemporalDateTime? _timestamp;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  SensorDataModelIdentifier get modelIdentifier {
      return SensorDataModelIdentifier(
        id: id
      );
  }
  
  String? get translation {
    return _translation;
  }
  
  String? get binaryState {
    return _binaryState;
  }
  
  amplify_core.TemporalDateTime? get timestamp {
    return _timestamp;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const SensorData._internal({required this.id, translation, binaryState, timestamp, createdAt, updatedAt}): _translation = translation, _binaryState = binaryState, _timestamp = timestamp, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory SensorData({String? id, String? translation, String? binaryState, amplify_core.TemporalDateTime? timestamp}) {
    return SensorData._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      translation: translation,
      binaryState: binaryState,
      timestamp: timestamp);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SensorData &&
      id == other.id &&
      _translation == other._translation &&
      _binaryState == other._binaryState &&
      _timestamp == other._timestamp;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("SensorData {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("translation=" + "$_translation" + ", ");
    buffer.write("binaryState=" + "$_binaryState" + ", ");
    buffer.write("timestamp=" + (_timestamp != null ? _timestamp!.format() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  SensorData copyWith({String? translation, String? binaryState, amplify_core.TemporalDateTime? timestamp}) {
    return SensorData._internal(
      id: id,
      translation: translation ?? this.translation,
      binaryState: binaryState ?? this.binaryState,
      timestamp: timestamp ?? this.timestamp);
  }
  
  SensorData copyWithModelFieldValues({
    ModelFieldValue<String?>? translation,
    ModelFieldValue<String?>? binaryState,
    ModelFieldValue<amplify_core.TemporalDateTime?>? timestamp
  }) {
    return SensorData._internal(
      id: id,
      translation: translation == null ? this.translation : translation.value,
      binaryState: binaryState == null ? this.binaryState : binaryState.value,
      timestamp: timestamp == null ? this.timestamp : timestamp.value
    );
  }
  
  SensorData.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _translation = json['translation'],
      _binaryState = json['binaryState'],
      _timestamp = json['timestamp'] != null ? amplify_core.TemporalDateTime.fromString(json['timestamp']) : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'translation': _translation, 'binaryState': _binaryState, 'timestamp': _timestamp?.format(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'translation': _translation,
    'binaryState': _binaryState,
    'timestamp': _timestamp,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<SensorDataModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<SensorDataModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final TRANSLATION = amplify_core.QueryField(fieldName: "translation");
  static final BINARYSTATE = amplify_core.QueryField(fieldName: "binaryState");
  static final TIMESTAMP = amplify_core.QueryField(fieldName: "timestamp");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "SensorData";
    modelSchemaDefinition.pluralName = "SensorData";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: SensorData.TRANSLATION,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: SensorData.BINARYSTATE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: SensorData.TIMESTAMP,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _SensorDataModelType extends amplify_core.ModelType<SensorData> {
  const _SensorDataModelType();
  
  @override
  SensorData fromJson(Map<String, dynamic> jsonData) {
    return SensorData.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'SensorData';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [SensorData] in your schema.
 */
class SensorDataModelIdentifier implements amplify_core.ModelIdentifier<SensorData> {
  final String id;

  /** Create an instance of SensorDataModelIdentifier using [id] the primary key. */
  const SensorDataModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'SensorDataModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is SensorDataModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}