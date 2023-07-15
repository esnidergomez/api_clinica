import { Router } from "express";
import {
    getMedico,
    getMedicos,
    getMedicosFavoritos,
    putMedicoFavorito
} from "../../controllers/gestionMedico/gestionmedico.controller.js";
const medicoRouter = Router();

medicoRouter.get("/consultar-medicos", getMedicos);
medicoRouter.get("/consultar-medico/:idMedico", getMedico);
medicoRouter.get("/consultar-medicos-favoritos/:idUsuario", getMedicosFavoritos);
medicoRouter.put("/asignar-medico-favorito/:idUsuario", putMedicoFavorito);

export default medicoRouter;