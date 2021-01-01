USE Ferias

CREATE TABLE feria (
	id int PRIMARY KEY ,
	nombre varchar(255) NOT NULL,	
	cuit varchar(13) NOT NULL,
	cantidad_puestos int DEFAULT NULL,
	localidad varchar(255) DEFAULT NULL,
	domicilio varchar(255) DEFAULT NULL,
    zona varchar(255)
);

CREATE TABLE producto_tipo (
id int PRIMARY KEY,
nombre varchar(255) NOT NULL,
descripcion varchar(255) DEFAULT NULL
);

CREATE TABLE usuario (          
id int  PRIMARY KEY,			
email varchar(180) NOT NULL,
password varchar(25) NOT NULL,
nombre varchar(255) DEFAULT NULL,
apellido varchar(255) DEFAULT NULL
);

CREATE TABLE producto (
id int PRIMARY KEY,					
tipo_id integer NOT NULL,
especie varchar(255) NOT NULL,
variedad varchar(255) DEFAULT NULL,
activo bit NOT NULL,
FOREIGN KEY (tipo_id) REFERENCES producto_tipo(id)
);

CREATE TABLE declaracion (
id int PRIMARY KEY,
fechageneracion date NOT NULL,		
feria_id integer NOT NULL,
user_autor_id integer DEFAULT NULL,
FOREIGN KEY (feria_id) REFERENCES feria(id),
FOREIGN KEY (user_autor_id) REFERENCES usuario(id)
);

CREATE TABLE declaracion_individual (
id int PRIMARY KEY,
producto_declarado_id integer NOT NULL,
declaracion_id integer NOT NULL,
fecha date NOT NULL,
precio_por_bulto decimal(12,2) DEFAULT NULL,
comercializado bit NOT NULL DEFAULT 1,
peso_por_bulto decimal(5,2) DEFAULT NULL,
FOREIGN KEY (producto_declarado_id) REFERENCES producto(id),
FOREIGN KEY (declaracion_id) REFERENCES declaracion(id)
);

CREATE TABLE user_feria (
user_id integer NOT NULL,
feria_id integer NOT NULL,
PRIMARY KEY (user_id, feria_id),
FOREIGN KEY (user_id) REFERENCES usuario(id),
FOREIGN KEY (feria_id) REFERENCES feria(id)
);
