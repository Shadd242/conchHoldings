using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Configuration;

namespace forexRootKitEA
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        #region Configuration

        string buyPivotTimeFrameString = ConfigurationManager.AppSettings["buyPivotTimeFrameString"];
        string buyPivotPointLineIndexString = ConfigurationManager.AppSettings["buyPivotPointLineIndexString"];
        string buyPivotPointModeString = ConfigurationManager.AppSettings["buyPivotPointModeString"];
        string buyPivotDirectionString = ConfigurationManager.AppSettings["buyPivotDirectionString"];
        string buyPivotPointATRTimeFrameString = ConfigurationManager.AppSettings["buyPivotPointATRTimeFrameString"];

        string sellPivotTimeFrameString = ConfigurationManager.AppSettings["sellPivotTimeFrameString"];
        string sellPivotPointLineIndexString = ConfigurationManager.AppSettings["sellPivotPointLineIndexString"];
        string sellPivotPointModeString = ConfigurationManager.AppSettings["sellPivotPointModeString"];
        string sellPivotDirectionString = ConfigurationManager.AppSettings["sellPivotDirectionString"];
        string sellPivotPointATRTimeFrameString = ConfigurationManager.AppSettings["sellPivotPointATRTimeFrameString"];

        string buyMATimeFrameString = ConfigurationManager.AppSettings["buyMATimeFrameString"];
        string buyMATypeString = ConfigurationManager.AppSettings["buyMATypeString"];
        string buyMAModeString = ConfigurationManager.AppSettings["buyMAModeString"];
        string buyMADirectionString = ConfigurationManager.AppSettings["buyMADirectionString"];
        string buyMAATRTimeFrameString = ConfigurationManager.AppSettings["buyMAATRTimeFrameString"];
        string sellMATimeFrameString = ConfigurationManager.AppSettings["sellMATimeFrameString"];
        string sellMATypeString = ConfigurationManager.AppSettings["sellMATypeString"];
        string sellMAModeString = ConfigurationManager.AppSettings["sellMAModeString"];
        string sellMADirectionString = ConfigurationManager.AppSettings["sellMADirectionString"];
        string sellMAATRTimeFrameString = ConfigurationManager.AppSettings["sellMAATRTimeFrameString"];

        string buyStopLossModeString = ConfigurationManager.AppSettings["buyStopLossModeString"];
        string buyStopLossATRTimeFrameString = ConfigurationManager.AppSettings["buyStopLossATRTimeFrameString"];
        string sellStopLossModeString = ConfigurationManager.AppSettings["sellStopLossModeString"];
        string sellStopLossATRTimeFrameString = ConfigurationManager.AppSettings["sellStopLossATRTimeFrameString"];

        string buyTakeProfitModeString = ConfigurationManager.AppSettings["buyTakeProfitModeString"];
        string buyTakeProfitATRTimeFrameString = ConfigurationManager.AppSettings["buyTakeProfitATRTimeFrameString"];
        string sellTakeProfitModeString = ConfigurationManager.AppSettings["sellTakeProfitModeString"];
        string sellTakeProfitATRTimeFrameString = ConfigurationManager.AppSettings["sellTakeProfitATRTimeFrameString"];

        string buyPipStepModeString = ConfigurationManager.AppSettings["buyPipStepModeString"];
        string buyPipStepATRTimeFrameString = ConfigurationManager.AppSettings["buyPipStepATRTimeFrameString"];
        string sellPipStepModeString = ConfigurationManager.AppSettings["sellPipStepModeString"];
        string sellPipStepATRTimeFrameString = ConfigurationManager.AppSettings["sellPipStepATRTimeFrameString"];

        string buyEmptyOrderModeString = ConfigurationManager.AppSettings["buyEmptyOrderModeString"];
        string sellEmptyOrderModeString = ConfigurationManager.AppSettings["sellEmptyOrderModeString"];

        string defaultConfigPath = ConfigurationManager.AppSettings["defaultConfigPath"];
        string noValueFromUI = ConfigurationManager.AppSettings["noValueFromUI"];

        string M1 = ConfigurationManager.AppSettings["M1"];
        string M5 = ConfigurationManager.AppSettings["M5"];
        string M15 = ConfigurationManager.AppSettings["M15"];
        string M30 = ConfigurationManager.AppSettings["M30"];
        string H1 = ConfigurationManager.AppSettings["H1"];
        string H4 = ConfigurationManager.AppSettings["H4"];
        string D1 = ConfigurationManager.AppSettings["D1"];
        string W1 = ConfigurationManager.AppSettings["W1"];
        string MN = ConfigurationManager.AppSettings["MN"];

        string GreaterThan = ConfigurationManager.AppSettings["GreaterThan"];
        string LessThan = ConfigurationManager.AppSettings["LessThan"];

        string ExplicitSpacing = ConfigurationManager.AppSettings["ExplicitSpacing"];
        string ATRSpacing = ConfigurationManager.AppSettings["ATRSpacing"];

        string PivotPoint = ConfigurationManager.AppSettings["PivotPoint"];
        string R1 = ConfigurationManager.AppSettings["R1"];
        string R2 = ConfigurationManager.AppSettings["R2"];
        string R3 = ConfigurationManager.AppSettings["R3"];
        string S1 = ConfigurationManager.AppSettings["S1"];
        string S2 = ConfigurationManager.AppSettings["S2"];
        string S3 = ConfigurationManager.AppSettings["S3"];

        string SMA = ConfigurationManager.AppSettings["SMA"];
        string EMA = ConfigurationManager.AppSettings["EMA"];

        string MarketOrder = ConfigurationManager.AppSettings["MarketOrder"];
        string LimitOrder = ConfigurationManager.AppSettings["LimitOrder"];
        string StopOrder = ConfigurationManager.AppSettings["StopOrder"];

        string slippageString = ConfigurationManager.AppSettings["slippageString"];
        string minLotSizeString = ConfigurationManager.AppSettings["minLotSizeString"];
        string buyRiskStepString = ConfigurationManager.AppSettings["buyRiskStepString"];
        string sellRiskStepString = ConfigurationManager.AppSettings["sellRiskStepString"];
        string maxLotSizeString = ConfigurationManager.AppSettings["maxLotSizeString"];

        string buyPivotPointBufferString = ConfigurationManager.AppSettings["buyPivotPointBufferString"];
        string buyPivotPointATRPeriodString = ConfigurationManager.AppSettings["buyPivotPointATRPeriodString"];
        string buyPivotPointATRShiftString = ConfigurationManager.AppSettings["buyPivotPointATRShiftString"];

        string sellPivotPointBufferString = ConfigurationManager.AppSettings["sellPivotPointBufferString"];
        string sellPivotPointATRPeriodString = ConfigurationManager.AppSettings["sellPivotPointATRPeriodString"];
        string sellPivotPointATRShiftString = ConfigurationManager.AppSettings["sellPivotPointATRShiftString"];

        string buyMAPeriodString = ConfigurationManager.AppSettings["buyMAPeriodString"];
        string sellMAPeriodString = ConfigurationManager.AppSettings["sellMAPeriodString"];

        string buyMAShiftString = ConfigurationManager.AppSettings["buyMAShiftString"];
        string sellMAShiftString = ConfigurationManager.AppSettings["sellMAShiftString"];

        string buyMABufferString = ConfigurationManager.AppSettings["buyMABufferString"];
        string sellMABufferString = ConfigurationManager.AppSettings["sellMABufferString"];

        string buyMAATRPeriodString = ConfigurationManager.AppSettings["buyMAATRPeriodString"];
        string buyMAATRShiftString = ConfigurationManager.AppSettings["buyMAATRShiftString"];

        string sellMAATRPeriodString = ConfigurationManager.AppSettings["sellMAATRPeriodString"];
        string sellMAATRShiftString = ConfigurationManager.AppSettings["sellMAATRShiftString"];

        string buyStopLossBufferString = ConfigurationManager.AppSettings["buyStopLossBufferString"];
        string buyStopLossATRPeriodString = ConfigurationManager.AppSettings["buyStopLossATRPeriodString"];
        string buyStopLossATRShiftString = ConfigurationManager.AppSettings["buyStopLossATRShiftString"];

        string buyTakeProfitBufferString = ConfigurationManager.AppSettings["buyTakeProfitBufferString"];
        string buyTakeProfitATRPeriodString = ConfigurationManager.AppSettings["buyTakeProfitATRPeriodString"];
        string buyTakeProfitATRShiftString = ConfigurationManager.AppSettings["buyTakeProfitATRShiftString"];

        string buyStopBufferString = ConfigurationManager.AppSettings["buyStopBufferString"];
        string buyLimitBufferString = ConfigurationManager.AppSettings["buyLimitBufferString"];

        string buyPSBufferString = ConfigurationManager.AppSettings["buyPSBufferString"];
        string buyPipStepATRPeriodString = ConfigurationManager.AppSettings["buyPipStepATRPeriodString"];
        string buyPipStepATRShiftString = ConfigurationManager.AppSettings["buyPipStepATRShiftString"];

        string sellStopLossBufferString = ConfigurationManager.AppSettings["sellStopLossBufferString"];
        string sellStopLossATRPeriodString = ConfigurationManager.AppSettings["sellStopLossATRPeriodString"];
        string sellStopLossATRShiftString = ConfigurationManager.AppSettings["sellStopLossATRShiftString"];

        string sellTakeProfitBufferString = ConfigurationManager.AppSettings["sellTakeProfitBufferString"];
        string sellTakeProfitATRPeriodString = ConfigurationManager.AppSettings["sellTakeProfitATRPeriodString"];
        string sellTakeProfitATRShiftString = ConfigurationManager.AppSettings["sellTakeProfitATRShiftString"];

        string sellStopBufferString = ConfigurationManager.AppSettings["sellStopBufferString"];
        string sellLimitBufferString = ConfigurationManager.AppSettings["sellLimitBufferString"];

        string sellPSBufferString = ConfigurationManager.AppSettings["sellPSBufferString"];
        string sellPipStepATRPeriodString = ConfigurationManager.AppSettings["sellPipStepATRPeriodString"];
        string sellPipStepATRShiftString = ConfigurationManager.AppSettings["sellPipStepATRShiftString"];

        string useLondonSessionString = ConfigurationManager.AppSettings["useLondonSessionString"];
        string useAmericaSessionString = ConfigurationManager.AppSettings["useAmericaSessionString"];

        string londonSessionCheckedString = ConfigurationManager.AppSettings["londonSessionCheckedString"];
        string americaSessionCheckedString = ConfigurationManager.AppSettings["americaSessionCheckedString"];

        string londonSessionUnCheckedString = ConfigurationManager.AppSettings["londonSessionUnCheckedString"];
        string americaSessionUnCheckedString = ConfigurationManager.AppSettings["americaSessionUnCheckedString"];

        #endregion Configuration

        string slippage;
        string minLotSize;
        string buyRiskStep;
        string sellRiskStep;
        string maxLotSize;

        string basePath = @"C:/Users/Rashad/AppData/Roaming/MetaQuotes/Terminal/46A834A4BD020127C05B0DA2582F8F5C";

        string buyPivotPointBuffer;
        string buyPivotPointATRPeriod;
        string buyPivotPointATRShift;

        string _useLondonSession;
        string useLondonSession
        {
            get { return _useLondonSession; }
            set
            {
                _useLondonSession = value;
                if (value == londonSessionCheckedString)
                {
                    sessions.tbtnLondon.IsChecked = true;
                }
                else if (value == londonSessionUnCheckedString)
                {
                    sessions.tbtnLondon.IsChecked = false;
                }
            }
        }

        string _useAmericaSession;
        string useAmericaSession
        {
            get { return _useAmericaSession; }
            set
            {
                _useAmericaSession = value;
                if (value == americaSessionCheckedString)
                {
                    sessions.tbtnAmerica.IsChecked = true;
                }
                else if (value == americaSessionUnCheckedString)
                {
                    sessions.tbtnAmerica.IsChecked = false;
                }
            }
        }

        #region Pivot Point

        string _buyPivotTimeFrame;
        string buyPivotTimeFrame
        {
            get
            {
                return _buyPivotTimeFrame;
            }
            set
            {
                _buyPivotTimeFrame = value;
                setTimeFrame(buy.pivotPoint.timeFrame, value);
            }
        }

        string _buyPivotPointMode;
        string buyPivotPointMode
        {
            get { return _buyPivotPointMode; }
            set
            {
                _buyPivotPointMode = value;
                setSpacingMode(buy.pivotPoint.spacingMode, value);
            }
        }

        string _buyPivotPointLineIndex;
        string buyPivotPointLineIndex
        {
            get { return _buyPivotPointLineIndex; }
            set
            {
                _buyPivotPointLineIndex = value;
                setPivotPoint(buy.pivotPoint.pivotPoint, value);
            }
        }

        string _buyPivotDirection;
        string buyPivotDirection
        {
            get { return _buyPivotDirection; }
            set
            {
                _buyPivotDirection = value;
                setDirection(buy.pivotPoint.pivotPoint.direction, value);
            }
        }

        string _buyPivotPointATRTimeFrame;
        string buyPivotPointATRTimeFrame
        {
            get { return _buyPivotPointATRTimeFrame; }
            set
            {
                _buyPivotPointATRTimeFrame = value;
                setTimeFrame(buy.pivotPoint.ATR.timeFrame, value);
            }
        }

        string sellPivotPointBuffer;
        string sellPivotPointATRPeriod;
        string sellPivotPointATRShift;

        string _sellPivotTimeFrame;
        string sellPivotTimeFrame
        {
            get
            {
                return _sellPivotTimeFrame;
            }
            set
            {
                _sellPivotTimeFrame = value;
                setTimeFrame(sell.pivotPoint.timeFrame, value);
            }
        }

        string _sellPivotPointMode;
        string sellPivotPointMode
        {
            get { return _sellPivotPointMode; }
            set
            {
                _sellPivotPointMode = value;
                setSpacingMode(sell.pivotPoint.spacingMode, value);
            }
        }

        string _sellPivotPointLineIndex;
        string sellPivotPointLineIndex
        {
            get { return _sellPivotPointLineIndex; }
            set
            {
                _sellPivotPointLineIndex = value;
                setPivotPoint(sell.pivotPoint.pivotPoint, value);
            }
        }

        string _sellPivotDirection;
        string sellPivotDirection
        {
            get { return _sellPivotDirection; }
            set
            {
                _sellPivotDirection = value;
                setDirection(sell.pivotPoint.pivotPoint.direction, value);
            }
        }

        string _sellPivotPointATRTimeFrame;
        string sellPivotPointATRTimeFrame
        {
            get { return _sellPivotPointATRTimeFrame; }
            set
            {
                _sellPivotPointATRTimeFrame = value;
                setTimeFrame(sell.pivotPoint.ATR.timeFrame, value);
            }
        }
        
        #endregion Pivot Point

        #region MA

        string buyMAPeriod;
        string buyMAShift;
        string buyMAATRPeriod;
        string buyMAATRShift;
        string buyMABuffer;

        string _buyMAMode;
        string buyMAMode
        {
            get { return _buyMAMode; }
            set
            {
                _buyMAMode = value;
                setSpacingMode(buy.mA.spacingMode, value);
            }
        }
        string _buyMAType;
        string buyMAType
        {
            get { return _buyMAType; }
            set
            {
                _buyMAType = value;
                getMAType(buy.mA.mAMode, value);
            }
        }
        string _buyMATimeFrame;
        string buyMATimeFrame
        {
            get { return _buyMATimeFrame; }
            set
            {
                _buyMATimeFrame = value;
                setTimeFrame(buy.mA.timeFrame, value);
            }
        }
        string _buyMADirection;
        string buyMADirection
        {
            get { return _buyMADirection; }
            set
            {
                _buyMADirection = value;
                setDirection(buy.mA.direction, value);
            }
        }
        string _buyMAATRTimeFrame;
        string buyMAATRTimeFrame
        {
            get { return _buyMAATRTimeFrame; }
            set
            {
                _buyMAATRTimeFrame = value;
                setTimeFrame(buy.mA.ATR.timeFrame, value);
            }
        }

        string sellMAPeriod;
        string sellMAShift;
        string sellMAATRPeriod;
        string sellMAATRShift;
        string sellMABuffer;

        string _sellMAMode;
        string sellMAMode
        {
            get { return _sellMAMode; }
            set
            {
                _sellMAMode = value;
                setSpacingMode(sell.mA.spacingMode, value);
            }
        }
        string _sellMAType;
        string sellMAType
        {
            get { return _sellMAType; }
            set
            {
                _sellMAType = value;
                getMAType(sell.mA.mAMode, value);
            }
        }
        string _sellMATimeFrame;
        string sellMATimeFrame
        {
            get { return _sellMATimeFrame; }
            set
            {
                _sellMATimeFrame = value;
                setTimeFrame(sell.mA.timeFrame, value);
            }
        }
        string _sellMADirection;
        string sellMADirection
        {
            get { return _sellMADirection; }
            set
            {
                _sellMADirection = value;
                setDirection(sell.mA.direction, value);
            }
        }
        string _sellMAATRTimeFrame;
        string sellMAATRTimeFrame
        {
            get { return _sellMAATRTimeFrame; }
            set
            {
                _sellMAATRTimeFrame = value;
                setTimeFrame(sell.mA.ATR.timeFrame, value);
            }
        }

        #endregion MA

        #region Stop Loss

        string buyStopLossBuffer;
        string buyStopLossATRPeriod;
        string buyStopLossATRShift;
        string _buyStopLossMode;
        string buyStopLossMode
        {
            get { return _buyStopLossMode; }
            set
            {
                _buyStopLossMode = value;
                setSpacingMode(buy.stopLoss.spacingMode, value);
            }
        }
        string _buyStopLossATRTimeFrame;
        string buyStopLossATRTimeFrame
        {
            get
            {
                return _buyStopLossATRTimeFrame;
            }
            set
            {
                _buyStopLossATRTimeFrame = value;
                setTimeFrame(buy.stopLoss.ATR.timeFrame, value);
            }
        }

        string sellStopLossBuffer;
        string sellStopLossATRPeriod;
        string sellStopLossATRShift;
        string _sellStopLossMode;
        string sellStopLossMode
        {
            get { return _sellStopLossMode; }
            set
            {
                _sellStopLossMode = value;
                setSpacingMode(sell.stopLoss.spacingMode, value);
            }
        }
        string _sellStopLossATRTimeFrame;
        string sellStopLossATRTimeFrame
        {
            get
            {
                return _sellStopLossATRTimeFrame;
            }
            set
            {
                _sellStopLossATRTimeFrame = value;
                setTimeFrame(sell.stopLoss.ATR.timeFrame, value);
            }
        }

        #endregion Stop Loss

        #region Take Profit

        string buyTakeProfitBuffer;
        string buyTakeProfitATRPeriod;
        string buyTakeProfitATRShift;
        string _buyTakeProfitMode;
        string buyTakeProfitMode
        {
            get { return _buyTakeProfitMode; }
            set
            {
                _buyTakeProfitMode = value;
                setSpacingMode(buy.takeProfit.spacingMode, value);
            }
        }
        string _buyTakeProfitATRTimeFrame;
        string buyTakeProfitATRTimeFrame
        {
            get { return _buyTakeProfitATRTimeFrame; }
            set
            {
                _buyTakeProfitATRTimeFrame = value;
                setTimeFrame(buy.takeProfit.ATR.timeFrame, value);
            }
        }

        string sellTakeProfitBuffer;
        string sellTakeProfitATRPeriod;
        string sellTakeProfitATRShift;
        string _sellTakeProfitMode;
        string sellTakeProfitMode
        {
            get { return _sellTakeProfitMode; }
            set
            {
                _sellTakeProfitMode = value;
                setSpacingMode(sell.takeProfit.spacingMode, value);
            }
        }
        string _sellTakeProfitATRTimeFrame;
        string sellTakeProfitATRTimeFrame
        {
            get { return _sellTakeProfitATRTimeFrame; }
            set
            {
                _sellTakeProfitATRTimeFrame = value;
                setTimeFrame(sell.takeProfit.ATR.timeFrame, value);
            }
        }

        #endregion Take Profit

        #region Pip Step

        string buyPSBuffer;
        string buyPipStepATRPeriod;
        string buyPipStepATRShift;
        string _buyPipStepMode;
        string buyPipStepMode
        {
            get { return _buyPipStepMode; }
            set
            {
                _buyPipStepMode = value;
                setSpacingMode(buy.pipStep.spacingMode, value);
            }
        }
        string _buyPipStepATRTimeFrame;
        string buyPipStepATRTimeFrame
        {
            get { return _buyPipStepATRTimeFrame; }
            set
            {
                _buyPipStepATRTimeFrame = value;
                setTimeFrame(buy.pipStep.ATR.timeFrame, value);
            }
        }

        string sellPSBuffer;
        string sellPipStepATRPeriod;
        string sellPipStepATRShift;
        string _sellPipStepMode;
        string sellPipStepMode
        {
            get { return _sellPipStepMode; }
            set
            {
                _sellPipStepMode = value;
                setSpacingMode(sell.pipStep.spacingMode, value);
            }
        }
        string _sellPipStepATRTimeFrame;
        string sellPipStepATRTimeFrame
        {
            get { return _sellPipStepATRTimeFrame; }
            set
            {
                _sellPipStepATRTimeFrame = value;
                setTimeFrame(sell.pipStep.ATR.timeFrame, value);
            }
        }

        #endregion Pip Step

        #region Empty Order Mode

        string buyStopBuffer;
        string buyLimitBuffer;
        string _buyEmptyOrderMode;
        string buyEmptyOrderMode
        {
            get { return _buyEmptyOrderMode; }
            set
            {
                _buyEmptyOrderMode = value;
                setEmptyOrderMode(buy.emptyOrderMode, value);
            }
        }

        string sellStopBuffer;
        string sellLimitBuffer;
        string _sellEmptyOrderMode;
        string sellEmptyOrderMode
        {
            get { return _sellEmptyOrderMode; }
            set
            {
                _sellEmptyOrderMode = value;
                setEmptyOrderMode(sell.emptyOrderMode, value);
            }
        }

        #endregion Empty Order Mode

        public MainWindow()
        {
             
            InitializeComponent();

            cmbbxCurrentSymbol.SelectedIndex = 0;

            #region PIVOT POINT
            setTimeFrameGroupName(buy.pivotPoint.timeFrame, buyPivotTimeFrameString);
            setPivotPointGroupName(buy.pivotPoint.pivotPoint, buyPivotPointLineIndexString);
            setSpacingGroupName(buy.pivotPoint.spacingMode, buyPivotPointModeString);
            setDirectionGroupName(buy.pivotPoint.pivotPoint.direction, buyPivotDirectionString);
            setTimeFrameGroupName(buy.pivotPoint.ATR.timeFrame, buyPivotPointATRTimeFrameString);

            setTimeFrameGroupName(sell.pivotPoint.timeFrame, sellPivotTimeFrameString);
            setPivotPointGroupName(sell.pivotPoint.pivotPoint, sellPivotPointLineIndexString);
            setSpacingGroupName(sell.pivotPoint.spacingMode, sellPivotPointModeString);
            setDirectionGroupName(sell.pivotPoint.pivotPoint.direction, sellPivotDirectionString);
            setTimeFrameGroupName(sell.pivotPoint.ATR.timeFrame, sellPivotPointATRTimeFrameString);

            #endregion PIVOT POINT

            #region MA

            setTimeFrameGroupName(buy.mA.timeFrame, buyMATimeFrameString);
            setMAGroupName(buy.mA.mAMode, buyMATypeString);
            setSpacingGroupName(buy.mA.spacingMode, buyMAModeString);
            setDirectionGroupName(buy.mA.direction, buyMADirectionString);
            setTimeFrameGroupName(buy.mA.ATR.timeFrame, buyMAATRTimeFrameString);

            setTimeFrameGroupName(sell.mA.timeFrame, sellMATimeFrameString);
            setMAGroupName(sell.mA.mAMode, sellMATypeString);
            setSpacingGroupName(sell.mA.spacingMode, sellMAModeString);
            setDirectionGroupName(sell.mA.direction, sellMADirectionString);
            setTimeFrameGroupName(sell.mA.ATR.timeFrame, sellMAATRTimeFrameString);

            #endregion MA

            #region STOP LOSS

            setSpacingGroupName(buy.stopLoss.spacingMode, buyStopLossModeString);
            setTimeFrameGroupName(buy.stopLoss.ATR.timeFrame, buyStopLossATRTimeFrameString);

            setSpacingGroupName(sell.stopLoss.spacingMode, sellStopLossModeString);
            setTimeFrameGroupName(sell.stopLoss.ATR.timeFrame, sellStopLossATRTimeFrameString);

            #endregion STOP LOSS

            #region TAKE PROFIT

            setSpacingGroupName(buy.takeProfit.spacingMode, buyTakeProfitModeString);
            setTimeFrameGroupName(buy.takeProfit.ATR.timeFrame, buyTakeProfitATRTimeFrameString);

            setSpacingGroupName(sell.takeProfit.spacingMode, sellTakeProfitModeString);
            setTimeFrameGroupName(sell.takeProfit.ATR.timeFrame, sellTakeProfitATRTimeFrameString);

            #endregion TAKE PROFIT

            #region PIP STEP

            setSpacingGroupName(buy.pipStep.spacingMode, buyPipStepModeString);
            setTimeFrameGroupName(buy.pipStep.ATR.timeFrame, buyPipStepATRTimeFrameString);

            setSpacingGroupName(sell.pipStep.spacingMode, sellPipStepModeString);
            setTimeFrameGroupName(sell.pipStep.ATR.timeFrame, sellPipStepATRTimeFrameString);

            #endregion PIP STEP

            #region EOM

            setOrderTypesGroupName(buy.emptyOrderMode, buyEmptyOrderModeString);
            setOrderTypesGroupName(sell.emptyOrderMode, sellEmptyOrderModeString);

            #endregion EOM

            Slippage.TextChanged += Slippage_TextChanged;
            MinLotSize.TextChanged += MinLotSize_TextChanged;
            BuyRiskStep.TextChanged += BuyRiskStep_TextChanged;
            SellRiskStep.TextChanged += SellRiskStep_TextChanged;
            MaxLotSize.TextChanged += MaxLotSize_TextChanged;

            buy.pivotPoint.Buffer.TextChanged += BuyBuffer_TextChanged;
            buy.pivotPoint.ATR.Period.TextChanged += BuyPeriod_TextChanged;
            buy.pivotPoint.ATR.Shift.TextChanged += BuyShift_TextChanged;

            buy.mA.MAPeriod.TextChanged += BuyMAPeriod_TextChanged;
            buy.mA.MAShift.TextChanged += BuyMAShift_TextChanged;
            buy.mA.MABuffer.TextChanged += BuyMABuffer_TextChanged;
            buy.mA.ATR.Period.TextChanged += BuyATRPeriod_TextChanged;
            buy.mA.ATR.Shift.TextChanged += BuyATRShift_TextChanged;

            sell.pivotPoint.Buffer.TextChanged += SellBuffer_TextChanged;
            sell.pivotPoint.ATR.Period.TextChanged += SellPeriod_TextChanged;
            sell.pivotPoint.ATR.Shift.TextChanged += SellShift_TextChanged;

            sell.mA.MAPeriod.TextChanged += SellMAPeriod_TextChanged;
            sell.mA.MAShift.TextChanged += SellMAShift_TextChanged;
            sell.mA.MABuffer.TextChanged += SellMABuffer_TextChanged;
            sell.mA.ATR.Period.TextChanged += SellATRPeriod_TextChanged;
            sell.mA.ATR.Shift.TextChanged += SellATRShift_TextChanged;

            buy.stopLoss.txtStopLoss.TextChanged += BuytxtStopLoss_TextChanged;
            buy.stopLoss.ATR.Period.TextChanged += BuyStopLossATRPeriod_TextChanged;
            buy.stopLoss.ATR.Shift.TextChanged += BuyStopLossATRShift_TextChanged;

            buy.takeProfit.txtTakeProfit.TextChanged += BuytxtTakeProfit_TextChanged;
            buy.takeProfit.ATR.Period.TextChanged += BuyTakeProfitATRPeriod_TextChanged;
            buy.takeProfit.ATR.Shift.TextChanged += BuyTakeProfitATRShift_TextChanged;

            buy.pipStep.txtbxPSBuffer.TextChanged += BuyPSBuffer_TextChanged;
            buy.pipStep.ATR.Period.TextChanged += BuyPipStepATRPeriod_TextChanged;
            buy.pipStep.ATR.Shift.TextChanged += BuyPipStepATRShift_TextChanged;

            buy.emptyOrderMode.LimitBuffer.TextChanged += BuyLimitBuffer_TextChanged;
            buy.emptyOrderMode.StopBuffer.TextChanged += BuyStopBuffer_TextChanged;

            sell.stopLoss.txtStopLoss.TextChanged += SelltxtStopLoss_TextChanged;
            sell.stopLoss.ATR.Period.TextChanged += SellStopLossATRPeriod_TextChanged;
            sell.stopLoss.ATR.Shift.TextChanged += SellStopLossATRShift_TextChanged;

            sell.takeProfit.txtTakeProfit.TextChanged += SelltxtTakeProfit_TextChanged;
            sell.takeProfit.ATR.Period.TextChanged += SellTakeProfitATRPeriod_TextChanged;
            sell.takeProfit.ATR.Shift.TextChanged += SellTakeProfitATRShift_TextChanged;

            sell.pipStep.txtbxPSBuffer.TextChanged += SellPSBuffer_TextChanged;
            sell.pipStep.ATR.Period.TextChanged += SellPipStepATRPeriod_TextChanged;
            sell.pipStep.ATR.Shift.TextChanged += SellPipStepATRShift_TextChanged;

            sell.emptyOrderMode.LimitBuffer.TextChanged += SellLimitBuffer_TextChanged;
            sell.emptyOrderMode.StopBuffer.TextChanged += SellStopBuffer_TextChanged;

            sessions.tbtnLondon.Checked += tbtnLondon_Checked;
            sessions.tbtnAmerica.Checked += tbtnAmerica_Checked;
            sessions.tbtnLondon.Unchecked += tbtnLondon_Unchecked;
            sessions.tbtnAmerica.Unchecked += tbtnAmerica_Unchecked;

            btnGet.Click += btnGet_Click;
            btnSave.Click += btnSave_Click;

            readConfig(@defaultConfigPath);
        }

        private void saveConfig(string pathToConfig)
        {
            using (System.IO.StreamWriter file = new System.IO.StreamWriter(pathToConfig))
            {
                file.WriteLine("buyPivotTimeFrame" + "=" + buyPivotTimeFrame);
                file.WriteLine("buyPivotPointMode" + "=" + buyPivotPointMode);
                file.WriteLine("buyPivotPointLineIndex" + "=" + buyPivotPointLineIndex);
                file.WriteLine("buyPivotDirection" + "=" + buyPivotDirection);
                file.WriteLine("buyPivotPointATRTimeFrame" + "=" + buyPivotPointATRTimeFrame);
                file.WriteLine("sellPivotTimeFrame" + "=" + sellPivotTimeFrame);
                file.WriteLine("sellPivotPointMode" + "=" + sellPivotPointMode);
                file.WriteLine("sellPivotPointLineIndex" + "=" + sellPivotPointLineIndex);
                file.WriteLine("sellPivotDirection" + "=" + sellPivotDirection);
                file.WriteLine("sellPivotPointATRTimeFrame" + "=" + sellPivotPointATRTimeFrame);
                file.WriteLine("buyMAMode" + "=" + buyMAMode);
                file.WriteLine("buyMAType" + "=" + buyMAType);
                file.WriteLine("buyMATimeFrame" + "=" + buyMATimeFrame);
                file.WriteLine("buyMADirection" + "=" + buyMADirection);
                file.WriteLine("buyMAATRTimeFrame" + "=" + buyMAATRTimeFrame);
                file.WriteLine("sellMAMode" + "=" + sellMAMode);
                file.WriteLine("sellMAType" + "=" + sellMAType);
                file.WriteLine("sellMATimeFrame" + "=" + sellMATimeFrame);
                file.WriteLine("sellMADirection" + "=" + sellMADirection);
                file.WriteLine("sellMAATRTimeFrame" + "=" + sellMAATRTimeFrame);
                file.WriteLine("buyStopLossMode" + "=" + buyStopLossMode);
                file.WriteLine("buyStopLossATRTimeFrame" + "=" + buyStopLossATRTimeFrame);
                file.WriteLine("sellStopLossMode" + "=" + sellStopLossMode);
                file.WriteLine("sellStopLossATRTimeFrame" + "=" + sellStopLossATRTimeFrame);
                file.WriteLine("buyTakeProfitMode" + "=" + buyTakeProfitMode);
                file.WriteLine("buyTakeProfitATRTimeFrame" + "=" + buyTakeProfitATRTimeFrame);
                file.WriteLine("sellTakeProfitMode" + "=" + sellTakeProfitMode);
                file.WriteLine("sellTakeProfitATRTimeFrame" + "=" + sellTakeProfitATRTimeFrame);
                file.WriteLine("buyPipStepMode" + "=" + buyPipStepMode);
                file.WriteLine("buyPipStepATRTimeFrame" + "=" + buyPipStepATRTimeFrame);
                file.WriteLine("sellPipStepMode" + "=" + sellPipStepMode);
                file.WriteLine("sellPipStepATRTimeFrame" + "=" + sellPipStepATRTimeFrame);
                file.WriteLine("buyEmptyOrderMode" + "=" + buyEmptyOrderMode);
                file.WriteLine("sellEmptyOrderMode" + "=" + sellEmptyOrderMode);
                file.WriteLine("slippage" + "=" + slippage);
                file.WriteLine("minLotSize" + "=" + minLotSize);
                file.WriteLine("buyRiskStep" + "=" + buyRiskStep);
                file.WriteLine("sellRiskStep" + "=" + sellRiskStep);
                file.WriteLine("maxLotSize" + "=" + maxLotSize);
                file.WriteLine("buyPivotPointBuffer" + "=" + buyPivotPointBuffer);
                file.WriteLine("buyPivotPointATRPeriod" + "=" + buyPivotPointATRPeriod);
                file.WriteLine("buyPivotPointATRShift" + "=" + buyPivotPointATRShift);
                file.WriteLine("sellPivotPointBuffer" + "=" + sellPivotPointBuffer);
                file.WriteLine("sellPivotPointATRPeriod" + "=" + sellPivotPointATRPeriod);
                file.WriteLine("sellPivotPointATRShift" + "=" + sellPivotPointATRShift);
                file.WriteLine("buyMAPeriod" + "=" + buyMAPeriod);
                file.WriteLine("sellMAPeriod" + "=" + sellMAPeriod);
                file.WriteLine("buyMAShift" + "=" + buyMAShift);
                file.WriteLine("sellMAShift" + "=" + sellMAShift);
                file.WriteLine("buyMABuffer" + "=" + buyMABuffer);
                file.WriteLine("sellMABuffer" + "=" + sellMABuffer);
                file.WriteLine("buyMAATRPeriod" + "=" + buyMAATRPeriod);
                file.WriteLine("buyMAATRShift" + "=" + buyMAATRShift);
                file.WriteLine("sellMAATRPeriod" + "=" + sellMAATRPeriod);
                file.WriteLine("sellMAATRShift" + "=" + sellMAATRShift);
                file.WriteLine("buyStopLossBuffer" + "=" + buyStopLossBuffer);
                file.WriteLine("buyStopLossATRPeriod" + "=" + buyStopLossATRPeriod);
                file.WriteLine("buyStopLossATRShift" + "=" + buyStopLossATRShift);
                file.WriteLine("sellStopLossBuffer" + "=" + sellStopLossBuffer);
                file.WriteLine("sellStopLossATRPeriod" + "=" + sellStopLossATRPeriod);
                file.WriteLine("sellStopLossATRShift" + "=" + sellStopLossATRShift);
                file.WriteLine("buyTakeProfitBuffer" + "=" + buyTakeProfitBuffer);
                file.WriteLine("buyTakeProfitATRPeriod" + "=" + buyTakeProfitATRPeriod);
                file.WriteLine("buyTakeProfitATRShift" + "=" + buyTakeProfitATRShift);
                file.WriteLine("sellTakeProfitBuffer" + "=" + sellTakeProfitBuffer);
                file.WriteLine("sellTakeProfitATRPeriod" + "=" + sellTakeProfitATRPeriod);
                file.WriteLine("sellTakeProfitATRShift" + "=" + sellTakeProfitATRShift);
                file.WriteLine("buyPSBuffer" + "=" + buyPSBuffer);
                file.WriteLine("buyPipStepATRPeriod" + "=" + buyPipStepATRPeriod);
                file.WriteLine("buyPipStepATRShift" + "=" + buyPipStepATRShift);
                file.WriteLine("sellPSBuffer" + "=" + sellPSBuffer);
                file.WriteLine("sellPipStepATRPeriod" + "=" + sellPipStepATRPeriod);
                file.WriteLine("sellPipStepATRShift" + "=" + sellPipStepATRShift);
                file.WriteLine("buyLimitBuffer" + "=" + buyLimitBuffer);
                file.WriteLine("buyStopBuffer" + "=" + buyStopBuffer);
                file.WriteLine("sellLimitBuffer" + "=" + sellLimitBuffer);
                file.WriteLine("sellStopBuffer" + "=" + sellStopBuffer);
                file.WriteLine("useLondonSession" + "=" + useLondonSession);
                file.WriteLine("useAmericaSession" + "=" + useAmericaSession);
            }
            using (System.IO.StreamWriter file = new System.IO.StreamWriter(basePath + envString + cmbbxCurrentSymbol.Text +"-research.txt"))
            {
                file.WriteLine(research.sldrStartYear.Value + "," + research.sldrStartYear.Value + "," + research.sldrMatchThreshold.Value + "," + research.sldrTradeThreshold.Value +
                    "," + research.sldrPage.Value + "," + research.sldrRpp.Value + "," + research.sldrAverageRangeLenth.Value);
            }
        }

        void btnSave_Click(object sender, RoutedEventArgs e)
        {
            saveConfig(getPath());
        }

        void btnGet_Click(object sender, RoutedEventArgs e)
        {
            readConfig(getPath());
        }

        void tbtnAmerica_Unchecked(object sender, RoutedEventArgs e)
        {
            useAmericaSession = americaSessionUnCheckedString;
            printThis(useAmericaSessionString, useAmericaSession);
        }

        void tbtnLondon_Unchecked(object sender, RoutedEventArgs e)
        {
            useLondonSession = londonSessionUnCheckedString;
            printThis(useLondonSessionString, useLondonSession);
        }

        void tbtnAmerica_Checked(object sender, RoutedEventArgs e)
        {
            useAmericaSession = americaSessionCheckedString;
            printThis(useAmericaSessionString, useAmericaSession);
        }

        void tbtnLondon_Checked(object sender, RoutedEventArgs e)
        {
            useLondonSession = londonSessionCheckedString;
            printThis(useLondonSessionString, useLondonSession);
        }

        void printThis(string sender, string content)
        {
            Debug.WriteLine("sender = " + sender);
            Debug.WriteLine("content = " + content);
            Debug.WriteLine("---value set");
        }

        void BuyStopBuffer_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            buyStopBuffer = obj.Text;
            printThis(buyStopBufferString, buyStopBuffer);
        }
        void BuyLimitBuffer_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            buyLimitBuffer = obj.Text;
            printThis(buyLimitBufferString, buyLimitBuffer);
        }
        void BuyPipStepATRShift_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            buyPipStepATRShift = obj.Text;
            printThis(buyPipStepATRShiftString, buyPipStepATRShift);
        }
        void BuyPipStepATRPeriod_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            buyPipStepATRPeriod = obj.Text;
            printThis(buyPipStepATRPeriodString, buyPipStepATRPeriod);
        }
        void BuyPSBuffer_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            buyPSBuffer = obj.Text;
            printThis(buyPSBufferString, buyPSBuffer);
        }
        void BuyTakeProfitATRShift_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            buyTakeProfitATRShift = obj.Text;
            printThis(buyTakeProfitATRShiftString, buyTakeProfitATRShift);
        }
        void BuyTakeProfitATRPeriod_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            buyTakeProfitATRPeriod = obj.Text;
            printThis(buyTakeProfitATRPeriodString, buyTakeProfitATRPeriod);
        }
        void BuytxtTakeProfit_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            buyTakeProfitBuffer = obj.Text;
            printThis(buyTakeProfitBufferString, buyTakeProfitBuffer);
        }
        void BuyStopLossATRShift_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            buyStopLossATRShift = obj.Text;
            printThis(buyStopLossATRShiftString, buyStopLossATRShift);
        }
        void BuyStopLossATRPeriod_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            buyStopLossATRPeriod = obj.Text;
            printThis(buyStopLossATRPeriodString, buyStopLossATRPeriod);
        }
        void BuytxtStopLoss_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            buyStopLossBuffer = obj.Text;
            printThis(buyStopLossBufferString, buyStopLossBuffer);
        }

        void SellStopBuffer_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            sellStopBuffer = obj.Text;
            printThis(sellStopBufferString, sellStopBuffer);
        }
        void SellLimitBuffer_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            sellLimitBuffer = obj.Text;
            printThis(sellLimitBufferString, sellLimitBuffer);
        }
        void SellPipStepATRShift_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            sellPipStepATRShift = obj.Text;
            printThis(sellPipStepATRShiftString, sellPipStepATRShift);
        }
        void SellPipStepATRPeriod_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            sellPipStepATRPeriod = obj.Text;
            printThis(sellPipStepATRPeriodString, sellPipStepATRPeriod);
        }
        void SellPSBuffer_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            sellPSBuffer = obj.Text;
            printThis(sellPSBufferString, sellPSBuffer);
        }
        void SellTakeProfitATRShift_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            sellTakeProfitATRShift = obj.Text;
            printThis(sellTakeProfitATRShiftString, sellTakeProfitATRShift);
        }
        void SellTakeProfitATRPeriod_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            sellTakeProfitATRPeriod = obj.Text;
            printThis(sellTakeProfitATRPeriodString, sellTakeProfitATRPeriod);
        }
        void SelltxtTakeProfit_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            sellTakeProfitBuffer = obj.Text;
            printThis(sellTakeProfitBufferString, sellTakeProfitBuffer);
        }
        void SellStopLossATRShift_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            sellStopLossATRShift = obj.Text;
            printThis(sellStopLossATRShiftString, sellStopLossATRShift);
        }
        void SellStopLossATRPeriod_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            sellStopLossATRPeriod = obj.Text;
            printThis(sellStopLossATRPeriodString, sellStopLossATRPeriod);
        }
        void SelltxtStopLoss_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            sellStopLossBuffer = obj.Text;
            printThis(sellStopLossBufferString, sellStopLossBuffer);
        }

        void BuyATRPeriod_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            Debug.WriteLine("sender = " + buyMAATRPeriodString);
            buyMAATRPeriod = obj.Text;
            Debug.WriteLine("content = " + buyMAATRPeriod);
            Debug.WriteLine("---value set");
        }
        void BuyATRShift_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            Debug.WriteLine("sender = " + buyMAATRShiftString);
            buyMAATRShift = obj.Text;
            Debug.WriteLine("content = " + buyMAATRShift);
            Debug.WriteLine("---value set");
        }

        void SellATRPeriod_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            Debug.WriteLine("sender = " + sellMAATRPeriodString);
            sellMAATRPeriod = obj.Text;
            Debug.WriteLine("content = " + sellMAATRPeriod);
            Debug.WriteLine("---value set");
        }
        void SellATRShift_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            Debug.WriteLine("sender = " + sellMAATRShiftString);
            sellMAATRShift = obj.Text;
            Debug.WriteLine("content = " + sellMAATRShift);
            Debug.WriteLine("---value set");
        }

        void BuyMABuffer_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            Debug.WriteLine("sender = " + buyMABufferString);
            buyMABuffer = obj.Text;
            Debug.WriteLine("content = " + buyMABuffer);
            Debug.WriteLine("---value set");
        }
        void SellMABuffer_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            Debug.WriteLine("sender = " + sellMABufferString);
            sellMABuffer = obj.Text;
            Debug.WriteLine("content = " + sellMABuffer);
            Debug.WriteLine("---value set");
        }
        void BuyMAShift_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            Debug.WriteLine("sender = " + buyMAPeriodString);
            buyMAShift = obj.Text;
            Debug.WriteLine("content = " + buyMAShift);
            Debug.WriteLine("---value set");
        }
        void SellMAShift_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            Debug.WriteLine("sender = " + sellMAPeriodString);
            sellMAShift = obj.Text;
            Debug.WriteLine("content = " + sellMAShift);
            Debug.WriteLine("---value set");
        }
        void BuyMAPeriod_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            Debug.WriteLine("sender = " + buyMAPeriodString);
            buyMAPeriod = obj.Text;
            Debug.WriteLine("content = " + buyMAPeriod);
            Debug.WriteLine("---value set");
        }
        void SellMAPeriod_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            Debug.WriteLine("sender = " + sellMAPeriodString);
            sellMAPeriod = obj.Text;
            Debug.WriteLine("content = " + sellMAPeriod);
            Debug.WriteLine("---value set");
        }
        void SellShift_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            Debug.WriteLine("sender = " + sellPivotPointATRShiftString);
            sellPivotPointATRShift = obj.Text;
            Debug.WriteLine("content = " + sellPivotPointATRShift);
            Debug.WriteLine("---value set");
        }
        void BuyShift_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            Debug.WriteLine("sender = " + buyPivotPointATRShiftString);
            buyPivotPointATRShift = obj.Text;
            Debug.WriteLine("content = " + buyPivotPointATRShift);
            Debug.WriteLine("---value set");
        }
        void SellPeriod_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            Debug.WriteLine("sender = " + sellPivotPointATRPeriodString);
            sellPivotPointATRPeriod = obj.Text;
            Debug.WriteLine("content = " + sellPivotPointATRPeriod);
            Debug.WriteLine("---value set");
        }
        void BuyPeriod_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            Debug.WriteLine("sender = " + buyPivotPointATRPeriodString);
            buyPivotPointATRPeriod = obj.Text;
            Debug.WriteLine("content = " + buyPivotPointATRPeriod);
            Debug.WriteLine("---value set");
        }
        void SellBuffer_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            Debug.WriteLine("sender = " + sellPivotPointBufferString);
            sellPivotPointBuffer = obj.Text;
            Debug.WriteLine("content = " + sellPivotPointBuffer);
            Debug.WriteLine("---value set");
        }

        void BuyBuffer_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            Debug.WriteLine("sender = " + buyPivotPointBufferString);
            buyPivotPointBuffer = obj.Text;
            Debug.WriteLine("content = " + buyPivotPointBuffer);
            Debug.WriteLine("---value set");
        }

        void SellRiskStep_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            Debug.WriteLine("sender = " + sellRiskStepString);
            sellRiskStep = obj.Text;
            Debug.WriteLine("content = " + sellRiskStep);
            Debug.WriteLine("---value set");
        }

        void BuyRiskStep_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            Debug.WriteLine("sender = " + buyRiskStepString);
            buyRiskStep = obj.Text;
            Debug.WriteLine("content = " + buyRiskStep);
            Debug.WriteLine("---value set");
        }

        void MinLotSize_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            Debug.WriteLine("sender = " + minLotSizeString);
            minLotSize = obj.Text;
            Debug.WriteLine("content = " + minLotSize);
            Debug.WriteLine("---value set");
        }

        void MaxLotSize_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            Debug.WriteLine("sender = " + maxLotSizeString);
            maxLotSize = obj.Text;
            Debug.WriteLine("content = " + maxLotSize);
            Debug.WriteLine("---value set");
        }

        void Slippage_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox obj = (TextBox)sender;
            Debug.WriteLine("sender = " + slippageString);
            slippage = obj.Text;
            Debug.WriteLine("content = " + slippage);
            Debug.WriteLine("---value set");
        }

        void setValues(string key, string val)
        {
            if (key == buyPivotTimeFrameString){
                buyPivotTimeFrame = val;
            }else if (key == buyPivotPointLineIndexString){
                buyPivotPointLineIndex = val;
            }else if (key == buyPivotPointModeString){
                buyPivotPointMode = val;
            }else if (key == buyPivotDirectionString){
                buyPivotDirection = val;
            }else if (key == buyPivotPointATRTimeFrameString){
                buyPivotPointATRTimeFrame = val;
            }else if (key == sellPivotTimeFrameString){
                sellPivotTimeFrame = val;
            }else if (key == sellPivotPointModeString){
                sellPivotPointMode = val;
            }else if (key == sellPivotPointLineIndexString){
                sellPivotPointLineIndex = val;
            }else if (key == sellPivotDirectionString){
                sellPivotDirection = val;
            }else if (key == sellPivotPointATRTimeFrameString){
                sellPivotPointATRTimeFrame = val;
            }else if (key == buyMAModeString){
                buyMAMode = val;
            }else if (key == buyMATypeString){
                buyMAType = val;
            }else if (key == buyMATimeFrameString){
                buyMATimeFrame = val;
            }else if (key == buyMADirectionString){
                buyMADirection = val;
            }else if (key == buyMAATRTimeFrameString){
                buyMAATRTimeFrame = val;
            }else if (key == sellMAModeString){
                sellMAMode = val;
            }else if (key == sellMATypeString){
                sellMAType = val;
            }else if (key == sellMATimeFrameString){
                sellMATimeFrame = val;
            }else if (key == sellMADirectionString){
                sellMADirection = val;
            }else if (key == sellMAATRTimeFrameString){
                sellMAATRTimeFrame = val;
            }else if (key == buyStopLossModeString){
                buyStopLossMode = val;
            }else if (key == buyStopLossATRTimeFrameString){
                buyStopLossATRTimeFrame = val;
            }else if (key == sellStopLossModeString){
                sellStopLossMode = val;
            }else if (key == sellStopLossATRTimeFrameString){
                sellStopLossATRTimeFrame = val;
            }else if (key == buyTakeProfitModeString){
                buyTakeProfitMode = val;
            }else if (key == buyTakeProfitATRTimeFrameString){
                buyTakeProfitATRTimeFrame = val;
            }else if (key == sellTakeProfitModeString){
                sellTakeProfitMode = val;
            }else if (key == sellTakeProfitATRTimeFrameString){
                sellTakeProfitATRTimeFrame = val;
            }else if (key == buyPipStepModeString){
                buyPipStepMode = val;
            }else if (key == buyPipStepATRTimeFrameString){
                buyPipStepATRTimeFrame = val;
            }else if (key == sellPipStepModeString){
                sellPipStepMode = val;
            }else if (key == sellPipStepATRTimeFrameString){
                sellPipStepATRTimeFrame = val;
            }else if (key == buyEmptyOrderModeString){
                buyEmptyOrderMode = val;
            }else if (key == sellEmptyOrderModeString){
                sellEmptyOrderMode = val;
            }else if (key == slippageString) {
                Slippage.Text = val;
                slippage = val;
            }else if (key == minLotSizeString){
                MinLotSize.Text = val;
                minLotSize = val;
            }else if (key == buyRiskStepString) {
                BuyRiskStep.Text = val;
                buyRiskStep = val;
            }else if (key == sellRiskStepString){
                SellRiskStep.Text = val;
                sellRiskStep = val;
            }else if (key == maxLotSizeString){
                MaxLotSize.Text = val;
                maxLotSize = val;
            }else if (key == buyPivotPointBufferString) {
                buy.pivotPoint.Buffer.Text = val;
                buyPivotPointBuffer = val;
            }else if (key == buyPivotPointATRPeriodString) {
                buy.pivotPoint.ATR.Period.Text = val;
                buyPivotPointATRPeriod = val;
            }else if (key == buyPivotPointATRShiftString){
                buy.pivotPoint.ATR.Shift.Text = val;
                buyPivotPointATRShift = val;
            }else if (key == sellPivotPointBufferString){
                sell.pivotPoint.Buffer.Text = val;
                sellPivotPointBuffer = val;
            }else if (key == sellPivotPointATRPeriodString){
                sell.pivotPoint.ATR.Period.Text = val;
                sellPivotPointATRPeriod = val;
            }else if (key == sellPivotPointATRShiftString){
                sell.pivotPoint.ATR.Shift.Text = val;
                sellPivotPointATRShift = val;
            }else if (key == buyMAPeriodString) {
                buy.mA.MAPeriod.Text = val;
                buyMAPeriod = val;
            }else if (key == sellMAPeriodString){
                sell.mA.MAPeriod.Text = val;
                sellMAPeriod = val;
            }else if (key == buyMAShiftString) {
                buy.mA.MAShift.Text = val;
                buyMAShift = val;
            }else if (key == sellMAShiftString) {
                sell.mA.MAShift.Text = val;
                sellMAShift = val;
            }else if (key == buyMABufferString){
                buy.mA.MABuffer.Text = val;
                buyMABuffer = val;
            }else if (key == sellMABufferString){
                sell.mA.MABuffer.Text = val;
                sellMABuffer = val;
            }else if (key == buyMAATRPeriodString){
                buy.mA.ATR.Period.Text = val;
                buyMAATRPeriod = val;
            }else if (key == buyMAATRShiftString){
                buy.mA.ATR.Shift.Text = val;
                buyMAATRShift = val;
            }else if (key == sellMAATRPeriodString) {
                sell.mA.ATR.Period.Text = val;
                sellMAATRPeriod = val;
            }else if (key == sellMAATRShiftString){
                sell.mA.ATR.Shift.Text = val;
                sellMAATRShift = val;
            }else if (key == buyStopLossBufferString){
                buy.stopLoss.txtStopLoss.Text = val;
                buyStopLossBuffer = val;
            }else if (key == buyStopLossATRPeriodString){
                buy.stopLoss.ATR.Period.Text = val;
                buyStopLossATRPeriod = val;
            }else if (key == buyStopLossATRShiftString) {
                buy.stopLoss.ATR.Shift.Text = val;
                buyStopLossATRShift = val;
            }else if (key == buyTakeProfitBufferString){
                buy.takeProfit.txtTakeProfit.Text = val;
                buyTakeProfitBuffer = val;
            }else if (key == buyTakeProfitATRPeriodString){
                buy.takeProfit.ATR.Period.Text = val;
                buyTakeProfitATRPeriod = val;
            }else if (key == buyTakeProfitATRShiftString){
                buy.takeProfit.ATR.Shift.Text = val;
                buyTakeProfitATRShift = val;
            }else if (key == buyPSBufferString){
                buy.pipStep.txtbxPSBuffer.Text = val;
                buyPSBuffer = val;
            }else if (key == buyPipStepATRPeriodString) {
                buy.pipStep.ATR.Period.Text = val;
                buyPipStepATRPeriod = val;
            }else if (key == buyPipStepATRShiftString) {
                buy.pipStep.ATR.Shift.Text = val;
                buyPipStepATRShift = val;
            }else if (key == buyLimitBufferString){
                buy.emptyOrderMode.LimitBuffer.Text = val;
                buyLimitBuffer = val;
            }else if (key == buyStopBufferString) {
                buy.emptyOrderMode.StopBuffer.Text = val;
                buyStopBuffer = val;
            }else if (key == sellStopLossBufferString){
                sell.stopLoss.txtStopLoss.Text = val;
                sellStopLossBuffer = val;
            }else if (key == sellStopLossATRPeriodString){
                sell.stopLoss.ATR.Period.Text = val;
                sellStopLossATRPeriod = val;
            }else if (key == sellStopLossATRShiftString){
                sell.stopLoss.ATR.Shift.Text = val;
                sellStopLossATRShift = val;
            }else if (key == sellTakeProfitBufferString){
                sell.takeProfit.txtTakeProfit.Text = val;
                sellTakeProfitBuffer = val;
            }else if (key == sellTakeProfitATRPeriodString){
                sell.takeProfit.ATR.Period.Text = val;
                sellTakeProfitATRPeriod = val;
            }else if (key == sellTakeProfitATRShiftString){
                sell.takeProfit.ATR.Shift.Text = val;
                sellTakeProfitATRShift = val;
            }else if (key == sellPSBufferString){
                sell.pipStep.txtbxPSBuffer.Text = val;
                sellPSBuffer = val;
            }else if (key == sellPipStepATRPeriodString){
                sell.pipStep.ATR.Period.Text = val;
                sellPipStepATRPeriod = val;
            }else if (key == sellPipStepATRShiftString){
                sell.pipStep.ATR.Shift.Text = val;
                sellPipStepATRShift = val;
            }else if (key == sellLimitBufferString){
                sell.emptyOrderMode.LimitBuffer.Text = val;
                sellLimitBuffer = val;
            }else if (key == sellStopBufferString){
                sell.emptyOrderMode.StopBuffer.Text = val;
                sellStopBuffer = val;
            }else if (key == useLondonSessionString) {
                useLondonSession = val;
            } else if (key == useAmericaSessionString){
                useAmericaSession = val;
            }
        }

        void val_Changed(object sender, RoutedEventArgs e)
        {
            RadioButton obj = (RadioButton)sender;
            Debug.WriteLine("groupName = " + obj.GroupName);
            Debug.WriteLine("sender = " + obj.Name);
            string cont;
            if (obj.Content == null)
            {
                cont = noValueFromUI;
            }
            else
            {
                cont = obj.Content.ToString();
            }
            Debug.WriteLine("content = " + cont);
            setValues(obj.GroupName, cont);
            Debug.WriteLine("---value set");
        }

        string envString = "";

        private void readConfig(string pathToConfig)
        {
            try
            {
                int counter = 0;
                string line;
                System.IO.StreamReader file =
                   new System.IO.StreamReader(pathToConfig);
                while ((line = file.ReadLine()) != null)
                {
                    processConfigLine(line);
                    counter++;
                }
                file.Close();
                //txtboxConfigPath.Text = pathToConfig;
            }
            catch(Exception ex)
            {
                //readConfig(@"../../files/default.txt");
                //txtboxConfigPath.Text = @"../../files/default.txt";
                //defaultPath = @"C:/Users/Rashad/AppData/Roaming/MetaQuotes/Terminal/46A834A4BD020127C05B0DA2582F8F5C" + envString + cmbbxCurrentSymbol.Text + ".txt";
                readConfig(getPath());
                //txtboxConfigPath.Text = defaultPath;
                Debug.WriteLine(ex.Message);
            }
            
        }

        private string getPath()
        {
            return @"C:/Users/Rashad/AppData/Roaming/MetaQuotes/Terminal/46A834A4BD020127C05B0DA2582F8F5C" + envString + cmbbxCurrentSymbol.Text + ".txt";
        }

        private void processConfigLine(string line)
        {
            string[] configuration = line.Split('=');
            string key = configuration[0];
            string val = configuration[1];
            setValues(key, val);

            Person p1 = new Person();
            p1.name = "the";
            Person.nameStatic = "newval";

        }



        void setTimeFrame(Controls.TimeFrameControl inCTFC, string inValue)
        {
            if (inValue == M1){
                inCTFC.M1.IsChecked = true;
            }else if (inValue == M5){
                inCTFC.M5.IsChecked = true;
            }else if (inValue == M15){
                inCTFC.M15.IsChecked = true;
            }else if (inValue == M30){
                inCTFC.M30.IsChecked = true;
            }else if (inValue == H1) {
                inCTFC.H1.IsChecked = true;
            }else if (inValue == H4) {
                inCTFC.H4.IsChecked = true;
            }else if (inValue == D1) {
                inCTFC.D1.IsChecked = true;
            }else if (inValue == W1) {
                inCTFC.W1.IsChecked = true;
            }else if (inValue == MN) {
                inCTFC.MN.IsChecked = true;
            }
        }

        void setDirection(Controls.direction inDir, string inValue)
        {
            if (inValue == GreaterThan){
                inDir.Greater.IsChecked = true;
            }else if (inValue == LessThan){
                inDir.Less.IsChecked = true;
            }
        }

        void setSpacingMode(Controls.spacingMode cSM, string inValue)
        {
            if (inValue == ExplicitSpacing){
                cSM.Explicit.IsChecked = true;
            }else if (inValue == ATRSpacing){
                cSM.ATR.IsChecked = true;
            }
        }

        void setPivotPoint(Controls.PivotPointSelectorControl cppsc, string inValue)
        {
            if (inValue == PivotPoint) { 
                cppsc.pp.IsChecked = true;
            }else if (inValue == R1) {
                cppsc.r1.IsChecked = true;
            }else if (inValue == R2){
                cppsc.r2.IsChecked = true;
            }else if (inValue == R3){
                cppsc.r3.IsChecked = true;
            }else if (inValue == S1){
                cppsc.s1.IsChecked = true;
            }else if (inValue == S2){
                cppsc.s2.IsChecked = true;
            }else if (inValue == S3){
                cppsc.s3.IsChecked = true;
            }
        }

        void getMAType(Controls.MAMode cmm, string inValue)
        {
            if (inValue == SMA){
                cmm.sma.IsChecked = true;
            }else if (inValue == EMA) {
                cmm.ema.IsChecked = true;
            }
        }

        void setEmptyOrderMode(Controls.EOM ce, string inValue)
        {
            if (inValue == MarketOrder){
                ce.orderTypes.Market.IsChecked = true;
            }else if (inValue == LimitOrder){
                ce.orderTypes.Limit.IsChecked = true;
            }else if (inValue == StopOrder) {
                ce.orderTypes.Stop.IsChecked = true;
            }
        }

        void setTimeFrameGroupName(Controls.TimeFrameControl ctfc, string groupName)
        {
            ctfc.M1.GroupName = groupName;
            ctfc.M5.GroupName = groupName;
            ctfc.M15.GroupName = groupName;
            ctfc.M30.GroupName = groupName;
            ctfc.H1.GroupName = groupName;
            ctfc.H4.GroupName = groupName;
            ctfc.D1.GroupName = groupName;
            ctfc.W1.GroupName = groupName;
            ctfc.MN.GroupName = groupName;

            ctfc.M1.Checked += val_Changed;
            ctfc.M5.Checked += val_Changed;
            ctfc.M15.Checked += val_Changed;
            ctfc.M30.Checked += val_Changed;
            ctfc.H1.Checked += val_Changed;
            ctfc.H4.Checked += val_Changed;
            ctfc.D1.Checked += val_Changed;
            ctfc.W1.Checked += val_Changed;
            ctfc.MN.Checked += val_Changed;
        }

        void setPivotPointGroupName(Controls.PivotPointSelectorControl cppsc, string groupName)
        {
            cppsc.pp.GroupName = groupName;
            cppsc.r1.GroupName = groupName;
            cppsc.r2.GroupName = groupName;
            cppsc.r3.GroupName = groupName;
            cppsc.s1.GroupName = groupName;
            cppsc.s2.GroupName = groupName;
            cppsc.s3.GroupName = groupName;

            cppsc.pp.Checked += val_Changed;
            cppsc.r1.Checked += val_Changed;
            cppsc.r2.Checked += val_Changed;
            cppsc.r3.Checked += val_Changed;
            cppsc.s1.Checked += val_Changed;
            cppsc.s2.Checked += val_Changed;
            cppsc.s3.Checked += val_Changed;
        }

        void setSpacingGroupName(Controls.spacingMode csm, string groupName)
        {
            csm.ATR.GroupName = groupName;
            csm.Explicit.GroupName = groupName;
            csm.None.GroupName = groupName;
            csm.ATR.Checked += val_Changed;
            csm.Explicit.Checked += val_Changed;
            csm.None.Checked += val_Changed;
        }

        void setDirectionGroupName(Controls.direction cd, string groupName)
        {
            cd.Greater.GroupName = groupName;
            cd.Less.GroupName = groupName;
            cd.Greater.Checked += val_Changed;
            cd.Less.Checked += val_Changed;
        }

        void setMAGroupName(Controls.MAMode cmm, string groupName)
        {
            cmm.ema.GroupName = groupName;
            cmm.sma.GroupName = groupName;
            cmm.ema.Checked += val_Changed;
            cmm.sma.Checked += val_Changed;
        }

        void setOrderTypesGroupName(Controls.EOM ce, string groupName)
        {
            ce.orderTypes.Limit.GroupName = groupName;
            ce.orderTypes.Stop.GroupName = groupName;
            ce.orderTypes.Market.GroupName = groupName;
            ce.orderTypes.Limit.Checked += val_Changed;
            ce.orderTypes.Stop.Checked += val_Changed;
            ce.orderTypes.Market.Checked += val_Changed;
        }

        private void envChanged(object sender, RoutedEventArgs e)
        {
            if (rbtnDev != null)
            {
                string devString = @"/tester/files/";
                if (rbtnDev.IsChecked == true)
                {
                    envString = devString;
                }
            }

            if (rbtnProd != null)
            {
                string prodString = @"/MQL4/Files/";
                if (rbtnProd.IsChecked == true)
                {
                    envString = prodString;
                }
            }

        }

        private void btndefault_Click(object sender, RoutedEventArgs e)
        {
            string defaultPath = basePath + envString + "default.txt";
            readConfig(defaultPath);
            saveConfig(getPath());
        }

        private void btnsell1_Click(object sender, RoutedEventArgs e)
        {
            string defaultPath = basePath + envString + "sell1.txt";
            readConfig(defaultPath);
            saveConfig(getPath());
        }

        private void btnsell2_Click(object sender, RoutedEventArgs e)
        {
            string defaultPath = basePath + envString + "sell2.txt";
            readConfig(defaultPath);
            saveConfig(getPath());
        }

        private void btnsell3_Click(object sender, RoutedEventArgs e)
        {
            string defaultPath = basePath + envString + "sell3.txt";
            readConfig(defaultPath);
            saveConfig(getPath());
        }

        private void btnbuy1_Click(object sender, RoutedEventArgs e)
        {
            string defaultPath = basePath + envString + "buy1.txt";
            readConfig(defaultPath);
            saveConfig(getPath());
        }

        private void btnbuy2_Click(object sender, RoutedEventArgs e)
        {
            string defaultPath = basePath + envString + "buy2.txt";
            readConfig(defaultPath);
            saveConfig(getPath());
        }

        private void btnbuy3_Click(object sender, RoutedEventArgs e)
        {
            string defaultPath = basePath + envString + "buy3.txt";
            readConfig(defaultPath);
            saveConfig(getPath());
        }
    }
}
