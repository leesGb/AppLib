package equipments
{
	import deltax.graphic.scenegraph.object.RenderObject;
    

    public class EquipItemInUse 
	{

        public var equipName:String;
        public var renderObject:RenderObject;
        public var fxIDs:Vector.<String>;

        public function EquipItemInUse(){
            this.fxIDs = new Vector.<String>();
        }
    }
}
