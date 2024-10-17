create schema if not exists gruiz_videoclub;

set schema 'gruiz_videoclub';

/* Si descomentamos esto podemos correr el script entero de forma infinita sin errores (aunque se que este tipo de scripts no esta para eso, pero me ha ayudado a entender un poco mejor a entender lo de CASCADE)
drop table if exists correspondencia;
drop table if exists codigo_postal;
drop table if exists poblacion;
drop table if exists provincia;
drop table if exists email;
drop table if exists telefono;
drop table if exists prestamo;
drop table if exists copia;
drop table if exists pelicula;
drop table if exists socio;
*/

/*Tablas sin foreing key constarints*/
create table if not exists provincia (
	id serial primary key,
	provincia varchar(30) not null
);

create table if not exists poblacion (
	id serial primary key,
	poblacion varchar(50) not null,
	id_provincia smallint not null
);

create table if not exists codigo_postal (
  id serial primary key,
  codigo_postal varchar(5) not null,
  id_poblacion smallint not null
);

create table if not exists correspondencia (
	id_socio smallint primary key,
	calle varchar(50) not null,
	numero smallint,
	piso varchar(10),
  id_codigo_postal smallint not null
);

create table if not exists socio (
  id serial primary key,
	dni varchar(9) not null,
	nombre varchar(30) not null,
	apellidos varchar(70) not null,
	fecha_nacimiento date not null
);

create table if not exists email (
	email varchar(50) primary key,
	id_socio smallint not null
);

create table if not exists telefono (
	telefono varchar(9) primary key,
	id_socio smallint not null
);

create table if not exists prestamo (
	id serial primary key,
  fecha_entrega date not null,
  fecha_devolucion date not null,
  id_socio smallint not null,
  id_copia smallint not null
);

create table if not exists copia (
	id serial primary key,
  id_pelicula smallint not null
);

create table if not exists pelicula (
	id serial primary key,
	titulo varchar(50) not null,
  genero varchar(20) not null,
  director varchar(70) not null,
  sinopsis text not null
);

/*Incluyo las constraints foreign key en todas las tablas*/
alter table poblacion
add constraint provincia_poblacion_fk
foreign key (id_provincia) references provincia(id);

alter table codigo_postal
add constraint poblacion_codigo_postal_fk
foreign key (id_poblacion) references poblacion(id);

alter table correspondencia
add constraint codigo_postal_correspondencia_fk
foreign key (id_codigo_postal) references codigo_postal(id);

alter table correspondencia
add constraint socio_correspondencia_fk
foreign key (id_socio) references socio(id);

alter table email
add constraint socio_email_fk
foreign key (id_socio) references socio(id);

alter table telefono
add constraint socio_telefono_fk
foreign key (id_socio) references socio(id);

alter table prestamo
add constraint socio_prestamo_fk
foreign key (id_socio) references socio(id);

alter table prestamo
add constraint copia_prestamo_fk
foreign key (id_copia) references copia(id);

alter table copia
add constraint pelicula_copia_fk
foreign key (id_pelicula) references pelicula(id);
/* Esto viene de 1 prompt que le he hecho a chat gpt
--Poblamos la base de datos.
-- Insert into provincia
INSERT INTO provincia (provincia) VALUES ('Barcelona'), ('Madrid');

-- Insert into poblacion
INSERT INTO poblacion (poblacion, id_provincia) VALUES ('Badalona', 1), ('Alcobendas', 2);

-- Insert into codigo_postal
INSERT INTO codigo_postal (codigo_postal, id_poblacion) VALUES ('08912', 1), ('28100', 2);

-- Insert into socio (members)
INSERT INTO socio (dni, nombre, apellidos, fecha_nacimiento) 
VALUES ('12345678A', 'Carlos', 'Ruiz', '1985-05-10'),
       ('87654321B', 'Maria', 'Lopez', '1990-03-22');

-- Insert into correspondencia (addresses for members)
INSERT INTO correspondencia (id_socio, calle, numero, piso, id_codigo_postal) 
VALUES (1, 'Gran Via', 123, '2B', 1),
       (2, 'Calle Mayor', 45, '3A', 2);

-- Insert into pelicula (films)
INSERT INTO pelicula (titulo, genero, director, sinopsis) 
VALUES ('Matrix', 'Sci-Fi', 'The Wachowskis', 'A hacker discovers the truth about reality.'),
       ('Inception', 'Sci-Fi', 'Christopher Nolan', 'A thief who steals secrets through dream-sharing.'),
       ('Interstellar', 'Sci-Fi', 'Christopher Nolan', 'A group of explorers travels through a wormhole.'),
       ('Titanic', 'Romance', 'James Cameron', 'A love story set during the Titanic disaster.');

-- Insert into copia (film copies)
INSERT INTO copia (id_pelicula) 
VALUES (1), (1), (1), -- 3 copies of Matrix
       (2), (2),      -- 2 copies of Inception
       (3),           -- 1 copy of Interstellar
       (4), (4);      -- 2 copies of Titanic

-- Insert into prestamo (loans)
-- Loans that are still out (current loans)
INSERT INTO prestamo (fecha_entrega, fecha_devolucion, id_socio, id_copia)
VALUES ('2024-10-01', '2024-10-20', 1, 1), -- Loan for a Matrix copy (still out)
       ('2024-10-05', '2024-10-22', 2, 4); -- Loan for an Inception copy (still out)

-- Loans that have been returned (older loans)
INSERT INTO prestamo (fecha_entrega, fecha_devolucion, id_socio, id_copia)
VALUES ('2024-09-01', '2024-09-15', 1, 2), -- Returned Matrix copy
       ('2024-09-10', '2024-09-25', 2, 5); -- Returned Inception copy
*/
/* Esta tambien viene de 1 prompt en chat gpt
--Consulta requerida.
SELECT p.titulo AS titulo_pelicula, 
       COUNT(c.id) AS numero_copias_disponibles
FROM pelicula p
JOIN copia c ON p.id = c.id_pelicula
LEFT JOIN prestamo pr ON c.id = pr.id_copia
WHERE pr.id IS NULL -- Copies that have never been loaned
   OR pr.fecha_devolucion < CURRENT_DATE -- Copies that have been returned
GROUP BY p.titulo
HAVING COUNT(c.id) > 0;
*/
/* Esta tambien viene de 1 prompt en chat gpt
-- Borra todas las entradas de las tablas, resetea los serial, cascade para asegurar que las tablas con foreign keys son manejadas correctamente
TRUNCATE TABLE correspondencia, codigo_postal, poblacion, provincia, email, telefono, prestamo, copia, pelicula, socio RESTART IDENTITY CASCADE;
*/