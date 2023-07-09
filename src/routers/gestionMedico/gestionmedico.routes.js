import { Router } from "express";

const medicoRouter = Router();

medicoRouter.get("/consultar-medicos", () => console.log(""));
medicoRouter.get("/consultar-medico/:idMedico", () => console.log(""));
medicoRouter.get("/consultar-medicos-favoritos/:idUsuario", () => console.log(""));
medicoRouter.put("/asignar-medico-favorito/:idUsuario", () => console.log(""));

export default medicoRouter;