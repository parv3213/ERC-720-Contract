pragma solidity ^0.5.7;

library AddressUtils
{

  /**
   * @dev Returns whether the target address is a contract.
   * @param _addr Address to check.
   * @return addressCheck True if _addr is a contract, false if not.
   */
  function isContract(
    address _addr
  )
    internal
    view
    returns (bool addressCheck)
  {
    // This method relies in extcodesize, which returns 0 for contracts in
    // construction, since the code is only stored at the end of the
    // constructor execution.

    // According to EIP-1052, 0x0 is the value returned for not-yet created accounts
    // and 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470 is returned
    // for accounts without code, i.e. `keccak256('')`
    bytes32 codehash;
    bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
    assembly { codehash := extcodehash(_addr) } // solhint-disable-line
    addressCheck = (codehash != 0x0 && codehash != accountHash);
  }
}
  interface ERC721TokenReceiver {
            /// @notice Handle the receipt of an NFT
            /// @dev The ERC721 smart contract calls this function on the
            /// recipient after a `transfer`. This function MAY throw to revert and reject the transfer. Return
            /// of other than the magic value MUST result in the transaction being reverted.
            /// @notice The contract address is always the message sender.
            /// @param _operator The address which called `safeTransferFrom` function
            /// @param _from The address which previously owned the token
            /// @param _tokenId The NFT identifier which is being transferred
            /// @param _data Additional data with no specified format
            /// @return `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
            /// unless throwing
            function onERC721Received(address _operator, address _from, uint256 _tokenId, bytes calldata _data) external returns(bytes4);
         }


        /// @title ERC-721 Non-Fungible Token Standard
        /// @dev See https://github.com/ethereum/EIPs/blob/master/EIPS/eip-721.md
        ///  Note: the ERC-165 identifier for this interface is 0x80ac58cd
        interface ERC721 /* is ERC165 */ {
            /// @dev This emits when ownership of any NFT changes by any mechanism.
            ///  This event emits when NFTs are created (`from` == 0) and destroyed
            ///  (`to` == 0). Exception: during contract creation, any number of NFTs
            ///  may be created and assigned without emitting Transfer. At the time of
            ///  any transfer, the approved address for that NFT (if any) is reset to none.
            event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);

            /// @dev This emits when the approved address for an NFT is changed or
            ///  reaffirmed. The zero address indicates there is no approved address.
            ///  When a Transfer event emits, this also indicates that the approved
            ///  address for that NFT (if any) is reset to none.
            event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);

            /// @dev This emits when an operator is enabled or disabled for an owner.
            ///  The operator can manage all NFTs of the owner.
            event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

            /// @notice Count all NFTs assigned to an owner
            /// @dev NFTs assigned to the zero address are considered invalid, and this
            ///  function throws for queries about the zero address.
            /// @param _owner An address for whom to query the balance
            /// @return The number of NFTs owned by `_owner`, possibly zero
            function balanceOf(address _owner) external view returns (uint256);

            /// @notice Find the owner of an NFT
            /// @dev NFTs assigned to zero address are considered invalid, and queries
            ///  about them do throw.
            /// @param _tokenId The identifier for an NFT
            /// @return The address of the owner of the NFT
            function ownerOf(uint256 _tokenId) external view returns (address);

            /// @notice Transfers the ownership of an NFT from one address to another address
            /// @dev Throws unless `msg.sender` is the current owner, an authorized
            ///  operator, or the approved address for this NFT. Throws if `_from` is
            ///  not the current owner. Throws if `_to` is the zero address. Throws if
            ///  `_tokenId` is not a valid NFT. When transfer is complete, this function
            ///  checks if `_to` is a smart contract (code size > 0). If so, it calls
            ///  `onERC721Received` on `_to` and throws if the return value is not
            ///  `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`.
            /// @param _from The current owner of the NFT
            /// @param _to The new owner
            /// @param _tokenId The NFT to transfer
            /// @param data Additional data with no specified format, sent in call to `_to`
            function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes calldata data) external payable;

            /// @notice Transfers the ownership of an NFT from one address to another address
            /// @dev This works identically to the other function with an extra data parameter,
            ///  except this function just sets data to ""
            /// @param _from The current owner of the NFT
            /// @param _to The new owner
            /// @param _tokenId The NFT to transfer
            function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable;

            /// @notice Transfer ownership of an NFT -- THE CALLER IS RESPONSIBLE
            ///  TO CONFIRM THAT `_to` IS CAPABLE OF RECEIVING NFTS OR ELSE
            ///  THEY MAY BE PERMANENTLY LOST
            /// @dev Throws unless `msg.sender` is the current owner, an authorized
            ///  operator, or the approved address for this NFT. Throws if `_from` is
            ///  not the current owner. Throws if `_to` is the zero address. Throws if
            ///  `_tokenId` is not a valid NFT.
            /// @param _from The current owner of the NFT
            /// @param _to The new owner
            /// @param _tokenId The NFT to transfer
            function transferFrom(address _from, address _to, uint256 _tokenId) external payable;

            /// @notice Set or reaffirm the approved address for an NFT
            /// @dev The zero address indicates there is no approved address.
            /// @dev Throws unless `msg.sender` is the current NFT owner, or an authorized
            ///  operator of the current owner.
            /// @param _approved The new approved NFT controller
            /// @param _tokenId The NFT to approve
            function approve(address _approved, uint256 _tokenId) external payable;

            /// @notice Enable or disable approval for a third party ("operator") to manage
            ///  all of `msg.sender`'s assets.
            /// @dev Emits the ApprovalForAll event. The contract MUST allow
            ///  multiple operators per owner.
            /// @param _operator Address to add to the set of authorized operators.
            /// @param _approved True if the operator is approved, false to revoke approval
            function setApprovalForAll(address _operator, bool _approved) external;

            /// @notice Get the approved address for a single NFT
            /// @dev Throws if `_tokenId` is not a valid NFT
            /// @param _tokenId The NFT to find the approved address for
            /// @return The approved address for this NFT, or the zero address if there is none
            function getApproved(uint256 _tokenId) external view returns (address);

            /// @notice Query if an address is an authorized operator for another address
            /// @param _owner The address that owns the NFTs
            /// @param _operator The address that acts on behalf of the owner
            /// @return True if `_operator` is an approved operator for `_owner`, false otherwise
            function isApprovedForAll(address _owner, address _operator) external view returns (bool);
        }

contract ERC721Token is ERC721{
    
    using AddressUtils for address;

    mapping(address => uint) private ownerToTokenCount;
    mapping(uint => address) private idToOwner;
    mapping(uint => address) private idToApproved;
    mapping(address => mapping(address => bool)) private ownerToOperators;
    bytes4 internal constant MAGIC_ON_ERC721_RECEIVED = 0x150b7a02;
    
    modifier canTransfer(uint _tokenId) {
        require(msg.sender == idToOwner[_tokenId] 
            || msg.sender == idToApproved[_tokenId]
            || true == ownerToOperators[idToOwner[_tokenId]][msg.sender],
            "Not authorized");
        _;
    }
    
    function balanceOf(address _owner) external view returns (uint256){
        return ownerToTokenCount[_owner];
    }
    
    function ownerOf(uint256 _tokenId) external view returns (address){
        return idToOwner[_tokenId];
    }
    
    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes calldata data) external payable {
        _safeTransferFrom(_from,_to,_tokenId,data);
    }
    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable{
      _safeTransferFrom(_from,_to,_tokenId, "");
    }
    
    function transferFrom(address _from, address _to, uint256 _tokenId) external payable{
        _transfer(_from, _to, _tokenId);
    }

    function approve(address _approved, uint256 _tokenId) external payable{
        address owner = idToOwner[_tokenId];
        require(msg.sender == owner, "Not authorized");
        idToApproved[_tokenId] = _approved;
        emit Approval(msg.sender, _approved, _tokenId);
    }
    
    function setApprovalForAll(address _operator, bool _approved) external{
        ownerToOperators[msg.sender][_operator] = _approved;
        emit ApprovalForAll( msg.sender, _operator, _approved);
    }
    
    function getApproved(uint256 _tokenId) external view returns (address){
        return idToApproved[_tokenId];
    }
    
    function isApprovedForAll(address _owner, address _operator) external view returns (bool){
        return ownerToOperators[_owner][_operator];
    }

    function _safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory data) internal {
        _transfer(_from, _to, _tokenId);
        if(_to.isContract()){
            bytes4 retval = ERC721TokenReceiver(_to).onERC721Received(msg.sender, _from, _tokenId, data);
            require(retval == MAGIC_ON_ERC721_RECEIVED, "Recipient SC does not handle ERC721 token");
        }
    }

    function _transfer(address _from, address _to, uint _tokenId) internal canTransfer(_tokenId) {
        ownerToTokenCount[_from] -= 1;
        ownerToTokenCount[_to] += 1; 
        idToOwner[_tokenId] = _to;
        emit Transfer(_from,_to,_tokenId);
    }
}