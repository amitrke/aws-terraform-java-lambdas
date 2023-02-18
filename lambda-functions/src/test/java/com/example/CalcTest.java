package com.example;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyResponseEvent;

public class CalcTest {
    private final CalcHandler handler = new CalcHandler();

    @Test
    void testAddRequest() {
        APIGatewayProxyRequestEvent request = new APIGatewayProxyRequestEvent();
        request.setBody("{\"a\": 1, \"b\": 2, \"oper\": \"add\"}");

        Context context = new TestContext();

        APIGatewayProxyResponseEvent response = handler.handleRequest(request, context);

        assertEquals(200, response.getStatusCode());
        assertEquals("{\"result\": 3.0}", response.getBody());
    }

    @Test
    void testInvalidOperRequest() {
        APIGatewayProxyRequestEvent request = new APIGatewayProxyRequestEvent();
        request.setBody("{\"a\": 1, \"b\": 2, \"oper\": \"invalid\"}");

        Context context = new TestContext();

        APIGatewayProxyResponseEvent response = handler.handleRequest(request, context);

        assertEquals(422, response.getStatusCode());
        assertEquals("{\"Error\": \"Invalid operation\"}", response.getBody());
    }
}
