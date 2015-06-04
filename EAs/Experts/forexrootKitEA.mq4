//+------------------------------------------------------------------+
//|                                               forexrootKitEA.mq4 |
//|                               Copyright 2015, Conchman Holdings. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+

#property copyright "Copyright 2015, Conchman Holdings."
#property link      "http://www.mql5.com"
#property strict

//External parameters
extern int slippage = 0;//slippage in piPs
extern double minLotSize = 0.01;
extern int buyRiskStep = 1000;//buyRiskStep in dollars
extern int sellRiskStep = 1000;//sellRiskStep in dollars
extern double maxLotSize = 20;

extern string PivotPointSectionStart = "----------------PIVOT POINT-------------";
extern int pivotTimeFrame = PERIOD_D1;//pivotTimeFrame | 1440 - PERIOD_D1 | 60 - PERIOD_H1 
extern string buyPivotPointSectionStart = "----------------buy-------------";
extern int buyPivotPointMode = 1;//buyPivotPointMode | -1 = None | 0 = Explicit | 1 = ATR
extern int buyPivotPointLineIndex = 3;//buyPivotPointLineIndex | -1 = pp | 0 = r1 | 1 = r2 | 2 = r3 | 3 = s1 | 4 = s2 | 5 = s3
extern int buyPivotDirection = 0;//buyPivotDirection | 0 = < | 1 = >
extern int buyPivotPointBuffer = 0;//buyPivotPointBuffer in piPs
extern int buyPivotPointARTTimeFrame = PERIOD_H1;//buyPivotPointARTTimeFrame | 1440 - PERIOD_D1 | 60 - PERIOD_H1
extern int buyPivotPointARTRange = 30;
extern int buyPivotPointARTShift = 0;
extern string sellPivotPointSectionStart = "----------------sell-------------";
extern int sellPivotPointMode = 1;//sellPivotPointMode | -1 = None | 0 = Explicit | 1 = ATR
extern int sellPivotPointLineIndex = 0;//sellPivotPointLineIndex | -1 = pp | 0 = r1 | 1 = r2 | 2 = r3 | 3 = s1 | 4 = s2 | 5 = s3
extern int sellPivotDirection = 1;//sellPivotDirection | 0 = < | 1 = >
extern int sellPivotPointBuffer = 0;//sellPivotPointBuffer in piPs
extern int sellPivotPointARTTimeFrame = PERIOD_H1;//sellPivotPointARTTimeFrame | 1440 - PERIOD_D1 | 60 - PERIOD_H1
extern int sellPivotPointARTRange = 30;
extern int sellPivotPointARTShift = 0;
extern string PivotPointSectionEnd = "----------------PIVOT POINT-------------";

extern string StopLossSectionStart = "----------------STOP LOSS-------------";
extern string buyStopLossSectionStart = "----------------buy-------------";
extern int buyStopLossMode = 1;//buyStopLossMode | -1 & 0 = Explicit | 1 = ATR
extern double buyStopLoss = 250;//buyStopLoss in piPs
extern int buyStopLossATRTimeFrame = PERIOD_D1;//buyStopLossATRTimeFrame | 1440 - PERIOD_D1 | 60 - PERIOD_H1
extern int buyStopLossATRPeriod = 30;
extern int buyStopLossATRShift = 0;
extern string sellStopLossSectionStart = "----------------sell-------------";
extern int sellStopLossMode = 1;//sellStopLossMode | -1 & 0 = Explicit | 1 = ATR
extern double sellStopLoss = 250;//sellStopLoss in piPs
extern int sellStopLossATRTimeFrame = PERIOD_D1;//sellStopLossATRTimeFrame | 1440 - PERIOD_D1 | 60 - PERIOD_H1
extern int sellStopLossATRPeriod = 30;
extern int sellStopLossATRShift = 0;
extern string StopLossSectionEnd = "----------------STOP LOSS-------------";

extern string TakeProfitSectionStart = "----------------TAKE PROFIT-------------";
extern string buyTakeProfitSectionStart = "----------------buy-------------";
extern int buyTakeProfitMode = 1;//buyTakeProfitMode | -1 & 0 = Explicit | 1 = ATR
extern double buyTakeProfit = 10;//buyTakeProfit in piPs
extern int buyTakeProfitATRTimeFrame = PERIOD_H1;//buyTakeProfitATRTimeFrame | 1440 - PERIOD_D1 | 60 - PERIOD_H1
extern int buyTakeProfitATRPeriod = 30;
extern int buyTakeProfitATRShift = 0;
extern string sellTakeProfitSectionStart = "----------------sell-------------";
extern int sellTakeProfitMode = 1;//sellTakeProfitMode | -1 & 0 = Explicit | 1 = ATR
extern double sellTakeProfit = 10;//sellTakeProfit in piPs
extern int sellTakeProfitATRTimeFrame = PERIOD_H1;//sellTakeProfitATRTimeFrame | 1440 - PERIOD_D1 | 60 - PERIOD_H1
extern int sellTakeProfitATRPeriod = 30;
extern int sellTakeProfitATRShift = 0;
extern string TakeProfitSectionEnd = "----------------TAKE PROFIT-------------";

extern string PipStepSectionStart = "----------------PIP STEP-------------";
extern string buyPipStepSectionStart = "----------------buy-------------";
extern int buyPipStepMode = 1;//buyPipStepMode | -1 = Explicit | 1 = ATR
extern int buyPS = 100;//buyPS in piPs
extern int buyPipStepATRTimeFrame = PERIOD_D1;//buyPipStepATRTimeFrame | 1440 - PERIOD_D1 | 60 - PERIOD_H1
extern int buyPipStepATRPeriod = 30;
extern int buyPipStepATRShift = 0;
extern string sellPipStepSectionStart = "----------------sell-------------";
extern int sellPipStepMode = 1;//sellPipStepMode | -1 = Explicit | 1 = ATR
extern int sellPS = 100;//sellPS in piPs
extern int sellPipStepATRTimeFrame = PERIOD_D1;//sellPipStepATRTimeFrame | 1440 - PERIOD_D1 | 60 - PERIOD_H1
extern int sellPipStepATRPeriod = 30;
extern int sellPipStepATRShift = 0;
extern string PipStepSectionEnd = "----------------PIP STEP-------------";

extern string EmptyOrderSectionStart = "----------------EMPTY ORDER MODE-------------";
extern string buyEmptyOrderSectionStart = "----------------buy-------------";
extern int buyEmptyOrderMode = 0; //buyEmptyOrderMode | 0 = Market | 1 = LIMIT | 2 = STOP
extern double buyLimitBuffer = 50;//buyLimitBuffer in piPs
extern double buyStopBuffer = 50;//buyStopBuffer in piPs
extern string sellEmptyOrderSectionStart = "----------------sell-------------";
extern int sellEmptyOrderMode = 0; //sellEmptyOrderMode | 0 = Market | 1 = LIMIT | 2 = STOP
extern double sellLimitBuffer = 50;//sellLimitBuffer in piPs
extern double sellStopBuffer = 50;//sellStopBuffer in piPs
extern string EmptyOrderSectionEnd = "----------------EMPTY ORDER MODE-------------";

double buyPivotPointLine = 0;
double sellPivotPointLine = 0;

//Global Variables
double UsePoint;
int UseSlippage;
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
//----  
   getPivots();
   buyPivotPointLine = getPivotValue(buyPivotPointLineIndex);
   sellPivotPointLine = getPivotValue(sellPivotPointLineIndex);
   if (canOpenBuy() &&
       buyPivotPointLogic()){
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
         case 0:
            openBuy(OP_BUY);
            break;
      }
   }
   if (canOpenSell() &&
       sellPivotPointLogic()){
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
         case 0:
            openSell(OP_SELL);
            break;
      }
   }
   if (sellTakeProfitMode > -1){
      closeSellOrdersInProfit();
      closeSellOrdersInLoss();
   }
   if (buyTakeProfitMode > -1){
      closeBuyOrdersInProfit();
      closeBuyOrdersInLoss();
   }
   hud();
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
   switch(buyStopLossMode){
      case 0:
         if(OpenPrice > 0){
            return 0;
         }else{
            return (buyStopLoss * UsePoint);
         }
      case 1:
         if(OpenPrice > 0){
            return 0;
         }else{
            return getATR(buyStopLossATRTimeFrame,buyStopLossATRPeriod,buyStopLossATRShift);
         }          
      default:
         return _buyStopLoss;
   }
}

//-----BUY Stop Loss

//-----Sell Stop Loss

double GetSellStopLoss(double OpenPrice){
   double _sellStopLoss = OpenPrice + (sellStopLoss * UsePoint);
   switch(sellStopLossMode){
      case 0:
         if(OpenPrice > 0){
            return 0;
         }else{
            return (sellStopLoss * UsePoint);
         }      
      case 1:
         if(OpenPrice > 0){
            return 0;
         }else{
            return getATR(sellStopLossATRTimeFrame,sellStopLossATRPeriod,sellStopLossATRShift);
         }       
      default:         
         return _sellStopLoss;
   }
}

//-----Sell Stop Loss

//-----BUY Take Profit

double GetBuyTakeProfit(double OpenPrice){
   double _buyTakeProfit = OpenPrice + (buyTakeProfit * UsePoint);
   switch(buyTakeProfitMode){
      case 0:
         if(OpenPrice > 0){
            return 0;
         }else{
            return (buyTakeProfit * UsePoint);
         }
      case 1: 
         if(OpenPrice > 0){
            return 0;
         }else{
            return getATR(buyTakeProfitATRTimeFrame,buyTakeProfitATRPeriod,buyTakeProfitATRShift);
         }      
      default:
         return _buyTakeProfit; 
   }
}

//-----BUY Take Profit

//-----SELL Take Profit

double GetSellTakeProfit(double OpenPrice){
   double _sellTakeProfit = OpenPrice - (sellTakeProfit * UsePoint);
   switch(sellTakeProfitMode){
      case 0:
         if (OpenPrice > 0){
            return 0;
         }else{
            return (sellTakeProfit * UsePoint);
         }  
      case 1:
         if (OpenPrice > 0){
            return 0;
         }else{
            return getATR(buyTakeProfitATRTimeFrame,buyTakeProfitATRPeriod,buyTakeProfitATRShift);
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
   if (ticket > 0) {
      if (OrderSelect(ticket, SELECT_BY_TICKET, MODE_TRADES)) {
          Print("BUY order opened : lots = " + DoubleToString(buy_lots), OrderOpenPrice());
      }
   } else {
      Print("Error opening BUY order : lots = " + DoubleToString(buy_lots),
      " : takeprofit = " + DoubleToString(takeprofit),
      " : stoploss = " + DoubleToString(stoploss),
      " : buy_lots = " + DoubleToString(buy_lots),
      " : ask = " + DoubleToString(orderPrice),
      GetLastError()); 
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
   if (ticket > 0) {
      if (OrderSelect(ticket, SELECT_BY_TICKET, MODE_TRADES)) {
         Print("SELL order opened : lots = " + DoubleToString(sell_lots), OrderOpenPrice());
      }
   } else {
      Print("Error opening SELL order : lots = " + DoubleToString(sell_lots), 
            " : takeprofit = " + DoubleToString(takeprofit),
            " : stoploss = " + DoubleToString(stoploss),
            " : sell_lots = " + DoubleToString(sell_lots),
            " : bid = " + DoubleToString(orderPrice),
            GetLastError()); 
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
         if (!canOpenSell(getSellPs(), openPrice)){
            return false;
         }
      }
   }
   return true;
}

bool canOpenSell(double _sell_ps, double sell_price){
   double sell_psPoint = _sell_ps;// * Point; 
   if (MathAbs(Bid - sell_price) > sell_psPoint){
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
             if (!canOpenBuy(getBuyPs(), openPrice)){
                  return false;               
             }
         }
     }
   }
   return true;
}

bool canOpenBuy(double _buy_ps, double buy_price){
   double buy_psPoint = _buy_ps;// * Point;
   if (MathAbs(Ask - buy_price) > buy_psPoint){
      Print("canOpenBuy: " + IntegerToString(true));
      return true;
   }
   Print("canOpenBuy: " + IntegerToString(false));
   return false;
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
            double takeprofit = OrderOpenPrice() - GetSellTakeProfit(0);
            if (Ask <= takeprofit) {
               closed = OrderClose(OrderTicket(), OrderLots(), Ask, 3, Violet);
               if (!closed) {
                   Print("Error closing order in profit - SELL: " + IntegerToString(OrderTicket()) + ", lots: " + DoubleToString(OrderLots()) + " " + IntegerToString(GetLastError()));   
               }
            }
        }
    }
}

void closeSellOrdersInLoss() {
    RefreshRates();
    int totalOrders = OrdersTotal();
    for(int i = 0; i < totalOrders; i++) {
        double os =OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
        if (OrderSymbol() == Symbol() && (OrderType() == OP_SELL || 
                                          OrderType() == OP_SELLLIMIT ||
                                          OrderType() == OP_SELLSTOP)) {
            while (IsTradeContextBusy()) Sleep(10);
            RefreshRates();
            bool closed = false;
            double stoploss = OrderOpenPrice() + GetSellStopLoss(0);
            if (Ask >= stoploss) {
               closed = OrderClose(OrderTicket(), OrderLots(), Ask, 3, Violet);
               if (!closed) {
                   Print("Error closing order in profit - SELL: " + IntegerToString(OrderTicket()) + ", lots: " + DoubleToString(OrderLots()) + " " + IntegerToString(GetLastError()));   
               }
            }
        }
    }
}

void closeBuyOrdersInLoss() {
    RefreshRates();
    int totalOrders = OrdersTotal();
    for(int i = 0; i < totalOrders; i++) {
        double os = OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
        if (OrderSymbol() == Symbol() && (OrderType() == OP_BUY || 
                                          OrderType() == OP_BUYLIMIT ||
                                          OrderType() == OP_BUYSTOP)) {
            while (IsTradeContextBusy()) Sleep(10);
            RefreshRates();
            bool closed = false;
            bool timeToClose = false;
            double stoploss = OrderOpenPrice() - GetBuyStopLoss(0);
            if (Bid <= stoploss) {
                closed = OrderClose(OrderTicket(), OrderLots(), Bid, 3, Violet);
                if (!closed) {
                    Print("Error closing order in profit - BUY: " + IntegerToString(OrderTicket()) + ", lots: " + DoubleToString(OrderLots()) + " " + IntegerToString(GetLastError()));   
                }
            }
        }
    }
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
        if (OrderSymbol() == Symbol() && (OrderType() == OP_BUY 
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
        if (OrderSymbol() == Symbol() && (OrderType() == orderType
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
        if (OrderSymbol() == Symbol() && (OrderType() == OP_SELL
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
        if (OrderSymbol() == Symbol() && (OrderType() == orderType
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

double getATR(int timeframe, int period, int shift) {
   return iATR(NULL,timeframe,period,shift);
}

double getBuyPs(){
   switch(buyPipStepMode){
      case 0:
         return getATR(buyPipStepATRTimeFrame,buyPipStepATRPeriod,buyPipStepATRShift);
      default:
         return buyPS * UsePoint;
   }
}

double getSellPs(){
   switch(sellPipStepMode){
      case 0:
         return getATR(sellPipStepATRTimeFrame,sellPipStepATRPeriod,sellPipStepATRShift);
      default:
         return sellPS * UsePoint;
   }
}


double pivotPoint;
double r1;
double r2;
double r3;
double s1;
double s2;
double s3;

void getPivots(){
   double close = iClose(NULL,pivotTimeFrame,1);
   double high = iHigh(NULL,pivotTimeFrame,1);
   double low = iLow(NULL,pivotTimeFrame,1);
   pivotPoint = (high + low + close) / 3;
   r1 = (2 * pivotPoint) - low;
   s1 = (2 * pivotPoint) - high;
   r2 = (pivotPoint - s1) + r1;
   s2 = pivotPoint - (r1 - s1);
   r3 = (pivotPoint - s2) + r2;
   s3 = pivotPoint - (r2 - s2);
   
   drawLine("dailyPivotPoint",pivotPoint,24,clrYellow);
   drawLine("r1",r1,24,clrDeepSkyBlue);
   drawLine("r2",r2,24,clrDodgerBlue);
   drawLine("r3",r3,24,clrBlue);
   drawLine("s1",s1,24,clrLightPink);
   drawLine("s2",s2,24,clrDeepPink);
   drawLine("s3",s3,24,clrRed);
}

void drawLine(string objectName, double price, int length, color objColor){
   ObjectDelete(objectName);
   ObjectCreate(objectName, OBJ_TREND, 0, Time[0], price, Time[length], price);
   ObjectSet(objectName, OBJPROP_RAY, false);
   ObjectSet(objectName, OBJPROP_COLOR, objColor);
}

bool checkDirection(int direction, double inLine, double inPrice){
   switch(direction){
      case 0:
         if(inPrice < inLine){
            return true;
         }else{
            return false;
         }
         break;
      case 1:
         if(inPrice > inLine){
            return true;
         }else{
            return false;
         }
         break;
   }
   return false;
}

bool buyPivotPointLogic(){
   double priceDiff = MathAbs(Ask - buyPivotPointLine);
   if (buyPivotPointMode < 0)
      return true;
   if (checkDirection(buyPivotDirection,buyPivotPointLine,Ask)){
      switch(buyPivotPointMode){
         case 0:
            if(priceDiff > (buyPivotPointBuffer * UsePoint)){
               return true;
            }else{
               return false;
            }
         case 1:
            if(priceDiff > getATR(buyPivotPointARTTimeFrame,buyPivotPointARTRange,buyPivotPointARTShift)){
               return true;
            }else{
               return false;
            }
      }
   }
   return false;
}

bool sellPivotPointLogic(){
   double priceDiff = MathAbs(Bid - sellPivotPointLine);
   if (sellPivotPointMode < 0)
      return true;
   if (checkDirection(sellPivotDirection,sellPivotPointLine,Bid)){
      switch(sellPivotPointMode){
         case 0:
            if(priceDiff > (sellPivotPointBuffer * UsePoint)){
               return true;
            }else{
               return false;
            }
         case 1:
            if(priceDiff > getATR(sellPivotPointARTTimeFrame,sellPivotPointARTRange,sellPivotPointARTShift)){
               return true;
            }else{
               return false;
            }
      }
   }
   return false;
}

double getPivotValue(int inLineIndex){
   switch(inLineIndex){
      default:
         return pivotPoint;
      case 0:
         return r1;
      case 1:
         return r2;
      case 2:
         return r3;
      case 3:
         return s1;
      case 4:
         return s2;
      case 5:
         return s3;                                    
   }
}

void hud() {
    double buy_psPoint = buyPS * UsePoint;  
    double sell_psPoint = sellPS * UsePoint;
    
    double buy_tp = GetBuyTakeProfit(0);
    double sell_tp = GetSellTakeProfit(0);
    
    double buy_sl = GetBuyStopLoss(0);
    double sell_sl = GetSellStopLoss(0);
    
    double buy_lots = getBuyLotSize();
    double sell_lots = getSellLotSize();
    
    Comment(
        "ForexRootkitBandsDual v." + DoubleToString(version) , "\n",      
        "enabled = " + IntegerToString(IsExpertEnabled()) + "\n" +
        "trade allowed = " + IntegerToString(IsTradeAllowed()) + "\n" +
        "optimization = " + IntegerToString(IsOptimization()) + "\n" +
        "testing = " + IntegerToString(IsTesting()) + "\n" +
        "demo = " + IntegerToString(IsDemo()) + "\n" +
        "stopped = " + IntegerToString(IsStopped()) + "\n" +
        "connected = " + IntegerToString(IsConnected()) + "\n\n" +     
        "buy_lots = " + DoubleToStr(buy_lots, 2) + ", sell_lots = " + DoubleToStr(sell_lots, 2), "\n",
        "buy rs = " + IntegerToString(buyRiskStep) + ", sell_rs = " + IntegerToString(sellRiskStep), "\n",        
        "buy_ps = " + IntegerToString(buyPS) + ", sell_ps = " + IntegerToString(sellPS), "\n",
        "buy_tp = " + DoubleToStr(buy_tp, 0) + ", sell_tp = " + DoubleToStr(sell_tp, 0), "\n",
        "buy_sl = " + DoubleToStr(buy_sl, 0) + ", sell_sl = " + DoubleToStr(sell_sl, 0), "\n",
        "bid = "  + DoubleToStr(Bid, 4), "\n",
        "ask = "  + DoubleToStr(Ask, 4), "\n", "\n",
        "spread = " + DoubleToStr((Ask-Bid)*10000, 1), "\n\n",
        "tc = " + IntegerToString(getTradeCount()) + ", buy tc = " + IntegerToString(getBuyTradeCount()) + ", sell tc = " + IntegerToString(getSellTradeCount()), "\n\n",
        "sellTakeProfitMode = " + IntegerToString(sellTakeProfitMode), "\n",
        "buyTakeProfitMode = " + IntegerToString(buyTakeProfitMode), "\n",
        "sellStopLossMode = " + IntegerToString(sellStopLossMode), "\n",
        "buystopLossMode = " + IntegerToString(buyStopLossMode), "\n\n",
        "buy_tp amount = $" + DoubleToStr(buy_tp * buy_lots, 2) + ", sell_tp amount = $" + DoubleToStr(sell_tp * sell_lots, 2), "\n",
        "buy_sl amount = $" + DoubleToStr(buy_sl * buy_lots, 2) + ", sell_sl amount = $" + DoubleToStr(sell_sl * sell_lots, 2), "\n\n",
        "account balance = $" + DoubleToStr(AccountBalance(), 2), "\n",
        "account equity = $" + DoubleToStr(AccountEquity(), 2), "\n",
        "account margin = $" + DoubleToStr(AccountMargin(), 2) + "\n",
        "account free margin = $" + DoubleToStr(AccountFreeMargin(), 2) +  "\n\n",
        "% drawdown = " + DoubleToStr((100-((AccountEquity()-AccountCredit())/AccountBalance())*100), 2) + "\n"
    );
}