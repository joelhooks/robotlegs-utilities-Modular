package testutils.modules
{
import org.robotlegs.utilities.modular.mvcs.ModuleMediator;

/**
 * @author dlaurent 7 juin 2012
 */
public class ModuleAMediator extends ModuleMediator
{
    public static var numInstances : int = 0;

    public function ModuleAMediator( view : ModuleAView )
    {
        numInstances++;
    }
}
}
