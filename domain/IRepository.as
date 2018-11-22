package domain
{
	public interface IRepository
	{
		/**
		 * Add Customer
		 * */
		function add(customer:Customer, isCurrent:Boolean = true):void;
		
		/**
		 * Remove Customer
		 * */
		function remove(customerId:int):Boolean;
		
		/**
		 * Get Customer
		 */
		function find(customerId:int):Customer;
	}
}