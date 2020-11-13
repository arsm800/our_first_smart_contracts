pragma solidity ^0.5.0;

//Import SafeMath
import "github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/math/SafeMath.sol";

// lvl 2: tiered split
contract TieredProfitSplitter {
    
    using SafeMath for uint;
    
    address payable employee_one; // ceo
    address payable employee_two; // cto
    address payable employee_three; // bob

    constructor(address payable _one, address payable _two, address payable _three) public {
        employee_one = _one;
        employee_two = _two;
        employee_three = _three;
    }

    // Should always return 0! Use this to test your `deposit` function's logic
    function balance() public view returns(uint) {
        return address(this).balance;
    }

    function deposit() public payable {
        uint points = msg.value / 100; // Calculates rudimentary percentage by dividing msg.value into 100 units
        uint total;
        uint amount;

        //Calculate and transfer the distribution percentage
        //Set amount to equal `points` * the number of percentage points for this employee
        amount = points * 15;
        
        //Add the `amount` to `total` to keep a running total
        total = total.add(amount);
        
        //Transfer the `amount` to the employee
        employee_three.transfer(amount);

        //Repeat the previous steps for `employee_two`
        amount = points * 25;
        total = total.add(amount);
        
        employee_two.transfer(amount);
        
        //Transfer remaining balance to CE) (employee_one)
        employee_one.transfer(msg.value - total);
    }

    function() external payable {
        deposit();
    }
}