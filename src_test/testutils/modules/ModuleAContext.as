package testutils.modules
{
import org.robotlegs.core.IInjector;
import org.robotlegs.utilities.modular.mvcs.ModuleContext;

import flash.display.DisplayObjectContainer;
import flash.system.ApplicationDomain;

/**
 * @author dlaurent 7 juin 2012
 */
public class ModuleAContext extends ModuleContext
{
    public function ModuleAContext( contextView : DisplayObjectContainer = null, autoStartup : Boolean = true,
        parentInjector : IInjector = null, applicationDomain : ApplicationDomain = null )
    {
        super( contextView, autoStartup, parentInjector, applicationDomain );
    }

    override public function startup() : void
    {
        injector.mapSingleton( ModuleAView );
        mediatorMap.mapView( ModuleAView, ModuleAMediator );

        contextView.addChild( injector.getInstance( ModuleAView ) );

        super.startup();
    }

    override public function shutdown() : void
    {
        contextView.removeChild( injector.getInstance( ModuleAView ) );

        super.shutdown();
    }
}
}
