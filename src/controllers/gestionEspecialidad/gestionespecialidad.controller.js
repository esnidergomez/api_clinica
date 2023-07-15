import { pool } from "../../db.js";

export const getEspecialidades = async (req, res, next) => {
    try {
      const result = await pool.query('CALL obtenerEspecialidades();');
      
      if (result[0].length === 0) {
        res.status(404).json({ message: 'No se encontraron especialidades' });
      } else {
        res.json(result[0]);
      }
    } catch (error) {
      next(error);
    }
};
  

export const getEspecialidadClinica = async (req, res, next) => {
    const idClinica = req.params.idClinica;
  
    try {
      const result = await pool.query('CALL obtenerEspecialidadesPorClinica(?);', [idClinica]);
  
      if (result[0].length === 0) {
        res.status(404).json({ message: 'No se encontraron especialidades para la clínica especificada' });
      } else {
        res.json(result[0]);
      }
    } catch (error) {
      next(error);
    }
};
  

export const getEspecialidadesFavoritasPorUsuario = async (req, res, next) => {
    const idUsuario = req.params.idUsuario;
  
    try {
      const result = await pool.query('CALL verEspecialidadesFavoritas(?);', [idUsuario]);
  
      if (result[0].length === 0) {
        res.status(404).json({ message: 'No se encontraron especialidades favoritas para el usuario especificado' });
      } else {
        res.json(result[0]);
      }
    } catch (error) {
      next(error);
    }
};
  

export const putEspecialidadFavorita = async (req, res, next) => {
    const idUsuario = req.body.idUsuario;
    const idEspecialidad = req.body.idEspecialidad;
  
    try {
      const result = await pool.query('CALL gestionarEspecialidadFavorita(?, ?);', [idUsuario, idEspecialidad]);
      
      const mensaje = result[0][0].mensaje;
      res.json({ message: mensaje });
    } catch (error) {
      next(error);
    }
  };
  