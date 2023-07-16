---Lista todas las especialidades:
DELIMITER //

CREATE PROCEDURE obtenerEspecialidades()
BEGIN
    SELECT *
    FROM clinica.especialidad;
END //

DELIMITER ;

CALL obtenerEspecialidades();
-- Listas las especialidades de cierta clinica donde hay medicos
DELIMITER //

CREATE PROCEDURE obtenerEspecialidadesPorClinica(IN idClinica INT)
BEGIN
    SELECT e.*
    FROM clinica.especialidad e
    INNER JOIN clinica.medico m ON m.idespecialidad = e.idespecialidad
    WHERE m.idclinica = idClinica;
END //

DELIMITER ;
CALL obtenerEspecialidadesPorClinica(1);

-- Mostrar especialidades favoritas
DELIMITER //

CREATE PROCEDURE verEspecialidadesFavoritas(IN idUsuario INT)
BEGIN
    SELECT E.*
    FROM clinica.especialidad_favorita EF
    INNER JOIN clinica.especialidad E ON EF.idespecialidad = E.idespecialidad
    WHERE EF.idusuario = idUsuario;
END //

DELIMITER ;
CALL verEspecialidadesFavoritas(1);

-- Agregar especialidades favoritas
CREATE PROCEDURE gestionarEspecialidadFavorita(IN idUsuario INT, IN idEspecialidad INT)
BEGIN
    DECLARE existeFavorito INT;
    
    -- Verificar si la especialidad ya está marcada como favorita
    SELECT COUNT(*) INTO existeFavorito
    FROM clinica.especialidad_favorita
    WHERE idusuario = idUsuario AND idespecialidad = idEspecialidad;
    
    IF existeFavorito > 0 THEN
        -- La especialidad ya está en la lista de favoritos, se elimina
        DELETE FROM clinica.especialidad_favorita
        WHERE idusuario = idUsuario AND idespecialidad = idEspecialidad;
        
        SELECT 'no favoritos' AS mensaje;
    ELSE
        -- La especialidad no está en la lista de favoritos, se agrega
        INSERT INTO clinica.especialidad_favorita (idespecialidad, idusuario)
        VALUES (idEspecialidad, idUsuario);
        
        SELECT 'favoritos' AS mensaje;
    END IF;
END //

DELIMITER ;

SET SQL_SAFE_UPDATES = 0;
CALL gestionarEspecialidadFavorita(1, 1);
SET SQL_SAFE_UPDATES = 1;

-- COnsultar hora disponible
DELIMITER //

CREATE PROCEDURE obtenerHorasDisponibles(IN idMedico INT, IN idClinica INT, IN idEspecialidad INT)
BEGIN
    SELECT td.fechadisponible, td.horadisponible
    FROM clinica.medico_tiempos_disponibles mtd
    INNER JOIN clinica.tiempos_disponibles td ON mtd.idtiempos_disponibles = td.idtiempos_disponibles
    WHERE mtd.idmedico = idMedico AND mtd.idclinica = idClinica AND mtd.idespecialidad = idEspecialidad;
END //

DELIMITER ;
CALL obtenerHorasDisponibles(1, 1, 1);

-----Obtiene todos los medicos registrados:
DELIMITER //

CREATE PROCEDURE obtenerDatosMedicos()
BEGIN
    SELECT m.idMedico,
           m.nombre,
           m.idEspecialidad,
           e.nombreEspecialidad,
           m.idClinica,
           c.nombreClinica
    FROM Medico m
    LEFT JOIN Especialidad e ON e.idEspecialidad = m.idEspecialidad
    LEFT JOIN Clinica c ON c.idClinica = m.idClinica;
END //

DELIMITER ;

CALL obtenerDatosMedicos();

-----Filtra un médico en específico por su id:
DELIMITER //

CREATE PROCEDURE filtrarMedico(IN idMedico INT)
BEGIN
    SELECT m.idMedico,
           m.nombre,
           m.idEspecialidad,
           e.nombreEspecialidad,
           m.idClinica,
           c.nombreClinica
    FROM medico m
    LEFT JOIN especialidad e ON e.idEspecialidad = m.idEspecialidad
    LEFT JOIN clinica c ON c.idClinica = m.idClinica
    WHERE m.idMedico = idMedico;
END //

DELIMITER ;
CALL filtrarMedico(1);


----Filtra los medicos seleccionados favoritos
DELIMITER //

CREATE PROCEDURE filtrarMedicoFavorito(IN idUsuario INT)
BEGIN
    SELECT mf.idmedico,
           m.nombre,
           mf.idusuario,
           u.nombreusuario
    FROM medico_favorito mf
    LEFT JOIN medico m ON m.idmedico = mf.idmedico
    LEFT JOIN usuario u ON u.idusuario = mf.idusuario
    WHERE mf.idusuario = idUsuario;
END //

DELIMITER ;
CALL filtrarMedicoFavorito(1);


--- Asignar medico como favorito
DELIMITER //

CREATE PROCEDURE gestionarMedicoFavorito(IN idUsuario INT, IN idMedico INT)
BEGIN
    DECLARE existeFavorito INT;
    
    -- Verificar si el médico ya está marcado como favorito
    SELECT COUNT(*) INTO existeFavorito
    FROM clinica.medico_favorito
    WHERE idusuario = idUsuario AND idmedico = idMedico;
    
    IF existeFavorito > 0 THEN
        -- El médico ya está en la lista de favoritos, se elimina
        DELETE FROM clinica.medico_favorito
        WHERE idusuario = idUsuario AND idmedico = idMedico;
        
        SELECT 'Médico eliminado de favoritos' AS mensaje;
    ELSE
        -- El médico no está en la lista de favoritos, se agrega
        INSERT INTO clinica.medico_favorito (idmedico, idusuario)
        VALUES (idMedico, idUsuario);
        
        SELECT 'Médico agregado a favoritos' AS mensaje;
    END IF;
END //

DELIMITER ;
SET SQL_SAFE_UPDATES = 0;
CALL gestionarMedicoFavorito(1, 1);
SET SQL_SAFE_UPDATES = 1;

--Registrar reservas
DELIMITER //

CREATE PROCEDURE RegistrarCita(
    IN usuarioID INT,
    IN fechaagenda DATE,
    IN horaagenda TIME,
    IN fechahorapago DATETIME,
    IN idmedico INT,
    IN idespecialidad INT,
    IN idclinica INT,
    IN idtiempos_disponibles INT,
    IN precio DECIMAL(6,2),
    IN idpago VARCHAR(50)
)
BEGIN
    DECLARE citaID INT;

    -- Insertar una nueva cita con los valores proporcionados
    INSERT INTO cita (fechaagenda, horaagenda, fechahorapago, idmedico, idespecialidad, idclinica, idtiempos_disponibles, cancelado, precio, idpago)
    VALUES (fechaagenda, horaagenda, fechahorapago, idmedico, idespecialidad, idclinica, idtiempos_disponibles, NULL, precio, idpago);
    
    -- Obtener el ID de la última cita insertada
    SET citaID = LAST_INSERT_ID();
    
    -- Actualizar el campo idcita en la tabla usuario
    UPDATE usuario
    SET idcita = citaID
    WHERE idusuario = usuarioID;
    
    -- Devolver el ID de la cita registrada
    SELECT citaID AS 'ID de la Cita';
END //

DELIMITER ;

CALL RegistrarCita(1, '2023-07-01', '09:00:00', NULL, 1, 1, 1, 1, 100, 'COD-001');
--Consultar Reservas
DELIMITER //

CREATE PROCEDURE ObtenerReservasUsuario(IN usuarioID INT)
BEGIN
    SELECT u.idusuario, u.nombreusuario, u.email, u.telefono, u.fechanacimiento, c.idcita, c.fechaagenda, c.horaagenda, c.fechahorapago, c.cancelado, c.precio, c.idpago
    FROM usuario u
    INNER JOIN cita c ON u.idcita = c.idcita
    WHERE u.idusuario = usuarioID AND c.cancelado IS NULL;
END //

DELIMITER ;
CALL ObtenerReservasUsuario(1);

--Cancelar cita
DELIMITER //

CREATE PROCEDURE CancelarCita(IN citaID INT)
BEGIN
    UPDATE cita
    SET cancelado = 'Cancelado'
    WHERE idcita = citaID;
END //

DELIMITER ;
CALL CancelarCita(1);







