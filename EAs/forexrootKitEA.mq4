//+------------------------------------------------------------------+
//|                                               forexrootKitEA.mq4 |
//|                               Copyright 2015, Conchman Holdings. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, Conchman Holdings."
#property link      "http://www.mql5.com"
#property strict

//External parameters
extern int slippage = 0;

extern int stopLossMode = 0;//StopLossMode | -1 & 0 - Explicit - 0
extern double buyStopLoss = 25;//Buy StopLoss in pips
extern double sellStopLoss = 25;//Sell StopLoss in pips

extern int takeProfitMode = 0;//TakeProfitMode | -1 & 0 - Explicit
extern double buyTakeProfit = 25;//Buy take profit in pips
extern double sellTakeProfit = 25;//Sell take profit in pips

//Need to make psMode
extern int buyPS = 25;//Pip distance between buy orders
extern int sellPS = 25;//Pip distance between sell orders

extern double minLotSize = 0.01;//Min lot size

extern int buyRiskStep = 1000;//Buy RiskStep
extern int sellRiskStep = 1000;//Sell RiskStep

extern double maxLotSize = 20;//Max lot size


extern int sellEmptyOrderMode = 0; //sellEmptyOrderMode 0 - Market | 1 - LIMIT | 2 - STOP
extern int buyEmptyOrderMode = 0; //buyEmptyOrderMode 0 - Market | 1 - LIMIT | 2 - STOP

extern double sellLimitBuffer = 50;//sellLimitBuffer pip distance
extern double sellStopBuffer = 50;//sellStopBuffer pip distance
extern double buyLimitBuffer = 50;//buyLimitBuffer pip distance
extern double buyStopBuffer = 50;//buyStopBuffer pip distance

//Global Variables
double UsePoint;
int UseSlippage;
double buy_global_max;
double buy_global_min;
double sell_global_max;
double sell_global_min;
double version = 1.0;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   UsePoint = PipPoint(Symbol());
   UseSlippage = GetSlippaage(Symbol(),slippage);
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   if (canOpenBuy()){
      switch(buyEmptyOrderMode){
         case 1:
            if(getBuyTradeCount(OP_BUYLIMIT) == 0){
               openBuy(OP_BUYLIMIT);
            }else{
               openBuy(OP_BUY);
            }
            break;
         case 2:
            if(getBuyTradeCount(OP_BUYSTOP) == 0){
               openBuy(OP_BUYSTOP);
            }else{
               openBuy(OP_BUY);
            }
            break;
         default:
            openBuy(OP_BUY);
            break;
      }
   }
   if (canOpenSell()){
      switch(sellEmptyOrderMode){
         case 1:
            if(getSellTradeCount(OP_SELLLIMIT) == 0){
               openSell(OP_SELLLIMIT);
            }else{
               openSell(OP_SELL);
            }
            break;
         case 2:
            if(getSellTradeCount(OP_SELLSTOP) == 0){
               openSell(OP_SELLSTOP);
            }else{
               openSell(OP_SELL);
            }
            break;
         default:
            openSell(OP_SELL);
            break;
      }
   }
   if (takeProfitMode > -1){
      closeSellOrdersInProfit();
      closeBuyOrdersInProfit();
   }
   
   Comment("UsePoint: " + DoubleToString(UsePoint) + "\n" + 
           "UseSlippage: " + IntegerToString(UseSlippage));
  }
//+------------------------------------------------------------------+
double PipPoint(string Currency)
{
   double CalcDigits = MarketInfo(Currency, MODE_DIGITS);
   double CalcPoint = 0;
   if(CalcDigits == 2 || CalcDigits == 3) CalcPoint = 0.01;
   else if(CalcDigits == 4 || CalcDigits == 5) CalcPoint = 0.0001;
   return(CalcPoint);
}

int GetSlippaage(string Currency, int SlippagePips)
{
   double CalcDigits = MarketInfo(Currency,MODE_DIGITS);
   int CalcSlippage = 0;
   if(CalcDigits == 2 || CalcDigits == 4) CalcSlippage = SlippagePips;
   else if (CalcDigits == 3 || CalcDigits == 5) CalcSlippage = SlippagePips * 10;
   return(CalcSlippage);
}

//-----BUY Stop Loss

double GetBuyStopLoss(double OpenPrice){
   double _buyStopLoss = OpenPrice - (buyStopLoss * UsePoint);
   switch(stopLossMode){
      case 0:
         if(OpenPrice > 0){
            return 0;
         }else{
            return (buyStopLoss * UsePoint);
         }         
      default:
         return _buyStopLoss;
   }
}

//-----BUY Stop Loss

//-----Sell Stop Loss

double GetSellStopLoss(double OpenPrice){
   double _sellStopLoss = OpenPrice + (sellStopLoss * UsePoint);
   switch(stopLossMode){
      case 0:
         if(OpenPrice > 0){
            return 0;
         }else{
            return (sellStopLoss * UsePoint);
         }         
      default:         
         return _sellStopLoss;
   }
}

//-----Sell Stop Loss

//-----BUY Take Profit

double GetBuyTakeProfit(double OpenPrice){
   double _buyTakeProfit = OpenPrice + (buyTakeProfit * UsePoint);
   switch(takeProfitMode){
      case 0:
         if(OpenPrice > 0){
            return 0;
         }else{
            return (buyTakeProfit * UsePoint);
         } 
      default:
         return _buyTakeProfit; 
   }
}

//-----BUY Take Profit

//-----SELL Take Profit

double GetSellTakeProfit(double OpenPrice){
   double _sellTakeProfit = OpenPrice - (sellTakeProfit * UsePoint);
   switch(takeProfitMode){
      case 0:
         if (OpenPrice > 0){
            return 0;
         }else{
            return (sellTakeProfit * UsePoint);
         }  
      default:
         return _sellTakeProfit;  
   }
}

//-----SELL Take Profit

/**
 * This funtion calculates the lot size automatically.
 * 0.01 lots is added for every $rs in profit.
 */
double getBuyLotSize() {
    double result = 0;
    double balance = AccountBalance();
    double step = buyRiskStep;
    double threshold = step;
    while (balance >= threshold) {
        result += minLotSize;
        threshold += step;
    }
    if (maxLotSize > 0 && result > maxLotSize) {
        result = maxLotSize;
    }
    if (result < minLotSize){
      result = minLotSize;
    }
    return (result);
}

/**
 * This funtion calculates the lot size automatically.
 * 0.01 lots is added for every $rs in profit.
 */
double getSellLotSize() {
    double result = 0;
    double balance = AccountBalance();
    double step = sellRiskStep;
    double threshold = step;
    while (balance >= threshold) {
        result += minLotSize;
        threshold += step;
    }
    if (maxLotSize > 0 && result > maxLotSize) {
        result = maxLotSize;
    }
    if (result < minLotSize){
      result = minLotSize;
    }
    return (result);
}

void openBuy(int inBuyOrderType) {
   Print("Setting up BUY");
   while (IsTradeContextBusy()) {
      Print("Trade Context Busy - BUY");
      Sleep(10);
   }
   RefreshRates();
   double orderPrice = getBuyOrderPrice(inBuyOrderType);
   double takeprofit = GetBuyTakeProfit(orderPrice);
   double stoploss = GetBuyStopLoss(orderPrice);
   double buy_lots = getBuyLotSize();
   int ticket = OrderSend(Symbol(), inBuyOrderType, buy_lots, orderPrice, UseSlippage, stoploss, takeprofit, "ForexRootkitBandsDual v." + DoubleToString(version), 10000, 0, Blue);
   //Print("ticket: " + ticket + " | takeprofit: " + takeprofit);
   if (ticket > 0) {
      if (OrderSelect(ticket, SELECT_BY_TICKET, MODE_TRADES)) {
          Print("BUY order opened : lots = " + DoubleToString(buy_lots), OrderOpenPrice());
          buy_global_min = OrderOpenPrice();
      }
   } else {
      Print("Error opening BUY order : lots = " + DoubleToString(buy_lots),
      " : takeprofit = " + DoubleToString(takeprofit),
      " : stoploss = " + DoubleToString(stoploss),
      " : buy_lots = " + DoubleToString(buy_lots),
      " : ask = " + DoubleToString(orderPrice),
      GetLastError()); 
      //return(-1);
   }
}

void openSell(int inSellOrderType) {
   Print("Setting up SELL");
   while (IsTradeContextBusy()) {
      Print("Trade Context Busy - SELL");
      Sleep(10);
   }
   RefreshRates();
   double orderPrice = getSellOrderPrice(inSellOrderType);
   double takeprofit = GetSellTakeProfit(orderPrice);
   double stoploss = GetSellStopLoss(orderPrice);
   double sell_lots = getSellLotSize();
   int ticket = OrderSend(Symbol(), inSellOrderType, sell_lots, orderPrice, UseSlippage, stoploss, takeprofit, "ForexRootkitBandsDual v." + DoubleToString(version), 20000, 0, Red);
   //Print("ticket: " + ticket + " | takeprofit: " + takeprofit);
   if (ticket > 0) {
      if (OrderSelect(ticket, SELECT_BY_TICKET, MODE_TRADES)) {
         Print("SELL order opened : lots = " + DoubleToString(sell_lots), OrderOpenPrice());
         sell_global_max = OrderOpenPrice();
      }
   } else {
      Print("Error opening SELL order : lots = " + DoubleToString(sell_lots), 
            " : takeprofit = " + DoubleToString(takeprofit),
            " : stoploss = " + DoubleToString(stoploss),
            " : sell_lots = " + DoubleToString(sell_lots),
            " : bid = " + DoubleToString(orderPrice),
            GetLastError()); 

      //return(-1);
   }
}
double getSellOrderPrice(int inSellOrderType){
   switch(inSellOrderType){
      case OP_SELL:
         return Bid;
      case OP_SELLLIMIT:
         return Bid + (sellLimitBuffer * UsePoint);
      case OP_SELLSTOP:
         return Bid - (sellStopBuffer * UsePoint);
   }
   return -1;
}

double getBuyOrderPrice(int inBuyOrderType){
   switch(inBuyOrderType){
      case OP_BUY:
         return Ask;
      case OP_BUYLIMIT:
         return Ask - (buyLimitBuffer * UsePoint);
      case OP_BUYSTOP:
         return Ask + (buyStopBuffer * UsePoint);
   }
   return -1;
}

bool canOpenSell(){
   int totalOrders = OrdersTotal();
   for (int i = 0; i < totalOrders; i++) {
      double os = OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() == Symbol() && (OrderType() == OP_SELL || 
                                        OrderType() == OP_SELLLIMIT ||
                                        OrderType() == OP_SELLSTOP)) {
         double openPrice = OrderOpenPrice();
         if (!canOpenSell(sellPS, openPrice)){
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

bool canOpenBuy(){
   int totalOrders = OrdersTotal();
   if (totalOrders > 0) {
     for (int i = 0; i < totalOrders; i++) {
         double os = OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
         if (OrderSymbol() == Symbol() && (OrderType() == OP_BUY || 
                                           OrderType() == OP_BUYLIMIT ||
                                           OrderType() == OP_BUYSTOP)) {
             double openPrice = OrderOpenPrice();
             if (!canOpenBuy(buyPS, openPrice)){
                  return false;               
             }
         }
     }
   }
   return true;
}

bool canOpenBuy(double _buy_ps, double buy_price){
   double buy_psPoint = _buy_ps;// * Point;
   if (MathAbs(Ask - buy_price) > (buy_psPoint * UsePoint)){
      Print("canOpenBuy: " + IntegerToString(true));
      return true;
   }
   Print("canOpenBuy: " + IntegerToString(false));
   return false;
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

void closeBuyOrdersInProfit() {
    RefreshRates();
    int totalOrders = OrdersTotal();
    for(int i = 0; i < totalOrders; i++) {
        double os = OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
        if (OrderType() == OP_BUY && OrderSymbol() == Symbol()) {
            while (IsTradeContextBusy()) Sleep(10);
            RefreshRates();
            bool closed = false;
            double takeprofit;
            bool timeToClose = false;
            takeprofit = OrderOpenPrice() + GetBuyTakeProfit(0);
            if (Bid >= takeprofit) {
                closed = OrderClose(OrderTicket(), OrderLots(), Bid, 3, Violet);
                if (!closed) {
                    Print("Error closing order in profit - BUY: " + IntegerToString(OrderTicket()) + ", lots: " + DoubleToString(OrderLots()) + " " + IntegerToString(GetLastError()));   
                }
            }
        }
    }
    //return(0);
}

void closeSellOrdersInProfit() {
    RefreshRates();
    int totalOrders = OrdersTotal();
    for(int i = 0; i < totalOrders; i++) {
        double os =OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
        if (OrderType() == OP_SELL && OrderSymbol() == Symbol()) {
            while (IsTradeContextBusy()) Sleep(10);
            RefreshRates();
            bool closed = false;
            double takeprofit = OrderOpenPrice() - GetSellTakeProfit(0);;
            if (Ask <= takeprofit) {
               closed = OrderClose(OrderTicket(), OrderLots(), Ask, 3, Violet);
               if (!closed) {
                   Print("Error closing order in profit - SELL: " + IntegerToString(OrderTicket()) + ", lots: " + DoubleToString(OrderLots()) + " " + IntegerToString(GetLastError()));   
               }
            }
        }
    }
    //return(0);
}

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