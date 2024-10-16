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