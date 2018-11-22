package domain
{
	public class User
	{
		[Bindable] public var id:int;
		
		[Bindable] public var name:String;
		
		[Bindable]
		private var _site:Site;
		
		/**
		 * Store All Site Details in Associative Object
		 * Index: Site ID
		 * Value: Site Class Object
		 * */
		private var _siteStore:Object;
		
		/**
		 * Create New User
		 * @param: User ID, User Name
		 */
		public function User(userId:int, userName:String)
		{
			_siteStore = new Object();
			
			id = userId;
			name = userName;
		}
		
		/**
		 * Current Site Object
		 */
		public function get site():Site
		{
			return _site;
		}
		
		/**
		 * Add New Site
		 * @param: New Site, Is Current - Make This site as Current Site
		 */
		public function addSite(site:Site, isCurrent:Boolean = true):void
		{
			var tempSite:Site = findSite(site.id);
			
			if (!tempSite) {
				tempSite = _siteStore[site.id] = site;
			}
			
			if (isCurrent) {
				this._site = tempSite; 
			}
		}
		
		/**
		 * Find Site using Site ID
		 * @param: Site ID
		 */
		public function findSite(siteId:int):Site
		{
			if (_siteStore.hasOwnProperty(siteId)) {
				return _siteStore[siteId];
			}
			
			return null;
		}
		
		/**
		 * Remove Site from Site Store
		 * @param: Site ID
		 * @return: Success = True, Site Not Exists = False
		 */
		public function removeSite(siteId:int):Boolean
		{
			var tempSite:Site = findSite(siteId);
			
			if (tempSite) {
				delete _siteStore[siteId];
				return true;
			}
			
			return false;
		}
	}
}