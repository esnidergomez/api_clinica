USE clinica;
INSERT INTO `clinica`.`especialidad` (`nombreespecialidad`, `descriespecialidad`, `urlImagen`)
VALUES ('Cardiología', 'Especialidad médica que se ocupa del diagnóstico y tratamiento de las enfermedades del corazón.', 'url_imagen_1.jpg'),
       ('Dermatología', 'Especialidad médica que se ocupa del diagnóstico y tratamiento de las enfermedades de la piel.', 'url_imagen_2.jpg'),
       ('Gastroenterología', 'Especialidad médica que se ocupa del diagnóstico y tratamiento de las enfermedades del aparato digestivo.', 'url_imagen_3.jpg');

INSERT INTO `clinica`.`clinica` (`nombreclinica`)
VALUES ('Clínica A'),
       ('Clínica B'),
       ('Clínica C');

INSERT INTO `clinica`.`medico` (`nombre`, `idespecialidad`, `idclinica`, `urlImagen`)
VALUES ('Dr. García', 1, 1, 'url_imagen_medico_1.jpg'),
       ('Dra. Martínez', 2, 1, 'url_imagen_medico_2.jpg'),
       ('Dr. López', 3, 2, 'url_imagen_medico_3.jpg'),
       ('Dra. Rodríguez', 1, 3, 'url_imagen_medico_4.jpg');

INSERT INTO `clinica`.`tiempos_disponibles` (`idtiempos_disponibles`, `fechadisponible`, `horadisponible`)
VALUES (1, '2023-07-14', '09:00:00'),
       (2, '2023-07-15', '14:30:00'),
       (3, '2023-07-16', '11:15:00');

INSERT INTO `clinica`.`medico_tiempos_disponibles` (`idmedico`, `idespecialidad`, `idclinica`, `idtiempos_disponibles`)
VALUES (1, 1, 1, 1),
       (2, 2, 1, 2),
       (3, 3, 2, 3);

INSERT INTO `clinica`.`cita` (`fechaagenda`, `horaagenda`, `idmedico`, `idespecialidad`, `idclinica`, `idtiempos_disponibles`, `cancelado`, `precio`, `idpago`)
VALUES ('2023-07-14', '09:00:00', 1, 1, 1, 1, 'No', 50.00, 'COD-001'),
       ('2023-07-15', '14:30:00', 2, 2, 1, 2, 'No', 75.00, 'COD-002'),
       ('2023-07-16', '11:15:00', 3, 3, 2, 3, 'No', 60.00, 'COD-003');

INSERT INTO `clinica`.`usuario` (`nombreusuario`, `email`, `telefono`, `fechanacimiento`, `idcita`, `urlImagen`)
VALUES ('Juan Pérez', 'juan@example.com', '123456789', '1990-01-01', 1, 'url_imagen_usuario_1.jpg'),
       ('María López', 'maria@example.com', '987654321', '1985-05-10', 2, 'url_imagen_usuario_2.jpg'),
       ('Carlos Gómez', 'carlos@example.com', '555555555', '1995-12-15', 3, 'url_imagen_usuario_3.jpg');

INSERT INTO `clinica`.`medico_favorito` (`idmedico`, `idusuario`)
VALUES (1, 1),
       (2, 2),
       (3, 3);

INSERT INTO `clinica`.`especialidad_favorita` (`idespecialidad`, `idusuario`)
VALUES (1, 1),
       (2, 2),
       (3, 3);

