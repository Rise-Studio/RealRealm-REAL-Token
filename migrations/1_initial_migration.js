const REALREALM = artifacts.require("REALREALM");

async function deployTestnet(deployer) {
  const REALREALMDeploy = await deployer.deploy(REALREALM);
  console.log(`Deploy: REALREALMDeploy Address = ${REALREALMDeploy.address}`);
}

module.exports = function (deployer) {
  deployer.then(async () => {
    console.log(deployer.network);
    switch (deployer.network) {
      case "bsctestnet":
        await deployTestnet(deployer);
        break;
      case "bscmainnet":
        await deployTestnet(deployer);
        break;
      default:
        throw "Unsupported network";
    }
  });
};
