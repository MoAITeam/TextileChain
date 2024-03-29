pragma solidity >=0.4.23 <0.9.0;
import "./Textile.sol";
import "@optionality.io/clone-factory/contracts/CloneFactory.sol";

contract TextileFactory is CloneFactory {

  address public libraryAddress;

  event TextileCreated(address newTextileFactory);

  constructor(address _libraryAddress) public {
    libraryAddress = _libraryAddress;
  }
  
  function setLibraryAddress(address _libraryAddress) public {
    libraryAddress = _libraryAddress;
  }

  function createTextile(string _name, string  _factory_name, string  _factory_location, string  _factory_date, string _verification_id) public {
    address clone = createClone(libraryAddress);
    Textile(clone).init(msg.sender, _name, _factory_name, _factory_location, _factory_date, _verification_id);
    emit TextileCreated(clone);
  }
}