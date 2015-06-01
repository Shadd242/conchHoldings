//+------------------------------------------------------------------+
//|                                               forexrootKitEA.mq4 |
//|                               Copyright 2015, Conchman Holdings. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, Conchman Holdings."
#property link      "http://www.mql5.com"
#property strict

//External parameters
extern int slippage = 5;

extern int stopLossMode = -1;//StopLossMode | -1 - Explicit
extern double buyStopLoss = 250;//Buy StopLoss in pips
extern double sellStopLoss = 250;//Sell StopLoss in pips

extern int takeProfitMode = -1;//TakeProfitMode | -1 - Explicit
extern double buyTakeProfit = 250;//Buy take profit in pips
extern double sellTakeProfit = 250;//Sell take profit in pips

//Need to make psMode
extern int buyPS = 125;//Pip distance between buy orders
extern int sellPS = 125;//Pip distance between sell orders

extern double minLotSize = 0.01;//Min lot size

extern int buyRiskStep = 100;//Buy RiskStep
extern int sellRiskStep = 100;//Sell RiskStep

extern double maxLotSize = 20;//Max lot size

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
   double BuyStopLoss = 0;
   double sl = CalculateBuyStopLoss(stopLossMode);
   if(sl > 0) BuyStopLoss = OpenPrice - (sl * UsePoint);
   return BuyStopLoss;
}

double CalculateBuyStopLoss(int mode)
{
   double returnValue = 0;
   switch(mode){
      case 0: //Get pips by atr
         returnValue = 0;
      default:
         returnValue = buyStopLoss;
   }
   return returnValue;
}

//-----BUY Stop Loss

//-----Sell Stop Loss

double GetSellStopLoss(double OpenPrice){
   double SellStopLoss = 0;
   double sl = CalculateSellStopLoss(stopLossMode);
   if(sl > 0) SellStopLoss = OpenPrice + (sl * UsePoint);
   return SellStopLoss;
}

double CalculateSellStopLoss(int mode)
{
   double returnValue = 0;
   switch(mode){
      case 0: //Get pips by atr
         returnValue = 0;
      default:
         returnValue = sellStopLoss;
   }
   return returnValue;
}

//-----Sell Stop Loss

//-----BUY Take Profit

double GetBuyTakeProfit(double OpenPrice){
   double BuyTakeProfit = 0;
   double tp = CalculateBuyTakeProfit(takeProfitMode);
   if(tp > 0) BuyTakeProfit = OpenPrice + (tp * UsePoint);
   return BuyTakeProfit;
}

double CalculateBuyTakeProfit(int mode)
{
   double returnValue = 0;
   switch(mode){
      case 0: //Get pips by atr
         returnValue = 0;
      default:
         returnValue = buyTakeProfit;
   }
   return returnValue;
}

//-----BUY Take Profit

//-----SELL Take Profit

double GetSellTakeProfit(double OpenPrice){
   double SellTakeProfit = 0;
   double tp = CalculateSellTakeProfit(takeProfitMode);
   if(tp > 0) SellTakeProfit = OpenPrice - (tp * UsePoint);
   return SellTakeProfit;
}

double CalculateSellTakeProfit(int mode)
{
   double returnValue = 0;
   switch(mode){
      case 0: //Get pips by atr
         returnValue = 0;
      default:
         returnValue = sellTakeProfit;
   }
   return returnValue;
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

void openBuy() {
   Print("Setting up BUY");
   while (IsTradeContextBusy()) {
      Print("Trade Context Busy - BUY");
      Sleep(10);
   }
   RefreshRates();
   double takeprofit = GetBuyTakeProfit(Ask);
   double stoploss = GetBuyStopLoss(Ask);
   double buy_lots = getBuyLotSize();
   int ticket = OrderSend(Symbol(), OP_BUY, buy_lots, Ask, UseSlippage, stoploss, takeprofit, "ForexRootkitBandsDual v." + DoubleToString(version), 10000, 0, Blue);
   //Print("ticket: " + ticket + " | takeprofit: " + takeprofit);
   if (ticket > 0) {
      if (OrderSelect(ticket, SELECT_BY_TICKET, MODE_TRADES)) {
          Print("BUY order opened : lots = " + DoubleToString(buy_lots), OrderOpenPrice());
          buy_global_min = OrderOpenPrice();
      }
   } else {
      Print("Error opening BUY order : lots = " + DoubleToString(buy_lots), GetLastError()); 
      //return(-1);
   }
}

void openSell() {
   Print("Setting up SELL");
   while (IsTradeContextBusy()) {
      Print("Trade Context Busy - SELL");
      Sleep(10);
   }
   RefreshRates();
   double takeprofit = GetSellTakeProfit(Bid);
   double stoploss = GetSellStopLoss(Bid);
   double sell_lots = getSellLotSize();
   int ticket = OrderSend(Symbol(), OP_SELL, sell_lots, Bid, UseSlippage, stoploss, takeprofit, "ForexRootkitBandsDual v." + DoubleToString(version), 20000, 0, Red);
   //Print("ticket: " + ticket + " | takeprofit: " + takeprofit);
   if (ticket > 0) {
      if (OrderSelect(ticket, SELECT_BY_TICKET, MODE_TRADES)) {
         Print("SELL order opened : lots = " + DoubleToString(sell_lots), OrderOpenPrice());
         sell_global_max = OrderOpenPrice();
      }
   } else {
      Print("Error opening SELL order : lots = " + DoubleToString(sell_lots), GetLastError()); 
      //return(-1);
   }
}

bool canOpenSell(){
   double sell_psPoint = sellPS * Point;
   double sell_max = getSellMaxTrade();
   if (Bid >= sell_max + sell_psPoint) {
      return true;
   }
   return false;
}

bool canOpenBuy(){
   double buy_psPoint = buyPS * Point;
   double buy_min = getBuyMinTrade();
   if (Ask <= buy_min - buy_psPoint) {
      return true;
   }
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