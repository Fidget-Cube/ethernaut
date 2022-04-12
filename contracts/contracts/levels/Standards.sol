// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        require(c / a == b);
        return c;
    }
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0);
        uint256 c = a / b;
        return c;
    }
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a);
        uint256 c = a - b;
        return c;
    }
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a);
        return c;
    }
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0);
        return a % b;
    }
}

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        // solhint-disable-next-line no-inline-assembly
        assembly { size := extcodesize(account) }
        return size > 0;
    }
}

/**
 * @title ERC20Basic
 * @dev Simpler version of ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/179
 */
contract ERC20Basic {
  using SafeMath for uint256;

  uint256 public totalSupply;
  mapping(address => uint256) internal balances;

  /**
   * @dev Gets the balance of the specified address.
   * @param who The address to query the balance of.
   * @return An uint256 representing the amount of tokens owned by the passed address.
   */
  function balanceOf(address who) public view returns (uint256) {
      return balances[who];
  }

  /**
   * @dev transfer token for a specified address
   * @param to The address to transfer to.
   * @param value The amount to be transferred.
   */
  function transfer(address to, uint256 value) public returns (bool) {
      require(to != address(0));
      require(balances[msg.sender] >= value, "Not Enough Funds");

      balances[msg.sender] = balances[msg.sender].sub(value);
      balances[to] = balances[to].add(value);

      emit Transfer(msg.sender, to, value);
      return true;
  }
  
  event Transfer(address indexed from, address indexed to, uint256 value);
}

/**
 * @title ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/20
 */
contract ERC20 is ERC20Basic {
  mapping(address => mapping(address => uint256)) internal allowed;

  /**
   * @dev Function to check the amount of tokens that an owner allowed to a spender.
   * @param owner The address which owns the funds.
   * @param spender The address which will spend the funds.
   * @return A uint256 specifying the amount of tokens still available for the spender.
   */
  function allowance(address owner, address spender) public view returns (uint256) {
      return allowed[owner][spender];
  }

  /**
   * @dev Transfer tokens from one address to another.
   * @param from The address which you want to send tokens from.
   * @param to The address which you want to transfer to.
   * @param value The amount of tokens to be transferred.
   */
  function transferFrom(address from, address to, uint256 value) public returns (bool) {
      require(to != address(0));
      require(balances[from] >= value, "Not Enough Funds");
      require(allowed[from][msg.sender] >= value, "Not allowed to tranfer that many tokens.");

      balances[from] = balances[from].sub(value);
      balances[to] = balances[to].add(value);
      allowed[from][msg.sender] = allowed[from][msg.sender].sub(value);

      emit Transfer(from, to, value);
      return true;
  }

  /**
   * @dev Approve the passed address to spend the specified amount of tokens on behalf of msg.sender.
   *
   * Beware that changing an allowance with this method brings the risk that someone may use both the old
   * and the new allowance by unfortunate transaction ordering. One possible solution to mitigate this
   * race condition is to first reduce the spender's allowance to 0 and set the desired value afterwards:
   * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
   * @param spender The address which will spend the funds.
   * @param value The amount of tokens to be spent.
   */
  function approve(address spender, uint256 value) public returns (bool) {
      allowed[msg.sender][spender] = value;
      emit Approval(msg.sender, spender, value);
      return true;
  }

  event Approval(address indexed owner, address indexed spender, uint256 value);
}

interface ConfirmationContract {
    function onERC20Received() external returns (uint256);
}

contract Standards is ERC20 {
  using Address for address payable;

  uint256 public constant decimals = 18;
  uint256 public constant initialSupply = 10_000_000_000 * (10 ** decimals); // Safemath not required here

  constructor() public {
      totalSupply = initialSupply;
      balances[address(this)] = initialSupply;
  }

  function permitFunds(uint256 value) public returns (bool) {
      require(msg.sender.isContract(), "Function caller is not contract.");
      ConfirmationContract cc = ConfirmationContract(msg.sender);
      uint256 retval = cc.onERC20Received();
      require(retval == 519725, "Contract ERC20 receiver implemented incorrectly.");
      return this.approve(msg.sender, value);
  }
}
