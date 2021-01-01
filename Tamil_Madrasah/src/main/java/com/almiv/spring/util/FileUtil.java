package com.almiv.spring.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class FileUtil {
	private static final Log  logger = LogFactory.getLog(FileUtil.class);
	public static File CopyPDF(String name,String filePathToCopy) {
		File file=null;
		try {
			file = new File("PDFs");
			if(file.mkdir()) { 
				System.out.println("Directory Created2");
			} else {
				System.out.println("Directory already exist!");
			}
			DateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmm");
			Date date = new Date();
//			System.out.println(dateFormat.format(date)); //2016/11/16 12:08:43
			String strName=name.replace(" ", "_");
			strName=strName.replace("/","");
			
			file = new File("C:\\Users\\rasul\\Desktop\\PDFs\\receipt_"+strName+"_"+dateFormat.format(date)+".pdf");
			System.out.println("test:"+file);
			if(file.createNewFile()) {
				System.out.println("File is created");
			}else {
				System.out.println("File not created");
			}
			File source = new File(filePathToCopy);
			
			//copy file conventional way using Stream
			//long start = System.nanoTime();
			copyFileUsingStream(source, file);
			//logger.info("Time taken by Stream Copy = "+(System.nanoTime()-start));
			
			//Create the file
			if (file.createNewFile())
			{

				logger.info("File is created! Path:"+ file.getAbsolutePath());
			} else {
				logger.info("File already exists. Path:"+ file.getAbsolutePath());
			}

		}catch(Exception e){
			System.out.println(e);
		}
		return file;
	}
	private static void copyFileUsingStream(File source, File dest) throws IOException {
		InputStream is = null;
		OutputStream os = null;
		try {
			is = new FileInputStream(source);
			os = new FileOutputStream(dest);
			byte[] buffer = new byte[1024];
			int length;
			while ((length = is.read(buffer)) > 0) {
				os.write(buffer, 0, length);
			}
		} finally {
			is.close();
			os.close();
		}
	}
}
