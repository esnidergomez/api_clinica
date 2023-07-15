import { pool } from "../../db.js";

export const postRegistrarReserva = async (req, res) => {
    const usuarioID = req.params.idUsuario;
    const
        {
            fechaagenda,
            horaagenda,
            idmedico,
            idespecialidad,
            idclinica,
            idtiempos_disponibles,
            precio,
            idpago
        } = req.body;

    try {
        const query = `CALL RegistrarCita(${usuarioID}, '${fechaagenda}', '${horaagenda}', NULL, ${idmedico}, ${idespecialidad}, ${idclinica}, ${idtiempos_disponibles}, ${precio}, '${idpago}');`;

        const result = await pool.query(query);
        const citaID = result[0][0]['ID de la Cita'];

        console.log('Cita registrada exitosamente. ID de la cita:', citaID);
        res.json({ citaID });
    } catch (error) {
        console.error('Error al registrar la cita:', error);
        res.status(500).json({ error: 'Error al registrar la cita' });
    }
}

export const postCancelarReserva = async (req, res) => {
    const citaID = req.params.idReserva;

    try {
        await pool.query(
            'CALL CancelarCita(?);',
            [citaID]
        );
        res.json({ message: 'Cita cancelada exitosamente' });
    } catch (error) {
        next(error);
    }
}

export const getConsultarReserva = async (req, res) => {
    const { idUsuario } = req.params;
    try {
        const result = await pool.query(
            'CALL ObtenerReservasUsuario(?);', [idUsuario]
        );
        res.json(result[0]);
    } catch (error) {
        next(error);
    }
}