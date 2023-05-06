// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.0;

import "./Ownable.sol";
import "hardhat/console.sol";

abstract contract Constants {
    bool public constant getTradingMode = true;

    uint8 internal constant UNKNOWN = 0;
    uint8 internal constant BASIC_PAYMENT = 1;
    uint8 internal constant REFUND = 2;
    uint8 internal constant DIVIDEND = 3;
    uint8 internal constant GROUP_PAYMENT = 4;
}

contract GasContract is Ownable, Constants {
    address internal immutable contractOwner;

    uint256 public totalSupply = 0; // cannot be updated
    uint256 internal paymentCounter = 0;

    struct Payment {
        uint8 paymentType;
        string recipientName; // max 8 characters
        bool adminUpdated;
        address recipient;
        address admin; // administrators address
        uint256 paymentID;
        uint256 amount;
    }

    struct History {
        uint256 lastUpdate;
        address updatedBy;
        uint256 blockNumber;
    }

    struct ImportantStruct {
        uint16 valueA; // max 3 digits
        uint16 valueB; // max 3 digits
        uint256 bigValue;
    }

    History[] internal paymentHistory; // when a payment was updated

    mapping(address => uint256) internal balances;
    mapping(address => Payment[]) internal payments;
    mapping(address => uint256) public whitelist;
    mapping(uint256 => address) public administrators;

    event AddedToWhitelist(address userAddress, uint256 tier);
    event supplyChanged(address indexed, uint256 indexed);
    event Transfer(address recipient, uint256 amount);
    event PaymentUpdated(
        address admin,
        uint256 ID,
        uint256 amount,
        string recipient
    );
    event WhiteListTransfer(address indexed);

    modifier onlyAdminOrOwner() {
        require(
            _checkForAdmin() || msg.sender == contractOwner,
            "Caller not approved"
        );
        _;
    }

    modifier checkIfWhiteListed() {
        uint256 usersTier = whitelist[msg.sender];
        require(usersTier > 0 && usersTier < 4, "User tier invalid");
        _;
    }

    constructor(address[] memory _admins, uint256 _totalSupply) {
        address _admin;
        totalSupply = _totalSupply;

        for (uint256 ii = 0; ii < 5; ii++) {
            _admin = _admins[ii];

            if (_admin != address(0)) {
                administrators[ii] = _admin;

                if (_admin == msg.sender) {
                    balances[_admin] = _totalSupply;
                    emit supplyChanged(_admin, _totalSupply);
                } else {
                    balances[_admin] = 0;
                    emit supplyChanged(_admin, 0);
                }
            }
        }

        contractOwner = msg.sender;
    }

    function balanceOf(address _user) external view returns (uint256 balance_) {
        uint256 balance = balances[_user];
        return balance;
    }

    function getPayments(
        address _user
    ) external view returns (Payment[] memory) {
        return payments[_user];
    }

    function transfer(
        address _recipient,
        uint256 _amount,
        string calldata _name
    ) external returns (bool) {
        address senderOfTx = msg.sender;

        require(balances[senderOfTx] >= _amount, "Sender balance insufficient");
        require(bytes(_name).length < 9, "Recipient name exceeds 8 chars");

        balances[senderOfTx] -= _amount;
        balances[_recipient] += _amount;

        emit Transfer(_recipient, _amount);

        payments[senderOfTx].push(
            Payment({
                admin: address(0),
                adminUpdated: false,
                paymentType: BASIC_PAYMENT,
                recipient: _recipient,
                amount: _amount,
                recipientName: _name,
                paymentID: ++paymentCounter
            })
        );

        return true;
    }

    function updatePayment(
        address _user,
        uint256 _ID,
        uint256 _amount,
        uint8 _type
    ) external onlyAdminOrOwner {
        require(_ID > 0, "ID must be greater than 0");
        require(_amount > 0, "Amount must be greater than 0");
        require(_user != address(0), "Admin must be nonzero address");

        Payment[] storage userPayments = payments[_user];

        for (uint256 ii = 0; ii < payments[_user].length; ii++) {
            Payment storage userPayment = userPayments[ii];

            if (userPayment.paymentID == _ID) {
                userPayment.adminUpdated = true;
                userPayment.admin = _user;
                userPayment.paymentType = _type;
                userPayment.amount = _amount;

                _addHistory(_user);

                emit PaymentUpdated(
                    msg.sender,
                    _ID,
                    _amount,
                    userPayment.recipientName
                );
            }
        }
    }

    function addToWhitelist(
        address _userAddrs,
        uint256 _tier
    ) external onlyAdminOrOwner {
        require(_tier < 255, "Tier must be less than 256");

        whitelist[_userAddrs] = _tier > 3 ? 3 : _tier;

        emit AddedToWhitelist(_userAddrs, _tier);
    }

    function whiteTransfer(
        address _recipient,
        uint256 _amount,
        ImportantStruct memory
    ) external checkIfWhiteListed {
        require(_amount > 3, "Amount must be greater than 3");
        address senderOfTx = msg.sender;

        balances[senderOfTx] -= _amount;
        balances[senderOfTx] += whitelist[senderOfTx];

        balances[_recipient] += _amount;
        balances[_recipient] -= whitelist[senderOfTx];

        emit WhiteListTransfer(_recipient);
    }

    function _checkForAdmin() internal view returns (bool admin_) {
        for (uint256 ii = 0; ii < 5; ii++) {
            if (administrators[ii] == msg.sender) {
                return true;
            }
        }
    }

    function _addHistory(address _updateAddress) internal {
        paymentHistory.push(
            History({
                blockNumber: block.number,
                lastUpdate: block.timestamp,
                updatedBy: _updateAddress
            })
        );
    }
}
