import { Router } from "express";

const reservaRouter = Router();

reservaRouter.get("/registrar-reserva/:idUsuario", () => console.log(""));
reservaRouter.get("/consultar-reservas/:idUsuario", () => console.log(""));
reservaRouter.get("/cancelar-reserva/:idReserva", () => console.log(""));

export default reservaRouter;