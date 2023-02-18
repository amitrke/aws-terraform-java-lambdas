package com.example;

public class CalcOper {
    private int a;
    private int b;
    private String oper;

    public CalcOper(int a, int b, String oper) {
        this.a = a;
        this.b = b;
        this.oper = oper;
    }

    public int getA() {
        return a;
    }

    public void setA(int a) {
        this.a = a;
    }

    public int getB() {
        return b;
    }

    public void setB(int b) {
        this.b = b;
    }

    public String getOper() {
        return oper;
    }

    public void setOper(String oper) {
        this.oper = oper;
    }

    @Override
    public String toString() {
        return "CalcOper{" +
                "a=" + a +
                ", b=" + b +
                ", oper='" + oper + '\'' +
                '}';
    }
}
