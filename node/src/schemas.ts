import Joi, { ObjectSchema } from "joi";

const coordinateSchema = Joi.object().keys({
  x: Joi.number(),
  y: Joi.number(),
});

const gameSchema = Joi.object().keys({
  entity_data: Joi.array().items(
    Joi.object().keys({
      destination: coordinateSchema,
      position: coordinateSchema,
      name: Joi.string(),
      type: Joi.string(),
      is_player_controlled: Joi.boolean(),
    })
  ),
  world_data: Joi.object().keys({
    world_size: { max_x: Joi.number(), max_y: Joi.number() },
    object_data: Joi.array().items(
      Joi.object().keys({
        name: Joi.string(),
        size: coordinateSchema,
        position: coordinateSchema,
      })
    ),
  }),
});

export default {
  "/game": gameSchema,
} as { [key: string]: ObjectSchema };
