Create database Biblioteca;
use Biblioteca;

create table Usuarios(
id_usuario int auto_increment primary key,
nombre varchar(30) not null,
correo varchar(60) unique,
fecha_registro datetime not null,
telefono varchar(20) not null
);
INSERT INTO Usuarios (nombre, correo, fecha_registro, telefono) 
VALUES
('Juan Pérez', 'juan.perez@email.com', NOW(), '555-0101'),
('María García', 'm.garcia@email.com', NOW(), '555-0202'),
('Carlos Ruiz', 'cruiz88@email.com', NOW(), '555-0303'),
('Ana López', 'ana.lopez@email.com', NOW(), '555-0404'),
('Luis Méndez', 'luis.m@email.com', NOW(), '555-0505');

create table Prestamos(
id_prestamo int auto_increment primary key,
id_usuario int not null,
fecha_prestamo datetime DEFAULT CURRENT_TIMESTAMP not null,
estado enum ("Inactiva", "Activa", "Pendiente") default "Inactiva",
foreign key (id_usuario) references Usuarios (id_usuario)
);
INSERT INTO Prestamos (id_usuario, fecha_prestamo, estado) VALUES 
(1, NOW(), 'Activa'),
(2, NOW(), 'Pendiente'),
(3, NOW(), 'Inactiva'),
(4, NOW(), 'Activa'),
(5, NOW(), 'Activa');

create table Detalle_Prestamo(
	id_detalle int auto_increment primary key,
	id_prestamo int not null,
	id_libro int not null,
	fecha_devolucion datetime DEFAULT CURRENT_TIMESTAMP not null,
	foreign key (id_prestamo) references Prestamos(id_prestamo),
    foreign key (id_libro) references Libros(id_libro)
);
INSERT INTO Detalle_Prestamo (id_prestamo, id_libro, fecha_devolucion) VALUES
(1, 1, '2026-05-01 12:00:00'),
(2, 3, '2026-05-05 09:30:00'),
(3, 5, '2026-04-30 18:00:00'),
(4, 2, '2026-05-10 10:00:00'),
(5, 4, '2026-05-15 11:00:00');

create table Libros(
id_libro int auto_increment primary key,
titulo varchar(100) not null,
id_autor int not null,
id_editorial int not null,
anio_publicacion int not null,
foreign key (id_autor) references Autor(id_autor),
foreign key (id_editorial) references Editorial(id_editorial)
);
INSERT INTO Libros (titulo, id_autor, id_editorial, anio_publicacion) VALUES
('Cien años de soledad', 1, 2, 1967),
('La casa de los espíritus', 2, 1, 1982),
('El Resplandor', 3, 3, 1977),
('Harry Potter y la piedra filosofal', 4, 4, 1997),
('Don Quijote de la Mancha', 5, 2, 1605);

create table Libro_Categoria(
id_libro_categoria int auto_increment primary key,
id_categoria int not null,
id_libro int not null,
foreign key (id_categoria) references Categorias(id_categoria),
foreign key (id_libro) references Libros(id_libro)
);
INSERT INTO Libro_Categoria (id_categoria, id_libro) VALUES
(1, 1), -- Cien años es Ficción
(1, 2), -- La casa de los espíritus es Ficción
(2, 3), -- El Resplandor es Terror
(3, 4), -- Harry Potter es Fantasía
(4, 5); -- Don Quijote es Clásico

create table Categorias(
id_categoria int auto_increment primary key,
nombre varchar(50) not null,
descripcion varchar(150) not null
);
INSERT INTO Categorias (nombre, descripcion) 
VALUES
('Ficción', 'Relatos imaginarios y narrativas creativas.'),
('Terror', 'Historias diseñadas para provocar miedo y suspenso.'),
('Fantasía', 'Mundos mágicos y elementos sobrenaturales.'),
('Clásicos', 'Obras maestras que han perdurado en el tiempo.'),
('Historia', 'Libros basados en hechos reales y crónicas del pasado.');

create table Autor(
id_autor int auto_increment primary key,
nombre varchar(50) not null, 
apellido varchar(50) not null,
nacionalidad varchar (50) not null,
biografia text,
fecha_nacimiento date not null
);
INSERT INTO Autor (nombre, apellido, nacionalidad, biografia, fecha_nacimiento) 
VALUES
('Gabriel', 'García Márquez', 'Colombiana', 'Premio Nobel de Literatura en 1982.', '1927-03-06'),
('Isabel', 'Allende', 'Chilena', 'Escritora viva más leída de la lengua española.', '1942-08-02'),
('Stephen', 'King', 'Estadounidense', 'Maestro del suspenso y el terror contemporáneo.', '1947-09-21'),
('J.K.', 'Rowling', 'Británica', 'Creadora del universo de Harry Potter.', '1965-07-31'),
('Miguel', 'de Cervantes', 'Española', 'Autor de la máxima obra de la lengua española.', '1547-09-29');

create table Editorial (
id_editorial int auto_increment primary key,
nombre varchar(100) not null unique,
pais varchar(60) not null,
sitio_web varchar(255),
fecha_registro datetime default current_timestamp	
);
INSERT INTO Editorial (nombre, pais, sitio_web) 
VALUES
('Planeta', 'España', 'www.planeta.es'),
('Alfaguara', 'México', 'www.alfaguara.com'),
('Penguin Random House', 'EE.UU.', 'www.penguinrandomhouse.com'),
('Anagrama', 'España', 'www.anagrama-ed.es'),
('Norma', 'Colombia', 'www.librerianorma.com');


-- consultas lvl 1
-- 1
select * from libros;
-- 2
select titulo,anio_publicacion from libros; 
-- 3
select * from usuarios order by fecha_registro desc;
select * from usuarios;
update usuarios set fecha_registro = "2023-02-22 12:11:33" where correo ="m.garcia@email.com";
update usuarios set fecha_registro = "2020-10-22 12:11:33" where correo ="luis.m@email.com";
update usuarios set fecha_registro = "2022-04-19 12:11:33" where correo ="cruiz88@email.com";

-- consultas lvl 2
-- 1 libros con su autor
select * from libros;
select * from autor;

select
libros.titulo,
Autor.nombre,
Autor.apellido
from Libros inner join Autor
on Libros.id_autor = Autor.id_autor;

-- 2 libros con su editorial
select * from editorial;
select * from libros;

select libros.titulo ,
editorial.nombre,
editorial.pais,
editorial.sitio_web
from libros inner join editorial
on Libros.id_editorial = Editorial.id_editorial ;

-- 3 categoria de cada libro

select * from libro_categoria;
select * from categorias;
select * from libros;

select Libros.titulo as "Libro",
categorias.nombre as "categoria"
from Libros
inner join libro_categoria on libros.id_libro = libro_categoria.id_libro
inner join Categorias on libro_categoria.id_categoria = categorias.id_categoria;

-- consultas lvl 3

-- Mostrar todos los préstamos con nombre de usuario y libro
select * from prestamos;
select * from usuarios;
select * from libros;

select usuarios.nombre,
libros.titulo,
prestamos.fecha_prestamo
from prestamos
inner join usuarios on prestamos.id_usuario = usuarios.id_usuario
inner join detalle_prestamo on prestamos.id_prestamo = detalle_prestamo.id_prestamo
inner join libros on detalle_prestamo.id_prestamo = libros.id_libro;


-- Mostrar libros no devueltos

select libros.titulo,
usuarios.nombre,
prestamos.estado
from prestamos 
inner join usuarios on prestamos.id_usuario = usuarios.id_usuario
inner join detalle_prestamo on prestamos.id_prestamo = detalle_prestamo.id_prestamo
inner join Libros on detalle_prestamo.id_libro = libros.id_libro
where prestamos.estado in ("pendiente");

-- Mostrar historial completo de préstamos 

select usuarios.nombre,
libros.titulo,
editorial.nombre,
prestamos.fecha_prestamo,
detalle_prestamo.fecha_devolucion,
prestamos.estado
from prestamos
inner join usuarios on prestamos.id_usuario = usuarios.id_usuario
inner join detalle_prestamo on prestamos.id_prestamo = detalle_prestamo.id_prestamo
inner join libros on detalle_prestamo.id_libro = libros.id_libro
inner join editorial on libros.id_editorial = editorial.id_editorial
ORDER BY Prestamos.fecha_prestamo DESC;

-- nivel 4

-- Cantidad de libros por categoría

SELECT 
    C.nombre AS 'Categoría', 
    COUNT(LC.id_libro) AS 'Total Libros'
FROM Categorias C
inner JOIN Libro_Categoria LC ON C.id_categoria = LC.id_categoria
GROUP BY C.id_categoria, C.nombre;

-- Cantidad de préstamos por usuario

select usuarios.nombre as "Usuario",
count(prestamos.id_prestamo) as "Cantidad de Prestamos"
from usuarios
inner join prestamos on usuarios.id_usuario	 = 	prestamos.id_prestamo
group by  Usuarios.id_usuario, Usuarios.nombre;

update Prestamos set fecha_prestamo = "2026-04-04 10:00" where id_usuario = 2;
select * from prestamos;


-- Cantidad de libros por editorial

	SELECT 
		E.nombre AS 'Editorial', 
		COUNT(L.id_libro) AS 'Cantidad de Libros'
	FROM Editorial E
	LEFT JOIN Libros L ON E.id_editorial = L.id_editorial
	GROUP BY E.id_editorial, E.nombre;
    
    -- lvl 5
    -- usuario con mas prestamos
    
    SELECT 
    U.nombre AS 'Usuario Top', 
    COUNT(P.id_prestamo) AS 'Total de Préstamos'
FROM Usuarios U
JOIN Prestamos P ON U.id_usuario = P.id_usuario
GROUP BY U.id_usuario, U.nombre
ORDER BY COUNT(P.id_prestamo) DESC;
    
    -- libro más prestado
    
    SELECT 
    L.titulo AS 'Libro Más Popular', 
    COUNT(DP.id_libro) AS 'Veces Prestado'
FROM Libros L
JOIN Detalle_Prestamo DP ON L.id_libro = DP.id_libro
GROUP BY L.id_libro, L.titulo
ORDER BY COUNT(DP.id_libro) DESC
LIMIT 1;
    
    
    -- categoria más popular
    
    SELECT 
    C.nombre AS 'Categoría Más Popular', 
    COUNT(DP.id_libro) AS 'Total de Préstamos'
FROM Categorias C
JOIN Libro_Categoria LC ON C.nombre = LC.id_categoria -- o LC.id_categoria si usas IDs
JOIN Libros L ON LC.id_libro = L.id_libro
JOIN Detalle_Prestamo DP ON L.id_libro = DP.id_libro
GROUP BY C.id_categoria, C.nombre
ORDER BY COUNT(DP.id_libro) DESC
LIMIT 1;
    
    



    