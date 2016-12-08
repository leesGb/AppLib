package utils
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import deltax.common.resource.Enviroment;
	
	public class FileHelper
	{
		public function FileHelper()
		{
		}
		
		/**
		 * 读取文件并返回字符串 
		 * @param file
		 * @return 
		 * 
		 */		
		public static function readFileToStr(file:File):String
		{
			var fs:FileStream = new FileStream();
			var str:String;
			fs.open(file,FileMode.READ);
			str =fs.readUTFBytes(file.size);
			fs.close();
			fs=null;
			return str;
		}
		
		public static function readFileToByte(path:String):ByteArray
		{
			var file:File = getFileByPath(path);
			var fs:FileStream = new FileStream();
			fs.open(file,FileMode.READ);
			var byteArray:ByteArray = new ByteArray();
			fs.readBytes(byteArray);
			return byteArray;
		}
		
		public static function readFileToXML(path:String):XML
		{
			var file:File = getFileByPath(path);
			var fs:FileStream = new FileStream();
			fs.open(file,FileMode.READ);
			var xml:XML = XML(fs.readUTFBytes(fs.bytesAvailable));
			return xml;
		}
		
		/**
		 * 保存XML文件 
		 * @param xml
		 * @param xmlFile
		 * 
		 */		
		public static function saveXMLToFile(xml:XML,xmlFile:File):void
		{
			var fs:FileStream = new FileStream();
			var str:String='<?xml version="1.0" encoding="UTF-8"?>\r\n';
			fs.open(xmlFile,FileMode.WRITE);
			if(xml)
			{
				str += xml.toXMLString();
			}
			fs.writeUTFBytes(str);
			fs.close();
			fs=null; 
		}
		
		public static function saveByteArrayToFile(byteArray:ByteArray,pathName:String,callBack:Function = null):void
		{
			var file:File = getFileByPath(pathName);
			var fs:FileStream = new FileStream();
			fs.open(file,FileMode.WRITE);
			fs.writeBytes(byteArray);
			fs.close();
			fs=null;
			if(callBack!=null)
				callBack();
		}
		
		/**
		 *  保存XML文件 
		 * @param xml
		 * @param xmlFile
		 * 
		 */
		public static function saveStringToFile(xmlstr:String,xmlFile:File):void
		{
			var fs:FileStream = new FileStream();
			var str:String='<?xml version="1.0" encoding="UTF-8"?>\r\n';
			fs.open(xmlFile,FileMode.WRITE);
			str += xmlstr;
			fs.writeUTFBytes(str);
			fs.close();
			fs=null;
		}
		
		/**
		 *  保存txt文件 
		 * @param txtstr
		 * @param txtFile
		 * 
		 */
		public static function saveStringToFileTXT(txtstr:String,txtFile:File,utf8:Boolean = true):void
		{
			var fs:FileStream = new FileStream();
			fs.open(txtFile,FileMode.WRITE);
			if(utf8)
				fs.writeUTFBytes(txtstr);
			else
				fs.writeMultiByte(txtstr,"cn-gb");
			fs.close();
			fs=null;
		}
		
		//判断文件是否存在
		public static function isFileExist(path:String):Boolean
		{
			var path:String = File.applicationDirectory.resolvePath(path).nativePath;
			var file:File = new File( path );
			return file.exists;
		}
		
		public static function createFile(path:String):File
		{
			var path:String = File.applicationDirectory.resolvePath(path).nativePath;
			var file:File = new File( path );
			if(!file.exists)
			{
				return file;
			}
			return file;
		}
		
		/**
		 * 根据路径或者文件对象 
		 * 如果文件不存在则创建 
		 * @param path
		 * @return 
		 * 
		 */		
		public static function getFileByPath(path:String):File
		{
			var path:String = File.applicationDirectory.resolvePath(path).nativePath;
			var file:File = new File( path );
			return file;
		}
		
		
		/**
		 * Enviroment.ResourceRootPath资源的相对路径 
		 * @param path
		 * @return 
		 * 
		 */
		public static function getResComparPath(path:String):String{
			var file:File = new File(path);
			var resFile:File = new File(Enviroment.ResourceRootPath);
			var ss:String = file.nativePath.toLocaleLowerCase().replace(resFile.nativePath.toLocaleLowerCase() + "\\","");
			return ss==path.toLocaleLowerCase()?null:ss.replace(/\\/g,"/");
		}
		
		/**
		 * 获取该目录下指定格式的所有文件
		 * @param path				文件路径
		 * @param extension		指定格式
		 * @return 						返回该文件夹下所有的指定格式文件
		 */		
		public static function getUnderPathChilds(path:String,extension:String,out:Array=null):Array
		{
			var f:File = new File(path);
			var result:Array=(out || []);
			if(f.exists)
			{
				checkFileExtension(f,extension,result);
			}
			
			return result;
		}
		
		private static function checkFileExtension(f:File,extension:String,out:Array):void
		{
			var childs:Array = f.getDirectoryListing();
			if(childs)
			{
				var tf:File;
				for each(tf in childs)
				{
					if(tf.isDirectory)
					{
						checkFileExtension(tf,extension,out);
					}else
					{
						if(tf.extension == extension)
						{
							var obj:Object = {};
							obj.name = tf.name;
							obj.data = tf;
							out.push(obj);
						}	
					}
				}
			}
		}
		
	}
}