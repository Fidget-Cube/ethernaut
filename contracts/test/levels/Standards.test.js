const StandardsFactory = artifacts.require('./levels/StandardsFactory.sol')
const Standards = artifacts.require('./levels/Standards.sol')
const StandardsAttack = artifacts.require('./attacks/StandardsAttack.sol');

const Ethernaut = artifacts.require('./Ethernaut.sol')
const { BN, constants, expectEvent, expectRevert } = require('openzeppelin-test-helpers')
const utils = require('../utils/TestUtils')

contract('Standards', function(accounts) {

  let ethernaut
  let level
  let owner = accounts[1]
  let player = accounts[0]

  beforeEach(async function() {
    ethernaut = await Ethernaut.new();
    level = await StandardsFactory.new()
    await ethernaut.registerLevel(level.address)
  });

  it('should fail if the player didnt solve the level', async function() {
    const instance = await utils.createLevelInstance(ethernaut, level.address, player, Standards)
    const completed = await utils.submitLevelInstance(
      ethernaut,
      level.address,
      instance.address,
      player
    )

    assert.isFalse(completed)
  });

  it('should allow the player to solve the level', async function() {

    const instance = await utils.createLevelInstance(
      ethernaut, level.address, player, Standards,
      {from: player}
    )

    const attacker = await StandardsAttack.new();
    await attacker.exploit(instance.address);

    // Factory check
    const ethCompleted = await utils.submitLevelInstance(
      ethernaut,
      level.address,
      instance.address,
      player
    )
    assert.equal(ethCompleted, true)
  });
});
