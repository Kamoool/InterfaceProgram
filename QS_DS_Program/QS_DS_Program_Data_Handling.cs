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
        private void ReceivedDataHandle(object sender, EventArgs e)
        {
            string[] SplitData = IncomingData.Split(',');

            if (SplitData[0].Equals("V"))
            {
                SetRPMSensor(SplitData[1], SplitData[2]);
            }
            else if (SplitData[0].Equals("T"))
            {
                DisableFunctionsWorking();
                FunctionsAssignValues(SplitData);
                FunctionsShowTable();
            }
        }
        private string GenerateDataToSend()
        {
            string MSG = "S,";
            MSG += GenerateCheckBoxData();
            MSG += GenerateNumericData();
            MSG.Remove(MSG.Length - 1);
            return MSG;
        }

    }
}
