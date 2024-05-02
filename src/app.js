const express = require("express");
require("dotenv").config();
const Sequelize = require("sequelize");
const { Json } = require("sequelize/lib/utils");
const app = express();

//definimos los parametros de conexión
const sequelize = new Sequelize(
  process.env.DB_NAME,
  process.env.DB_USER,
  process.env.DB_PASSWORD,
  {
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    dialect: "mysql",
  }
);

const OrdenVenta = sequelize.define('orden_venta', {
    id: { type: Sequelize.INTEGER, primaryKey: true, autoIncrement: true },
    fecha_emision: Sequelize.DATE,
    motivo: Sequelize.TEXT,
    situacion: Sequelize.STRING
  }, {
    timestamps: false 
  });
  
// Insertar una nueva orden de venta
OrdenVenta.create({
  fecha_emision: new Date(), // usa la fecha actual
  motivo: "Venta de productos farmacéuticos",
  situacion: "En proceso",
})
  .then((nuevaOrden) => {
    console.log("Orden de Venta Insertada:", nuevaOrden);
  })
  .catch((error) => {
    console.error("Error al insertar la Orden de Venta:", error);
  });
OrdenVenta.findAll({
  attributes: ["id", "fecha_emision", "motivo", "situacion"],
}).then((ordenVentas) => {
  console.log(ordenVentas[0]);
});

//autentificamos
sequelize
  .authenticate()
  .then(() => {
    console.log("Connect Database successfully ");
  })

  .catch((error) => {
    console.log("error to connect database" + error);
  });

app.listen(3000, () => {
  console.log("Server run on port 3000");
});
