package com.boot.parking.controller;

import jakarta.annotation.PostConstruct;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import java.io.IOException;
import com.siot.IamportRestClient.*;
import com.siot.IamportRestClient.response.Payment;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.exception.IamportResponseException;

@Controller
public class PaymentController {

    private IamportClient iamportClient;

    @PostConstruct
    public void init() {
    	 try {
    	        String apiKey = "5006425641661820";
    	        String apiSecret = "7NMcNNSTFCq926FGoAEf3CPejqJp9mv7Xt3Eql3A3b0zX58RCFqdeILiMUO3OTD0rggtKzLfLILaAJ7W";
    	        this.iamportClient = new IamportClient(apiKey, apiSecret);
    	        System.out.println("IamportClient 생성 완료");
    	    } catch (Exception e) {
    	        e.printStackTrace();
    	    }
    }

    @PostMapping("/payment/verify")
    @ResponseBody
    public String verifyPayment(@RequestParam("imp_uid") String impUid) {
        try {
            IamportResponse<Payment> response = iamportClient.paymentByImpUid(impUid);
            Payment payment = response.getResponse();

            if (payment.getAmount().intValue() == 1000) {
                return "success";
            } else {
                return "결제 금액 불일치";
            }

        } catch (IamportResponseException | IOException e) {
            e.printStackTrace();
            return "fail";
        }
    }

    @GetMapping("/payment/form")
    public String paymentForm() {
        return "payment";
    }
}
