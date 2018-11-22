package domain
{
	public class CustomerRepository implements IRepository
	{
		[Bindable]
		private var _customerStore:Object;
		private static var _instance:CustomerRepository = null; 
		
		[Bindable]
		private var _customer:Customer;
		
		public function CustomerRepository(enforcer:SingletonEnforcer)
		{
			if (enforcer == null) {
				throw new Error("You can only have one Customer Repsoitory");
			}
			
			_customerStore = new Object();
		}
		
		/**
		 * Current Customer Object
		 */
		public function get customer():Customer
		{
			return _customer;
		}
		
		/**
		 * Store All Customer Details in Associative Object
		 * Index: Customer ID
		 * Value: Customer Class Object
		 */
		public function get customerStore():Object
		{
			return _customerStore;
		}
		
		public static function getInstance():CustomerRepository {
			if (_instance == null) {
				_instance = new CustomerRepository(new SingletonEnforcer);
			}
			
			return _instance;
		}
		
		public static function removeInstance():void {
			if (_instance) {
				_instance = null;
			}
		}

		/**
		 * Add New Customer
		 * @param: New Customer, Is Current - Make This as Current Customer
		 */
		public function add(customer:Customer, isCurrent:Boolean = true):void
		{
			var tempCustomer:Customer = find(customer.id);
			
			if (!tempCustomer) {
				tempCustomer = _customerStore[customer.id] = customer;
			}
			
			if (isCurrent) {
				this._customer = tempCustomer; 
			}
		}
		
		public function remove(customerId:int):Boolean
		{
			var tempUser:Customer = find(customerId);
			
			if (tempUser) {
				delete _customerStore[customerId];
				return true;
			}
			
			return false;
		}
		
		/**
		 * Find Customer using Customer ID
		 * @param: Customer ID
		 */
		public function find(customerId:int):Customer
		{
			if (_customerStore.hasOwnProperty(customerId)) {
				return _customerStore[customerId];
			}
			
			return null;
		}
	}
}
class SingletonEnforcer {}