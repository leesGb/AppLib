package events
{
   import flash.events.Event;
   
   public class LogerEvent extends Event
   {
	   public static const LOG_EVENT:String = "LOG_EVENT";
	   
      public static const INFO:String = "log:Info";
      
      public static const WARNING:String = "log:warning";
      
      public static const ERROR:String = "log:error";
      
      public static const MESSAGE:String = "log:message";
       
      public var level:String;
      
      public var text:String;
      
      public var clear:Boolean;
      
      public function LogerEvent($type:String, $level:String = "log:Info", $clear:Boolean = false)
      {
         super(LOG_EVENT,false,false);
         this.clear = $clear;
         this.text = $type;
         this.level = $level;
      }
      
      override public function clone() : Event
      {
         return new LogerEvent(this.text,this.level);
      }
   }
}
