pragma solidity >=0.4.23 <0.9.0;

contract Textile {

	address private current_owner;
	address private manufacturer;
	address [] private textile_components;
	string private factory_name;
	string private factory_location;
	string private factory_date;
	string private product_name;
	string private verification_id;

	bool private is_component = false;
	bool private is_init = false;
	bool private is_final_product = false;


	constructor() public {
		is_init = true;
	}

	modifier onlyOwner(){
        require(msg.sender == current_owner, "you are not the owner of this contract");
        _;
    }

	modifier isFinalProduct(){
		require(is_final_product,'Product shoul be a garment');
		_;
	}

	modifier isNotFinalProduct(){
		require(!is_final_product,'Product should not be a garment');
		_;
	}


    function init(address _current_owner, string _product_name, string _factory_name, string _factory_location, string _factory_date, string _verification_id) external  {
        product_name = _product_name;
		current_owner = _current_owner;
		factory_name = _factory_name;
		factory_location = _factory_location;
		factory_date = _factory_date;
		verification_id = _verification_id;

        is_init = true; 
    }

	function getIsFinalProduct() external view returns(bool final_product){
		return is_final_product;
	}

	
    function getName() external view returns(string memory){
        return product_name;
    }

	function addComponent(address component) external onlyOwner isNotFinalProduct {

		textile_components.push(component);
	}



	function finalProduct() external onlyOwner{

		is_final_product = true;
	}

	function getProductDetails() external view returns(string memory, address, string memory, string memory, string memory){
        return (product_name,manufacturer,factory_name,factory_location,factory_date);
    }

	function getManufacturer() external view returns(address, string memory){
        return (manufacturer, factory_name);
    }

    function getProductionLocation() external view returns(string memory){
        return factory_location;
    }

    function getProductionDate() external view returns(string memory){
        return factory_date;
    }

    function getComponents() external view returns(address[] memory){
        return textile_components;
    }
} 