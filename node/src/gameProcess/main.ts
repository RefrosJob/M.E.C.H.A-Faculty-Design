import { EntityCommands } from "../controllers/game/types";
import { Game } from "./classes/Game";

var used = false;

function main(game: Game) {
  const entities = game.getPlayerControlledEntities();
 const mech = entities[0]
  entities[0].moveTo(571,  205);
  const instructions: EntityCommands = game.getCommands();
  return instructions;
}

function once() {
  if (!used) {
    console.log("FIRED ONCE");
    used = true;
  }
}

export default main;
