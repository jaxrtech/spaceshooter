package jaxrtech.spaceshooter.traits
{
	import jaxrtech.spaceshooter.base.IBaseSprite;

	public interface IProjectile extends IBaseSprite, IWeapon
	{
		function get movementSpeed():Number;
	}
}