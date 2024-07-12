/*
Nombre: Jose Alejandro Jimenez de la Curz
Código Tecnico: IN5BV
Carnét: 2022152
Fecha de Creación: 30-03-2023
Fecha de Modificación: 	1-04-2023
						3-04-2023
                        6-04-2023
*/

Drop database if exists DBTonysKinal2023;
Create database  DBTonysKinal2023;

Use DBTonysKinal2023;

Create table Empresas(
	codigoEmpresa int auto_increment not null,
    nombreEmpresa varchar(150) not null,
    direccion varchar (150) not null,
    telefono varchar (10) not null,
    primary key PK_codigoEmpresa (codigoEmpresa)
);

Create table TipoEmpleado(
	codigoTipoEmpleado int not null auto_increment,
	descripcion varchar(50) not null,
    primary key PK_codigoTipoEmpleado (codigoTipoEmpleado)
);


Create table Empleados (
	codigoEmpleado int auto_increment not null,
    numeroEmpleado int not null,
    apellidosEmpleado varchar (150) not null,
    nombresEmpleado varchar(150) not null,
    direccionEmpleado varchar(150) not null,
    telefonoContacto varchar(150) not null,
    gradoCocinero varchar(150) not null,
    codigoTipoEmpleado int not null,
    primary key PK_codigoEmpleado  (codigoEmpleado),
    constraint FK_Empleados_TipoEmpleado foreign key
		(codigoTipoEmpleado) references TipoEmpleado (codigoTipoEmpleado) on delete cascade
);

Create table TipoPlato(
	codigoTipoPlato int auto_increment not null,
    descripcionTipo varchar (100) not null,
    primary key PK_codigoTipoPlato (codigoTipoPlato)
);

Create table Productos (
	codigoProducto int not null,
    nombreProducto varchar (150) not null,
    cantidad int not null,
    primary key PK_codigoProducto (codigoProducto)
);

Create table Servicios (
	codigoServicio int auto_increment not null,
    fechaServicio date not null,
    tipoServicio varchar(150) not null,
    horaServicio time not null,
    telefonoContacto varchar(10) not null,
    codigoEmpresa int not null,
    primary key PK_codigoServicio (codigoServicio),
    constraint FK_Servicios_Empresas foreign key (codigoEmpresa)
		references Empresas(codigoEmpresa)ON DELETE CASCADE
);

Create table Presupuestos(
	codigoPresupuesto int auto_increment not null,
    fechaSolicitud date not null,
    cantidadPresupuesto decimal (10, 2) not null,
    codigoEmpresa int not null,
    primary key PK_Presupuestos (codigoPresupuesto),
    constraint FK_Presupuestos_Empresa foreign key (codigoEmpresa)
		references Empresas (codigoEmpresa)ON DELETE CASCADE
);

Create table Platos (
	codigoPlato int auto_increment not null,
    cantidad int not null,
    nombrePlato varchar(50) not null,
    descripcionPlato varchar(150) not null,
    precioPlato decimal(10,2) not null,
    codigoTipoPlato int not null,
    tipoPlato_codigoTipoPlato int not null,
    primary key PK_codigoPlato (codigoPlato)
    /*constraint FK_Platos_TipoPlato1 foreign key(codigoTipoPlato)
		references TipoPlato (codigoTipoPlato)*/
); 

Create table Productos_has_Platos(
	Productos_codigoProducto int not null,
    codigoPlato int not null,
    codigoProducto int not null,
    primary key PK_Productos_codigoProducto (Productos_codigoProducto),
    constraint FK_Productos_has_Platos_Productos1 foreign key (codigoProducto)
		references Productos(codigoProducto),
	constraint FK_Productos_has_Platps_Platos1 foreign key (codigoPlato)
		references Platos(codigoPlato) ON DELETE CASCADE
);

Create table Servicios_has_Platos (
	Servicios_codigoServicio int not null,
    codigoPlato int not null,
    codigoServicio int not null,
    primary key PK_Servicios_codigoServicio (Servicios_codigoServicio),
    constraint FK_Servicios_has_Platos_Servicios1 foreign key (codigoServicio)
		references Servicios (codigoServicio),
	constraint FK_Servicios_has_Platos_Platos1 foreign key (codigoPlato)
		references Platos(codigoPlato)ON DELETE CASCADE
);

Create table Servicios_has_Empleados (
	Servicios_codigoServicio int not null,
    codigoServicio int not null,
    codigoEmpleado int not null,
    fechaEvento date not null,
    horaEvento time not null,
    lugarEvento varchar(150) not null,
    primary key PK_Servicios_codigoServicio (Servicios_codigoServicio),
    constraint FK_Servicios_has_Empleados_Servicios1 foreign key (codigoServicio)
		references Servicios (codigoServicio),
	constraint FK_Servicio_has_Empleados_Empleados1 foreign key (codigoEmpleado)
		references Empleados (codigoEmpleado)ON DELETE CASCADE
);

-- Use DBRecuperacion;

-- ------------------------------------Procedimientos almacenados Entidad Empresa ---------
-- --------------------------- Agregar Empresa

Delimiter $$
	Create procedure sp_AgregarEmpresa (in nombreEmpresa varchar(150), in direccion varchar(150), in telefono varchar(10))
    Begin
		Insert into Empresas (nombreEmpresa, direccion, telefono)
			values (nombreEmpresa, direccion, telefono);
    End $$
Delimiter ;

call sp_AgregarEmpresa ('Campero', 'Guatemala Ciudad', '12345678');
call sp_AgregarEmpresa ('Farmacia Galeno', 'Mixco', '12654578');
call sp_AgregarEmpresa ('Pinulito', 'Escuintla', '33508987');
call sp_AgregarEmpresa ('Suma', 'Guatemala Ciudad', '44809847');

-- ---------------------------- Listar Empresas

Delimiter $$
	Create procedure sp_ListarEmpresas ()
		Begin
			Select
            E.codigoEmpresa, 
            E.nombreEmpresa, 
            E.direccion, 
            E.telefono
            from Empresas E;
        End $$
Delimiter ;

call sp_ListarEmpresas();

-- ---------------------------- Buscar Empresa

Delimiter $$
	Create procedure sp_BuscarEmpresa (in codEmpresa int)
		Begin
			Select 
            E.codigoEmpresa, 
            E.nombreEmpresa, 
            E.direccion, 
            E.telefono
            from Empresas E
            where codigoEmpresa = codEmpresa;
        End $$
Delimiter ;

call sp_BuscarEmpresa (1);

-- ----------------------------- Eliminar Empresa

Delimiter $$
	Create procedure sp_EliminarEmpresa (in codEmpresa int)
    Begin
		Delete from Empresas
        where codigoEmpresa = codEmpresa;
    End $$
Delimiter ;

call sp_EliminarEmpresa ('4');

 -- -------------------------- Editar Empresa
 
 Delimiter $$
	Create procedure sp_EditarEmpresa (in codEmpresa int,in nomEmpresa varchar(150),
		in direccionn varchar(150),in telefono_ varchar(10))
        Begin
			Update Empresas E
            set
            E.nombreEmpresa = nomEmpresa,
            E.direccion = direccionn,
            E.telefono = telefono_
            where codEmpresa = codigoEmpresa;
		End$$
 Delimiter ;

call sp_EditarEmpresa (3,'Los pollos Primos', 'Guatemala Ciudad', '33508907');
call sp_ListarEmpresas ();

-- ----------------------------------------------------- CRUD TipoEmpleado -------------------------------------
-- --------------------------- Agregar TipoEmpleado

Delimiter $$
	create procedure sp_AgregarTipoEmpleado (in descripcion varchar(50))
		Begin
			Insert into TipoEmpleado (descripcion)
				values (descripcion);
        End$$
Delimiter ;

call sp_AgregarTipoEmpleado ('Obtiene los pedidos de la gente en el restaurant');
call sp_AgregarTipoEmpleado ('Recibe los pedidos de la gente');
call sp_AgregarTipoEmpleado ('Cocina los platillos principales');
call sp_AgregarTipoEmpleado ('Lava Platos');

-- --------------------------- Listar TipoEmpleado 

Delimiter $$
	Create procedure sp_ListarTipoEmpleado()
		Begin
			Select 
            T.codigoTipoEmpleado, 
            T.descripcion
            from TipoEmpleado T;  
        End $$
Delimiter ;

call sp_ListarTipoEmpleado();

-- ------------------------------ Buscar TipoEmpleado

Delimiter $$
	Create procedure sp_BuscarTipoEmpleado (in codTipoEmpleado int)
		Begin
			Select 
            T.descripcion
            from TipoEmpleado T
            where codigoTipoEmpleado = codTipoEmpleado;
        End $$
Delimiter ;

call sp_BuscarTipoEmpleado (1);

-- ------------------------------- Eliminar TipoEmpleado

Delimiter $$
	Create procedure sp_EliminarTipoEmpleado (in codTipoEmpleado int)
		Begin
			Delete from TipoEmpleado
            where codigoTipoEmpleado = codTipoEmpleado;
        End $$
Delimiter ;

call sp_EliminarTipoEmpleado (4);

-- -------------------------------- Editar TipoEmpleado

Delimiter $$
	Create procedure sp_EditarTipoEmpleado (in codTipoEmpleado int, in descripci varchar(50))
		Begin
			Update TipoEmpleado T
            set
            T.descripcion = descripci
            where codTipoEmpleado = codigoTipoEmpleado;
        End $$
Delimiter ;

call sp_EditarTipoEmpleado (2, 'Recibe los pedidos');

-- ------------------------------------------------------ CRUD Empleados ---------------------------------
-- ----------------------------- Agregar Empleados

Delimiter $$
	create procedure sp_AgregarEmpleado (in numeroEmpleado int, apellidosEmpleado varchar(150), nombresEmpleados varchar(150),
										in direccionEmpleado varchar(150), in telefonoContacto varchar(10), in gradoCocinero varchar(50),
                                        in codigoTipoEmpleado int)
		Begin
				Insert into Empleados (numeroEmpleado, apellidosEmpleado, nombresEmpleado, direccionEmpleado, 
									   telefonoContacto, gradoCocinero, codigoTipoEmpleado)
				values (numeroEmpleado, apellidosEmpleado, nombresEmpleado, direccionEmpleado, 
						telefonoContacto, gradoCocinero, codigoTipoEmpleado);
        End$$
Delimiter ;

call sp_AgregarEmpleado (2022150, 'Martinez Lopez', 'Luis Pedro', 'Calle B, Lote 156 Amatitlan', '54217175', 'Senior Chef', '1');
call sp_AgregarEmpleado (2022151, 'Villa Lobos', 'Gary José', 'Lote 15 Escuintla', '55208951', 'Sous Chef', '2');
call sp_AgregarEmpleado (2022152, 'Jimenez de la Cruz', 'Jose Alejandro', '5ta avenida 2-44 Zona 6', '05508978', 'Chef Ejecutivo', '3');
/*
-- --------------------------- Listar Empleados

Delimiter $$
	Create procedure sp_ListarEmpleados ()
		Begin
			Select 
            E.codigoEmpleado, 
            E.numeroEmpleado, 
            E.apellidosEmpleado, 
            E.nombresEmpleado, 
            E.direccionEmpleado, 
            E.telefonoContacto, 
            E.gradoCocinero, 
            E.codigoTipoEmpleado
            from Empleados E;
        End $$
Delimiter ; 
 
call sp_ListarEmpleados ();

-- ------------------------------- Buscar Empleados 

Delimiter $$
	Create procedure sp_BuscarEmpleados(in codEmpleado int)
		Begin
			Select 
            E.codigoEmpleado, 
            E.numeroEmpleado, 
            E.apellidosEmpleado, 
            E.nombresEmpleado, 
            E.direccionEmpleado, 
            E.telefonoContacto, 
            E.gradoCocinero, 
            E.codigoTipoEmpleado
            from Empleados E
            where codigoEmpleado = codEmpleado;
        End $$
Delimiter ;

call sp_BuscarEmpleados (1);

-- ------------------------- Eliminar Empleados 

Delimiter $$
	Create procedure sp_EliminarEmpleados (in codEmpleado int)
		Begin
			Delete from Empleados
            where codigoEmpleado = codEmpleado;
        End $$
Delimiter ;

call sp_EliminarEmpleados (3);
call sp_AgregarEmpleados (2022152, 'Jimenez de la Cruz', 'Jose Alejandro', '5ta avenida 2-44 Zona 6', '05508978', 'Chef Ejecutivo', '3');

-- ----------------------- Editar Empleados 

Delimiter $$
	Create procedure sp_EditarEmpleado (in codEmpleado int,in numEmpleado int,in apelliEmpleado varchar(150),in nomEmpleado varchar(150), 
		in direcciEmpleado varchar(150),in telefonoContact varchar(150),in gradCocinero varchar(150),in codTipoEmpleado int)
		Begin
			Update Empleados E
            Set 
            E.numeroEmpleado = numEmpleado,
            E.apellidosEmpleado = apelliEmpleado,
            E.nombresEmpleado = nomEmpleado,
            E.direccionEmpleado = direcciEmpleado,
            E.telefonoContacto = telefonoContact,
            E.gradoCocinero = gradCocinero,
            E.codigoTipoEmpleado = codTipoEmpleado
            where codEmpleado = codigoEmpleado;
        End $$
Delimiter ;

call sp_EditarEmpleado (1,2022150, 'Martinez Gil', 'Luis Pedro', 'Calle C, Lote 156 Amatitlan', '54210000', 'Senior Chef', '1');
*/

-- -------------------------------------------------------- CRUD TipoPlato -----------------------------------------------
-- ---------------------------------- Agregar TipoPlato 

Delimiter $$
	Create procedure sp_AgregarTipoPlato (in descriTipo varchar(100))
		Begin
			Insert into TipoPlato (descripcionTipo)
				Values (descriTipo);
        End$$
Delimiter ;

call sp_AgregarTipoPlato ('Rico plato para comida formal');
call sp_AgregarTipoPlato ('Rico platillo que puede ser tomado como postre');
call sp_AgregarTipoPlato ('Delicioso platillo oriental');
call sp_AgregarTipoPlato ('Delicioso platillo Mexicano');

-- ------------------------------- listar TipoPlatos

Delimiter $$
	Create procedure sp_ListarTipoPlatos ()
		Begin
			Select
            T.codigoTipoPlato, 
            T.descripcionTipo
            from TipoPlato T;
        End $$
Delimiter ;

call sp_ListarTipoPlatos ();

-- -------------------------- Buscar TipoPlato

Delimiter $$
	Create procedure sp_BuscarTipoPlato (in codTipoPlato int)
		Begin
			Select 
            T.codigoTipoPlato, 
            T.descripcionTipo
            from TipoPlato T
            Where codigoTipoPlato = codTipoPlato;
        End $$
Delimiter ;

call sp_BuscarTipoPlato (1);

-- ------------------------ Eliminar TipoPlato 
Delimiter $$
	Create procedure sp_EliminarTipoPlato (in codTipoPlato int)
		Begin
			Delete from TipoPlato 
            where codigoTipoPlato = codTipoPlato;
        End $$
Delimiter ;

call sp_EliminarTipoPlato (4);

-- --------------------- Editar TipoPlato 

Delimiter $$
	Create procedure sp_EditarTipoPlato (in codTipoPlato int ,in descriTipo varchar(100))
		Begin
			Update TipoPlato T
            Set
            T.descripcionTipo = descriTipo
            where codigoTipoPlato = codTipoPlato;
        End$$
Delimiter ;

call sp_EditarTipoPlato(1, 'Rico Platillo Gourmet');

-- -------------------------------------------------------- CRUD Porductos -----------------------------------------
-- -------------------------- Agregar Productos 

Delimiter $$
	create procedure sp_AgregarProducto (in codigoProducto int, in nombreProducto varchar(150), in cantidad int)
		Begin
			Insert into Productos (codigoProducto, nombreProducto, cantidad)
				values (codigoProducto, nombreProducto, cantidad);
        End$$
Delimiter ;

call sp_AgregarProducto (40, 'Carne para Bistek', 20);
call sp_AgregarProducto (41, 'Tomates', 50);
call sp_AgregarProducto (42, 'Pollo', 90);
call sp_AgregarProducto (800, 'Prueba', 90);

-- ------------------------- Listar Productos
Delimiter $$
	Create procedure sp_ListarProductos ()
		Begin
			Select 
            P.codigoProducto, 
            P.nombreProducto, 
            P.cantidad
            from Productos P;
        End $$
Delimiter ;

call sp_ListarProductos ();

-- ------------------------- Buscar Producto

Delimiter $$
	Create procedure sp_BuscarProducto (in codProducto int)
		Begin
			Select 
            P.codigoProducto,
            P.nombreProducto, 
            P.cantidad
            from Productos P
            where codigoProducto = codProducto;
        End $$
Delimiter ;

call sp_BuscarProducto (40);

-- ------------------------- Eliminar Producto

Delimiter $$
	Create procedure sp_EliminarProducto (in codProducto int)
		Begin
			Delete from Productos
            where codigoProducto = codProducto;
        End $$
Delimiter ;

call sp_EliminarProducto(800);

-- ----------------------- Editar Producto

Delimiter $$
	Create procedure sp_EditarProducto (in codProducto int,in nomProducto varchar(150),in cant int)
		Begin
			Update Productos P
            Set
            nombreProducto = nomProducto,
            cantidad = cant
            where codigoProducto = codProducto;
        End$$
Delimiter ;

call sp_EditarProducto(40, 'Carne de Res', 30);
/*
-- -------------------------------- CRUD Servicios -----------------
-- ------------------- Agregar Servicio 

Delimiter $$
	Create procedure sp_AgregarServicio (in fechaServicio date,in tipoServicio varchar(150), 
		in horaServicio time,in telefonoContacto varchar(10),in codigoEmpresa int)
		Begin
			Insert into Servicios (fechaServicio, tipoServicio, horaServicio, telefonoContacto, codigoEmpresa)
				values (fechaServicio, tipoServicio, horaServicio, telefonoContacto, codigoEmpresa);
        End $$
Delimiter ;

call sp_AgregarServicio('2020-02-05', 'Servicio de Buffet', '15:20', '89897854', 1);
call sp_AgregarServicio('2020-06-08', 'Servicio de adomicilio', '10:20', '78567354', 2);
call sp_AgregarServicio('2020-09-02', 'Servicio VIP', '18:55', '38989854', 3);

-- ------------------ Listar Servicios 

Delimiter $$
	Create procedure sp_ListarServicios ()
		Begin
			Select 
            S.codigoServicio, 
            S.fechaServicio, 
            S.tipoServicio, 
            S.horaServicio, 
            S.telefonoContacto, 
            S.codigoEmpresa
            From Servicios S;
        End $$
Delimiter ;

call sp_ListarServicios ();

-- ---------------------- Buscar Servicios 

Delimiter $$
	Create procedure sp_BuscarServicios (in codServicio int)
		Begin
			Select 
            S.codigoServicio, 
            S.fechaServicio, 
            S.tipoServicio, 
            S.horaServicio, 
            S.telefonoContacto, 
            S.codigoEmpresa
            From Servicios S
            where codigoServicio = codServicio;
        End $$
Delimiter ;

call sp_BuscarServicios (1);

-- ------------------------ Eliminar Servicio 

Delimiter $$
	Create procedure sp_EliminarServicio (in codServicio int)
		Begin
			Delete from Servicios
            where codigoSerrvicio = codServicio;
        End $$
Delimiter ;



-- --------------------------- Editar Servicio 

Delimiter $$
	Create procedure sp_EditarServicio (in codServicio int, feServicio date,in tipServicio varchar(150),
		in horServicio time,in teleContacto varchar(10),in codEmpresa int)
		Begin
			Update Servicios S
            Set
            S.fechaServicio = feServicio,
            S.tipoServicio = tipServicio,
            S.horaServicio = horServicio,
            S.telefonoContacto = teleContacto,
            S.codigoEmpresa = codEmpresa
            where codigoServicio = codServicio;
        End $$
Delimiter ;

call sp_EditarServicio (2, '2020-06-08', 'Servicio de Adomicilio', '10:20', '78567354', 2);
*/

-- ------------------------------------------- CRUD DE PRESUPUESTOS ---------------------
-- --------------------- Agregar Presupuesto

Delimiter $$
	Create procedure sp_AgregarPresupuesto (in fechSolicitud date,in cantiPresupuesto decimal (10,2),
		in codEmpresa int)
        Begin
			Insert into Presupuestos (fechaSolicitud, cantidadPresupuesto, codigoEmpresa)
				values (fechSolicitud, cantiPresupuesto, codEmpresa);
        End $$
Delimiter ;

call sp_AgregarPresupuesto ('2022-07-20', 560.50, 1);
call sp_AgregarPresupuesto ('2021-09-10', 860.50, 2);
call sp_AgregarPresupuesto ('2022-07-09', 1000.00, 3);
-- ---------------------- Listar Presupuestos

Delimiter $$
	Create procedure sp_ListarPresupuestos ()
		Begin
			Select 
            P.codigoPresupuesto,
            P.fechaSolicitud, 
            P.cantidadPresupuesto, 
            P.codigoEmpresa
            from Presupuestos P;
        End $$
Delimiter ;

call sp_ListarPresupuestos ();

-- ---------------------Buscar Presupuesto

Delimiter $$
	Create procedure sp_BuscarPresupuesto (in codPresupuesto int)
		Begin
			Select 
            P.fechaSolicitud, 
            P.cantidadPresupuesto, 
            P.codigoEmpresa
            from Presupuestos P
            where codigoPresupuesto = codPresupuesto;
        End $$
Delimiter ;

call sp_BuscarPresupuesto (1);

-- ------------------ Eliminar Presupuesto 

Delimiter $$
	Create procedure sp_EliminarPresupuesto (in codPresupuesto int)
		Begin
			Delete from Presupuestos
            where codigoPresupuesto = codPresupuesto;
        End $$
Delimiter ;

-- on delete cascade tip en todas las llaves foraneas 

-- -------------------- Editar Presupuestos 

Delimiter $$
	Create procedure sp_EditarPresupuesto (in codPresupuesto int,in fechSolicitud date,
		in cantiPresupuesto decimal(10,2),in codEmpresa int) 
        Begin
			Update Presupuestos P
            Set
            fechaSolicitud = fechSolicitud,
            cantidadPresupuesto = cantiPresupuesto,
            codigoEmpresa = codEmpresa
            where codigoPresupuesto = codPresupuesto;
        End $$
Delimiter ;

call sp_EditarPresupuesto (1, '2022-07-20', 512.50, 1);/*

-- --------------------------- CRUD de Platos ------
-- ------------------------ Agregar Plato

Delimiter $$
	Create procedure sp_AgregarPlato(in cantidad int,in nombrePlato varchar(50),in descripcionPlato varchar(50)
		,in precioPlato decimal(10,2),in codigoTipoPlato int,in tipoPlato_codigoTipoPlato int)
        Begin
			Insert into Platos(cantidad, nombrePlato, descripcionPlato, precioPlato, codigoTipoPlato, tipoPlato_codigoTipoPlato)
				values (cantidad, nombrePlato, descripcionPlato, precioPlato, codigoTipoPlato, tipoPlato_codigoTipoPlato);
        End$$
Delimiter ;

call sp_AgregarPlato (60, 'Ramen japones', 'Rico ramen de carne de cerdo', 59.99, 1, 201);
call sp_AgregarPlato (50, 'Pizza de Quesos', 'Deliciosa pizza con variedad de quesos', 58.00, 2, 202);
call sp_AgregarPlato (40, 'CheeseBurguer', 'hecha a base de carne de res', 39.99, 3, 203);
-- --------------------- Listar Platos

Delimiter $$
	Create procedure sp_ListarPlatos()
		Begin
			Select 
			P.codigoPlato, 
			P.cantidad, 
			P.nombrePlato, 
			P.descripcionPlato, 
			P.precioPlato, 
			P.codigoTipoPlato, 
			P.tipoPlato_codigoTipoPlato
			from Platos P;
		End$$
Delimiter ;

call sp_ListarPlatos ();

-- --------------------- Buscar Plato

Delimiter $$
	Create procedure sp_BuscarPlato (in codPlato int)
		Begin
			Select
            P.codigoPlato, 
            P.cantidad, 
            P.nombrePlato, 
            P.descripcionPlato, 
            P.precioPlato, 
            P.codigoTipoPlato, 
            P.tipoPlato_codigoTipoPlato
            From Platos P
            where codigoPlato = codPlato;
        End $$
Delimiter ;

call sp_BuscarPlato (1);

-- ------------------- Eliminar Plato

Delimiter $$
	Create procedure sp_EliminarPlato(in codPlato int)
		Begin
			Delete from Platos
            where codigoPlato = codPlato;
        End $$
Delimiter ;

-- ------------------- Editar Plato
Delimiter $$
	Create procedure sp_EditarPlato(in codPlato int, in cant int, in nomPlato varchar(50), in descriPlato varchar(150),
										in precPlato decimal(10,2), in codTipoPlato int)
		Begin
			Update Platos PL
            Set 
            cantidad = cant,
            nombrePlato = nomPlato,
            descripcionPlato = descriPlato,
            precioPlato = precPlato,
            codigoTipoPlato = codTipoPlato
            where codigoPlato = codPlato;
        End$$
Delimiter ;

Call sp_EditarPlato (3, 45, 'CheeseBurguer', 'hecha a base de carne de res', 100.00, 203);

-- ------------------------------------- CRUD Productos_has_Platos --------------------
-- -------------------- Agregar Productos_has_Platos

Delimiter $$
	create procedure sp_AgregarProductos_has_Platos (in Productos_codigoProducto int, in codigoPlato int,
													 in codigoProducto int)
		Begin
			Insert into Productos_has_Platos (Productos_codigoProducto, codigoPlato, codigoProducto)
				values (Productos_codigoProducto, codigoPlato, codigoProducto);
        End$$
Delimiter ;

call sp_AgregarProductos_has_Platos (600, 1, 40);

-- ----------------------- Listar Productos_has_Platos

Delimiter $$
	Create procedure sp_ListarProductos_has_Platos ()
		Begin
			Select
            P.Productos_codigoProducto, 
            P.codigoPlato, 
            P.codigoProducto
            from Productos_has_Platos P;
        End $$
Delimiter ;

call sp_ListarProductos_has_Platos();

-- --------------------- Buscar Productos_has_Platos
Delimiter $$
	Create procedure sp_BuscarProductos_has_Platos(in codProductos_has_Platos int)
		Begin
			Select 
            P.Productos_codigoProducto, 
            P.codigoPlato, 
            P.codigoProducto
            From Productos_has_Platos P
            where Productos_codigoProducto = codProductos_has_Platos;
        End $$
Delimiter ;

call sp_BuscarProductos_has_Platos(600);

-- ----------------- Eliminar Productos_has_Platos
Delimiter $$
	Create procedure sp_EliminarProductos_has_Platos (in codProductos_has_Platos int)
		Begin
			Delete from Productos_has_Platos
            where Productos_codigoProducto = codProductos_has_Platos;
        End$$
Delimiter ;

-- ------------------ Editar Productos_has_Platos
Delimiter $$
	Create procedure sp_EditarProductos_has_Platos(in Prod_codigoProducto int, in codPlato int, in codProducto int)
		Begin
			Update Productos_has_Platos PHP
            Set
             codigoPlato = codPlato,
             codigoProducto = codProducto
            Where Productos_codigoProducto = Prod_codigoProducto;
        End$$
Delimiter ;  

-- -------------------------------------- CRUD De Servicios_has_Platos -----
-- ------------------- Agregar Servicios_has_Platos

Delimiter $$
	create procedure sp_AgregarServicios_has_Platos (in Servicios_codigoServicio int, codigoPlato int,
													 in codigoServicio int)
		Begin
			Insert into Servicios_has_Platos(Servicios_codigoServicio, codigoPlato, codigoServicio)
				values (Servicios_codigoServicio, codigoPlato, codigoServicio);
        End$$
Delimiter ;

call sp_AgregarServicios_has_Platos(800, 1, 1);
call sp_AgregarServicios_has_Platos(801, 2, 2);
call sp_AgregarServicios_has_Platos(802, 3, 3);

-- ------------------ Listar Servicios_has_Platos

Delimiter $$
	Create procedure sp_ListarServicios_has_Platos()
		Begin
			Select 
            S.Servicios_codigoServicio, 
            S.codigoPlato, 
            S.codigoServicio
            from Servicios_has_Platos S;
        End $$
Delimiter ;

call sp_ListarServicios_has_Platos();

-- -------------------- Buscar Servicios_has_Platos
Delimiter $$
	Create procedure sp_BuscarServicios_has_Platos(in Servicios_codServicio int)
		Begin
			Select 
            S.Servicios_codigoServicio, 
            S.codigoPlato, 
            S.codigoServicio
            from Servicios_has_Platos S
            where Servicios_codigoServicio = Servicios_codServicio;
        End $$
Delimiter ;

call sp_BuscarServicios_has_Platos(800);

-- ------------------ Eliminar Servicios_has_Platos

Delimiter $$
	Create procedure sp_EliminarServicios_codigoServicio (in Serv_codigoServicio int)
		Begin
			Delete from Servicios_has_Platos
            where Servicios_codigoServicio = Serv_codigoServicio;
        End$$
Delimiter ;



-- -------------------- Editar Servicios_has_Platos
Delimiter $$
	Create procedure sp_EditarServicios_has_Platos(in Serv_codServicio int, in codPlato int, 
													in codServicio int)
		Begin
			Update Servicios_has_Platos SHP
            Set
             codigoPlato = codPlato,
             codigoServicio = codServicio
            Where Servicios_codigoServicio = Serv_codServicio;
        End$$
Delimiter ;

call sp_EditarServicios_has_Platos(802, 3, 3);

-- ---------------------------------- CRUD Servicios_has_Empleados --------------
-- ------------- Agregar Servicios_has_Empleados
Delimiter $$
	create procedure sp_AgregarServicios_has_Empleados(in Servicios_codigoServicio int, in codigoServicio int,
				  in codigoEmpleado int, in fechaEvento date, in horaEvento time, in lugarEvento varchar(150))
		Begin
			Insert into Servicios_has_Empleados(Servicios_codigoServicio, codigoServicio, codigoEmpleado,
												fechaEvento, horaEvento, lugarEvento)
				values (Servicios_codigoServicio, codigoServicio, codigoEmpleado,
												fechaEvento, horaEvento, lugarEvento);
        End$$
Delimiter ;

call sp_AgregarServicios_has_Empleados(900, 1, 1, '2023-07-01', '03:55', 'Amatitaln calle B, lote 15');
call sp_AgregarServicios_has_Empleados(901, 2, 2, '2023-02-02', '06:55', 'Zona 6, 5ta calle 9-2');
call sp_AgregarServicios_has_Empleados(902, 3, 4, '2023-03-09', '07:55', '6-96, valle la Mariposa');

-- -------------- Listar Servicios_has_Empleados
Delimiter $$
	Create procedure sp_ListarServicios_has_Empleados()
		Begin
			Select
            S.Servicios_codigoServicio, 
            S.codigoServicio, 
            S.codigoEmpleado, 
            S.fechaEvento, 
            S.horaEvento, 
            S.lugarEvento
            From servicios_has_empleados S;
        End $$
Delimiter ;

call sp_ListarServicios_has_Empleados();

-- ----------------- Buscar Servicios_has_Empleados

Delimiter $$
	Create procedure sp_BuscarServicios_has_Empleados(in Servicios_codServicio int)
		Begin
			Select
            S.Servicios_codigoServicio, 
            S.codigoServicio, 
            S.codigoEmpleado, 
            S.fechaEvento, 
            S.horaEvento, 
            S.lugarEvento
            From servicios_has_empleados S
            where Servicios_codigoServicio = Servicios_codServicio;
        End $$
Delimiter ;

call sp_BuscarServicios_has_Empleados(900);

-- ----------------------- Eliminar Servicios_has_Empleados

Delimiter $$
	Create procedure sp_EliminarServicios_has_Empleados (in Servicios_codServicio int)
		Begin
			Delete from Servicios_has_Empleados
            where Servicios_codigoServicio = Servicios_codServicio;
        End$$
Delimiter ;

-- ----------------- Editar Servicios_has_Empleados
Delimiter $$
	Create procedure sp_EditarServicios_has_Empleados(in Serv_codigoServicio int, in codServicio int, in codEmpleado int,
														in fEvento date, in hEvento time, in lugEvento varchar(150))
		Begin
			Update Servicios_has_Empleados SHE
            set
            codigoServicio = codServicio,  
            codigoEmpleado = codEmpleado,
			fechaEvento = fEvento, 
            horaEvento = hEvento, 
            lugarEvento = lugEvento 
            Where Servicios_codigoServicio = Serv_codigoServicio;
        End$$
Delimiter ;

call sp_EditarServicios_has_Empleados(902, 3, 4, '2023-03-09', '07:55', '6-96, Valle la Mariposa');
