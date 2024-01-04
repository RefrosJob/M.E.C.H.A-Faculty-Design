import { EntityCommands } from "../controllers/game/types";
import { Game } from "./classes/Game";

function main(game: Game) {
  const entities = game.getEntities();
  console.log(entities);

  const instructions: EntityCommands = game.getCommands();
  console.log(instructions);
  return instructions;
}

export default main;
