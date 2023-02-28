pragma solidity >=0.4.22 <0.9.0;

contract Textile {

	address private current_owner;
	address private manufacturer;
	address [] private textile_components;
	string private factory_name;
	string private factory_location;
	string private factory_date;
	string private product_name;

	bool private is_component = false;
	bool private is_init = false;
	bool private is_final_product = false;


	constructor(){
		is_init = true;
	}

	modifier notInit(){
		require(is_init,'Product shoul be initialized');
		_;
	}

	modifier onlyOwner(){
        require(msg.sender == current_owner, "you are not the owner of this contract");
        _;
    }

	modifier isFinalProduct(){
		require(is_final_product,'Product shoul be initialized');
		_;
	}

	modifier isNotFinalProduct(){
		require(!is_final_product,'Product should be initialized');
		_;
	}


	modifier isNotConsumed(){
		require(!is_component,'Product shoul be initialized');
		_;
	}

	event productExchanged(address previous_address, address current_address);

    function init(address _current_owner, string calldata _product_name, string calldata _factory_name, string calldata _factory_location, string calldata _factory_date) external notInit {
        product_name = _product_name;
		current_owner = _current_owner;
		factory_name = _factory_name;
		factory_location = _factory_location;
		factory_date = _factory_date;

        is_init = true; 
    }

	function productExchange() external onlyOwner isNotConsumed {

		address old_address = current_owner;
		current_owner = msg.sender;

		emit productExchanged(old_address, current_owner);

	}

	function addComponent(address component) external onlyOwner isNotFinalProduct {

		textile_components.push(component);
	}

	function consumeProduct() external onlyOwner isNotConsumed {
		
		is_component = true;
	}

	function finalProduct() external onlyOwner{

		is_final_product = true;
	}

	function getProductDetails() external view returns(string memory, address, string memory, string memory, string memory){
        return (product_name,manufacturer,factory_name,factory_location,factory_date);
    }
} 