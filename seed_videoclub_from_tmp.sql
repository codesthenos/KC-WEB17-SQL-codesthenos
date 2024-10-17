-- esta linea es para resetear todas los valores de la tabla, lo seriales y todo
truncate table correspondencia, codigo_postal, poblacion, provincia, email, telefono, prestamo, copia, pelicula, socio restart identity cascade;


-- SOCIO
insert into socio (dni, nombre, apellidos, fecha_nacimiento)
select distinct dni, 
	   nombre,
	   concat(apellido_1, ' ', apellido_2) apellidos,
	   cast(fecha_nacimiento as date) fecha_nacimiento
from tmp_videoclub;
-- test
select * from socio;

-- EMAIL
insert into email (email, id_socio)
select distinct tv.email, s.id from tmp_videoclub tv
inner join socio s on tv.dni = s.dni;
-- test
select s.nombre, e.email from socio s
inner join email e on s.id = e.id_socio;

-- TELEFONO
insert into telefono (telefono, id_socio)
select distinct tv.telefono, s.id from tmp_videoclub tv
inner join socio s on tv.dni = s.dni;
-- test
select s.nombre, t.telefono  from socio s
inner join telefono t on s.id = t.id_socio;

-- PELICULA
insert into pelicula (titulo, genero, director, sinopsis)
select distinct
	titulo, genero, director, sinopsis
from tmp_videoclub;
--test
select * from pelicula;

-- COPIA
insert into copia (id, id_pelicula)
select distinct tv.id_copia, p.id from tmp_videoclub tv
inner join pelicula p on tv.titulo = p.titulo
order by tv.id_copia;
-- test
select c.id as "copy id", p.titulo as "film title" from copia c inner join pelicula p on c.id_pelicula = p.id;

-- PRESTAMO
insert into prestamo (fecha_entrega, fecha_devolucion, id_socio, id_copia)
select
	tv.fecha_alquiler, tv.fecha_devolucion, s.id, c.id
from tmp_videoclub tv
inner join copia c on tv.id_copia = c.id
inner join socio s on tv.dni = s.dni;
-- test
select * from prestamo p;