import express from "express";
import controller from "../controllers/game/game.controller";
import schemaValidator from "../middlewares/schemaValidator";

const router = express.Router();

const gameRoute = "/game";

router.post(gameRoute, schemaValidator(gameRoute), controller.gameHandler);

export = router;
