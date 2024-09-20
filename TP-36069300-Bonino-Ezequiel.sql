### Creado por ###

### Nombre y apellido: Ezequiel Bonino
### DNI: 36069300
### Materia: Introduccion a base de datos (Turno Tarde)
### Profesor: Nicolas Perez

### Link del DER

## https://drive.google.com/drive/folders/1oUdMkwRWYoivHoWTw4OwZIpWWGsHlMBN?usp=sharing

### Link video: https://youtu.be/-snehOhIhlI

### Creacion de las tablas y relaciones (estas estan dento de las tablas)

drop schema if exists tp_36069300_bonino_ezequiel;

create schema if not exists tp_36069300_bonino_ezequiel;

use tp_36069300_bonino_ezequiel;

create table if not exists Provincia(
provincia_id int primary key auto_increment,
provincia varchar(50) not null unique
);

alter table provincia rename  to Provincia1;
alter table provincia1 rename to Provincia;

alter table provincia change column provincia nombre varchar(100);
alter table provincia change column nombre provincia varchar(50);

create table if not exists Localidad(
localidad_id int primary key auto_increment,
localidad varchar(45) not null unique, 
provincia_id int not null,
foreign key(provincia_id) references Provincia(provincia_id) 
);

create table if not exists Barrio(
barrio_id int primary key auto_increment,
barrio varchar(45) not null,
localidad_id int not null,
foreign key(localidad_id) references Localidad(localidad_id) 
);

create table if not exists Calle(
calle_id int primary key,
calle varchar(45) not null,
barrio_id int not null,
foreign key(barrio_id) references Barrio(barrio_id) 
);


create table if not exists Direccion(
direccion_id int primary key auto_increment,
numero_calle varchar(50) not null,
calle_id int not null,
foreign key(calle_id) references Calle(calle_id) 
);


create table if not exists Persona(
cuil bigint primary key,
dni int not null,
nombre varchar(45) not null,
apellido varchar(45) not null,
email varchar(70) not null
);

create table if not exists Docente(
matricula_docente int primary key auto_increment,
persona_cuil bigint not null,
direccion_id int not null,
foreign key(persona_cuil) references Persona(cuil),
foreign key(direccion_id) references Direccion(direccion_id)
);

create table if not exists Departamento(
departamento_id int primary key auto_increment,
departamento varchar(150) not null unique
);

create table if not exists Carrera(
carrera_id int primary key auto_increment,
nombre varchar(45) not null unique,
departamento_id int not null,
foreign key(departamento_id) references Departamento(departamento_id)
);


create table if not exists Alumno(
matricula_alumno int primary key auto_increment,
carrera_id int not null,
persona_cuil bigint not null,
direccion_id int not null,
foreign key(carrera_id) references Carrera(carrera_id),
foreign key(persona_cuil) references Persona(cuil),
foreign key(direccion_id) references Direccion(direccion_id)
);


create table if not exists Usuario(
usuario_id int primary key auto_increment,
alumno_matricula int not null,
password varchar(45) not null,
foreign key(alumno_matricula) references Alumno(matricula_alumno)
);


create table if not exists Materia(
materia_id int primary key auto_increment,
materia varchar(45) not null
);


create table if not exists Carrera_has_materia(
carrera_id int,
materia_id int,
primary key(carrera_id, materia_id)
);

create table if not exists Tipo_comision(
tipo_comision_id int primary key auto_increment,
tipo_comision varchar(70) not null
);

create table if not exists Periodo_electivo(
periodo_electivo_id int primary key auto_increment,
periodo_electivo varchar(45) not null
);

create table if not exists Sede(
sede_id int primary key auto_increment,
sede varchar(45) not null
);

create table if not exists Turno(
turno_id int primary key auto_increment,
turno varchar(45)
);


create table if not exists Comision(
comision_id int primary key auto_increment,
tipo_comision_id int not null,
periodo_electivo_id int not null,
sede_id int not null,
turno_id int not null,
matricula_docente int not null,
materia_id int not null,
foreign key(tipo_comision_id) references Tipo_comision(tipo_comision_id),
foreign key(periodo_electivo_id) references Periodo_electivo(periodo_electivo_id),
foreign key(sede_id) references Sede(sede_id),
foreign key(turno_id) references Turno(turno_id),
foreign key(matricula_docente) references Docente(matricula_docente),
foreign key(materia_id) references Materia(materia_id)
);

create table if not exists Estado_inscripcion(
estado_inscripcion_id int primary key not null,
estado varchar(45) not null
);

create table if not exists Inscripciones_materias(
inscripcion_materia_id int not null,
usuario_id int not null,
comision_id int not null,
estado_inscripcion_id int not null,
fecha date not null,
foreign key (usuario_id) references Usuario(usuario_id),
foreign key (comision_id) references Comision(comision_id),
foreign key (estado_inscripcion_id) references Estado_inscripcion(estado_inscripcion_id),
primary key(inscripcion_materia_id)
);


create table if not exists Estado_resultado_cursada_examen(
estado_resultado_id int primary key auto_increment,
estado varchar(45) not null
);

create table if not exists Vigencia(
fecha_fin_vigencia date primary key,
vigente bit(1)
);

create table if not exists Usuario_has_materias_cursadas(
usuario_id int not null,
materia_id int not null,
nota int not null,
fecha_fin_cursada date not null,
fecha_fin_vigencia date,
anio_academico int not null,
final_aprobado bit(1) not null,
estado_resultado_id int not null,
foreign key (fecha_fin_vigencia) references Vigencia(fecha_fin_vigencia),
foreign key (estado_resultado_id) references Estado_resultado_cursada_examen(estado_resultado_id)
);

create table if not exists Forma_aprobacion(
forma_aprobacion_id int primary key auto_increment,
forma_forma_aprobacion varchar(45) not null
);

create table if not exists Turno_examen(
turno_examen_id int primary key auto_increment,
turno_examen varchar(45)
);

create table if not exists Tipo_mesa(
tipo_mesa_id int primary key auto_increment,
tipo_mesa varchar(45) not null
);

create table if not exists Mesa(
mesa_id int primary key auto_increment,
tipo_mesa_id int not null,
sede_id int not null,
matricula_docente int not null,
materia_id int not null,
turno_examen_id int not null,
fecha date not null,
hora varchar(10) not null,
foreign key(tipo_mesa_id) references Tipo_mesa(tipo_mesa_id),
foreign key(sede_id) references Sede(sede_id),
foreign key(matricula_docente) references Docente(matricula_docente),
foreign key(materia_id) references Materia(materia_id),
foreign key(turno_examen_id) references Turno_examen(turno_examen_id)
);

create table if not exists Inscripciones_examenes(
inscripciones_examenes_id int,
usuario_id int,
mesa_id int,
fecha_inscripcion date not null,
foreign key(usuario_id) references Usuario(usuario_id),
foreign key(mesa_id) references Mesa(mesa_id),
primary key(inscripciones_examenes_id)
);


create table if not exists Detalle_examen(
detalle_examen_id int,
inscripciones_examenes_id int,
nota int not null,
forma_aprobacion_id int,
estado_resultado_id int not null,
foreign key(inscripciones_examenes_id) references Inscripciones_examenes(inscripciones_examenes_id),
foreign key(forma_aprobacion_id) references Forma_aprobacion(forma_aprobacion_id),
foreign key (estado_resultado_id) references Estado_resultado_cursada_examen(estado_resultado_id),
primary key(detalle_examen_id, inscripciones_examenes_id)
);

### Ingreso de datos ###

#### Provincias
insert into Provincia values (1, "Buenos Aires");
insert into Provincia values (2, "CABA");


### Localidad 

insert into Localidad values (1, "Almirante brown", 1);
insert into Localidad values (2, "Lanus", 1);
insert into Localidad values (3, "Lomas de zamora", 1);


insert into Barrio values (1, "Adrogue", 1);
insert into Barrio values (2, "Jose Marmol", 1);
insert into Barrio values (3, "Remedios de escalada", 2);
insert into Barrio values (4, "Temperley", 3);

insert into Calle values (1, "Granville", 2);
insert into Calle values (2, "Mitre", 1);
insert into Calle values (3, "Hipólito Yrigoyen", 3);

insert into Direccion values (1, 755,1);
insert into Direccion values (2, 666, 2);
insert into Direccion values (3, 1845, 3);
insert into Direccion values (4, 1200, 2);
insert into Direccion values (5, 1820, 3);
insert into Direccion values (6, 1500, 2);

### Personas

### Personas que se usan como docentes
insert into Persona values (27456992008,45699200, "Maria", "Fernandez", "maria@gmail.com");
insert into Persona values (27376662228,37666222, "Julia", "Ortiz", "ju@gmail.com");
insert into Persona values (20332224658,33222465, "Mario", "March", "march@gmail.com");

### Personas que se usan como alumnos
insert into Persona values (20364501508,36450150, "Ezequiel", "Bonino", "ezequieldbo25@gmail.com");
insert into Persona values (20391212068,39121206, "Carlos", "Alcatraz", "carlos@gmail.com");
insert into Persona values (27442226668,44222666, "Carla", "Boz", "boz@gmail.com");
insert into Persona values (27401231238,40123123, "Claudia", "Valde", "valde@gmail.com");


insert into Docente values (5555, 27456992008, 3);
insert into Docente values (6666, 27376662228, 2);
insert into Docente values (7777, 20332224658, 2);

insert into Departamento values(1, "Departamento de desarrollo productivo y tecnologico");
insert into Departamento values(2, "Departamento de Humanidades y Artes");
insert into Departamento values(3, "Departamento de Salud Comunitaria");

insert into Carrera values(1,"Sistemas",1);
insert into Carrera values(2, "Enfermeria",3);
insert into Carrera values(3, "Audiovisión",2);


insert into Alumno values(3636,1 ,20364501508,1);
insert into Alumno values(45636,3,20391212068,4); 
insert into Alumno values(4444,1 ,27442226668,5);
insert into Alumno values(5556,3,27401231238,6); 

insert into Materia values(1, "Matematicas 1");
insert into Materia values(2, "Programacion");
insert into Materia values(3, "Introduccion a base de datos");
insert into Materia values(4, "Tecnología de la Imagen");
insert into Materia values(5, "Guión");
insert into Materia values(6, "Taller de Composición Sonora");
insert into Materia values(7, "Cultura y Salud");
insert into Materia values(8, "Ingles 1");
insert into Materia values(9, "Ingles 2");
insert into Materia values(10, "Ingles 2");
insert into Materia values(11, "Expresion de problemas y algoritmos");
insert into Materia values(12, "Organizacion de computadoras");
insert into Materia values(13, "Seminario de lenguajes");
insert into Materia values(14, "Ingenieria de software 1");
insert into Materia values(15, "Matematicas 2");

### Materias de sistemas

insert into Carrera_has_materia values(1,1);
insert into Carrera_has_materia values(1,2);
insert into Carrera_has_materia values(1,3);
insert into Carrera_has_materia values(1,11);
insert into Carrera_has_materia values(1,12);
insert into Carrera_has_materia values(1,13);
insert into Carrera_has_materia values(1,14);
insert into Carrera_has_materia values(1,15);

### Materias de Audiovision
insert into Carrera_has_materia values(2,4);
insert into Carrera_has_materia values(2,5);
insert into Carrera_has_materia values(2,6);

### Materias de enfermeria
insert into Carrera_has_materia values(3,7);


### Materias que comparten las tres carreras

insert into Carrera_has_materia values(1,8);
insert into Carrera_has_materia values(1,9);
insert into Carrera_has_materia values(1,10);

insert into Carrera_has_materia values(2,8);
insert into Carrera_has_materia values(2,9);
insert into Carrera_has_materia values(2,10);

insert into Carrera_has_materia values(3,8);
insert into Carrera_has_materia values(3,9);
insert into Carrera_has_materia values(3,10);

insert into Usuario values(1,3636,"123456");
insert into Usuario values(2,45636,"234567");
insert into Usuario values(3,4444,"454545");
insert into Usuario values(4,5556,"666666");

insert into Estado_inscripcion values(1, "Pendiente");
insert into Estado_inscripcion values(2, "Aprobado");
insert into Estado_inscripcion values(3, "Rechazado");

insert into Tipo_comision values(1, "Presencial sin soporte a la presencialidad");

insert into Sede values (1, "Lanus");

insert into Periodo_electivo values(1, "1° cuatrimetre");
insert into Periodo_electivo values(2, "2° cuatrimetre");

insert into Turno values(1, "Mañana");
insert into Turno values(2, "Tarde");
insert into Turno values(3, "Noche");

### Comiciones sistemas

insert into Comision values(1, 1, 1, 1, 2, 5555,1);
insert into Comision values(2, 1, 2, 1, 1, 5555,2);
insert into Comision values(3, 1, 1, 1, 2, 6666,8);
insert into Comision values(4, 1, 2, 1, 3, 6666,8);
insert into Comision values(5, 1, 2, 1, 3, 6666,15);


### Comisiones de Audiovision

insert into Comision values(6, 1, 2, 1, 3, 6666,5);
insert into Comision values(7, 1, 2, 1, 3, 6666,6);

### Inscripciones a materias de sistema
### Solo el usuario 1 y 3 son de sistemas

insert into Inscripciones_materias values (1, 1, 3, 1, "2024-3-14");
insert into Inscripciones_materias values (2, 3, 3, 1, "2024-3-14");
insert into Inscripciones_materias values (3, 1, 5,  1,"2024-3-14");
insert into Inscripciones_materias values (4, 3, 2,  1,"2024-3-14");

### Inscripciones a materias de Audiovision
## Solo el usuario 2 y 4 son de audiovision

insert into Inscripciones_materias values (6, 2, 6,  1,"2024-3-14");
insert into Inscripciones_materias values (7, 4, 6,  1,"2024-3-14");
insert into Inscripciones_materias values (8, 4, 7,  1,"2024-3-14");

insert into Vigencia values ("2022-01-05",0);
insert into Vigencia values ("2019-07-05",0);
insert into Vigencia values ("2023-11-03",0);
insert into Vigencia values ("2026-01-17",1);


insert into Estado_resultado_cursada_examen values (1, "Aprobado");
insert into Estado_resultado_cursada_examen values (2, "Desaprobado");

### Materias de usuarios de sistemas 

insert into Usuario_has_materias_cursadas values(1,1,7,"2023-11-09","2026-01-17", 2023,1,1);
insert into Usuario_has_materias_cursadas values(1,11,8,"2018-05-07","2022-01-05", 2018,1,1);
insert into Usuario_has_materias_cursadas values(1,12,7,"2019-07-05","2019-07-05", 2019,1,1);
insert into Usuario_has_materias_cursadas values(1,13,9,"2023-11-03","2023-11-03", 2023,1,1);

insert into Usuario_has_materias_cursadas values(3,1,6,"2023-11-09","2026-01-17", 2023,1,1);
insert into Usuario_has_materias_cursadas values(3,11,5,"2018-05-07","2022-01-05", 2018,1,1);
insert into Usuario_has_materias_cursadas values(3,12,4,"2019-07-05","2019-07-05", 2019,1,1);
insert into Usuario_has_materias_cursadas values(3,13,10,"2023-11-03","2023-11-03", 2023,1,1);

insert into Forma_aprobacion values (1, "Examen");
insert into Forma_aprobacion values (2, "Promocion");

insert into Turno_examen values (1, "1° Llamado");
insert into Turno_examen values (2, "2° Llamado");

insert into Tipo_mesa values(1, "Regular y libre");
insert into Tipo_mesa values(2, "Regular");

### Mesas sistemas

insert into Mesa values (1,1,1,5555,3,1,"2023-06-16", "9:00");
insert into Mesa values (2,1,1,5555,1,1,"2023-06-18", "18:00");
insert into Mesa values (3,1,1,5555,2,1,"2023-06-19", "14:00");
insert into Mesa values (4,1,1,5555,5,1,"2023-06-20", "14:00");
insert into Mesa values (5,1,1,5555,13,1,"2023-06-14", "9:00");
insert into Mesa values (6,1,1,5555,15,1,"2023-06-16", "9:00");

### Mesas de Audiovision

insert into Mesa values (7,1,1,5555,5,1,"2023-06-16", "16:00");
insert into Mesa values (8,1,1,5555,6,1,"2023-06-16", "9:00");

### Inscripciones a examenes de sistemas
insert into Inscripciones_examenes values (1,1,1, "2024-06-13");
insert into Inscripciones_examenes values (2,3,1, "2024-06-13");

### Inscripciones a examenes de audiovision

insert into Inscripciones_examenes values (3,4,7, "2024-06-13");
insert into Inscripciones_examenes values (4,4,8, "2024-06-13");


insert into Detalle_examen values(1, 1,7,1,1);
insert into Detalle_examen values(2, 2,2,1,2);


### CONSULTAS

## 1- Devuelve el nombre, apellido, email, cuil y dni de los alumnos de la universidad

select p.cuil,p.nombre, p.apellido, p.email, p.dni from Persona p 
inner join Alumno a on a.persona_cuil = p.cuil;


## 2- Devuelve el nombre, apellido, email, cuil y dni del Alumno con la matricula 3636

select p.cuil,p.nombre, p.apellido, p.email, p.dni, a.matricula_alumno as matricula 
from Persona p 
inner join Alumno a on a.persona_cuil = p.cuil 
where a.matricula_alumno = 3636;

## 3- Devuelve todas las carreras con su departamento

select c.carrera_id, c.nombre, d.departamento as nombre_departamento
from carrera c
inner join departamento d on c.departamento_id = d.departamento_id;

## 4- Devuelve la cantidad de carreras por departamento

select d.departamento, count(c.carrera_id) as cantidad_carreras_por_departamento
from departamento d 
inner join carrera c on d.departamento_id = c.carrera_id 
group by d.departamento_id;

## 5- Devuelve el nombre de todas las materias de la carrera Sistemas

select m.materia as Materia, c.nombre as Carrera  
from Carrera c
inner join Carrera_has_materia chm on chm.carrera_id = c.carrera_id
inner join Materia m on chm.materia_id = m.materia_id
where c.nombre = "Sistemas";


## 6- Devuelve todas las comisiones disponibles con sus respectivas materias y a las carreras que pertenecen

select c.comision_id, m.materia, t.tipo_comision, p.periodo_electivo, s.sede, tur.turno, d.matricula_docente
, per.nombre, per.apellido, carrera.nombre
from Comision c 
inner join Tipo_comision t on c.tipo_comision_id = t.tipo_comision_id
inner join Materia m on c.materia_id = m.materia_id
inner join Periodo_electivo p on c.periodo_electivo_id = p.periodo_electivo_id
inner join Sede s on c.sede_id = s.sede_id
inner join Turno tur on c.turno_id = tur.turno_id
inner join Docente d on c.matricula_docente = d.matricula_docente
inner join Persona per on d.persona_cuil = per.cuil
inner join Carrera_has_materia chm on chm.materia_id = m.materia_id
inner join Carrera carrera on carrera.carrera_id = chm.carrera_id;

## 7-  Devuelve todas las comisiones de la Carrera Sistemas

select c.comision_id, m.materia, t.tipo_comision, p.periodo_electivo, s.sede, tur.turno, d.matricula_docente
, per.nombre, per.apellido, carr.nombre
from Comision c 
inner join Tipo_comision t on c.tipo_comision_id = t.tipo_comision_id
inner join Materia m on c.materia_id = m.materia_id
inner join Periodo_electivo p on c.periodo_electivo_id = p.periodo_electivo_id
inner join Sede s on c.sede_id = s.sede_id
inner join Turno tur on c.turno_id = tur.turno_id
inner join Docente d on c.matricula_docente = d.matricula_docente
inner join Persona per on d.persona_cuil = per.cuil
inner join Carrera_has_materia chm on chm.materia_id = m.materia_id
inner join Carrera carr on chm.carrera_id = carr.carrera_id
where carr.carrera_id = 1;

## 8- Devuelve todas las inscripciones realizadas por los alumnos
### Muestra el cuil, nombre y apellido del alumno, el id de la comision, la materia de dicha comision,
### La fecha en que se realizo la inscripcion y el estado de la misma

select per.cuil as cuil, per.nombre as nombre, per.apellido as apellido, c.comision_id as comision_id,
m.materia, insc.fecha, estado.estado
from inscripciones_materias insc
inner join Usuario u on u.usuario_id = insc.usuario_id
inner join Alumno a on u.alumno_matricula = a.matricula_alumno
inner join Persona per on a.persona_cuil = per.cuil
inner join Comision c on insc.comision_id = c.comision_id
inner join Materia m on m.materia_id = c.materia_id
inner join estado_inscripcion estado on estado.estado_inscripcion_id = insc.estado_inscripcion_id;

## 9 Devuelve todas las mesas de examen disponibles

select m.mesa_id as id, s.sede, t.tipo_mesa, m.fecha, m.hora, mat.materia, turno.turno_examen
, p.nombre, p.apellido
from mesa m
inner join Sede s on m.sede_id = s.sede_id
inner join Tipo_mesa t on t.tipo_mesa_id = m.tipo_mesa_id
inner join Docente d on d.matricula_docente = m.matricula_docente
inner join Persona p on d.persona_cuil = p.cuil
inner join Turno_examen turno on turno.turno_examen_id = m.turno_examen_id
inner join Materia mat on mat.materia_id = m.materia_id;


### 10- Devuelve todas las materias cursadas por el alumno Ezequiel bonino
select 
m.materia, per.nombre, per.apellido, materias_cursadas.nota,
materias_cursadas.fecha_fin_cursada, 
materias_cursadas.fecha_fin_vigencia,  
if(materias_cursadas.final_aprobado = 1, "SI", "NO") as final_aprobado, resultado.estado, 
if(vigencia.vigente = 1, "SI", "NO") as vigente
from Usuario_has_materias_cursadas materias_cursadas
inner join Usuario u on u.usuario_id = materias_cursadas.usuario_id
inner join Alumno a on a.matricula_alumno = u.alumno_matricula
inner join Persona per on per.cuil = a.persona_cuil
inner join Materia m on m.materia_id = materias_cursadas.materia_id
inner join Estado_resultado_cursada_examen resultado on resultado.estado_resultado_id = materias_cursadas.estado_resultado_id
inner join Vigencia vigencia on vigencia.fecha_fin_vigencia = materias_cursadas.fecha_fin_vigencia
where per.nombre = "Ezequiel" and per.apellido = "Bonino";


### 11- Obten la nota mas alta de alumno Ezequiel Bonino de aquellas materias con el estado de aprobado

select materias_cursadas.nota, resultado.estado
from Usuario_has_materias_cursadas materias_cursadas
inner join Usuario u on u.usuario_id = materias_cursadas.usuario_id
inner join Alumno a on a.matricula_alumno = u.alumno_matricula
inner join Persona per on per.cuil = a.persona_cuil
inner join Materia m on m.materia_id = materias_cursadas.materia_id
inner join Estado_resultado_cursada_examen resultado on resultado.estado_resultado_id = materias_cursadas.estado_resultado_id
inner join Vigencia vigencia on vigencia.fecha_fin_vigencia = materias_cursadas.fecha_fin_vigencia
where resultado.estado_resultado_id = 1
and per.nombre = "Ezequiel" and per.apellido = "Bonino"
order by materias_cursadas.nota desc limit 1;


### 12- Obten la nota mas baja de alumno Ezequiel Bonino de aquellas materias con el estado de aprobado

select materias_cursadas.nota, resultado.estado
from Usuario_has_materias_cursadas materias_cursadas
inner join Usuario u on u.usuario_id = materias_cursadas.usuario_id
inner join Alumno a on a.matricula_alumno = u.alumno_matricula
inner join Persona per on per.cuil = a.persona_cuil
inner join Materia m on m.materia_id = materias_cursadas.materia_id
inner join Estado_resultado_cursada_examen resultado on resultado.estado_resultado_id = materias_cursadas.estado_resultado_id
inner join Vigencia vigencia on vigencia.fecha_fin_vigencia = materias_cursadas.fecha_fin_vigencia
where resultado.estado_resultado_id = 1
and per.nombre = "Ezequiel" and per.apellido = "Bonino"
order by materias_cursadas.nota asc limit 1;


### 12- Obtene el promedio de notas del alumno Ezequiel Bonino cuando el estado de la cursada es aprobado

select avg(materias_cursadas.nota), resultado.estado
from Usuario_has_materias_cursadas materias_cursadas
inner join Usuario u on u.usuario_id = materias_cursadas.usuario_id
inner join Alumno a on a.matricula_alumno = u.alumno_matricula
inner join Persona per on per.cuil = a.persona_cuil
inner join Materia m on m.materia_id = materias_cursadas.materia_id
inner join Estado_resultado_cursada_examen resultado on resultado.estado_resultado_id = materias_cursadas.estado_resultado_id
inner join Vigencia vigencia on vigencia.fecha_fin_vigencia = materias_cursadas.fecha_fin_vigencia
where resultado.estado_resultado_id = 1
and per.nombre = "Ezequiel" and per.apellido = "Bonino"
order by materias_cursadas.nota asc limit 1;


### 13- Devuelve la nota maxima de cada alumno agrupada por alumno

select max(materias_cursadas.nota) as nota, per.nombre, per.apellido
from Usuario_has_materias_cursadas materias_cursadas
inner join Usuario u on u.usuario_id = materias_cursadas.usuario_id
inner join Alumno a on a.matricula_alumno = u.alumno_matricula
inner join Persona per on per.cuil = a.persona_cuil
inner join Materia m on m.materia_id = materias_cursadas.materia_id
inner join Estado_resultado_cursada_examen resultado on resultado.estado_resultado_id = materias_cursadas.estado_resultado_id
inner join Vigencia vigencia on vigencia.fecha_fin_vigencia = materias_cursadas.fecha_fin_vigencia
group by a.matricula_alumno;


### 14- Devuelve la nota minima de cada alumno agrupada por alumno

select min(materias_cursadas.nota) as nota, per.nombre, per.apellido
from Usuario_has_materias_cursadas materias_cursadas
inner join Usuario u on u.usuario_id = materias_cursadas.usuario_id
inner join Alumno a on a.matricula_alumno = u.alumno_matricula
inner join Persona per on per.cuil = a.persona_cuil
inner join Materia m on m.materia_id = materias_cursadas.materia_id
inner join Estado_resultado_cursada_examen resultado on resultado.estado_resultado_id = materias_cursadas.estado_resultado_id
inner join Vigencia vigencia on vigencia.fecha_fin_vigencia = materias_cursadas.fecha_fin_vigencia
group by a.matricula_alumno;


### 15- Devuelve todas las inscripciones a examenes

select  per.nombre, per.apellido, ins_examenes.fecha_inscripcion, materia.materia
from inscripciones_examenes ins_examenes
inner join Usuario u on ins_examenes.usuario_id = u.usuario_id
inner join Alumno a on a.matricula_alumno = u.alumno_matricula
inner join Persona per on per.cuil = a.persona_cuil
inner join Mesa m on ins_examenes.mesa_id = m.mesa_id
inner join Materia materia on m.materia_id = materia.materia_id;

### 16- Devuelve todos los detalles de los examnes


select  per.nombre, per.apellido, detalle.nota, forma_aprobacion.forma_forma_aprobacion, resultado.estado
from detalle_examen detalle
inner join Inscripciones_examenes insc_examanes on detalle.inscripciones_examenes_id = insc_examanes.inscripciones_examenes_id
inner join Usuario u on insc_examanes.usuario_id = u.usuario_id
inner join Alumno a on a.matricula_alumno = u.alumno_matricula
inner join Persona per on per.cuil = a.persona_cuil
inner join Forma_aprobacion forma_aprobacion on forma_aprobacion.forma_aprobacion_id = detalle.forma_aprobacion_id
inner join Estado_resultado_cursada_examen resultado on resultado.estado_resultado_id = detalle.estado_resultado_id;

### 17- Devuelve todos los docentes de la provincia de buenos aires

select p.nombre, p.apellido, dirr.numero_calle, c.calle, b.barrio, l.localidad, prov.provincia
from docente d
inner join persona p on d.persona_cuil = p.cuil
inner join direccion dirr on dirr.direccion_id = d.direccion_id
inner join calle c on c.calle_id = dirr.calle_id
inner join barrio b on b.barrio_id = c.barrio_id
inner join localidad l on l.localidad_id = b.localidad_id
inner join Provincia prov on prov.provincia_id = l.provincia_id
where prov.provincia = "Buenos Aires";

### 18- Devuelve las materias cursadas en el año 2019 del alumno ezequiel bonino

select 
m.materia, per.nombre, per.apellido, materias_cursadas.nota,
materias_cursadas.fecha_fin_cursada, 
materias_cursadas.fecha_fin_vigencia,  
if(materias_cursadas.final_aprobado = 1, "SI", "NO") as final_aprobado, resultado.estado, 
if(vigencia.vigente = 1, "SI", "NO") as vigente
from Usuario_has_materias_cursadas materias_cursadas
inner join Usuario u on u.usuario_id = materias_cursadas.usuario_id
inner join Alumno a on a.matricula_alumno = u.alumno_matricula
inner join Persona per on per.cuil = a.persona_cuil
inner join Materia m on m.materia_id = materias_cursadas.materia_id
inner join Estado_resultado_cursada_examen resultado on resultado.estado_resultado_id = materias_cursadas.estado_resultado_id
inner join Vigencia vigencia on vigencia.fecha_fin_vigencia = materias_cursadas.fecha_fin_vigencia
where per.nombre = "Ezequiel" and per.apellido = "Bonino" and materias_cursadas.fecha_fin_cursada like "2019%";


### 19- Muestra el nombre y apellido de cada docente, con la materia que imparte
### Si no tiene materia se debera mostrar null

select p.nombre, p.apellido, m.materia from docente d
left join Persona p on p.cuil = d.persona_cuil
left join comision c on d.matricula_docente = c.matricula_docente
left join materia m on m.materia_id = c.materia_id;


### Update and delete

select * from materia where materia_id = 7;
update materia set materia = "Química y Física Biológica" where materia_id = 7;

delete from materia where materia_id = 7;
select * from materia where materia_id = 7;
