export interface GameData {
  worldData: WorldData;
  entityData: EntityDataList;
}

export interface WorldData {
  objectData: ObjectDataList;
  worldSize: { maxX: number; maxY: number };
}

export type ObjectDataList = ObjectData[];

export interface ObjectData {
  name: string;
  position: Coordinates;
  size: Coordinates;
}

type EntityDataList = EntityData[];

export interface EntityData {
  name: string;
  position: Coordinates;
  destination: Coordinates;
  type: EntityType;
  isPlayerControlled: boolean;
}

export enum EntityType {
  MECH = "mech",
}

export interface Coordinates {
  x: number;
  y: number;
}

export type EntityCommands = EntityCommand[];

export interface EntityCommand {
  entityName: string;
  command: { [key: string]: any };
}
