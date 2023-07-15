import { pool } from "../../db.js";

export const getMedicos = async (req, res, next) => {
    try {
        const result = await pool.query('CALL obtenerDatosMedicos();');

        if (result[0].length === 0) {
            res.status(404).json({ message: 'No se encontraron médicos registrados' });
        } else {
            res.json(result[0]);
        }
    } catch (error) {
        next(error);
    }
};


export const getMedico = async (req, res, next) => {
    const idMedico = req.params.idMedico;

    try {
        const result = await pool.query('CALL filtrarMedico(?);', [idMedico]);

        if (result[0].length === 0) {
            res.status(404).json({ message: 'No se encontró el médico especificado' });
        } else {
            res.json(result[0][0]);
        }
    } catch (error) {
        next(error);
    }
};


export const getMedicosFavoritos = async (req, res, next) => {
    const idUsuario = req.params.idUsuario;

    try {
        const result = await pool.query('CALL filtrarMedicoFavorito(?);', [idUsuario]);

        if (result[0].length === 0) {
            res.status(404).json({ message: 'No se encontraron médicos favoritos para el usuario especificado' });
        } else {
            res.json(result[0]);
        }
    } catch (error) {
        next(error);
    }
};


export const putMedicoFavorito = async (req, res, next) => {
    const idUsuario = req.body.idUsuario;
    const idMedico = req.body.idMedico;

    try {
        const result = await pool.query('CALL gestionarMedicoFavorito(?, ?);', [idUsuario, idMedico]);

        const mensaje = result[0][0].mensaje;
        res.json({ message: mensaje });
    } catch (error) {
        next(error);
    }
};
