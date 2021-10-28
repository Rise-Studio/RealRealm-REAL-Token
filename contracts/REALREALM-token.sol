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
      0xfFC8562d79073Bb64F8ad9E626Bff5B97884b41e,
      30000000 * 10**decimals()
    ); // Seed Sale - 30.000.000 - 3%
    _mint(
      0x3e9BC83779b0c8eB9B0bCE9cf980Ce4630fcbb94,
      120000000 * 10**decimals()
    ); // Private Sale - 120.000.000
    _mint(
      0x508bf5CA461b1b7e3C55FF64d4D396EaEcA0489D,
      12000000 * 10**decimals()
    ); // Public Sale - 12.000.000
    _mint(
      0x47dA2d7674FdFa8e16ef0EE306c337f0F4548806,
      250000000 * 10**decimals()
    ); // Game Rewards - 250.000.000
    _mint(
      0x2d082504DF6d138Bdc669cc7914D0B16df863dd9,
      93000000 * 10**decimals()
    ); // Staking Rewards - 93.000.000
    _mint(
      0x76B7d23274B73801327F22C2D2BA79E316500750,
      95000000 * 10**decimals()
    ); // Marketing - 95.000.000
    _mint(
      0x76B7d23274B73801327F22C2D2BA79E316500750,
      100000000 * 10**decimals()
    ); // Ecosystem - 100.000.000
    _mint(
      0x5A4010D01377A515F64633403F9cdaef91f8a631,
      100000000 * 10**decimals()
    ); // Liquidity - 100.000.000
    _mint(
      0x0D1Ba337c0f17322155EDDbc1c2f246d61698D40,
      150000000 * 10**decimals()
    ); // Team - 150.000.000
    _mint(
      0xFFEAd3439759FCC40738d21ae581a811a977a709,
      50000000 * 10**decimals()
    ); // Advisors & Partnership - 50.000.000
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
