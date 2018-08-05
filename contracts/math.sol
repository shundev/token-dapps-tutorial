pragma solidity^ 0.4.24;

/**
 * Overflow / Underflow safe math
 */
library SafeMath {
    function mul(uint256 a, uint256 b) internal pure returns (uint256 c) {
        // It's cheaper not to check `b`.
        if (a == 0) {
            return 0;
        }

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
