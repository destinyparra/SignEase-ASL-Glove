import { ModelInit, MutableModel, __modelMeta__, ManagedIdentifier } from "@aws-amplify/datastore";
// @ts-ignore
import { LazyLoading, LazyLoadingDisabled } from "@aws-amplify/datastore";





type EagerSensorData = {
  readonly [__modelMeta__]: {
    identifier: ManagedIdentifier<SensorData, 'id'>;
    readOnlyFields: 'createdAt' | 'updatedAt';
  };
  readonly id: string;
  readonly binaryState: string;
  readonly translation: string;
  readonly timestamp: string;
  readonly createdAt?: string | null;
  readonly updatedAt?: string | null;
}

type LazySensorData = {
  readonly [__modelMeta__]: {
    identifier: ManagedIdentifier<SensorData, 'id'>;
    readOnlyFields: 'createdAt' | 'updatedAt';
  };
  readonly id: string;
  readonly binaryState: string;
  readonly translation: string;
  readonly timestamp: string;
  readonly createdAt?: string | null;
  readonly updatedAt?: string | null;
}

export declare type SensorData = LazyLoading extends LazyLoadingDisabled ? EagerSensorData : LazySensorData

export declare const SensorData: (new (init: ModelInit<SensorData>) => SensorData) & {
  copyOf(source: SensorData, mutator: (draft: MutableModel<SensorData>) => MutableModel<SensorData> | void): SensorData;
}