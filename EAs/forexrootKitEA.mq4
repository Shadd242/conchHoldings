//+------------------------------------------------------------------+
//|                                               forexrootKitEA.mq4 |
//|                               Copyright 2015, Conchman Holdings. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, Conchman Holdings."
#property link      "http://www.mql5.com"
#property version   "1.00"
#property strict

//External parameters
extern int Slippage = 5;
extern int StopLossMode = -1;//StopLossMode | 1 - Explicit
extern int TakeProfitMode = -1;//TakeProfitMode | 1 - Explicit
extern double StopLoss = 0;//StopLoss in pips
extern double TakeProfit = 0;//TakeProfit in pips
extern double MinLotSize = 0.01;//MinLotSize
extern int RiskStep = 100;//RiskStep

//Global Variables
double UsePoint;
int UseSlippage;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   UsePoint = PipPoint(Symbol());
   UseSlippage = GetSlippaage(Symbol(),Slippage);
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

double CalculateBuyStopLoss(double OpenPrice){
   double BuyStopLoss = 0;
   double sl = CalculateStopLoss(StopLossMode);
   if(sl > 0) BuyStopLoss = OpenPrice - (sl * UsePoint);
   return BuyStopLoss;
}

double CalculateSellStopLoss(double OpenPrice){
   double SellStopLoss = 0;
   double sl = CalculateStopLoss(StopLossMode);
   if(sl > 0) SellStopLoss = OpenPrice + (sl * UsePoint);
   return SellStopLoss;
}

double CalculateBuyTakeProfit(double OpenPrice){
   double BuyTakeProfit = 0;
   double tp = CalculateTakeProfit(TakeProfitMode);
   if(tp > 0) BuyTakeProfit = OpenPrice + (tp * UsePoint);
   return BuyTakeProfit;
}

double CalculateSellTakeProfit(double OpenPrice){
   double SellTakeProfit = 0;
   double tp = CalculateTakeProfit(TakeProfitMode);
   if(tp > 0) SellTakeProfit = OpenPrice - (tp * UsePoint);
   return SellTakeProfit;
}

double CalculateStopLoss(int mode)
{
   double returnValue = 0;
   switch(mode){
      case 0: //Get pips by atr
         returnValue = 0;
      default:
         returnValue = StopLoss;
   }
   return returnValue;
}

double CalculateTakeProfit(int mode)
{
   double returnValue = 0;
   switch(mode){
      case 0: //Get pips by atr
         returnValue = 0;
      default:
         returnValue = TakeProfit;
   }
   return returnValue;
}

double getLotSize() {
    double result = 0.00;
    double balance = AccountBalance();
    double step = RiskStep;
    double threshold = step;
    while (balance >= threshold) {
        result += MinLotSize;
        threshold += step;
    }
    if (result > 20)
    {
      result = 20;
    }
    return result;
}