import {
  Coordinates,
  EntityData,
  EntityType,
} from "../../../controllers/game/types";

export class Entity implements EntityData {
  public name: string;
  public position: Coordinates;
  public destination: Coordinates;
  public type: EntityType;
  public isPlayerControlled: boolean;

  public moveToCoords: Coordinates | undefined;

  constructor(entityData: EntityData) {
    this.name = entityData.name;
    this.position = entityData.position;
    this.destination = entityData.destination;
    this.type = entityData.type;
    this.isPlayerControlled = entityData.isPlayerControlled;
  }

  public getName(): string {
    return this.name;
  }

  public getPosition(): Coordinates {
    return this.position;
  }

  public getDestination(): Coordinates {
    return this.destination;
  }

  public isMoving(): boolean {
    return !(
      this.position.x === this.destination.x &&
      this.position.y === this.destination.y
    );
  }

  public moveTo(x: number, y: number): void {
    this.moveToCoords = { x, y };
  }
}
