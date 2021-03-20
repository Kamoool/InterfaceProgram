using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QS_DS_Program
{
    public partial class QS_DS_Program : Form
    {
        private void ReceivedDataHandle(object sender, EventArgs e) // metoda wyświetlania temperatury
        {
            string[] SplitData = IncomingData.Split(',');

            if (SplitData[0] == "V")
            {
                SetRPMSensor(SplitData[1], SplitData[2]);
            }
            else if (SplitData[0] == "T")
            {
                DisableFunctionAll();
                if (SplitData[1] == "1")
                {
                    Typ = 1;
                    EnableFunction1();
                }
                else if (SplitData[1] == "2")
                {
                    Typ = 2;
                    EnableFunction2();
                }
                else if (SplitData[1] == "3")
                {
                    Typ = 3;
                    EnableFunction3();
                }
                if (SplitData[2] == "1")
                {
                    Push_Check_QS.Checked = true;
                    Pull_Check_QS.Checked = false;
                    Push_Check_DS.Checked = false;
                    Pull_Check_DS.Checked = true;
                }
                else if (SplitData[2] == "0")
                {
                    Pull_Check_QS.Checked = true;
                    Push_Check_QS.Checked = false;
                    Pull_Check_DS.Checked = false;
                    Push_Check_DS.Checked = true;
                }

                QSForce.Value = Int32.Parse(SplitData[3]);
                DSForce.Value = Int32.Parse(SplitData[4]);
                Pulses.Value = Decimal.Parse(SplitData[5], NumberStyles.AllowDecimalPoint, CultureInfo.InvariantCulture);
                MinRPMQS.Value = Int32.Parse(SplitData[6]);
                MinRPMDS.Value = Int32.Parse(SplitData[7]);
                if (SplitData[8] == "1")
                {
                    QSEnable_Check.Checked = true;
                }
                else if (SplitData[8] == "0")
                {
                    QSEnable_Check.Checked = false;
                }

                PreDelayQS.Value = Int32.Parse(SplitData[9]);
                CutTime1.Value = Int32.Parse(SplitData[10]);
                CutTime2.Value = Int32.Parse(SplitData[11]);
                CutTime3.Value = Int32.Parse(SplitData[12]);
                CutTime4.Value = Int32.Parse(SplitData[13]);
                CutTime5.Value = Int32.Parse(SplitData[14]);
                CutTime6.Value = Int32.Parse(SplitData[15]);
                CutTime7.Value = Int32.Parse(SplitData[16]);
                CutTime8.Value = Int32.Parse(SplitData[17]);

                if (SplitData[18] == "1")
                {
                    DSEnable_Check.Checked = true;
                }
                else if (SplitData[18] == "0")
                {
                    DSEnable_Check.Checked = false;
                }

                PreDelayDS.Value = Int32.Parse(SplitData[19]);
                BlipTime1.Value = Int32.Parse(SplitData[20]);
                BlipTime2.Value = Int32.Parse(SplitData[21]);
                BlipTime3.Value = Int32.Parse(SplitData[22]);
                BlipTime4.Value = Int32.Parse(SplitData[23]);
                BlipTime5.Value = Int32.Parse(SplitData[24]);
                BlipTime6.Value = Int32.Parse(SplitData[25]);
                BlipTime7.Value = Int32.Parse(SplitData[26]);
                BlipTime8.Value = Int32.Parse(SplitData[27]);

                MaxRPMDS.Value = Int32.Parse(SplitData[28]);


            }
        }
    }
}
