package jaxrtech.spaceshooter.sprites
{
	import jaxrtech.spaceshooter.base.IBaseSprite;

	public interface IProjectile extends IBaseSprite, IWeapon
	{
		function get movementSpeed():Number;
	}
}