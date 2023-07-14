import { Router } from "express";
import { postPagar } from "../../controllers/mercadoPago/mercadopago.controller.js";
const pagoRouter = Router();

pagoRouter.get("/pagar", postPagar);
 
export default pagoRouter;