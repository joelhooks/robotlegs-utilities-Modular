package org.robotlegs.utilities.modular.mvcs
{
import testutils.TestStage;
import testutils.modules.FixedModuleAContext;
import testutils.modules.ModuleAContext;
import testutils.modules.ModuleAMediator;

import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertFalse;
import org.flexunit.asserts.assertTrue;
import org.flexunit.async.Async;

import flash.events.Event;
import flash.events.TimerEvent;
import flash.system.System;
import flash.utils.Timer;

/**
 * @author dlaurent 7 juin 2012
 */
public class ModuleContextTest
{

    [Before( async )]
    public function setup() : void
    {
        System.gc();
        ModuleAMediator.numInstances = 0;

        // This strange thing is intended to let the time for the GC to clean memory (sometimes
        // it is a bit more longer and listeners from the first test are still there when running the second test).
        var delayer : Timer = new Timer( 2000, 1 );
        Async.proceedOnEvent( this, delayer, TimerEvent.TIMER_COMPLETE, 3000 );
        delayer.start();
    }

    /**
     * With the original ModuleContext, we see that the ADDED_TO_STAGE listeners (viewMap and mediatorMap)
     * are not unregistered if the GC didn't pass after the dispose of moduleAContext.
     *
     * NOTE : This test is a bit random, it can fail if the GC does the garbage collection just after the
     * "moduleAContext.dispose()" instruction.
     */
    [Test]
    public function after_ModuleContext_shutdown__contextView_still_have_ADDED_TO_STAGE_listener() : void
    {
        // --o Setup
        var moduleAContext : ModuleAContext = new ModuleAContext( TestStage.stage, false );
        moduleAContext.startup();
        // --o Exercise
        moduleAContext.dispose();
        // --o Verify
        assertTrue( TestStage.stage.hasEventListener( Event.ADDED_TO_STAGE ) );
    }

    /**
     * With the fix, the ADDED_TO_STAGE listeners (viewMap and mediatorMap) are released.
     */
    [Test]
    public function after_FixedModuleContext_shutdown__contextView_shouldnt_have_ADDED_TO_STAGE_listener() : void
    {
        // --o Setup
        var moduleAContext : FixedModuleAContext = new FixedModuleAContext( TestStage.stage, false );
        moduleAContext.startup();
        // --o Exercise
        moduleAContext.dispose();
        // --o Verify
        assertFalse( TestStage.stage.hasEventListener( Event.ADDED_TO_STAGE ) );
    }

    /**
     * Here, we can see that the memory leak issue has the consequence to instanciate too much mediators
     * for a unique view instance.
     *
     * NOTE : This test is a bit random, it can fail if the GC does the garbage collection just after the
     * "moduleAContext.dispose()" instruction.
     */
    [Test]
    public function with_memory_leak_issue__too_much_mediators_are_created_after_second_instanciation() : void
    {
        // --o Setup
        var moduleAContext : ModuleAContext = new ModuleAContext( TestStage.stage, false );
        moduleAContext.startup();
        moduleAContext.dispose();
        // --o Exercise
        assertEquals( 1, ModuleAMediator.numInstances );
        // --o Verify
        moduleAContext = new ModuleAContext( TestStage.stage, false );
        moduleAContext.startup();
        // Two mediators have been created for this single module startup.
        assertEquals( 3, ModuleAMediator.numInstances );
    }
}
}
