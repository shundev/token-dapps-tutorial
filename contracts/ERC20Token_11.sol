pragma solidity^ 0.4.24;

/**
 * 2. Implementation of a token smart contract 
 *   11. Additional functions to satisfy ERC20 spec.
 *     - approve
 *     - transferFrom
 *     - allowance
 */


/**
 * Actual ERC20 that can be distributed.
 * It must implement all the ERC20Interface.
 */
contract ERC20Token {
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
     * How much token you wait to create.
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
     * See _totalSupply for understanding what it stands for.
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

        balances[msg.sender] -= value;
        balances[to] += value;
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

        balances[from] -= value;
        balances[to] += value;
        allowed[from][msg.sender] -= value;
        emit Transfer(from, to, value);
        return true;
    }
}
