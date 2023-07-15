import { Router } from "express";
import {
    getMedico,
    getMedicos,
    getMedicosFavoritos,
    putMedicoFavorito
} from "../../controllers/gestionMedico/gestionmedico.controller";
const medicoRouter = Router();

medicoRouter.get("/consultar-medicos", getMedico);
medicoRouter.get("/consultar-medico/:idMedico", getMedicos);
medicoRouter.get("/consultar-medicos-favoritos/:idUsuario", getMedicosFavoritos);
medicoRouter.put("/asignar-medico-favorito/:idUsuario", putMedicoFavorito);

export default medicoRouter;