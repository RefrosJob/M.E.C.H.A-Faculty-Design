import { WorldData } from "../../../controllers/game/types";
import { WorldObject } from "./WorldObject";

export interface World {
  objectData: WorldObject[];
  worldSize: { maxX: number; maxY: number };
}

export class World implements World {
  private _objectData: WorldObject[];
  private _worldSize: World["worldSize"];

  constructor(worldData: WorldData) {
    this._objectData = worldData.objectData.map(
      (objectData) => new WorldObject(objectData)
    );
    this._worldSize = worldData.worldSize;
  }

  public getWorldObjects() {
    return this._objectData;
  }

  public getWorldObjectByName(name: string): WorldObject | undefined {
    return this._objectData.find((worldObject) => worldObject.name === name);
  }

  public getWorldSize(): World["worldSize"] {
    return this._worldSize;
  }
}
