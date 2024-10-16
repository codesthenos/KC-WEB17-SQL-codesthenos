create schema if not exists gruiz_videoclub;

set schema 'gruiz_videoclub';
/*
drop table if exists correspondencia;
drop table if exists codigo_postal;
drop table if exists poblacion;
drop table if exists provincia;
drop table if exists email;
drop table if exists telefono;
drop table if exists pelicula;
drop table if exists copia;
drop table if exists prestamo;
drop table ix exists socio;
*/
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
/*
,
	constraint provincia_poblacion_fk foreign key (id_provincia) references provincia(id)
,
	constraint miembro_email_fk foreign key (dni_miembro) references miembro(dni)
,
	constraint miembro_telefono_fk foreign key (dni_miembro) references miembro(dni)
,
	constraint miembro_matricula_fk foreign key (dni_miembro) references miembro(dni)
,
	constraint miembro_profesor_fk foreign key (dni_miembro) references miembro(dni)

alter table correspondencia
add constraint miembro_correspondencia_fk
foreign key (dni_miembro) references miembro(dni);

alter table correspondencia
add constraint poblacion_correspondencia_fk
foreign key (id_poblacion) references poblacion(id);

create unique index index_nombre_provincia on provincia (lower(provincia));

alter table matricula
add constraint curso_matricula_fk
foreign key (id_curso) references curso(id);

alter table asignatura
add constraint curso_asignatura_fk
foreign key (id_curso) references curso(id);

alter table evaluacion
add constraint matricula_evaluacion_fk
foreign key (id_matricula) references matricula(id);

alter table evaluacion
add constraint profesor_evaluacion_fk
foreign key (id_profesor) references profesor(id);

alter table profesor
add constraint asignatura_profesor_fk
foreign key (id_asignatura) references asignatura(id);
*/