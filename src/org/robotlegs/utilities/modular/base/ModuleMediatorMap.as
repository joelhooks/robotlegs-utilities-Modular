package org.robotlegs.utilities.modular.base
{
import org.robotlegs.base.MediatorMap;
import org.robotlegs.core.IInjector;
import org.robotlegs.core.IReflector;

import flash.display.DisplayObjectContainer;

/**
 * @author dlaurent 7 juin 2012
 */
public class ModuleMediatorMap extends MediatorMap
{
    public function ModuleMediatorMap( contextView : DisplayObjectContainer, injector : IInjector,
        reflector : IReflector )
    {
        super( contextView, injector, reflector );
    }

    public function dispose() : void
    {
        removeListeners();
    }
}
}
