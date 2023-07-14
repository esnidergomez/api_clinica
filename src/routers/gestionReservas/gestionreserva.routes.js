import { Router } from "express";
import { 
    postRegistrarReserva,
    postCancelarReserva, 
    getConsultarReserva
} from "../../controllers/gestionReservas/gestionreserva.controller.js";
const reservaRouter = Router();

reservaRouter.post("/registrar-reserva/:idUsuario", postRegistrarReserva);
reservaRouter.get("/consultar-reservas/:idUsuario", getConsultarReserva);
reservaRouter.post("/cancelar-reserva/:idReserva", postCancelarReserva);

export default reservaRouter; 