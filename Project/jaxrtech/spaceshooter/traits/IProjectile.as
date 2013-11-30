package jaxrtech.spaceshooter.traits
{
	import jaxrtech.spaceshooter.base.IService;

	public interface IProjectile extends IService, IWeapon
	{
		function get movementSpeed():Number;
	}
}