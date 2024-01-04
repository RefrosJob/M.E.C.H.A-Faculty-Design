import { GameData, ObjectDataList } from "./types";

export function mapGameData(rawGameData: any): GameData {
  let currGameData = rawGameData;
  if (typeof rawGameData === "string") {
    currGameData = JSON.parse(rawGameData);
  }
  return {
    worldData: {
      objectData: currGameData["world_data"]["object_data"] as ObjectDataList,
      worldSize: {
        maxX: currGameData["world_data"]["world_size"]["max_x"],
        maxY: currGameData["world_data"]["world_size"]["max_y"],
      },
    },
    entityData: currGameData["entity_data"].map((data: any) => {
      return {
        ...data,
        isPlayerControlled: data["is_player_controlled"],
      };
    }),
  } as GameData;
}
