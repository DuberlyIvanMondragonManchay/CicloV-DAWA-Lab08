module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.bulkInsert('Personas', [
      {
        nomCli: 'Duberly',
        apeCli: 'Mondragón',
        dirCli: 'Ate',
        dniCli: '77346433',
        createdAt: new Date(),
        updatedAt: new Date(),
      },
    ]);
  },
  down: (queryInterface, Sequelize) => {
    return queryInterface.bulkDelete('Personas', null, {});
  },
};