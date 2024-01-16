import {
  EntityCommand,
  EntityCommands,
  GameData,
} from "../../controllers/game/types";
import { Entity } from "./entity/Entity";
import { World } from "./world/World";

export interface Game {
  entities: Entity[];
  world: World;
}

export class Game implements Game {
  private _entities: Entity[] = [];
  private _world: World;

  private commands: EntityCommands = [];

  constructor(gameData: GameData) {
    this._entities = gameData.entityData.map((entity) => new Entity(entity));
    this._world = new World(gameData.worldData);
  }

  public getWorld(): World {
    return this._world;
  }

  public getEntities(): Entity[] {
    return this._entities;
  }

  public getPlayerControlledEntities(): Entity[] {
    return this._entities.filter((entity) => entity.isPlayerControlled);
  }

  public getEntityByName(name: string): Entity | undefined {
    return this._entities.find((entity) => entity.name === name);
  }

  public getCommands(): EntityCommands {
    const newCommands: EntityCommands = this._entities
      .filter((entity) => entity.moveToCoords)
      .map<EntityCommand>((entity) => {
        if (entity.moveToCoords) {
          return {
            entityName: entity.name,
            command: { moveTo: entity.moveToCoords },
          };
        }
        return {
          entityName: entity.name,
          command: { moveTo: entity.position },
        };
      });

    this.commands.push(...newCommands);
    return this.commands;
  }
}
