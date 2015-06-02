//+------------------------------------------------------------------+
//|                                         forexrootKitToolsLib.mq4 |
//|                               Copyright 2015, Conchman Holdings. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property library
#property copyright "Copyright 2015, Conchman Holdings."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| My function                                                      |
//+------------------------------------------------------------------+
// int MyCalculator(int value,int value2) export
//   {
//    return(value+value2);
//   }
//+------------------------------------------------------------------+
int getTradeCount() {
    int result = 0;
    int totalOrders = OrdersTotal();
    for (int i = 0; i < totalOrders; i++) {
        double os = OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
        if (OrderSymbol() == Symbol()) {
            result++;
        }
    }
    return (result);
}

int getBuyTradeCount() {
    int result = 0;
    int totalOrders = OrdersTotal();
    for (int i = 0; i < totalOrders; i++) {
        double os = OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
        if (OrderSymbol() == Symbol() && (OrderType() == OP_BUY //|| 
                                          //OrderType() == OP_BUYLIMIT ||
                                          //OrderType() == OP_BUYSTOP
                                          )) {
            result++;
        }
    }
    return (result);
}

int getBuyTradeCount(int orderType) {
    int result = 0;
    int totalOrders = OrdersTotal();
    for (int i = 0; i < totalOrders; i++) {
        double os = OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
        if (OrderSymbol() == Symbol() && (OrderType() == orderType //|| 
                                          //OrderType() == OP_BUYLIMIT ||
                                          //OrderType() == OP_BUYSTOP
                                          )) {
            result++;
        }
    }
    return (result);
}

int getSellTradeCount() {
    int result = 0;
    int totalOrders = OrdersTotal();
    for (int i = 0; i < totalOrders; i++) {
        double os = OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
        if (OrderSymbol() == Symbol() && (OrderType() == OP_SELL //|| 
                                          //OrderType() == OP_SELLLIMIT ||
                                          //OrderType() == OP_SELLSTOP
                                          )) {
            result++;
        }
    }
    return (result);
}

int getSellTradeCount(int orderType) {
    int result = 0;
    int totalOrders = OrdersTotal();
    for (int i = 0; i < totalOrders; i++) {
        double os = OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
        if (OrderSymbol() == Symbol() && (OrderType() == orderType //|| 
                                          //OrderType() == OP_SELLLIMIT ||
                                          //OrderType() == OP_SELLSTOP
                                          )) {
            result++;
        }
    }
    return (result);
}

double getSellMaxTrade() {
    int totalOrders = OrdersTotal();
    double max = 0;
    for (int i = 0; i < totalOrders; i++) {
        bool os = OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
        if (OrderSymbol() == Symbol() && (OrderType() == OP_SELL || OrderType() == OP_SELLLIMIT)) {
            double openPrice = OrderOpenPrice();
            if (openPrice > max) {
                max = openPrice;
            }
        }
    }
    return (max);
}

double getBuyMinTrade() {
    int totalOrders = OrdersTotal();
    double min = 0;
    if (totalOrders > 0) {
        min = 100000000; // need to find this constant. :/
        for (int i = 0; i < totalOrders; i++) {
            bool os = OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
            if (OrderSymbol() == Symbol() && (OrderType() == OP_BUY || OrderType() == OP_BUYLIMIT)) {
                double openPrice = OrderOpenPrice();
                if (openPrice < min) {
                   min = openPrice;
                }
            }
        }
    }
    return (min);
}

bool canOpenSell(double inSellPS){
   int totalOrders = OrdersTotal();
   for (int i = 0; i < totalOrders; i++) {
      double os = OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() == Symbol() && (OrderType() == OP_SELL || 
                                        OrderType() == OP_SELLLIMIT ||
                                        OrderType() == OP_SELLSTOP)) {
         double openPrice = OrderOpenPrice();
         if (!canOpenSell(inSellPS, openPrice)){
            return false;
         }
      }
   }
   return true;
}

bool canOpenSell(double _sell_ps, double sell_price){
   double sell_psPoint = _sell_ps;// * Point; 
   if (MathAbs(Bid - sell_price) > (sell_psPoint * UsePoint)){
      Print("canOpenSell: " + IntegerToString(true));
      return true;
   }
   Print("canOpenSell: " + IntegerToString(false));
   return false;
}

bool canOpenSell(double _sell_ps, double sell_price){
   double sell_psPoint = _sell_ps;// * Point; 
   if (MathAbs(Bid - sell_price) > (sell_psPoint * UsePoint)){
      Print("canOpenSell: " + IntegerToString(true));
      return true;
   }
   Print("canOpenSell: " + IntegerToString(false));
   return false;
}