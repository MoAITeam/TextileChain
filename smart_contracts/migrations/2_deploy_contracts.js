const Textile = artifacts.require("Textile");
const TextileFactory = artifacts.require("TextileFactory")

module.exports = function(deployer) {
  deployer.deploy(Textile).then(() => deployer.deploy(TextileFactory,Textile.address));

};
