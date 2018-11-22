package topOrder
{
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;

	public class LabTopOrder
	{
		// ----------------------
		// Variable Declaration
		// ----------------------
		public var MAX_COUNT:int = 40;
		
		[Bindable] public var dataProvider:ArrayCollection = new ArrayCollection();
		
		public function LabTopOrder()
		{
			setSorting();
		}
		
		// ----------------------
		// Service Validation
		// ----------------------
		/**
		 * validation Function will check the following conditions.
		 * <ol> 
		 * <li>Request Data is Not NULL</li>
		 * <li>Request Data is Lab Top Order Service or not</li>
		 * </ol>
		 */
		public function validate(requestData:Object):Boolean
		{
			var flag:Boolean = false;
			
			if (!requestData) {
				return false;
			}
			
			if (requestData.classType == 1/*Lab*/) {
				return true;
			}
			
			return false;
		}
		
		private function setSorting():void
		{
			var sort:Sort = new Sort();
			sort.fields = [new SortField("order_count",false,true,true)];
			dataProvider.sort = sort;
			dataProvider.refresh();
		}
		
		public function addItem(itemArray:Array, paramID:String = 'id'):void
		{
			for (var i:int = 0; i < itemArray.length; i++) 
			{
				var itemAvail:Boolean = false;
				
				for (var j:int = 0; j < dataProvider.length; j++) 
				{
					if (itemArray[i][paramID] == dataProvider[j][paramID]) {
						itemAvail = true;
						dataProvider[j].order_count = Number(dataProvider[j].order_count) + 1; 
						break;
					}
				}
				
				if (!itemAvail && dataProvider.length < MAX_COUNT) {
					itemArray[i].order_count = 1;
					dataProvider.addItem(itemArray[i]);
				}
			}
			
			setSorting();
		}
	}
}