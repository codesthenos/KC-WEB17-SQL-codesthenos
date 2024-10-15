# Práctica del modulo SQL impartido por Francisco José Molina Martínez [**@franciscomoma**](https://github.com/franciscomoma) en KeepCoding

La práctica consiste en crear una **base de datos** y se entregaran dos documentos:

- **Diagrama** _Entidad/Relacion_ en formato `.drawio`
- **Script** _SQL_ que debe crear un **esquema**, con todas las **tablas** y cargar los datos de la **consulta** que se pide

## Apto si:

- El **script** se debe ejecutar sin fallos

- Se debe aplicar **normalizacion** _siempre que se pueda_

## Descripcion de la base de datos

- Debe _registrar_ **prestamos**, **inventario** y **peliculas**

## Requisitos funcionales

- **socios** con:

  - **nombre**
  - **apellidos**
  - **fecha de nacimiento**
  - **telefono**
  - **dni**
  - **id**

- **direccion de correspondencia** con:

  - **codigo postal**
  - **calle**
  - **numero**
  - **piso**

- **peliculas** con:

  - **titulo**
  - **genero**
  - **director**
  - **sinopsis**
  - **copias**
  - **prestada?**

- **prestamo** con:

  - **fecha entrega**
  - **fecha devolucion**

- _Consulta_ que muestre el **titulo** y el **numero de copias** de las **peliculas NO prestadas**
