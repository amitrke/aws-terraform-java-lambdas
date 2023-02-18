package com.example;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyRequestEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayProxyResponseEvent;

public class CalcTest {
    private final CalcHandler handler = new CalcHandler();

    @Test
    void testHandleRequest() {
        APIGatewayProxyRequestEvent request = new APIGatewayProxyRequestEvent();
        request.setBody("John");

        Context context = new TestContext();

        APIGatewayProxyResponseEvent response = handler.handleRequest(request, context);

        assertEquals(200, response.getStatusCode());
        assertEquals("Hello, John!", response.getBody());
    }
}
