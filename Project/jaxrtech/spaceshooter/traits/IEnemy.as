package jaxrtech.spaceshooter.traits
{
	import jaxrtech.spaceshooter.base.IService;
	
	public interface IEnemy extends IService, IKillable, IScorable, IWeapon
	{
		// Intentionally left empty
	}
}