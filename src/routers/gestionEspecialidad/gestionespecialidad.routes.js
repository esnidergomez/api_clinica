import { Router } from "express";
import {
    getEspecialidades,
    getEspecialidadClinica,
    getEspecialidadesFavoritasPorUsuario,
    putEspecialidadFavorita
} from "../../controllers/gestionEspecialidad/gestionespecialidad.controller.js";
const especialidadRouter = Router();

especialidadRouter.get("/consultar-especialidades", getEspecialidades);
especialidadRouter.get("/consultar-especialidades/:idClinica", getEspecialidadClinica);
especialidadRouter.get("/consultar-especialidades-favoritas/:idUsuario", getEspecialidadesFavoritasPorUsuario);
especialidadRouter.put("/asignar-especialidades-favoritas/:idUsuario", putEspecialidadFavorita);

export default especialidadRouter;