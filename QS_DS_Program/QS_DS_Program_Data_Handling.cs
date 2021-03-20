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

            if (SplitData[0] == "V")
            {
                SetRPMSensor(SplitData[1], SplitData[2]);
            }
            else if (SplitData[0] == "T")
            {
                //TODO - ADD Version label
                DisableFunctionAll();
                FunctionsAssignValues(SplitData);
                FunctionsShowTable();
            }
        }
    }
}
