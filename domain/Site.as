package domain
{
	import topOrder.LabTopOrder;

	public class Site
	{
		[Bindable] public var id:int;
		
		[Bindable] public var name:String;
		
		
		// ----------------------
		// Top Order Objects
		// ----------------------
		[Bindable] public var labTopOrder:LabTopOrder;
		
		/**
		 * Create New User
		 * @param: User ID, User Name
		 */
		public function Site(siteId:int, siteName:String)
		{
			labTopOrder = new LabTopOrder();
			
			id = siteId;
			name = siteName;
		}
	}
}