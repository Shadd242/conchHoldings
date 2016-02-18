//+------------------------------------------------------------------+
//|                                               forexrootKitEA.mq4 |
//|                               Copyright 2015, Conchman Holdings. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+

#property copyright "Copyright 2015, Conchman Holdings."
#property link      "http://www.mql5.com"
#property strict

//External parameters
int slippage = 7;//slippage in piPs
double minLotSize = 0.01;
int buyRiskStep = 1000;//buyRiskStep in dollars
int sellRiskStep = 1000;//sellRiskStep in dollars
double maxLotSize = 20;

string researchSignal = "";

string PivotPointSectionStart = "----------------PIVOT POINT-------------";
int buyPivotTimeFrame = PERIOD_D1;//pivotTimeFrame | 1440 - PERIOD_D1 | 60 - PERIOD_H1 
string buyPivotPointSectionStart = "----------------buy-------------";
int buyPivotPointMode = 1;//buyPivotPointMode | -1 = None | 0 = Explicit | 1 = ATR
int buyPivotPointLineIndex = -1;//buyPivotPointLineIndex | -1 = pp | 0 = r1 | 1 = r2 | 2 = r3 | 3 = s1 | 4 = s2 | 5 = s3
int buyPivotDirection = 0;//buyPivotDirection | 0 = < | 1 = >
int buyPivotPointBuffer = 0;//buyPivotPointBuffer in piPs
int buyPivotPointATRTimeFrame = PERIOD_D1;//buyPivotPointATRTimeFrame | 1440 - PERIOD_D1 | 60 - PERIOD_H1
int buyPivotPointATRPeriod = 30;
int buyPivotPointATRShift = 0;
string sellPivotPointSectionStart = "----------------sell-------------";
int sellPivotTimeFrame = PERIOD_D1;//pivotTimeFrame | 1440 - PERIOD_D1 | 60 - PERIOD_H1 
int sellPivotPointMode = 1;//sellPivotPointMode | -1 = None | 0 = Explicit | 1 = ATR
int sellPivotPointLineIndex = -1;//sellPivotPointLineIndex | -1 = pp | 0 = r1 | 1 = r2 | 2 = r3 | 3 = s1 | 4 = s2 | 5 = s3
int sellPivotDirection = 1;//sellPivotDirection | 0 = < | 1 = >
int sellPivotPointBuffer = 0;//sellPivotPointBuffer in piPs
int sellPivotPointATRTimeFrame = PERIOD_D1;//sellPivotPointATRTimeFrame | 1440 - PERIOD_D1 | 60 - PERIOD_H1
int sellPivotPointATRPeriod = 30;
int sellPivotPointATRShift = 0;
string PivotPointSectionEnd = "----------------PIVOT POINT-------------";

string MASectionStart = "----------------MA-------------";
string buyMASectionStart = "----------------buy-------------";
int buyMAMode = 1;//buyMAMode | 0 = Explicit | 1 = ATR
int buyMAType = MODE_SMA;//buyMAType | / = MODE_SMA | / = MODE_EMA
int buyMATimeFrame = PERIOD_D1;//buyMATimeFrame | 1440 - PERIOD_D1 | 60 - PERIOD_H1
int buyMAPeriod = 30;
int buyMAShift = 0;
int buyMADirection = 0;//buyMADirection | 0 = < | 1 = >
int buyMABuffer = 25;//buyMABuffer in piPs
int buyMAATRTimeFrame = PERIOD_D1;//buyMAATRTimeFrame | 1440 - PERIOD_D1 | 60 - PERIOD_H1
int buyMAATRPeriod = 30;
int buyMAATRShift = 0;
string sellMASectionStart = "----------------sell-------------";
int sellMAMode = 1;//sellMAMode | 0 = Explicit | 1 = ATR
int sellMAType = MODE_SMA;//sellMAType | / = MODE_SMA | / = MODE_EMA
int sellMATimeFrame = PERIOD_D1;//sellMATimeFrame | 1440 - PERIOD_D1 | 60 - PERIOD_H1
int sellMAPeriod = 30;
int sellMAShift = 0;
int sellMADirection = 1;//sellMADirection | 0 = < | 1 = >
int sellMABuffer = 25;//sellMABuffer in piPs
int sellMAATRTimeFrame = PERIOD_D1;//sellMAATRTimeFrame | 1440 - PERIOD_D1 | 60 - PERIOD_H1
int sellMAATRPeriod = 30;
int sellMAATRShift = 0;
string MASectionEnd = "----------------MA-------------";

string StopLossSectionStart = "----------------STOP LOSS-------------";
string buyStopLossSectionStart = "----------------buy-------------";
int buyStopLossMode = 1;//buyStopLossMode | -1 & 0 = Explicit | 1 = ATR
double buyStopLossBuffer = 250;//buyStopLoss in piPs
int buyStopLossATRTimeFrame = PERIOD_D1;//buyStopLossATRTimeFrame | 1440 - PERIOD_D1 | 60 - PERIOD_H1
int buyStopLossATRPeriod = 30;
int buyStopLossATRShift = 0;
string sellStopLossSectionStart = "----------------sell-------------";
int sellStopLossMode = 1;//sellStopLossMode | -1 & 0 = Explicit | 1 = ATR
double sellStopLossBuffer = 250;//sellStopLoss in piPs
int sellStopLossATRTimeFrame = PERIOD_D1;//sellStopLossATRTimeFrame | 1440 - PERIOD_D1 | 60 - PERIOD_H1
int sellStopLossATRPeriod = 30;
int sellStopLossATRShift = 0;
string StopLossSectionEnd = "----------------STOP LOSS-------------";

string TakeProfitSectionStart = "----------------TAKE PROFIT-------------";
string buyTakeProfitSectionStart = "----------------buy-------------";
int buyTakeProfitMode = 1;//buyTakeProfitMode | -1 & 0 = Explicit | 1 = ATR
double buyTakeProfitBuffer = 10;//buyTakeProfit in piPs
int buyTakeProfitATRTimeFrame = PERIOD_D1;//buyTakeProfitATRTimeFrame | 1440 - PERIOD_D1 | 60 - PERIOD_H1
int buyTakeProfitATRPeriod = 30;
int buyTakeProfitATRShift = 0;
string sellTakeProfitSectionStart = "----------------sell-------------";
int sellTakeProfitMode = 1;//sellTakeProfitMode | -1 & 0 = Explicit | 1 = ATR
double sellTakeProfitBuffer = 10;//sellTakeProfit in piPs
int sellTakeProfitATRTimeFrame = PERIOD_D1;//sellTakeProfitATRTimeFrame | 1440 - PERIOD_D1 | 60 - PERIOD_H1
int sellTakeProfitATRPeriod = 30;
int sellTakeProfitATRShift = 0;
string TakeProfitSectionEnd = "----------------TAKE PROFIT-------------";

string PipStepSectionStart = "----------------PIP STEP-------------";
string buyPipStepSectionStart = "----------------buy-------------";
int buyPipStepMode = 1;//buyPipStepMode | -1 = Explicit | 1 = ATR
int buyPSBuffer = 100;//buyPS in piPs
int buyPipStepATRTimeFrame = PERIOD_D1;//buyPipStepATRTimeFrame | 1440 - PERIOD_D1 | 60 - PERIOD_H1
int buyPipStepATRPeriod = 30;
int buyPipStepATRShift = 0;
string sellPipStepSectionStart = "----------------sell-------------";
int sellPipStepMode = 1;//sellPipStepMode | -1 = Explicit | 1 = ATR
int sellPSBuffer = 100;//sellPS in piPs
int sellPipStepATRTimeFrame = PERIOD_D1;//sellPipStepATRTimeFrame | 1440 - PERIOD_D1 | 60 - PERIOD_H1
int sellPipStepATRPeriod = 30;
int sellPipStepATRShift = 0;
string PipStepSectionEnd = "----------------PIP STEP-------------";

string EmptyOrderSectionStart = "----------------EMPTY ORDER MODE-------------";
string buyEmptyOrderSectionStart = "----------------buy-------------";
int buyEmptyOrderMode = 0; //buyEmptyOrderMode | 0 = Market | 1 = LIMIT | 2 = STOP
double buyLimitBuffer = 50;//buyLimitBuffer in piPs
double buyStopBuffer = 50;//buyStopBuffer in piPs
string sellEmptyOrderSectionStart = "----------------sell-------------";
int sellEmptyOrderMode = 0; //sellEmptyOrderMode | 0 = Market | 1 = LIMIT | 2 = STOP
double sellLimitBuffer = 50;//sellLimitBuffer in piPs
double sellStopBuffer = 50;//sellStopBuffer in piPs
string EmptyOrderSectionEnd = "----------------EMPTY ORDER MODE-------------";

double buyPivotPointLine = 0;
double sellPivotPointLine = 0;

datetime barTime=0;

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

bool useLondonSession = true;
string londonSessionStartString = "07:00";
string londonSessionEndString = "17:00";
datetime londonSessionStart = 0;
datetime londonSessionEnd=0;
bool inLondonSession = false;

bool useAmericaSession = true;
string americaSessionStartString = "13:00";
string americaSessionEndString = "23:00";
datetime americaSessionStart = 0;
datetime americaSessionEnd=0;
bool inAmericaSession = false;

string _canOpenBuy = "";
string _buyPivotPointLogic = "";
string _buyMALogic = "";

string _canOpenSell = "";
string _sellPivotPointLogic = "";
string _sellMALogic = "";

string InpFileName="Sym.txt"; // file name
//input string InpDirectoryName="C:\\Users\\Rashad\\Documents\\comms"; // directory name C:\Users\Rashad\Documents\comms
string sym;
int bars;

bool buyOpenOnBar = false;
bool sellOpenOnBar = false;

void OnTick()
  {
//----  
   sym = Symbol();
   StringReplace(sym, "i", "");
   InpFileName = sym + ".txt";
   if (bars != Bars){
      buyOpenOnBar = false;
      sellOpenOnBar = false;
      bars = Bars;
      readFile();
      getBuyPivots();
      getSellPivots();
   }
   readFile(sym + "-PatResult.txt");
   saveCurrentPattern(10);
   barTime = Time[0];
   londonSessionStart = StrToTime(StringSubstr(TimeToStr(barTime),0,11) + londonSessionStartString);
   londonSessionEnd = StrToTime(StringSubstr(TimeToStr(barTime),0,11) + londonSessionEndString);
   americaSessionStart = StrToTime(StringSubstr(TimeToStr(barTime),0,11) + americaSessionStartString);
   americaSessionEnd = StrToTime(StringSubstr(TimeToStr(barTime),0,11) + americaSessionEndString);
   buyPivotPointLine = getBuyPivotValue(buyPivotPointLineIndex);
   sellPivotPointLine = getSellPivotValue(sellPivotPointLineIndex);
   inLondonSession = isInSession(londonSessionStart,londonSessionEnd,useLondonSession);
   inAmericaSession = isInSession(americaSessionStart,americaSessionEnd,useAmericaSession);
   
   _canOpenBuy = canOpenBuy();
   _buyPivotPointLogic = buyPivotPointLogic();
   _buyMALogic = buyMALogic();
   
   _canOpenSell = canOpenSell();
   _sellPivotPointLogic = sellPivotPointLogic();
   _sellMALogic = sellMALogic();
   
   if (_canOpenBuy == true &&
       _buyPivotPointLogic == true && 
       _buyMALogic == true &&
       inLondonSession == false &&
       inAmericaSession == false &&
       researchSignal == "buy" &&
       buyOpenOnBar == false
       ){
       
      //Print("canOpenBuy = " + _canOpenBuy);
      //Print("buyPivotPointLogic = " + _buyPivotPointLogic);
      //Print("buyMALogic = " + _buyMALogic);
   
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
   if (canOpenSell() == true &&
       sellPivotPointLogic() == true &&
       sellMALogic() == true &&
       inLondonSession == false &&
       inAmericaSession == false &&
       researchSignal == "sell" &&
       sellOpenOnBar == false
       ){
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
   
   //closeSellOrdersInProfit();
   //closeSellOrdersInLoss();
   
   //closeBuyOrdersInProfit();
   //closeBuyOrdersInLoss();
   
   //drawLine("avgNegOutcome",negOutcomePrice,48,clrRed); 
   //drawLine("avgPosOutcome",posOutcomePrice,48,clrBlue);
   
   if (sellTakeProfitMode > -1 && sellOpenOnBar == false
   ){
      closeSellOrdersInProfit();
      closeSellOrdersInLoss();
   }
   if (buyTakeProfitMode > -1 && buyOpenOnBar == false
   ){
      Print("buyTakeProfitMode= " + buyTakeProfitMode);
      closeBuyOrdersInProfit();
      closeBuyOrdersInLoss();
   }
   hud();
   
   //if (bars != Bars){
   //   Sleep(30000);
   //   bars = Bars;
   //}
}
  
  double posOutcomePrice = 0;
  double negOutcomePrice = 0;
  
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

double GetBuyStopLoss(double OpenPrice, int sender){
   double _buyStopLoss = OpenPrice - (buyStopLossBuffer * UsePoint);
   switch(buyStopLossMode){
      case 0:
         if (sender == 0){
            return 0;
         }
         if (sender == 1){
            return (buyStopLossBuffer * UsePoint);
         } 
      case 1:
         if (sender == 0){
            return 0;
         }
         if (sender == 1){
            return getATR(buyStopLossATRTimeFrame,buyStopLossATRPeriod,buyStopLossATRShift);
         }         
      default:
         return 0;
   }
}

//-----BUY Stop Loss

//-----Sell Stop Loss

double GetSellStopLoss(double OpenPrice, int sender){
   double _sellStopLoss = OpenPrice + (sellStopLossBuffer * UsePoint);
   switch(sellStopLossMode){
      case 0:
         if (sender == 0){
            return 0;
         }
         if (sender == 1){
            return (sellStopLossBuffer * UsePoint);
         }    
      case 1:     
         if (sender == 0){
            return 0;
         }
         if (sender == 1){
            return getATR(sellStopLossATRTimeFrame,sellStopLossATRPeriod,sellStopLossATRShift);
         }      
      default:         
         return 0;
   }
}

//-----Sell Stop Loss

//-----BUY Take Profit

double GetBuyTakeProfit(double OpenPrice, int sender){
   double _buyTakeProfit = OpenPrice + (buyTakeProfitBuffer * UsePoint);
   switch(buyTakeProfitMode){
      case 0:
         if (sender == 0){
            return 0;
         }
         if (sender == 1){
            return (buyTakeProfitBuffer * UsePoint);
            //return getPosAvgOutcomePrice(OpenPrice);
         }
      case 1:
         if (sender == 0){
            return 0;
         }
         if (sender == 1){
            return getATR(buyTakeProfitATRTimeFrame,buyTakeProfitATRPeriod,buyTakeProfitATRShift);
         }      
      default:
         return 0; 
   }
}

//-----BUY Take Profit

//-----SELL Take Profit
//sender who is calling the method. 0 = open order | 1 = close order
double GetSellTakeProfit(double OpenPrice, int sender){
   double _sellTakeProfit = OpenPrice - (sellTakeProfitBuffer * UsePoint);
   switch(sellTakeProfitMode){
      case 0:
         if (sender == 0){
            return 0;
         }
         if (sender == 1){
            return (sellTakeProfitBuffer * UsePoint);
            //return getNegAvgOutcomePrice(OpenPrice);
         }
      case 1:
         if (sender == 0){
            return 0;
         }
         if (sender == 1){
            return getATR(buyTakeProfitATRTimeFrame,buyTakeProfitATRPeriod,buyTakeProfitATRShift);
         }  
      default:
         return 0;  
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
   double takeprofit = GetBuyTakeProfit(orderPrice,0);
   double stoploss = GetBuyStopLoss(orderPrice,0);
   double buy_lots = getBuyLotSize();
   int ticket = OrderSend(Symbol(), inBuyOrderType, buy_lots, orderPrice, UseSlippage, stoploss, takeprofit, "ForexRootkitBandsDual v." + DoubleToString(version), 10000, 0, Blue);
   if (ticket > 0) {
      if (OrderSelect(ticket, SELECT_BY_TICKET, MODE_TRADES)) {
          buyOpenOnBar = true;
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
   double takeprofit = GetSellTakeProfit(orderPrice,0);
   double stoploss = GetSellStopLoss(orderPrice,0);
   double sell_lots = getSellLotSize();
   int ticket = OrderSend(Symbol(), inSellOrderType, sell_lots, orderPrice, UseSlippage, stoploss, takeprofit, "ForexRootkitBandsDual v." + DoubleToString(version), 20000, 0, Red);
   if (ticket > 0) {
      if (OrderSelect(ticket, SELECT_BY_TICKET, MODE_TRADES)) {
         sellOpenOnBar = true;
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
      //Print("canOpenSell: " + IntegerToString(true));
      return true;
   }
   //Print("canOpenSell: " + IntegerToString(false));
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
      //Print("canOpenBuy: " + IntegerToString(true));
      return true;
   }
   //Print("canOpenBuy: " + IntegerToString(false));
   return false;
}
double toBuyTP = 0;
double buyTarget = 0;
void closeBuyOrdersInProfit() {
    RefreshRates();
    int totalOrders = OrdersTotal();
    Print("Closing orders in profit");
    for(int i = 0; i < totalOrders; i++) {
        double os = OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
        if (OrderType() == OP_BUY && OrderSymbol() == Symbol()) {
            while (IsTradeContextBusy()) Sleep(10);
            RefreshRates();
            bool closed = false;
            double takeprofit;
            bool timeToClose = false;
            takeprofit = OrderOpenPrice() + GetBuyTakeProfit(0,1);
            toBuyTP = NormalizeDouble((takeprofit - Bid) / UsePoint,5);
            buyTarget = takeprofit;
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

double toSellTP = 0;
double sellTarget = 0;
void closeSellOrdersInProfit() {
    RefreshRates();
    int totalOrders = OrdersTotal();
    for(int i = 0; i < totalOrders; i++) {
        double os =OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
        if (OrderType() == OP_SELL && OrderSymbol() == Symbol()) {
            while (IsTradeContextBusy()) Sleep(10);
            RefreshRates();
            bool closed = false;
            double takeprofit = OrderOpenPrice() - GetSellTakeProfit(0,1);
            toSellTP = NormalizeDouble((Ask - takeprofit) / UsePoint,5);
            sellTarget = takeprofit;
            if (Ask <= takeprofit) {
               closed = OrderClose(OrderTicket(), OrderLots(), Ask, 3, Violet);
               if (!closed) {
                   Print("Error closing order in profit - SELL: " + IntegerToString(OrderTicket()) + ", lots: " + DoubleToString(OrderLots()) + " " + IntegerToString(GetLastError()));   
               }
            }
        }
    }
}

void closeAllSellOrders() {
    RefreshRates();
    int totalOrders = OrdersTotal();
    for(int i = 0; i < totalOrders; i++) {
        double os =OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
        if (OrderType() == OP_SELL && OrderSymbol() == Symbol()) {
            while (IsTradeContextBusy()) Sleep(10);
            RefreshRates();
            bool closed = false;
            double takeprofit = OrderOpenPrice() - GetSellTakeProfit(0,1);
            toSellTP = NormalizeDouble((Ask - takeprofit) / UsePoint,5);
            sellTarget = takeprofit;
            closed = OrderClose(OrderTicket(), OrderLots(), Ask, 3, Violet);
            if (!closed) {
                Print("Error closing order in profit - SELL: " + IntegerToString(OrderTicket()) + ", lots: " + DoubleToString(OrderLots()) + " " + IntegerToString(GetLastError()));   
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
            double stoploss = OrderOpenPrice() + GetSellStopLoss(0,1);
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
            double stoploss = OrderOpenPrice() - GetBuyStopLoss(0,1);
            if (Bid <= stoploss) {
                closed = OrderClose(OrderTicket(), OrderLots(), Bid, 3, Violet);
                if (!closed) {
                    Print("Error closing order in profit - BUY: " + IntegerToString(OrderTicket()) + ", lots: " + DoubleToString(OrderLots()) + " " + IntegerToString(GetLastError()));   
                }
            }
        }
    }
}

void closeAllBuyOrders() {
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
            double stoploss = OrderOpenPrice() - GetBuyStopLoss(0,1);
            closed = OrderClose(OrderTicket(), OrderLots(), Bid, 3, Violet);
            if (!closed) {
              Print("Error closing order in profit - BUY: " + IntegerToString(OrderTicket()) + ", lots: " + DoubleToString(OrderLots()) + " " + IntegerToString(GetLastError()));   
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
         return buyPSBuffer * UsePoint;
      case 1:
         return getATR(buyPipStepATRTimeFrame,buyPipStepATRPeriod,buyPipStepATRShift);
      default:
         return -1;
   }
}

double getSellPs(){
   switch(sellPipStepMode){
      case 0:
         return sellPSBuffer * UsePoint;
      case 1:
         return getATR(sellPipStepATRTimeFrame,sellPipStepATRPeriod,sellPipStepATRShift);
      default:
         return -1;
   }
}


double buypivotPoint;
double buyr1;
double buyr2;
double buyr3;
double buys1;
double buys2;
double buys3;

double sellpivotPoint;
double sellr1;
double sellr2;
double sellr3;
double sells1;
double sells2;
double sells3;

void getBuyPivots(){
   double close = iClose(NULL,buyPivotTimeFrame,1);
   double high = iHigh(NULL,buyPivotTimeFrame,1);
   double low = iLow(NULL,buyPivotTimeFrame,1);
   buypivotPoint = (high + low + close) / 3;
   buyr1 = (2 * buypivotPoint) - low;
   buys1 = (2 * buypivotPoint) - high;
   buyr2 = (buypivotPoint - buys1) + buyr1;
   buys2 = buypivotPoint - (buyr1 - buys1);
   buyr3 = (buypivotPoint - buys2) + buyr2;
   buys3 = buypivotPoint - (buyr2 - buys2);
   
   drawLine("buyPivotPoint",buypivotPoint,24,clrYellow);
   drawLine("buyr1",buyr1,24,clrDeepSkyBlue);
   drawLine("buyr2",buyr2,24,clrDodgerBlue);
   drawLine("buyr3",buyr3,24,clrBlue);
   drawLine("buys1",buys1,24,clrLightPink);
   drawLine("buys2",buys2,24,clrDeepPink);
   drawLine("buys3",buys3,24,clrRed);
}

void getSellPivots(){
   double close = iClose(NULL,sellPivotTimeFrame,1);
   double high = iHigh(NULL,sellPivotTimeFrame,1);
   double low = iLow(NULL,sellPivotTimeFrame,1);
   sellpivotPoint = (high + low + close) / 3;
   sellr1 = (2 * sellpivotPoint) - low;
   sells1 = (2 * sellpivotPoint) - high;
   sellr2 = (sellpivotPoint - sells1) + sellr1;
   sells2 = sellpivotPoint - (sellr1 - sells1);
   sellr3 = (sellpivotPoint - sells2) + sellr2;
   sells3 = sellpivotPoint - (sellr2 - sells2);
   
   drawLine("sellPivotPoint",sellpivotPoint,24,clrYellow);
   drawLine("sellr1",sellr1,24,clrDeepSkyBlue);
   drawLine("sellr2",sellr2,24,clrDodgerBlue);
   drawLine("sellr3",sellr3,24,clrBlue);
   drawLine("sells1",sells1,24,clrLightPink);
   drawLine("sells2",sells2,24,clrDeepPink);
   drawLine("sells3",sells3,24,clrRed);
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
      //Print("checking direction...");
      //Print("buyPivotPointMode... " + buyPivotPointMode);
      switch(buyPivotPointMode){
         case 0:
            if(priceDiff > (buyPivotPointBuffer * UsePoint)){
               return true;
            }else{
               return false;
            }
         case 1:
            if(priceDiff > getATR(buyPivotPointATRTimeFrame,buyPivotPointATRPeriod,buyPivotPointATRShift)){
               return true;
            }else{
               return false;
            }
      }
   }
   return false;
}

bool buyMALogic(){
   double buyMA = getSMA(buyMATimeFrame,buyMAPeriod,buyMAShift,buyMAType);
   double priceDiff = MathAbs(Ask - buyMA);
   if (buyMAMode < 0)
      return true;
   if (checkDirection(buyMADirection,buyMA,Ask)){
      switch(buyMAMode){
         case 0:
            if(priceDiff > (buyMABuffer * UsePoint)){
               return true;
            }else{
               return false;
            }
         case 1:
            if(priceDiff > getATR(buyMAATRTimeFrame,buyMAATRPeriod,buyMAATRShift)){
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
            if(priceDiff > getATR(sellPivotPointATRTimeFrame,sellPivotPointATRPeriod,sellPivotPointATRShift)){
               return true;
            }else{
               return false;
            }
      }
   }
   return false;
}

bool sellMALogic(){
   double sellMA = getSMA(sellMATimeFrame,sellMAPeriod,sellMAShift,sellMAType);
   double priceDiff = MathAbs(Bid - sellMA);
   if (sellMAMode < 0)
      return true;
   if (checkDirection(sellMADirection,sellMA,Bid)){
      switch(sellMAMode){
         case 0:
            if(priceDiff > (sellMABuffer * UsePoint)){
               return true;
            }else{
               return false;
            }
         case 1:
            if(priceDiff > getATR(sellMAATRTimeFrame,sellMAATRPeriod,sellMAATRShift)){
               return true;
            }else{
               return false;
            }
      }
   }
   return false;
}

double getBuyPivotValue(int inLineIndex){
   switch(inLineIndex){
      default:
         return buypivotPoint;
      case 0:
         return buyr1;
      case 1:
         return buyr2;
      case 2:
         return buyr3;
      case 3:
         return buys1;
      case 4:
         return buys2;
      case 5:
         return buys3;                                    
   }
}

double getSellPivotValue(int inLineIndex){
   switch(inLineIndex){
      default:
         return sellpivotPoint;
      case 0:
         return sellr1;
      case 1:
         return sellr2;
      case 2:
         return sellr3;
      case 3:
         return sells1;
      case 4:
         return sells2;
      case 5:
         return sells3;                                    
   }
}

void hud() {
    double buy_psPoint = buyPSBuffer * UsePoint;  
    double sell_psPoint = sellPSBuffer * UsePoint;
    
    double buy_tp = GetBuyTakeProfit(0,1);
    double sell_tp = GetSellTakeProfit(0,1);
    
    double buy_sl = GetBuyStopLoss(0,1);
    double sell_sl = GetSellStopLoss(0,1);
    
    double buy_lots = getBuyLotSize();
    double sell_lots = getSellLotSize();
    
    Comment(
        "ForexRootkitBandsDual v." + DoubleToString(version) , "\n",
        /**
        "slippage = " + IntegerToString(slippage) + "\n" +   
        "minLotSize = " + DoubleToString(minLotSize) + "\n" +
        "buyRiskStep = " + IntegerToString(buyRiskStep) + "\n" +
        "sellRiskStep = " + IntegerToString(sellRiskStep) + "\n" +
        "maxLotSize = " + DoubleToString(maxLotSize) + "\n" +
        
        "buyPivotTimeFrame = " + IntegerToString(buyPivotTimeFrame) + "\n" +
        "buyPivotPointMode = " + IntegerToString(buyPivotPointMode) + "\n" +
        "buyPivotPointLineIndex = " + IntegerToString(buyPivotPointLineIndex) + "\n" +
        "buyPivotDirection = " + IntegerToString(buyPivotDirection) + "\n" +
        "buyPivotPointBuffer = " + IntegerToString(buyPivotPointBuffer) + "\n" +
        "buyPivotPointATRTimeFrame = " + IntegerToString(buyPivotPointATRTimeFrame) + "\n" +
        "buyPivotPointATRPeriod = " + IntegerToString(buyPivotPointATRPeriod) + "\n" +
        "buyPivotPointATRShift = " + IntegerToString(buyPivotPointATRShift) + "\n" +
        
        "sellpivotTimeFrame = " + IntegerToString(sellPivotTimeFrame) + "\n" +
        "sellPivotPointMode = " + IntegerToString(sellPivotPointMode) + "\n" +
        "sellPivotPointLineIndex = " + IntegerToString(sellPivotPointLineIndex) + "\n" +
        "sellPivotDirection = " + IntegerToString(sellPivotDirection) + "\n" +
        "sellPivotPointBuffer = " + IntegerToString(sellPivotPointBuffer) + "\n" +
        "sellPivotPointATRTimeFrame = " + IntegerToString(sellPivotPointATRTimeFrame) + "\n" +
        "sellPivotPointATRPeriod = " + IntegerToString(sellPivotPointATRPeriod) + "\n" +
        "sellPivotPointATRShift = " + IntegerToString(sellPivotPointATRShift) + "\n" +
           
        "buyMAMode = " + IntegerToString(buyMAMode) + "\n" +  
        "buyMAType = " + IntegerToString(buyMAType) + "\n" +
        "buyMATimeFrame = " + IntegerToString(buyMATimeFrame) + "\n" +
        "buyMAPeriod = " + IntegerToString(buyMAPeriod) + "\n" +
        "buyMAShift = " + IntegerToString(buyMAShift) + "\n" +
        "buyMADirection = " + IntegerToString(buyMADirection) + "\n" +
        "buyMABuffer = " + IntegerToString(buyMABuffer) + "\n" +
        "buyMAATRTimeFrame = " + IntegerToString(buyMAATRTimeFrame) + "\n" +
        "buyMAATRPeriod = " + IntegerToString(buyMAATRPeriod) + "\n" +
        "buyMAATRShift = " + IntegerToString(buyMAATRShift) + "\n" +     
        "sellMAMode = " + IntegerToString(sellMAMode) + "\n" +  
        "sellMAType = " + IntegerToString(sellMAType) + "\n" +
        "sellMATimeFrame = " + IntegerToString(sellMATimeFrame) + "\n" +
        "sellMAPeriod = " + IntegerToString(sellMAPeriod) + "\n" +
        "sellMAShift = " + IntegerToString(sellMAShift) + "\n" +
        "sellMADirection = " + IntegerToString(sellMADirection) + "\n" +
        "sellMABuffer = " + IntegerToString(sellMABuffer) + "\n" +
        "sellMAATRTimeFrame = " + IntegerToString(sellMAATRTimeFrame) + "\n" +
        "sellMAATRPeriod = " + IntegerToString(sellMAATRPeriod) + "\n" +
        "sellMAATRShift = " + IntegerToString(sellMAATRShift) + "\n" +                  
        "buyStopLossMode = " + IntegerToString(buyStopLossMode) + "\n" +
        "buyStopLossBuffer = " + IntegerToString(buyStopLossBuffer) + "\n" +
        "buyStopLossATRTimeFrame = " + IntegerToString(buyStopLossATRTimeFrame) + "\n" +
        "buyStopLossATRPeriod = " + IntegerToString(buyStopLossATRPeriod) + "\n" +
        "buyStopLossATRShift = " + IntegerToString(buyStopLossATRShift) + "\n" +      
        "sellStopLossMode = " + IntegerToString(sellStopLossMode) + "\n" +
        "sellStopLossBuffer = " + IntegerToString(sellStopLossBuffer) + "\n" +
        "sellStopLossATRTimeFrame = " + IntegerToString(sellStopLossATRTimeFrame) + "\n" +
        "sellStopLossATRPeriod = " + IntegerToString(sellStopLossATRPeriod) + "\n" +
        "sellStopLossATRShift = " + IntegerToString(sellStopLossATRShift) + "\n" +             
        "buyTakeProfitMode = " + IntegerToString(buyTakeProfitMode) + "\n" +
        "buyTakeProfitBuffer = " + IntegerToString(buyTakeProfitBuffer) + "\n" +
        "buyTakeProfitATRTimeFrame = " + IntegerToString(buyTakeProfitATRTimeFrame) + "\n" +
        "buyTakeProfitATRPeriod = " + IntegerToString(buyTakeProfitATRPeriod) + "\n" +
        "buyTakeProfitATRShift = " + IntegerToString(buyTakeProfitATRShift) + "\n" +      
        "sellTakeProfitMode = " + IntegerToString(sellTakeProfitMode) + "\n" +
        "sellTakeProfitBuffer = " + IntegerToString(sellTakeProfitBuffer) + "\n" +
        "sellTakeProfitATRTimeFrame = " + IntegerToString(sellTakeProfitATRTimeFrame) + "\n" +
        "sellTakeProfitATRPeriod = " + IntegerToString(sellTakeProfitATRPeriod) + "\n" +
        "sellTakeProfitATRShift = " + IntegerToString(sellTakeProfitATRShift) + "\n" +       
        "buyPipStepMode = " + IntegerToString(buyPipStepMode) + "\n" +
        "buyPSBuffer = " + IntegerToString(buyPSBuffer) + "\n" +
        "buyPipStepATRTimeFrame = " + IntegerToString(buyPipStepATRTimeFrame) + "\n" +
        "buyPipStepATRPeriod = " + IntegerToString(buyPipStepATRPeriod) + "\n" +
        "buyPipStepATRShift = " + IntegerToString(buyPipStepATRShift) + "\n" +      
        "sellPipStepMode = " + IntegerToString(sellPipStepMode) + "\n" +
        "sellPSBuffer = " + IntegerToString(sellPSBuffer) + "\n" +
        "sellPipStepATRTimeFrame = " + IntegerToString(sellPipStepATRTimeFrame) + "\n" +
        "sellPipStepATRPeriod = " + IntegerToString(sellPipStepATRPeriod) + "\n" +
        "sellPipStepATRShift = " + IntegerToString(sellPipStepATRShift) + "\n" +
        
        "buyEmptyOrderMode = " + IntegerToString(buyEmptyOrderMode) + "\n" +
        "buyLimitBuffer = " + IntegerToString(buyLimitBuffer) + "\n" +
        "buyStopBuffer = " + IntegerToString(buyStopBuffer) + "\n" +      
        "sellEmptyOrderMode = " + IntegerToString(sellEmptyOrderMode) + "\n" +
        "sellLimitBuffer = " + IntegerToString(sellLimitBuffer) + "\n" +
        "sellStopBuffer = " + IntegerToString(sellStopBuffer) + "\n" +
        
        "useLondonSession = " + IntegerToString(useLondonSession) + "\n" +
        "useAmericaSession = " + IntegerToString(useAmericaSession) + "\n" +**/
        
        "Ask = " + Ask + "\n" +
        "Bid = " + Bid + "\n" +
        "=====Misc====" + "\n" +
        "inLondonSession = " + inLondonSession + "\n" +
        "inAmericaSession = " + inAmericaSession + "\n" +
        "researchSignal = " + researchSignal + "\n" + 
        "buyPivotPointMode = " + buyPivotPointMode + "\n" +
        
        "avgPosOutcome = " + avgPosOutcome + "\n" +
        "avgPosOutcomePrice = " + posOutcomePrice + "\n" +
        
        "avgNegOutcome = " + avgNegOutcome + "\n" +
        "avgNegOutcomePrice = " + negOutcomePrice + "\n" +
              
        "=====Misc====" + "\n\n" +
        
        "=====Buy====" + "\n" +
        "canOpenBuy = " + _canOpenBuy + "\n" +
        "buyPivotPointLogic = " + _buyPivotPointLogic + "\n" +
        "_buyMALogic = " + _buyMALogic + "\n"
        "=====Buy====" + "\n\n" +  
        
        "=====Sell====" + "\n" +
        "canOpenSell = " + _canOpenSell + "\n" +
        "sellPivotPointLogic = " + _sellPivotPointLogic + "\n" +
        "sellMALogic = " + _sellMALogic + "\n" +
        "=====Sell====" + "\n\n" +
        
        "=====TP====" + "\n" +              
        "buyTakeProfitMode = " + buyTakeProfitMode + "\n" +
        "buyTakeProfitBuffer = " + buyTakeProfitBuffer + "\n" +
        "sellTakeProfitMode = " + sellTakeProfitMode + "\n" +
        "sellTakeProfitBuffer = " + sellTakeProfitBuffer + "\n" +
        "toBuyTP = " + toBuyTP + "\n" +
        "buyTarget = " + buyTarget + "\n" + 
        "toSellTP = " + toSellTP + "\n" +
        "sellTarget = " + sellTarget + "\n" +    
        "=====TP====" + "\n\n" +      
        
        "bar Time = " + TimeToStr(barTime) + "\n" +
        "londonSessionStart = " + TimeToStr(londonSessionStart) + "\n" + 
        "londonSessionEnd = " + TimeToStr(londonSessionEnd) + "\n" +         
        "americaSessionStart = " + TimeToStr(americaSessionStart) + "\n" + 
        "americaSessionEnd = " + TimeToStr(americaSessionEnd) + "\n" +        
        "enabled = " + IntegerToString(IsExpertEnabled()) + "\n" +
        "trade allowed = " + IntegerToString(IsTradeAllowed()) + "\n" +
        "optimization = " + IntegerToString(IsOptimization()) + "\n" +
        "testing = " + IntegerToString(IsTesting()) + "\n" +
        "demo = " + IntegerToString(IsDemo()) + "\n" +
        "stopped = " + IntegerToString(IsStopped()) + "\n" +
        "connected = " + IntegerToString(IsConnected()) + "\n\n" +     
        "buy_lots = " + DoubleToStr(buy_lots, 2) + ", sell_lots = " + DoubleToStr(sell_lots, 2), "\n",
        "buy rs = " + IntegerToString(buyRiskStep) + ", sell_rs = " + IntegerToString(sellRiskStep), "\n",        
        "buy_ps = " + IntegerToString(buyPSBuffer) + ", sell_ps = " + IntegerToString(sellPSBuffer), "\n",
        "buy_tp = " + DoubleToStr(buy_tp, 0) + ", sell_tp = " + DoubleToStr(sell_tp, 0), "\n",
        "buy_sl = " + DoubleToStr(buy_sl, 0) + ", sell_sl = " + DoubleToStr(sell_sl, 0), "\n",
        "bid = "  + DoubleToStr(Bid, 4), "\n",
        "ask = "  + DoubleToStr(Ask, 4), "\n", "\n",
        "spread = " + DoubleToStr((Ask-Bid)*10000, 1), "\n\n",
        "tc = " + IntegerToString(getTradeCount()) + ", buy tc = " + IntegerToString(getBuyTradeCount()) + ", sell tc = " + IntegerToString(getSellTradeCount()), "\n\n",
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

double getSMA (int inTimeframe, int inSmaPeriod, int inSmaShift, int inMode){
   return (iMA(NULL,inTimeframe,inSmaPeriod,inSmaShift,inMode,PRICE_MEDIAN,0));
}

bool isInSession(datetime inSessionStart, datetime inSessionEnd, bool inUseSession){
   return false;
   if(inUseSession == false)
      return true;
   if (barTime > inSessionStart &&
       barTime < inSessionEnd){
       return true;
   }
   return false;
}

void processProperty(string stringToParse){
   //Print("processing property");
   //Print("...processProperty Open...");
   string to_split=stringToParse;   // A string to split into substrings
   string sep="=";                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string result[];               // An array to get strings
   //Print("...local Properties Created...");
   //--- Get the separator code
   u_sep=StringGetCharacter(sep,0);
   //--- Split the string to substrings
   int k=StringSplit(to_split,u_sep,result);
   //--- Show a comment 
   //PrintFormat("Strings obtained: %d. Used separator '%s' with the code %d",k,sep,u_sep);
   //--- Now output all obtained strings
   if(k>0)
   {
      for(int i=0;i<k;i++)
      {
         //PrintFormat("result[%d]=%s",i,result[i]);
      }
   }
   string prop = result[0];
   if (prop == "slippage"){
      slippage = StringToInteger(result[1]);
   }
   if (prop == "minLotSize"){
      minLotSize = StringToDouble(result[1]);
   }
   if (prop == "buyRiskStep"){
      buyRiskStep = StringToInteger(result[1]);
   }
   if (prop == "sellRiskStep"){
      sellRiskStep = StringToInteger(result[1]);
   }
   if (prop == "maxLotSize"){
      maxLotSize = StringToDouble(result[1]);
   }   
   if (prop == "buyPivotTimeFrame"){
      buyPivotTimeFrame = StringToInteger(result[1]);
   }
   if (prop == "buyPivotPointMode"){
      buyPivotPointMode = StringToInteger(result[1]);
   }
   if (prop == "buyPivotPointLineIndex"){
      buyPivotPointLineIndex = StringToInteger(result[1]);
   }
   if (prop == "buyPivotDirection"){
      buyPivotDirection = StringToInteger(result[1]);
   }
   if (prop == "buyPivotPointBuffer"){
      buyPivotPointBuffer = StringToInteger(result[1]);
   }
   if (prop == "buyPivotPointATRTimeFrame"){
      buyPivotPointATRTimeFrame = StringToInteger(result[1]);
   }
   if (prop == "buyPivotPointATRPeriod"){
      buyPivotPointATRPeriod = StringToInteger(result[1]);
   }
   if (prop == "buyPivotPointATRShift"){
      buyPivotPointATRShift = StringToInteger(result[1]);
   }
   if (prop == "sellPivotTimeFrame"){
      sellPivotTimeFrame = StringToInteger(result[1]);
   }
   if (prop == "sellPivotPointMode"){
      sellPivotPointMode = StringToInteger(result[1]);
   }
   if (prop == "sellPivotPointLineIndex"){
      sellPivotPointLineIndex = StringToInteger(result[1]);
   }
   if (prop == "sellPivotDirection"){
      sellPivotDirection = StringToInteger(result[1]);
   }
   if (prop == "sellPivotPointBuffer"){
      sellPivotPointBuffer = StringToInteger(result[1]);
   }
   if (prop == "sellPivotPointATRTimeFrame"){
      sellPivotPointATRTimeFrame = StringToInteger(result[1]);
   }
   if (prop == "sellPivotPointATRPeriod"){
      sellPivotPointATRPeriod = StringToInteger(result[1]);
   }
   if (prop == "sellPivotPointATRShift"){
      sellPivotPointATRShift = StringToInteger(result[1]);
   }   
   if (prop == "buyMAMode"){
      buyMAMode = StringToInteger(result[1]);
   }
   if (prop == "buyMAType"){
      buyMAType = StringToInteger(result[1]);
   }
   if (prop == "buyMATimeFrame"){
      buyMATimeFrame = StringToInteger(result[1]);
   }
   if (prop == "buyMAPeriod"){
      buyMAPeriod = StringToInteger(result[1]);
   }
   if (prop == "buyMAShift"){
      buyMAShift = StringToInteger(result[1]);
   }
   if (prop == "buyMADirection"){
      buyMADirection = StringToInteger(result[1]);
   }
   if (prop == "buyMABuffer"){
      buyMABuffer = StringToInteger(result[1]);
   }
   if (prop == "buyMAATRTimeFrame"){
      buyMAATRTimeFrame = StringToInteger(result[1]);
   }
   if (prop == "buyMAATRPeriod"){
      buyMAATRPeriod = StringToInteger(result[1]);
   }
   if (prop == "buyMAATRShift"){
      buyMAATRShift = StringToInteger(result[1]);
   }   
   if (prop == "sellMAMode"){
      sellMAMode = StringToInteger(result[1]);
   }
   if (prop == "sellMAType"){
      sellMAType = StringToInteger(result[1]);
   }
   if (prop == "sellMATimeFrame"){
      sellMATimeFrame = StringToInteger(result[1]);
   }
   if (prop == "sellMAPeriod"){
      sellMAPeriod = StringToInteger(result[1]);
   }
   if (prop == "sellMAShift"){
      sellMAShift = StringToInteger(result[1]);
   }
   if (prop == "sellMADirection"){
      sellMADirection = StringToInteger(result[1]);
   }
   if (prop == "sellMABuffer"){
      sellMABuffer = StringToInteger(result[1]);
   }
   if (prop == "sellMAATRTimeFrame"){
      sellMAATRTimeFrame = StringToInteger(result[1]);
   }
   if (prop == "sellMAATRPeriod"){
      sellMAATRPeriod = StringToInteger(result[1]);
   }
   if (prop == "sellMAATRShift"){
      sellMAATRShift = StringToInteger(result[1]);
   }  
   if (prop == "buyStopLossMode"){
      buyStopLossMode = StringToInteger(result[1]);
   }
   if (prop == "buyStopLossBuffer"){
      buyStopLossBuffer = StringToInteger(result[1]);
   }
   if (prop == "buyStopLossATRTimeFrame"){
      buyStopLossATRTimeFrame = StringToInteger(result[1]);
   }
   if (prop == "buyStopLossATRPeriod"){
      buyStopLossATRPeriod = StringToInteger(result[1]);
   }
   if (prop == "buyStopLossATRShift"){
      buyStopLossATRShift = StringToInteger(result[1]);
   } 
   if (prop == "sellStopLossMode"){
      sellStopLossMode = StringToInteger(result[1]);
   }
   if (prop == "sellStopLossBuffer"){
      sellStopLossBuffer = StringToInteger(result[1]);
   }
   if (prop == "sellStopLossATRTimeFrame"){
      sellStopLossATRTimeFrame = StringToInteger(result[1]);
   }
   if (prop == "sellStopLossATRPeriod"){
      sellStopLossATRPeriod = StringToInteger(result[1]);
   }
   if (prop == "sellStopLossATRShift"){
      sellStopLossATRShift = StringToInteger(result[1]);
   }  
   if (prop == "buyTakeProfitMode"){
      buyTakeProfitMode = StringToInteger(result[1]);
   }
   if (prop == "buyTakeProfitBuffer"){
      buyTakeProfitBuffer = StringToInteger(result[1]);
      //Print("buyTakeProfitBuffer = " + buyTakeProfitBuffer);
   }
   if (prop == "buyTakeProfitATRTimeFrame"){
      buyTakeProfitATRTimeFrame = StringToInteger(result[1]);
   }
   if (prop == "buyTakeProfitATRPeriod"){
      buyTakeProfitATRPeriod = StringToInteger(result[1]);
   }
   if (prop == "buyTakeProfitATRShift"){
      buyTakeProfitATRShift = StringToInteger(result[1]);
   } 
   if (prop == "sellTakeProfitMode"){
      sellTakeProfitMode = StringToInteger(result[1]);
   }
   if (prop == "sellTakeProfitBuffer"){
      sellTakeProfitBuffer = StringToInteger(result[1]);
   }
   if (prop == "sellTakeProfitATRTimeFrame"){
      sellTakeProfitATRTimeFrame = StringToInteger(result[1]);
   }
   if (prop == "sellTakeProfitATRPeriod"){
      sellTakeProfitATRPeriod = StringToInteger(result[1]);
   }
   if (prop == "sellTakeProfitATRShift"){
      sellTakeProfitATRShift = StringToInteger(result[1]);
   } 
   if (prop == "buyPipStepMode"){
      buyPipStepMode = StringToInteger(result[1]);
   }
   if (prop == "buyPSBuffer"){
      buyPSBuffer = StringToInteger(result[1]);
   }
   if (prop == "buyPipStepATRTimeFrame"){
      buyPipStepATRTimeFrame = StringToInteger(result[1]);
   }
   if (prop == "buyPipStepATRPeriod"){
      buyPipStepATRPeriod = StringToInteger(result[1]);
   }
   if (prop == "buyPipStepATRShift"){
      buyPipStepATRShift = StringToInteger(result[1]);
   } 
   if (prop == "sellPipStepMode"){
      sellPipStepMode = StringToInteger(result[1]);
   }
   if (prop == "sellPSBuffer"){
      sellPSBuffer = StringToInteger(result[1]);
   }
   if (prop == "sellPipStepATRTimeFrame"){
      sellPipStepATRTimeFrame = StringToInteger(result[1]);
   }
   if (prop == "sellPipStepATRPeriod"){
      sellPipStepATRPeriod = StringToInteger(result[1]);
   }
   if (prop == "sellPipStepATRShift"){
      sellPipStepATRShift = StringToInteger(result[1]);
   }   
   if (prop == "buyEmptyOrderMode"){
      buyEmptyOrderMode = StringToInteger(result[1]);
   }   
   if (prop == "buyLimitBuffer"){
      buyLimitBuffer = StringToInteger(result[1]);
   }
   if (prop == "buyStopBuffer"){
      buyStopBuffer = StringToInteger(result[1]);
   }  
   if (prop == "sellEmptyOrderMode"){
      sellEmptyOrderMode = StringToInteger(result[1]);
   }   
   if (prop == "sellLimitBuffer"){
      sellLimitBuffer = StringToInteger(result[1]);
   }
   if (prop == "sellStopBuffer"){
      sellStopBuffer = StringToInteger(result[1]);
   }
   if (prop == "useLondonSession"){
      if (StringToInteger(result[1]) == 1){
         useLondonSession = true;
      }else{
         useLondonSession = false;
      }
   }  
   if (prop == "useAmericaSession"){
      if (StringToInteger(result[1]) == 1){
         useAmericaSession = true;
      }else{
         useAmericaSession = false;
      }
   }
   if (prop == "researchSignal") {
      researchSignal = result[1];
   }
   
   if (prop == "avgNegOutcome") {
      avgNegOutcome = result[1];
   }
   
   if (prop == "avgPosOutcome") {
      avgPosOutcome = result[1];
   }
   
}

string avgNegOutcome = "";
string avgPosOutcome = "";

void readFile(){
   //--- open the file
   //Print ("Trying to open file...");
   //Print ("path: " + InpDirectoryName + "\\" +InpFileName);
   ResetLastError();
   int file_handle=FileOpen(InpFileName, FILE_READ|FILE_ANSI, ';');
   if(file_handle!=INVALID_HANDLE)
     {
      int    str_size;
      string str;
            
      //--- read data from the file
      while(!FileIsEnding(file_handle))
        {
         //--- find out how many symbols are used for writing the time
         str_size=FileReadInteger(file_handle,INT_VALUE);
         //--- read the string
         str=FileReadString(file_handle,str_size);
         //--- print the string
         //Print(str);
         processProperty(str);
        }
      //--- close the file
      FileClose(file_handle);
      //PrintFormat("Data is read, %s file is closed",InpFileName);
     }
   else
      PrintFormat("Failed to open %s file, Error code = %d",InpFileName,GetLastError());
}

void readFile(string file_name){
   //--- open the file
   //Print ("Trying to open file...");
   //Print ("path: " + InpDirectoryName + "\\" +InpFileName);
   ResetLastError();
   int file_handle=FileOpen(file_name, FILE_READ|FILE_ANSI, ';');
   if(file_handle!=INVALID_HANDLE)
     {
      int    str_size;
      string str;
            
      //--- read data from the file
      while(!FileIsEnding(file_handle))
        {
         //--- find out how many symbols are used for writing the time
         str_size=FileReadInteger(file_handle,INT_VALUE);
         //--- read the string
         str=FileReadString(file_handle,str_size);
         //--- print the string
         //Print(str);
         processProperty(str);
        }
      //--- close the file
      FileClose(file_handle);
      //PrintFormat("Data is read, %s file is closed",InpFileName);
     }
   else
      PrintFormat("Failed to open %s file, Error code = %d",InpFileName,GetLastError());
}

int getHandle(string fileName)
{
   //Open file/////////////////////////////////////////////////////////////////////////////////////////////////////////
   int handle=FileOpen(fileName,FILE_CSV|FILE_READ|FILE_WRITE,',');
   if(handle<1)
   {
      Comment("File data1.csv not found, the last error is ", GetLastError());
      return(false);
   }
   else
   {
      //Comment("Ok");
      //FileWrite(handle, "Time","Bid","Ask");
      //Comment("1");
   }
   return(handle);
}

void fileWrite(int handle, string _date, string _time, string _open, string _high, string _low, string _close, string _volume){
   FileSeek(handle, 0, SEEK_END);
   FileWrite(handle, _date, _time, _open, _high, _low, _close, _volume);
}

void saveCurrentPattern(int length){ 
   string patterFile = sym + "-currentPattern.txt";
   FileDelete(patterFile);
   int handle = getHandle(patterFile);
   for (int x=length;x>0;x--){
      string _date = TimeToStr(iTime(NULL,0,x),TIME_DATE);
      string _time = TimeToStr(iTime(NULL,0,x),TIME_MINUTES);
      string _open = iOpen(NULL,0,x);
      string _high = iHigh(NULL,0,x);
      string _low = iLow(NULL,0,x);
      string _close = iClose(NULL,0,x);
      string _volume = iVolume(NULL,0,x);
      fileWrite(handle,_date,_time,_open,_high,_low,_close,_volume);
   }
   FileClose(handle);
}

double getPosAvgOutcomePrice(double inPrice){
    return (StringToDouble(avgPosOutcome) / 100 * inPrice) + inPrice;
}

double getNegAvgOutcomePrice(double inPrice){
    return inPrice + (((StringToDouble(avgNegOutcome) / 100) * inPrice));
}
