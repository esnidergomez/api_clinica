import { Router } from "express";

const gestihorarioRouter = Router();

gestihorarioRouter.get("/consultar-horarios/:idClinica&idEspecialidad&idMedico", () => console.log(""));

export default gestihorarioRouter;