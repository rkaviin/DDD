package topOrder
{
	import mx.collections.ArrayCollection;
	import mx.collections.SortField;
	
	import spark.collections.Sort;
	
	public class TopOrder
	{
		// ----------------------
		// Variable Declaration
		// ----------------------
		public var MAX_COUNT:int = 40;
		private var _dataProvider:ArrayCollection = null;
		
		[Bindable] private var _dataProviderTopType:Object = null;
		
		private var _topTypeId:int = -1;
		
		// --------------
		// Constructor
		// --------------
		public function TopOrder()
		{
			_dataProviderTopType = new Object();
			dataProvider = new ArrayCollection();
		}
		
		[Bindable]
		public function get topTypeId():int
		{
			return _topTypeId;
		}
		
		/**
		 * 1 - Physician, 2 - Hospital, 3 - Community 
		 */
		public function set topTypeId(value:int):void
		{
			_topTypeId = value;
			
			if (_dataProviderTopType.hasOwnProperty(value)){
				dataProvider = _dataProviderTopType[value];
			}
			else {
				dataProvider = _dataProviderTopType[value] = new ArrayCollection();
			}
		}
		
		[Bindable]
		public function get dataProvider():ArrayCollection
		{
			return _dataProvider;
		}
		
		public function set dataProvider(value:ArrayCollection):void
		{
			_dataProvider = value;
			
			if(_dataProviderTopType.hasOwnProperty(topTypeId)){
				_dataProviderTopType[topTypeId] = value;
			}
		}
		
		public function addItem(itemArray:Array, paramID:String, paramCount:String):void
		{
			for (var i:int = 0; i < itemArray.length; i++) 
			{
				var itemAvail:Boolean = false;
				
				for (var j:int = 0; j < dataProvider.length; j++) 
				{
					if (itemArray[i][paramID] == dataProvider[j][paramID]) {
						itemAvail = true;
						dataProvider[j][paramCount] = Number(dataProvider[j][paramCount]) + 1; 
						break;
					}
				}
				
				if (!itemAvail && dataProvider.length < MAX_COUNT) {
					itemArray[i][paramCount] = 1;
					dataProvider.addItem(itemArray[i]);
				}
			}
		}
		
		public function getSortFunction(sortField:String):Sort
		{
			var sort:Sort= new Sort();
			sort.fields = [new SortField(sortField,false,true,true)];
			
			return sort;
		}
	}
}