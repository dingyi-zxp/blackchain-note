pragma solidity >=0.4.22 <0.7.0;
pragma experimental ABIEncoderV2;
import "./FoodInfoItem.sol";
import "./Distributor.sol";
import "./Producer.sol";
import "./Retailer.sol";


contract Trace is Producer, Distributor, Retailer{

        mapping (uint256 => address)  foods;//é£åæº¯æºidå°å·ä½é£åæº¯æºåçº¦çæ å°è¡¨
        uint[]  foodList;

        //æé å½æ°
        constructor(address producer, address distributor, address retailer) 
	public Producer(producer) 
	Distributor(distributor) 
	Retailer(retailer){

        }
        //çæé£åæº¯æºä¿¡æ¯æ¥å£
        //åªæProducerè½è°ç¨
        //name é£ååç§°
        //traceNumber é£åæº¯æºid
        //traceName å½åç¨æ·åç§°
	//quality å½åé£åè´¨é
        function newFood(string name, uint256 traceNumber, string traceName, uint8 quality) 
	public onlyProducer returns(address)
        {
            require(foods[traceNumber] == address(0), "traceNumber already exist");
            FoodInfoItem food = new FoodInfoItem(name, traceName, quality, msg.sender);
            foods[traceNumber] = food;
            foodList.push(traceNumber);
            return food;
        }

        //é£ååéè¿ç¨ä¸­å¢å æº¯æºä¿¡æ¯çæ¥å£
        //åªæDistributorè½è°ç¨
        //traceNumber é£åæº¯æºid
        //traceName å½åç¨æ·åç§°
        //quality å½åé£åè´¨é
        function addTraceInfoByDistributor(uint256 traceNumber, string traceName, uint8 quality) 
	public onlyDistributor returns(bool) {
            require(foods[traceNumber] != address(0), "traceNumber does not exist");
            return FoodInfoItem(foods[traceNumber]).addTraceInfoByDistributor( traceName, msg.sender, quality);
        }

        //é£ååºå®è¿ç¨ä¸­å¢å æº¯æºä¿¡æ¯çæ¥å£
        //åªæRetailerè½è°ç¨
        //traceNumber é£åæº¯æºid
        //traceName å½åç¨æ·åç§°
        //quality å½åé£åè´¨é
        function addTraceInfoByRetailer(uint256 traceNumber, string traceName, uint8 quality) 
	public onlyRetailer returns(bool) {
            require(foods[traceNumber] != address(0), "traceNumber does not exist");
            return FoodInfoItem(foods[traceNumber]).addTraceInfoByRetailer(traceName, msg.sender, quality);
        }

        //è·åé£åæº¯æºä¿¡æ¯æ¥å£
        //string[] ä¿å­é£åæµè½¬è¿ç¨ä¸­åä¸ªé¶æ®µçç¸å³ä¿¡æ¯
        //address[] ä¿å­é£åæµè½¬è¿ç¨åä¸ªé¶æ®µçç¨æ·å°åä¿¡æ¯ï¼åç¨æ·ä¸ä¸å¯¹åºï¼
        //uint8[] ä¿å­é£åæµè½¬è¿ç¨ä¸­åä¸ªé¶æ®µçç¶æåå
        function getTraceInfo(uint256 traceNumber) public constant returns(uint[], string[], address[], uint8[]) {
            require(foods[traceNumber] != address(0), "traceNumber does not exist");
            return FoodInfoItem(foods[traceNumber]).getTraceInfo();
        }

        function getFood(uint256 traceNumber) public constant returns(uint, string, string, string, address, uint8) {
            require(foods[traceNumber] != address(0), "traceNumber does not exist");
            return FoodInfoItem(foods[traceNumber]).getFood();
        }

        function getAllFood() public constant returns (uint[]) {
            return foodList;
        }
}