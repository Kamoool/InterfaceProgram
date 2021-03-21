using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
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

        private void Connect_BTN_Click(object sender, EventArgs e)
        {
            if (Connect_BTN.Text.Equals("Connect"))
            {
                try
                {
                    MainSerialPort.BaudRate = 9600;
                    MainSerialPort.PortName = comboBox1.Text;
                    MainSerialPort.NewLine = "\r\n";
                    MainSerialPort.DtrEnable = true;
                    MainSerialPort.Open();
                    Thread.Sleep(1000);
                    MessageBox.Show("Connected");
                    FunctionsEnableConnection();
                }

                catch (Exception)
                {
                    MessageBox.Show("Error - connection problem!");
                }
            }
            else if (Connect_BTN.Text.Equals("Disconnect"))
            {
                try
                {
                    MainSerialPort.WriteLine("E");
                }
                catch (Exception)
                { }
                MainSerialPort.Close();
                FunctionsBase();
            }

        }
        private void Read_BTN_Click(object sender, EventArgs e)
        {
            try
            {
                MainSerialPort.WriteLine("R");
            }
            catch (Exception)
            {
                MessageBox.Show("Error - connection problem");
            }
        }
        private void CutTest_BTN_Click(object sender, EventArgs e)
        {
            try
            {
                MainSerialPort.WriteLine("C");
            }
            catch (Exception)
            {
                MessageBox.Show("Error - connection problem");
            }
        }
        private void BlipTest_BTN_Click(object sender, EventArgs e)
        {
            try
            {
                MainSerialPort.WriteLine("B");
            }
            catch (Exception)
            {
                MessageBox.Show("Error - connection problem");
            }
        }
        private void Refresh_BTN_Click(object sender, EventArgs e)
        {
            FillComboBox();
        }
        private void Reset_BTN_Click(object sender, EventArgs e)
        {
            try
            {
                MainSerialPort.WriteLine("W");
            }
            catch (Exception)
            {
                MessageBox.Show("Error - connection problem");
            }
        }

        private void Save_BTN_Click(object sender, EventArgs e)
        {
            try
            {
                MainSerialPort.WriteLine(GenerateDataToSend());
            }
            catch (Exception)
            {
                MessageBox.Show("Error - connection problem");
            }
        }

    }
}
