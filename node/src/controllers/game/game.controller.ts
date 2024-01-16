import axios, { AxiosResponse } from "axios";
import { NextFunction, Request, Response } from "express";
import { mapGameData } from "./mappers";
import main from "../../gameProcess/main";
import { Game } from "../../gameProcess/classes/Game";

const gameHandler = async (req: Request, res: Response, next: NextFunction) => {
  const gameData = mapGameData(req.body);
  const game = new Game(gameData);
  return res.send(main(game));
};

export default { gameHandler };
