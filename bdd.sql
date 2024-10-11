CREATE DATABASE orbitalobjectsdb;
USE orbitalobjectsdb;

CREATE TABLE planets (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) UNIQUE,
    radius DECIMAL(10, 2),
    texture_url VARCHAR(255),
    description_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE planet_positions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    planet_id INT,
    year INT,
    distance_from_sun DECIMAL(10, 2),
    eccentricity DECIMAL(5, 4),
    inclination DECIMAL(5, 2),
    UNIQUE (planet_id, year),
    FOREIGN KEY (planet_id) REFERENCES planets(id)
);


CREATE TABLE comets (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    diameter FLOAT,
    eccentricity FLOAT,
    inclination FLOAT,
    perihelion FLOAT,
    M1 FLOAT,
    Q FLOAT,
    n FLOAT,
    tp_cal DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE asteroids (
    id INT PRIMARY KEY AUTO_INCREMENT, -- Identificador único para cada asteroide; se incrementa automáticamente.
    full_name VARCHAR(255) UNIQUE, -- Nombre completo del asteroide; debe ser único en la tabla.
    diameter DECIMAL(10, 2), -- Diámetro del asteroide en kilómetros o metros, con hasta 10 dígitos en total y 2 decimales.
    e DECIMAL(5, 4), -- Excentricidad de la órbita del asteroide; un número entre 0 y 1 que indica lo elíptica que es la órbita.
    i DECIMAL(5, 2), -- Inclinación de la órbita del asteroide en grados; indica el ángulo de inclinación respecto al plano de referencia.
    per_y DECIMAL(10, 2), -- Período orbital del asteroide en años; el tiempo que tarda en completar una órbita alrededor del Sol.
    M1 DECIMAL(10, 6), -- Puede representar la masa o alguna otra magnitud del asteroide; permite hasta 10 dígitos en total y 6 decimales.
    ad DECIMAL(10, 6), -- Distancia del afelio (punto más alejado del Sol) en unidades astronómicas o kilómetros, con hasta 6 decimales.
    n DECIMAL(10, 6), -- Tasa media de movimiento del asteroide en grados por día; representa cuántos grados recorre en su órbita en un día.
    tp_cal DATE, -- Fecha del último paso del asteroide por el perihelio (punto más cercano al Sol); almacenada en formato de fecha.
    is_high_risk BOOLEAN, -- Indica si el asteroide es de alto riesgo de colisión con la Tierra (TRUE o FALSE).
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Marca de tiempo que indica cuándo se creó el registro; se establece automáticamente en el momento de la inserción.
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- Marca de tiempo que indica cuándo se actualizó por última vez el registro; se actualiza automáticamente con cada modificación.
);




CREATE TABLE satellites (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) UNIQUE,
    radius DECIMAL(10, 2),
    texture_url VARCHAR(255),
    planet_id INT,
    FOREIGN KEY (planet_id) REFERENCES planets(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE orbits (
    id INT PRIMARY KEY AUTO_INCREMENT,
    object_id INT,
    object_type ENUM('asteroid', 'comet'),
    year INT,
    distance DECIMAL(10, 2),
    eccentricity DECIMAL(5, 4),
    inclination DECIMAL(5, 2),
    FOREIGN KEY (object_id) REFERENCES asteroids(id) ON DELETE CASCADE,
    FOREIGN KEY (object_id) REFERENCES comets(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- USE orbitalobjectsdb ;
-- Insertar Planetas
-- Actualizar los datos en la tabla planets
INSERT INTO planets (name, radius, texture_url, description_url) VALUES
('Mercurio', 1.0, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRc8BsVr__MysKQ6BCotY5BEK0G1hDyrN6zEg&s', './planetas/mercurio.html'),
('Venus', 1.5, 'https://upload.wikimedia.org/wikipedia/commons/1/1c/Solarsystemscope_texture_8k_venus_surface.jpg', './planetas/venus.html'),
('Tierra', 2.0, 'https://static.diariovasco.com/www/multimedia/201808/22/media/cortadas/mapamundi-kVxD-U60705670296r0C-984x608@Diario%20Vasco.jpg', './planetas/tierra.html'),
('Marte', 1.8, 'https://cdn.pixabay.com/photo/2020/02/04/17/04/map-4818860_1280.jpg', './planetas/marte.html'),
('Júpiter', 4.0, 'https://external-preview.redd.it/JJTceYLFNKh1trdhGTiDAku5dMw24H61e8xyi2_TS6g.jpg?auto=webp&s=1f3d29a36611e75f0fa8bf6e25865809a41771ad', './planetas/jupiter.html'),
('Saturno', 3.0, 'https://1.bp.blogspot.com/-KBL1f1hFhWI/Xnk2-C_qlQI/AAAAAAAAUKY/7g78bkJUTMYKtkhUMtOLD_BFiwwnNFQqgCLcBGAsYHQ/s1600/2k_saturn.jpg', './planetas/saturno.html'),
('Urano', 2.5, 'https://www.rtve.es/imagenes/462126main-image-1686-946-710/1276194002537.jpg', './planetas/urano.html'),
('Neptuno', 2.2, 'https://static.vecteezy.com/system/resources/previews/002/097/266/original/abstract-background-of-neptune-surface-free-vector.jpg', './planetas/neptuno.html');

-- Actualizar los datos en la tabla planet_positions para el año 2024
INSERT INTO planet_positions (planet_id, year, distance_from_sun, eccentricity, inclination) VALUES
(1, 2024, 10.0, 0.2, 6.6),
(2, 2024, 15.0, 0.1, 7.6),
(3, 2024, 20.0, 0.017, 14.0),
(4, 2024, 25.0, 0.093, 11.2),
(5, 2024, 35.0, 0.048, 12.0),
(6, 2024, 45.0, 0.056, 11.0),
(7, 2024, 55.0, 0.046, 12.8),
(8, 2024, 65.0, 0.009, 22.0);



INSERT INTO comets (name, diameter, eccentricity, inclination, perihelion, M1, Q, n, tp_cal) VALUES
('1P/Halley', 11, 0.9679, 162.2, 75.9, 5.5, 35.28, 0.01298, '1986-02-08'),
('2P/Encke', 4.8, 0.8484, 11.48, 3.31, 15.6, 4.1, 0.2981, '2023-10-21'),
('8P/Tuttle', 4.5, 0.8198, 54.98, 13.6, 14.6, 10.37, 0.07242, '2008-01-27'),
('12P/Pons-Brooks', NULL, 0.9546, 74.19, 71.2, 5, 33.59, 0.01384, '2024-04-21'),
('13P/Olbers', NULL, 0.9298, 44.63, 68, 6.7, 32.16, 0.01449, '2024-06-30'),
('20D/Westphal', NULL, 0.9198, 40.89, 61.9, 8.8, 30.03, 0.01593, '1913-11-26'),
('23P/Brorsen-Metcalf', NULL, 0.9720, 19.33, 70.5, 7.8, 33.66, 0.01398, '1989-09-11'),
('27P/Crommelin', NULL, 0.9193, 29.22, 27.4, 12.7, 17.45, 0.03594, '2011-08-02'),
('35P/Herschel-Rigollet', NULL, 0.9740, 64.21, 155, 8.3, 56.94, 0.006363, '1939-08-09'),
('55P/Tempel-Tuttle', 3.6, 0.9056, 162.49, 33.2, 10, 19.7, 0.02965, '1998-02-28'),
('96P/Machholz 1', 6.4, 0.9592, 58.14, 5.29, 13.6, 5.95, 0.1864, '2017-10-27'),
('109P/Swift-Tuttle', 26, 0.9632, 113.45, 133, 4.5, 51.22, 0.007395, '1992-12-11'),
('122P/de Vico', NULL, 0.9627, 85.38, 74.3, 7.5, 34.7, 0.01326, '1995-10-06'),
('161P/Hartley-IRAS', NULL, 0.8351, 95.7, 21.5, 11.5, 14.19, 0.04586, '2005-06-20'),
('177P/Barnard', NULL, 0.9544, 31.22, 120, 15.7, 47.5, 0.008226, '2006-08-28'),
('262P/McNaught-Russell', NULL, 0.8154, 29.08, 18.3, 14.7, 12.59, 0.05396, '2012-12-04'),
('273P/Pons-Gambart', NULL, 0.9753, 136.4, 188, 11.3, 64.85, 0.005239, '2012-12-19'),
('333P/LINEAR', NULL, 0.7360, 131.88, 8.68, 15.2, 7.33, 0.1136, '2016-04-03'),
('342P/SOHO', NULL, 0.9826, 13.27, 5.31, NULL, 6.03, 0.1857, '2016-07-01'),
('C/1905 F1 (Giacobini)', NULL, 0.9528, 40.07, 114, NULL, 46.01, 0.008618, '1905-04-04'),
('C/1914 S1 (Campbell)', NULL, 0.9038, 76.86, 18.7, NULL, 13.43, 0.05262, '1914-08-03'),
('C/1917 F1 (Mellish)', NULL, 0.9931, 32.69, 143, 11, 54.61, 0.006873, '1917-04-11'),
('C/1921 H1 (Dubiago)', NULL, 0.9347, 22.35, 70.7, NULL, 33.09, 0.01394, '1921-05-05'),
('C/1937 D1 (Wilk)', NULL, 0.9806, 26.01, 181, NULL, 63.33, 0.005452, '1937-02-21'),
('C/1942 EA (Vaisala)', NULL, 0.9268, 37.86, 73.9, NULL, 33.93, 0.01334, '1942-02-16'),
('C/1960 Y1 (Candy)', NULL, 0.9303, 151.17, 58.2, NULL, 29, 0.01692, '1961-02-10'),
('C/1989 A3 (Bradfield)', NULL, 0.9781, 83.06, 84.1, NULL, 37.97, 0.01172, '1988-12-05'),
('C/1991 L3 (Levy)', 11.6, 0.9289, 19.19, 51.3, 8.9, 26.64, 0.0192, '1991-07-08'),
('P/1999 J6 (SOHO)', NULL, 0.9842, 26.63, 5.46, NULL, 6.15, 0.1807, '2004-11-08'),
('C/2001 OG108 (LONEOS)', 13.6, 0.9253, 80.25, 48.5, 13.3, 25.61, 0.02032, '2002-03-15'),
('C/2001 W2 (BATTERS)', NULL, 0.9414, 115.91, 75.9, 12.1, 34.81, 0.01298, '2001-12-23'),
('C/2002 R5 (SOHO)', NULL, 0.9853, 14.12, 5.77, NULL, 6.38, 0.1709, '2002-09-05'),
('P/2002 S7 (SOHO)', NULL, 0.9848, 13.58, 5.79, NULL, 6.4, 0.1703, '2008-07-04'),
('P/2005 T4 (SWAN)', NULL, 0.9304, 160.04, 28.5, 15.4, 18, 0.03462, '2005-10-10'),
('P/2006 HR30 (Siding Spring)', NULL, 0.8431, 31.88, 21.9, 13.9, 14.41, 0.04509, '2007-01-02'),
('P/2008 Y12 (SOHO)', NULL, 0.9788, 23.35, 5.4, NULL, 6.09, 0.1825, '2008-12-22'),
('C/2010 L5 (WISE)', NULL, 0.9042, 147.05, 23.7, 18.9, 15.73, 0.04152, '2010-04-23'),
('C/2011 S2 (Kowalski)', NULL, 0.9316, 17.57, 65.8, 15.6, 31.5, 0.01497, '2011-10-26'),
('P/2012 NJ (La Sagra)', NULL, 0.8481, 84.38, 24.8, 14.8, 11.36, 0.05967, '2012-05-05'),
('C/2014 S2 (SWAN)', NULL, 0.9702, 27.49, 85.6, 6.5, 20.49, 0.02154, '2014-04-19'),
('C/2014 K6 (Mackenzie)', NULL, 0.9218, 39.27, 104, 8.3, 32.08, 0.01334, '2014-10-01'),
('C/2015 V2 (Loneos)', NULL, 0.9664, 25.71, 57.3, 11.9, 24.29, 0.0231, '2015-06-04'),
('C/2016 R2 (MPEC 2016-A34)', NULL, 0.9731, 53.78, 67.3, 7.1, 30.33, 0.0184, '2016-11-21'),
('C/2017 S3 (LONEOS)', NULL, 0.9307, 26.54, 65.9, 10.2, 32.5, 0.01534, '2017-12-14'),
('C/2018 W2 (SOHO)', NULL, 0.9638, 32.4, 75.3, 12.6, 30.67, 0.0182, '2018-09-18'),
('C/2019 P3 (Harrington)', NULL, 0.9341, 20.6, 22.4, 14.5, 10.91, 0.0382, '2019-05-23'),
('C/2020 B2 (Hale)', NULL, 0.9743, 18.32, 32.6, 15.2, 23.56, 0.02532, '2020-04-12'),
('C/2021 G1 (Murray)', NULL, 0.9639, 27.8, 51.5, 10.7, 14.5, 0.0333, '2021-09-05'),
('C/2022 B1 (SOHO)', NULL, 0.9278, 46.22, 61.4, 12.3, 25.45, 0.02232, '2022-01-10'),
('C/2023 A3 (Zhang)', NULL, 0.8987, 39.7, 48.5, 9.2, 15.7, 0.02816, '2023-08-25');


-- Asteroidess
-- Asteroidess

INSERT INTO asteroids (full_name, diameter, e, i, per_y, M1, ad, n, tp_cal, is_high_risk) VALUES
('1862 Apollo (1932 HA)', 1.5, 0.5599, 6.35, 1.78, NULL, 2.29, 0.5527, '2025-04-28', TRUE),
('3122 Florence (1981 ET3)', 4.9, 0.4231, 22.14, 2.35, NULL, 2.52, 0.4189, '2024-10-15', TRUE),
('3671 Dionysus (1984 KD)', 1.5, 0.5420, 13.54, 3.26, NULL, 3.39, 0.3020, '2023-08-09', TRUE),
('35107 (1991 VH)', 0.929, 0.1442, 13.91, 1.21, NULL, 1.30, 0.8126, '2024-06-15', TRUE),
('153591 (2001 SN263)', 2.0, 0.4799, 6.69, 2.80, NULL, 2.94, 0.3517, '2024-12-03', TRUE),
('153958 (2002 AM31)', NULL, 0.4515, 4.64, 2.22, NULL, 2.47, 0.4435, '2023-10-06', TRUE),
('162000 (1990 OS)', 0.4, 0.4624, 1.09, 2.17, NULL, 2.45, 0.4532, '2025-07-09', TRUE),
('164121 (2003 YT1)', 1.717, 0.2920, 44.06, 1.17, NULL, 1.43, 0.8430, '2025-03-14', TRUE),
('175706 (1996 FG3)', 1.196, 0.3501, 1.97, 1.08, NULL, 1.42, 0.9095, '2024-09-11', TRUE),
('185851 (2000 DP107)', 0.863, 0.3765, 8.67, 1.60, NULL, 1.88, 0.6179, '2024-07-08', TRUE),
('226514 (2003 UX34)', NULL, 0.6159, 2.56, 1.15, NULL, 1.77, 0.8600, '2025-03-04', TRUE),
('285263 (1998 QE2)', NULL, 0.5728, 12.88, 3.77, NULL, 3.81, 0.2616, '2024-09-11', TRUE),
('310560 (2001 QL142)', 0.654, 0.4991, 26.60, 1.08, NULL, 1.57, 0.9168, '2025-01-25', TRUE),
('311066 (2004 DC)', NULL, 0.3996, 19.46, 2.09, NULL, 2.29, 0.4720, '2025-03-01', TRUE),
('348400 (2005 JF21)', NULL, 0.5351, 10.84, 3.32, NULL, 3.42, 0.2968, '2025-08-15', TRUE),
('350751 (2002 AW)', NULL, 0.2567, 0.57, 1.11, NULL, 1.35, 0.8886, '2024-08-30', TRUE),
('357439 (2004 BL86)', NULL, 0.4025, 23.78, 1.84, NULL, 2.11, 0.5352, '2024-03-05', TRUE),
('363067 (2000 CO101)', NULL, 0.0901, 15.32, 1.12, NULL, 1.17, 0.8826, '2024-05-28', TRUE),
('363599 (2004 FG11)', 0.152, 0.7236, 3.14, 2.00, NULL, 2.73, 0.4932, '2024-05-29', TRUE),
('374851 (2006 VV2)', NULL, 0.6054, 23.73, 3.69, NULL, 3.83, 0.2673, '2025-08-11', TRUE);



INSERT INTO asteroids (full_name, diameter, e, i, per_y, M1, ad, n, tp_cal, is_high_risk) VALUES
('385186 (1994 AW1)', 0.811, 0.0755, 24.1, 1.16, NULL, 1.19, 0.8485, '2024-12-08', TRUE),
('399774 (2005 NB7)', NULL, 0.5174, 12.7, 2.92, NULL, 3.1, 0.3372, '2025-10-14', TRUE),
('450894 (2008 BT18)', NULL, 0.5946, 8.15, 3.31, NULL, 3.54, 0.2981, '2024-12-27', TRUE),
('461852 (2006 GY2)', NULL, 0.4959, 30.56, 2.53, NULL, 2.78, 0.3891, '2024-03-06', TRUE),
('481532 (2007 LE)', NULL, 0.5157, 29.55, 2.49, NULL, 2.79, 0.3954, '2024-10-06', TRUE),
('488453 (1994 XD)', NULL, 0.7337, 4.33, 3.59, NULL, 4.06, 0.2747, '2023-07-28', TRUE),
('489486 (2007 GS3)', NULL, 0.1291, 15.09, 1.09, NULL, 1.2, 0.9016, '2024-12-15', TRUE),
('494658 (2000 UG11)', NULL, 0.5718, 8.91, 2.68, NULL, 3.03, 0.3679, '2025-01-27', TRUE),
('523775 (2014 YB35)', 0.279, 0.4833, 12.64, 2.57, NULL, 2.78, 0.3833, '2025-07-13', TRUE),
('612098 (1999 RM45)', NULL, 0.6446, 10.89, 2.19, NULL, 2.77, 0.4510, '2025-09-02', TRUE),
('613286 (2005 YQ96)', NULL, 0.3336, 22.23, 0.641, NULL, 0.99, 1.538, '2024-11-15', TRUE);

INSERT INTO asteroids (full_name, diameter, e, i, per_y, M1, ad, n, tp_cal, is_high_risk) VALUES
('1866 Sisyphus (1972 XA)', 8.48, 0.538, 41.21, 2.61, NULL, 2.91, 0.3782, '2024-11-14', FALSE),
('5143 Heracles (1991 VL)', 4.843, 0.771, 8.98, 2.49, NULL, 3.25, 0.3965, '2024-06-24', FALSE),
('5381 Sekhmet (1991 JY)', 0.935, 0.2964, 48.97, 0.922, NULL, 1.23, 1.069, '2025-03-16', FALSE),
('5640 Gato (1990 DB)', 0.652, 0.187, 38.32, 0.642, NULL, 0.778, 0.591, '2024-07-24', FALSE),
('8296 Haskins (1981 AX)', 0.608, 0.4165, 25.47, 1.042, NULL, 1.49, 0.2343, '2024-10-03', FALSE),
('11036 Lila (1990 PB)', 1.117, 0.373, 31.48, 1.117, NULL, 1.193, 0.8298, '2024-10-03', FALSE);
