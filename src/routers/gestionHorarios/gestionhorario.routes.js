import { Router } from "express";
import { getHorariosDisponibleMedico } from "../../controllers/gestionHorarios/gestionhorario.controller.js";
const gestihorarioRouter = Router();

gestihorarioRouter.get("/consultar-horarios/:idClinica&idEspecialidad&idMedico", getHorariosDisponibleMedico);

export default gestihorarioRouter;