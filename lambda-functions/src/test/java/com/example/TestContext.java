package com.example;

import com.amazonaws.services.lambda.runtime.ClientContext;
import com.amazonaws.services.lambda.runtime.CognitoIdentity;
import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.LambdaLogger;

public class TestContext implements Context {

    @Override
    public String getAwsRequestId() {
        return "test-aws-request-id";
    }

    @Override
    public String getLogGroupName() {
        return "test-log-group-name";
    }

    @Override
    public String getLogStreamName() {
        return "test-log-stream-name";
    }

    @Override
    public String getFunctionName() {
        return "test-function-name";
    }

    @Override
    public String getFunctionVersion() {
        return "test-function-version";
    }

    @Override
    public String getInvokedFunctionArn() {
        return "test-invoked-function-arn";
    }

    @Override
    public CognitoIdentity getIdentity() {
        return null;
    }

    @Override
    public ClientContext getClientContext() {
        return null;
    }

    @Override
    public int getRemainingTimeInMillis() {
        return 0;
    }

    @Override
    public int getMemoryLimitInMB() {
        return 0;
    }

    @Override
    public LambdaLogger getLogger() {
        return new TestLogger();
    }

}

class TestLogger implements LambdaLogger {
    public void log(String message) {
        System.out.println(message);
    }

    public void log(byte[] message) {
        System.out.println(new String(message));
    }
}