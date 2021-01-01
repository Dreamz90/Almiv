package com.almiv.spring.util;

import java.io.File;

import javax.mail.internet.MimeMessage;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;

import com.almiv.spring.model.Receipt;

public class EMailUtil {
    final String senderEmail="tm.almiv@gmail.com";
    private static final Log  logger = LogFactory.getLog(EMailUtil.class);
    JavaMailSender mailSender;
    
    public void sendEmail(JavaMailSender mailSenderObj,Receipt receiptPDF,String receiverEmail) {
    	mailSender=mailSenderObj;
 
    	String subject="Payment receipt for ALMIV Tamil Madrasah";
        MimeMessagePreparator preparator = getContentWtihAttachementMessagePreparator(receiptPDF,receiverEmail,subject);
 
        try {
            mailSender.send(preparator);
            logger.info("Message With Attachement has been sent");
        } catch (MailException ex) {
        	logger.error(ex.getMessage());
        }
    }
    
    public void reSendEmail(JavaMailSender mailSenderObj,Receipt receiptPDF,String receiverEmail) {
    	mailSender=mailSenderObj;
    	String subject="<Resend> Payment receipt for ALMIV Tamil Madrasah";
        MimeMessagePreparator preparator = getContentWtihAttachementMessagePreparator(receiptPDF,receiverEmail,subject);
 
        try {
            mailSender.send(preparator);
            logger.info("Message With Attachement has been sent");
        } catch (MailException ex) {
        	logger.error(ex.getMessage());
        }
    }
 
    private MimeMessagePreparator getContentWtihAttachementMessagePreparator(final Receipt receipt, String receiverEmail,String subject) {
 
        MimeMessagePreparator preparator = new MimeMessagePreparator() {
 
            public void prepare(MimeMessage mimeMessage) throws Exception {
                MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
 
                helper.setSubject(subject);
                helper.setFrom(senderEmail);
                helper.setTo(receiverEmail);
                
                String content = "*** This is an automatically generated email, please do not reply***\n\nAssalamu Alaikum,\n\tPlease find attached the payment receipt for Tamil Madrasah "+StudentUtil.getCurrentYear()+".";
                helper.setText(content);
               // File attachment= new GenerateReceipt().GenerateReceipt_PDF(receipt.getStudentName(),receipt.getAmount());
                File attachment= new GenerateReceipt().GenerateReceipt_PDFv2(receipt);
                
                // Add a resource as an attachment               
                helper.addAttachment("receipt_"+receipt.getStudentName()+".pdf",attachment );
            }
        };
        return preparator;
    }
    
 /* MimeMessagePreparator getContentAsInlineResourceMessagePreparator(final Receipt receipt,String receiverEmail) {
 
        MimeMessagePreparator preparator = new MimeMessagePreparator() {
 
            public void prepare(MimeMessage mimeMessage) throws Exception {
                MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
 
                helper.setSubject("Payment receipt for Almiv Tamil Madarasah");
                helper.setFrom(senderEmail);
                helper.setTo(receiverEmail);
                String content = "Assalamu Alaikum.";
 
                // Add an inline resource.
                // use the true flag to indicate you need a multipart message
//                helper.setText("<html><body><p>" + content + "</p><img src='cid:company-logo'></body></html>", true);
//                helper.addInline("company-logo", new ClassPathResource("linux-icon.png"));
            }
        };
        return preparator;
    }*/
}
