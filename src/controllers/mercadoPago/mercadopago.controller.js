import { pool } from "../../db.js";
import mercadopago from "mercadopago";

export const postPagar = async (req, res) => { 
    const 
    { 
        titulo, 
        precio,
        idUsuario,
        fechaAgenda,
        horaAgenda,
        fechaHoraPago,
        idMedico,
        idEspecialidad,
        idClinica,
        idTiempoDisponible 
    } = req.body;
    mercadopago.configure({
        access_token: 'TEST-56925687694290-071103-bdf6640e055ddacf48b60f3c71ecba7e-1420890444' 
    })
    const result = await mercadopago.preferences.create({
        items: [ 
            {
                title: titulo,
                unit_price: precio,
                currency_id: "PEN",
                quantity: 1,
            }
        ],
        back_urls: {
            success: 'http://localhost:3000/success',
            failure: 'http://localhost:3000/failure',
            pending: 'http://localhost:3000/pending',
        },
        notification_urls: "http://localhost:3000/webhook",
    })
  
    try{
      const [rows] = await pool.query('CALL RegistrarCita(?,?,?,?,?,?,?,?,?,?);', [idUsuario,fechaAgenda, horaAgenda, fechaHoraPago, idMedico, idEspecialidad, idClinica, idTiempoDisponible,,precio,'COD-001' ])
      console.log(rows);
      res.send({
        actualiza: rows[0],
        link: result.body.init_point
      })
    }catch (error) {
      res.status(500).send(error);
    }
};