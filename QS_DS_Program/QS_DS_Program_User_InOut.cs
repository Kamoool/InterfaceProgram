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
        private string IncomingData;
        private void SerialDataReceived(object sender, System.IO.Ports.SerialDataReceivedEventArgs e)
        {
            IncomingData = MainSerialPort.ReadLine();
            Invoke(new EventHandler(ReceivedDataHandle));
        }
    }
}
