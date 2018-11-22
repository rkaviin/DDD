package domain
{
	public class Customer
	{
		[Bindable] public var id:int;
		
		[Bindable] public var name:String;
		
		[Bindable] public var productId:int;
		
		[Bindable] public var editionId:int;
		
		[Bindable] public var productTypeId:int;
		
		[Bindable] public var entityTypeId:int;
		
		[Bindable] public var licenseId:int;
		
		[Bindable] private var _user:User;
		
		/**
		 * Store All User Details in Associative Object
		 * Index: User ID
		 * Value: User Class Object
		 * */
		private var _userStore:Object;
		
		/**
		 * Create New Customer
		 * @param: Customer ID, Customer Name
		 */
		public function Customer(customerId:int, customerName:String)
		{
			_userStore = new Object();
			
			id = customerId;
			name = customerName;
		}
		
		/**
		 * Current User Object
		 */
		public function get user():User
		{
			return _user;
		}

		/**
		 * Add New User
		 * @param: New User, Is Current - Make This user as Current User
		 */
		public function addUser(user:User, isCurrent:Boolean = true):void
		{
			var tempUser:User = findUser(user.id);
			
			if (!tempUser) {
				tempUser = _userStore[user.id] = user;
			}
			
			if (isCurrent) {
				this._user = tempUser; 
			}
		}
		
		/**
		 * Find User using User ID
		 * @param: User ID
		 */
		public function findUser(userId:int):User
		{
			if (_userStore.hasOwnProperty(userId)) {
				return _userStore[userId];
			}
			
			return null;
		}
		
		/**
		 * Remove User from User Store
		 * @param: User ID
		 * @return: Success = True, User Not Exists = False
		 */
		public function removeUser(userId:int):Boolean
		{
			var tempUser:User = findUser(userId);
			
			if (tempUser) {
				delete _userStore[userId];
				return true;
			}
			
			return false;
		}
	}
}