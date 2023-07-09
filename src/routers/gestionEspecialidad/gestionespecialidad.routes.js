import { Router } from "express";

const especialidadRouter = Router();

especialidadRouter.get("/consultar-especialidades", () => console.log(""));
especialidadRouter.get("/consultar-especialidades/:idClinica", () => console.log(""));
especialidadRouter.get("/consultar-especialidades-favoritas/:idUsuario", () => console.log(""));
especialidadRouter.put("/asignar-especialidades-favoritas/:idUsuario", () => console.log(""));

export default especialidadRouter;