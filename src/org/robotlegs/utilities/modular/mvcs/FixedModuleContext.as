package org.robotlegs.utilities.modular.mvcs
{
import org.robotlegs.core.IInjector;
import org.robotlegs.core.IMediatorMap;
import org.robotlegs.core.IViewMap;
import org.robotlegs.utilities.modular.base.ModuleMediatorMap;
import org.robotlegs.utilities.modular.base.ModuleViewMap;

import flash.display.DisplayObjectContainer;
import flash.system.ApplicationDomain;

/**
 * @author dlaurent 7 juin 2012
 */
public class FixedModuleContext extends ModuleContext
{
    public function FixedModuleContext( contextView : DisplayObjectContainer = null, autoStartup : Boolean = true,
        parentInjector : IInjector = null, applicationDomain : ApplicationDomain = null )
    {
        super( contextView, autoStartup, parentInjector, applicationDomain );
    }

    override public function dispose() : void
    {
        ModuleMediatorMap( _mediatorMap ).dispose();
        ModuleViewMap( _viewMap ).dispose();
        super.dispose();
    }

    override protected function get mediatorMap() : IMediatorMap
    {
        return _mediatorMap ||
            ( _mediatorMap =
            new ModuleMediatorMap( contextView, injector.createChild( _applicationDomain ), reflector ) );
    }

    override protected function get viewMap() : IViewMap
    {
        return _viewMap || ( _viewMap = new ModuleViewMap( contextView, injector.createChild( _applicationDomain ) ) );
    }
}
}
