import { Coordinates, ObjectData } from "../../../controllers/game/types";

export class WorldObject implements ObjectData {
  public name: string;
  public position: Coordinates;
  public size: Coordinates;

  constructor(entityData: ObjectData) {
    this.name = entityData.name;
    this.position = entityData.position;
    this.size = entityData.size;
  }

  public getName(): string {
    return this.name;
  }

  public getPosition(): Coordinates {
    return this.position;
  }

  public getSize(): Coordinates {
    return this.size;
  }
}
