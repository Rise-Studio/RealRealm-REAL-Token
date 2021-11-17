// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Snapshot.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract REALREALM is
  ERC20,
  ERC20Snapshot,
  Ownable,
  Pausable
{
  constructor() ERC20("REAL REALM", "REAL") {
    _mint(
      0x99dB552C7f2CE441F25feD8317D74f9f10F26213,
      1000000000 * 10**decimals()
    ); // Seed Sale - 30.000.000 - 3%

    transferOwnership(0xC335B4832493Ec8AaEf44Ff40E81e64c4555CD57);
  }

  function snapshot() public onlyOwner {
    _snapshot();
  }

  function pause() public onlyOwner {
    _pause();
  }

  function unpause() public onlyOwner {
    _unpause();
  }

  function _beforeTokenTransfer(
    address from,
    address to,
    uint256 amount
  ) internal override(ERC20, ERC20Snapshot) whenNotPaused {
    super._beforeTokenTransfer(from, to, amount);
  }

  // The following functions are overrides required by Solidity.

  function _afterTokenTransfer(
    address from,
    address to,
    uint256 amount
  ) internal override(ERC20) {
    super._afterTokenTransfer(from, to, amount);
  }

  function _mint(address to, uint256 amount)
    internal
    override(ERC20)
  {
    super._mint(to, amount);
  }

  function _burn(address account, uint256 amount)
    internal
    override(ERC20)
  {
    super._burn(account, amount);
  }

  /* ========== EMERGENCY ========== */
  /*
    Users make mistake by transfering usdt/usdt ... to contract address. 
    This function allows contract owner to withdraw those tokens and send back to users.
    */
  function rescueStuckErc20(address _token) external onlyOwner {
    uint256 _amount = ERC20(_token).balanceOf(address(this));
    ERC20(_token).transfer(owner(), _amount);
  }
}
