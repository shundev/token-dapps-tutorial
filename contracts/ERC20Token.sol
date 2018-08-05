pragma solidity^ 0.4.24;

/**
 * Overflow / Underflow safe math
 */
library SafeMath {
    function mul(uint256 a, uint256 b) internal pure returns (uint256 c) {
        c = a * b;
        require(c / a == b, "Overflow");
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "Underflow");
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256 c) {
        c = a + b;
        require(c >= a, "Overflow");
        return c;
    }
}

/**
 * The interface to be required to implement for ERC20.
 * https://theethereum.wiki/w/index.php/ERC20_Token_Standard
 */
contract ERC20Interface {

    /**
     * How much token in total.
     */
    function totalSupply() public view returns (uint256);

    /**
     * Get the balance of `owner`.
     */
    function balanceOf(address owner) public view returns (uint256);

    /**
     * Get the allowance of `owner` to `spender`.
     */
    function allowance(address owner, address spender) public view returns (uint256);

    /**
     * Transfer the ownership of token in the amount of `value` from "me" to `to`.
     */
    function transfer(address to, uint256 value) public returns (bool);

    /**
     * Approve to spend "my" token in the amount of `value` to `spender`.
     */
    function approve(address spender, uint256 value) public returns (bool);

    /**
     * Transfer the ownership ot the token in the amount of `value` from `from` to `to`.
     * You have to be allowed by `from` to call the function.
     */
    function transferFrom(address from, address to, uint256 value) public returns (bool);

    /**
     * Emitted when the ownership of token is transfered.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * Emitted when allowed to spend.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


/**
 * Actual ERC20 that can be distributed.
 * It must implement all the ERC20Interface.
 */
contract ERC20Token is ERC20Interface {
    using SafeMath for uint256;

    /**
     * Token name
     */
    string public name;

    /**
     * Token symbol like BTC, ETH and so on.
     */
    string public symbol;

    /**
     * How many digits next to '.'
     * If decimals is 0, 1000 token is displayed as 1000.
     * If 3, 1000 token is displayed as 1.000.
     * Use 18, same decimals as ETH, if you don't have a paticular reason.
     */
    uint8 public decimals;

    /**
     * Maps owner address to his balance
     */
    mapping(address => uint256) private balances;

    /**
     * Maps owner address to spender to be allowed and amount. 
     */
    mapping(address => mapping(address => uint256)) private allowed;

    /**
     * How many tokens you supply.
     */
    uint256 private totalSupply_;

    /**
     * constructor is a special function that is called to deploy the contract.
     * And it can be called only once when the contract is deployed.
     */
    constructor (string _name, string _symbol, uint8 _decimals, uint256 _initialSupply) public {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply_ = _initialSupply;
    }

    /**
     * Required for ERC20.
     * See totalSupply_ for understanding what it stands for.
     */
    function totalSupply() public view returns (uint256) {
        return totalSupply_;
    }

    /**
     * Requried for ERC20.
     * Get how many tokens to be allowed to be spend.
     */
    function allowance(address owner, address spender) public view returns (uint256) {
        return allowed[owner][spender];
    }

    /**
     * Required for ERC20.
     * Transfers token in the amount of `value` from "me"(`msg.sender`) to address `to`.
     * `msg.sender` is the caller of a function.
     */
    function transfer(address to, uint256 value) public returns (bool) {
        require(value <= balances[msg.sender], "You don't have enough balance to transfer.");
        require(to != address(0), "You can't to transfer to 0x0. Please specify the recipient address `to`.");

        balances[msg.sender] = balances[msg.sender].sub(value);
        balances[to] = balances[to].add(value);
        emit Transfer(msg.sender, to, value);
        return true;
    }

    /**
     * Required for ERC20.
     * Get the current balance of `owner`.
     */
    function balanceOf(address owner) public view returns (uint256) {
        return balances[owner];
    }

    /**
     * Required for ERC20.
     * Allow spender to spend "my" tokens.
     */
    function approve(address spender, uint256 amount) public returns (bool) {
        allowed[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    /**
     * Required for ERC20.
     * Transfer tokens from one address to another.
     */
    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        require(value <= balances[from], "`from`'s balance is insufficient.");
        require(value <= allowed[from][msg.sender], "You're not allowed to spend `from`'s token.");
        require(to != address(0), "`to` address is empty.");

        balances[from] = balances[from].sub(value);
        balances[to] = balances[to].add(value);
        allowed[from][msg.sender] = allowed[from][msg.sender].sub(value);
        emit Transfer(from, to, value);
        return true;
    }
}