CREATE DATABASE farmacia;
use farmacia;
show tables;

CREATE TABLE orden_venta (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fecha_emision DATE,
    motivo TEXT,
    situacion VARCHAR(100)
)
CREATE TABLE especialidad (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    descripcion TEXT
)
CREATE TABLE medicamento_tipo (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    descripcion TEXT
)
CREATE TABLE medicamento(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    descripcion TEXT,
    fecha_fabricacion DATE,
    fecha_vencimiento DATE,
    presentacion VARCHAR(200),
    stok VARCHAR(50),
    precio_venta_uni DECIMAL,
    precio_venta_press DECIMAL,
    marca VARCHAR(50),
    especialidad_id INT,
    FOREIGN KEY (especialidad_id) REFERENCES especialidad(id)
    tipo_medicamento_id INT,
    FOREIGN KEY (tipo_medicamento_id) REFERENCES medicamento_tipo(id)
)
CREATE TABLE detalle_orden_venta(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cantidad_requerida INT,
    venta_id INT,
    medicamento_id INT,
    FOREIGN KEY (venta_id) REFERENCES orden_venta(id),
    FOREIGN KEY (medicamento_id) REFERENCES medicamento(id)
)
CREATE TABLE laboratorio(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    razon_social VARCHAR(255),
    direccion VARCHAR(200),
    telefono VARCHAR(9),
    email VARCHAR(50),
    contacto VARCHAR(10)
)
CREATE TABLE orden_compra(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fecha_emision DATE,
    situacion VARCHAR(200),
    nro_factura_prov INT,
    laboratorio_id INT,
    FOREIGN KEY (laboratorio_id) REFERENCES laboratorio(id)
)

CREATE TABLE detalle_orden_compra (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    descripcion TEXT,
    candidad INT,
    precio DECIMAL,
    monto_uni INT,
    medicamento_id INT,
    FOREIGN KEY (medicamento_id) REFERENCES medicamento(id),
    orden_compra_id INT,
    FOREIGN KEY (orden_compra_id) REFERENCES orden_compra(id)
)

-- Insert data
INSERT INTO orden_venta (fecha_emision, motivo, situacion)
VALUES
(CURDATE(), 'Venta regular', 'Completada'),
(CURDATE() - INTERVAL 1 DAY, 'Venta urgente', 'Pendiente'),
(CURDATE() - INTERVAL 2 DAY, 'Devolución', 'Cancelada');

INSERT INTO especialidad (descripcion)
VALUES
('Cardiología'),
('Dermatología'),
('Neurología');

INSERT INTO medicamento_tipo (descripcion)
VALUES
('Antibiótico'),
('Analgesico'),
('Antiinflamatorio');

INSERT INTO medicamento (descripcion, fecha_fabricacion, fecha_vencimiento, presentacion, stok, precio_venta_uni, precio_venta_press, marca, especialidad_id, tipo_medicamento_id)
VALUES
('Amoxicilina', '2023-01-01', '2025-01-01', 'Cápsulas', '100', 10.00, 100.00, 'Genérico', 1, 1),
('Ibuprofeno', '2023-02-01', '2025-02-01', 'Tabletas', '200', 5.00, 90.00, 'Bayer', 2, 2),
('Diclofenaco', '2023-03-01', '2025-03-01', 'Gel', '150', 15.00, 135.00, 'Genérico', 3, 3);

INSERT INTO detalle_orden_venta (cantidad_requerida, venta_id, medicamento_id)
VALUES
(2, 1, 1),
(3, 1, 2),
(1, 2, 3);

INSERT INTO laboratorio (razon_social, direccion, telefono, email, contacto)
VALUES
('LabCorp', '1234 Main St', '123456789', 'info@labcorp.com', 'Luis'),
('BioTest', '2345 Second St', '987654321', 'contact@biotest.com', 'Ana');

INSERT INTO orden_compra (fecha_emision, situacion, nro_factura_prov, laboratorio_id)
VALUES
(CURDATE(), 'En proceso', 123456, 1),
(CURDATE() - INTERVAL 5 DAY, 'Recibida', 654321, 2);

INSERT INTO detalle_orden_compra (descripcion, candidad, precio, monto_uni, medicamento_id, orden_compra_id)
VALUES
('Compra de Amoxicilina', 10, 9.00, 90, 1, 1),
('Compra de Ibuprofeno', 20, 4.50, 90, 2, 2);
