package org.robotlegs.utilities.modular.base
{
import org.robotlegs.base.ViewMap;
import org.robotlegs.core.IInjector;

import flash.display.DisplayObjectContainer;

/**
 * @author dlaurent 7 juin 2012
 */
public class ModuleViewMap extends ViewMap
{
    public function ModuleViewMap( contextView : DisplayObjectContainer, injector : IInjector )
    {
        super( contextView, injector );
    }

    public function dispose() : void
    {
        removeListeners();
    }
}
}
