package com.almiv.spring.util;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;

import org.springframework.core.io.ClassPathResource;

import com.almiv.spring.model.Receipt;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.ColumnText;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;

public class GenerateReceipt {
	public File GenerateReceipt_PDF(String studentName,double amt) {
		PdfReader reader;
		File generatedPDF=null;

		try {

			//open
			ClassPathResource pdfTemplate = new ClassPathResource("input/receipt_template.pdf");
			reader = new PdfReader(pdfTemplate.getFile().getAbsolutePath());

			//Copy the contents of the template to a new pdf and create an outputstream 
			generatedPDF=FileUtil.CopyPDF(studentName,pdfTemplate.getFile().getAbsolutePath());
			FileOutputStream outputStream = new FileOutputStream(generatedPDF);

			//Stamp the new PDF with new data.
			PdfStamper stamper = new PdfStamper(reader, outputStream);
			PdfContentByte canvas = stamper.getOverContent(1); 
			ColumnText.showTextAligned(canvas,   Element.ALIGN_LEFT, new Phrase( String.format("%.2f", amt)), 264, 245, 0); 

			//close
			stamper.close();//Stamper to close before output stream, otherwise no data is written.

			outputStream.flush();
			outputStream.close();

			reader.close();

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return generatedPDF;
	}
	public File GenerateReceipt_PDFv2(Receipt receipt) {
		PdfReader reader;
		File generatedPDF=null;

		try {

			//open
			ClassPathResource pdfTemplate = new ClassPathResource("input/receipt_templatev2.pdf");
			reader = new PdfReader(pdfTemplate.getFile().getAbsolutePath());

			//Copy the contents of the template to a new pdf and create an outputstream 
			generatedPDF=FileUtil.CopyPDF(receipt.getStudentName(),pdfTemplate.getFile().getAbsolutePath());
			FileOutputStream outputStream = new FileOutputStream(generatedPDF);

			//1) Stamp the new PDF with new data.
			PdfStamper stamper = new PdfStamper(reader, outputStream);
			PdfContentByte canvas = stamper.getOverContent(1);

			//1.1) Stamp Serial No
			Font fontQouteItems = new Font(BaseFont.createFont(), 9);
			String serialDate="SN: "+StudentUtil.getSerialDate()+"A"+receipt.getReceiptSerialNo();//Serial No format <yymmdd><A><serialNo>		
			ColumnText.showTextAligned(canvas,   Element.ALIGN_LEFT, new Phrase(serialDate,fontQouteItems), 500, 400, 0); 

			//1.2) Stamp amount paid
			ColumnText.showTextAligned(canvas,   Element.ALIGN_LEFT, new Phrase( String.format("%.2f", receipt.getAmount())), 300, 210, 0); 

			//1.3) Stamp student name and class
			ColumnText.showTextAligned(canvas,   Element.ALIGN_LEFT, new Phrase( receipt.getStudentName()), 150, 164, 0); 
			ColumnText.showTextAligned(canvas,   Element.ALIGN_LEFT, new Phrase( receipt.getStudentClass()), 150, 138, 0);
			
			//1.4) Stamp Date, current style is date:____<fill in manually>______
			String dateStr="Date:____________";
			if(!StudentUtil.getCurrentYear().equalsIgnoreCase("2020")) {
				dateStr="Date: "+StudentUtil.convertdate_date(new Date());
			}
			ColumnText.showTextAligned(canvas,   Element.ALIGN_LEFT, new Phrase( dateStr,fontQouteItems), 500, 385, 0);  

			//close stamper and output and reader stream
			stamper.close();//Stamper to close before output stream, otherwise no data is written.
			outputStream.flush();
			outputStream.close();
			reader.close();

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return generatedPDF;
	}

}
