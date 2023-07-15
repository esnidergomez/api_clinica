import { pool } from "../../db.js";

export const getHorariosDisponibleMedico = async (req, res, next) => {
    const idMedico = req.params.idMedico;
    const idClinica = req.params.idClinica;
    const idEspecialidad = req.params.idEspecialidad;
  
    try {
      const result = await pool.query('CALL obtenerHorasDisponibles(?, ?, ?);', [idMedico, idClinica, idEspecialidad]);
  
      if (result[0].length === 0) {
        res.status(404).json({ message: 'No se encontraron horarios disponibles para el médico, clínica y especialidad especificados' });
      } else {
        res.json(result[0]);
      }
    } catch (error) {
      next(error);
    }
  };
  
