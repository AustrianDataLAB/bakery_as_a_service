import fs from "fs";
import strapi, { Strapi } from "@strapi/strapi";
import {Knex} from "knex";
import Config = Knex.Config;

let instance: Strapi;

export const setupStrapi = async (): Promise<Strapi> => {
  if (!instance) {
    instance = await strapi({distDir: "./dist"}).load();

    instance.server.mount();
  }
  return instance;
}

export const cleanupStrapi = async (): Promise<void> => {
  const dbSettings = instance.config.get<Config>("database.connection");
  console.log(dbSettings);

  //close server to release the db-file
  instance.server.httpServer.close();

  // close the connection to the database before deletion
  await instance.db.connection.destroy();

  //delete test database after all tests have completed
  if (dbSettings && dbSettings.connection && (dbSettings.connection as Knex.Sqlite3ConnectionConfig).filename) {
    const tmpDbFile = (dbSettings.connection as Knex.Sqlite3ConnectionConfig).filename;
    if (fs.existsSync(tmpDbFile)) {
      fs.unlinkSync(tmpDbFile);
    }
  }
}
