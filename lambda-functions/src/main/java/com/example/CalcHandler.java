package com.example;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyResponseEvent;
import com.google.gson.Gson;

public class CalcHandler implements RequestHandler<APIGatewayProxyRequestEvent, APIGatewayProxyResponseEvent>{

    public APIGatewayProxyResponseEvent handleRequest(APIGatewayProxyRequestEvent event, Context context) {
        Gson g = new Gson();
        APIGatewayProxyResponseEvent response = new APIGatewayProxyResponseEvent();
        CalcOper calcOper;
        try {
            String body = event.getBody();
            calcOper = g.fromJson(body, CalcOper.class);
            System.out.println(calcOper);
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatusCode(422);
            response.setBody("{\"Error\": \"Invalid input\"}");
            return response;
        }

        float result = 0;
        switch(calcOper.getOper()) {
            case "add":
                result = calcOper.getA() + calcOper.getB();
                break;
            case "sub":
                result = calcOper.getA() - calcOper.getB();
                break;
            case "mul":
                result = calcOper.getA() * calcOper.getB();
                break;
            case "div":
                result = calcOper.getA() / calcOper.getB();
                break;
            default:
                response.setStatusCode(422);
                response.setBody("{\"Error\": \"Invalid operation\"}");
                return response;
        }

        response.setStatusCode(200);
        response.setBody("{\"result\": " + result + "}");
        return response;
    }
    
}
