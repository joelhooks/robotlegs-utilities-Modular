package
{
import testutils.TestStage;

import org.flexunit.internals.TraceListener;
import org.flexunit.runner.FlexUnitCore;
import org.robotlegs.utilities.modular.mvcs.ModuleContextTest;

import flash.display.Sprite;

public class LaunchTestSuite extends Sprite
{
    public function LaunchTestSuite()
    {
        TestStage.stage = stage;

        var uniqueTestClass : Class = null;

        core = new FlexUnitCore();
        core.addListener( new TraceListener() );

        if ( uniqueTestClass == null )
            core.run( ModuleContextTest );
        else
            core.run( uniqueTestClass );
    }

    private var core : FlexUnitCore;
}
}

