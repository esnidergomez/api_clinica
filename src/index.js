import express  from "express";
import gestihorarioRouter from "./routers/gestionHorarios/gestionhorario.routes.js";
import especialidadRouter from "./routers/gestionEspecialidad/gestionespecialidad.routes.js";
import medicoRouter from "./routers/gestionMedico/gestionmedico.routes.js";
import reservaRouter from "./routers/gestionReservas/gestionreserva.routes.js";
import pagoRouter from "./routers/mercadoPago/mercadopago.routes.js";
import { PORT } from './config.js'

const app = express();
const gestionMedicos        = '/ux-cuenta/appcodigo/servicio-al-cliente/v1',
      gestionEspecialidades = '/ux-administracion-presupuesto/appcodigo/servicio-al-cliente/v1',
      gestionReservas       = '/ux-administracion-presupuesto/appcodigo/servicio-al-cliente/v1',
      mercadoPago           = '/ux-administracion-presupuesto/appcodigo/servicio-al-cliente/v1',
      gestionHorarios       = '/ux-gestion-pagos/appcodigo/servicio-al-cliente/v1';

app.use(express.json());
app.use(gestionMedicos,medicoRouter); 
app.use(gestionEspecialidades,especialidadRouter);
app.use(gestionReservas,reservaRouter);
app.use(mercadoPago,pagoRouter);
app.use(gestionHorarios,gestihorarioRouter);
app.use((req, res, next) => { 
    res.status(404).json({ message: "endpoint Not found" });
});

app.listen(PORT);
console.log(PORT);