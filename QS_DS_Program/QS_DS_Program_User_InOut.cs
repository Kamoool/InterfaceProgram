using System;
using System.Collections.Generic;
using System.Diagnostics;
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
        private Stopwatch stopwatch = new Stopwatch();
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
                    Connect_BTN.Enabled = false;
                    MainSerialPort.BaudRate = 9600;
                    MainSerialPort.PortName = comboBox1.Text;
                    MainSerialPort.NewLine = "\r\n";
                    MainSerialPort.DtrEnable = true;
                    stopwatch.Reset();
                    stopwatch.Start();
                    MainSerialPort.Open();
                    while(stopwatch.ElapsedMilliseconds< 1000)
                    {
                    }
                    stopwatch.Stop();
                    //Thread.Sleep(1000);
                    MessageBox.Show("Connected");
                    FunctionsEnableConnection();
                    Connect_BTN.Enabled = true;
                }

                catch (Exception)
                {
                    MessageBox.Show("Error - connection problem!");
                    Connect_BTN.Enabled = true;
                }
            }
            else if (Connect_BTN.Text.Equals("Disconnect"))
            {
                try
                {
                    Connect_BTN.Enabled = false;
                    MainSerialPort.WriteLine("E");
                    MainSerialPort.DiscardInBuffer();
                    MainSerialPort.DiscardOutBuffer();
                    MainSerialPort.BaseStream.Flush();
                    stopwatch.Reset();
                    stopwatch.Start();
                    while (stopwatch.ElapsedMilliseconds < 1000)
                    {
                    }
                    stopwatch.Stop();
                    Connect_BTN.Enabled = true;
                }
                catch (Exception)
                {
                    Connect_BTN.Enabled = true;
                }
                MainSerialPort.Close();
                FunctionsBase();
            }

        }
        private void Read_BTN_Click(object sender, EventArgs e)
        {
            try
            {
                Read_BTN.Enabled = false;
                MainSerialPort.WriteLine("R");
                stopwatch.Reset();
                stopwatch.Start();
                while (stopwatch.ElapsedMilliseconds < 1000)
                {
                }
                stopwatch.Stop();
                Read_BTN.Enabled = true;
            }
            catch (Exception)
            {
                MessageBox.Show("Error - connection problem");
                Read_BTN.Enabled = true;
            }
        }
        private void CutTest_BTN_Click(object sender, EventArgs e)
        {
            try
            {
                CutTest_BTN.Enabled = false;
                CutTest_BTN.Update();
                MainSerialPort.WriteLine("C");
                stopwatch.Reset();
                stopwatch.Start();
                while (stopwatch.ElapsedMilliseconds < 1000)
                {
                }
                stopwatch.Stop();
                Application.DoEvents();
                if (!CutTest_BTN.IsDisposed) {
                    CutTest_BTN.Enabled = true;
                }
                
            }
            catch (Exception)
            {
                MessageBox.Show("Error - connection problem");
                CutTest_BTN.Enabled = true;
            }
        }
        private void BlipTest_BTN_Click(object sender, EventArgs e)
        {
            try
            {
                BlipTest_BTN.Enabled = false;
                BlipTest_BTN.Update();
                MainSerialPort.WriteLine("B");
                stopwatch.Reset();
                stopwatch.Start();
                while (stopwatch.ElapsedMilliseconds < 1000)
                {
                }
                stopwatch.Stop();
                Application.DoEvents();
                if (!BlipTest_BTN.IsDisposed)
                {
                    BlipTest_BTN.Enabled = true;
                }
            }
            catch (Exception)
            {
                MessageBox.Show("Error - connection problem");
                BlipTest_BTN.Enabled = true;
            }
        }
        private void Refresh_BTN_Click(object sender, EventArgs e)
        {
            Refresh_BTN.Enabled = false;
            FillComboBox();
            stopwatch.Reset();
            stopwatch.Start();
            while (stopwatch.ElapsedMilliseconds < 1000)
            {
            }
            stopwatch.Stop();
            Refresh_BTN.Enabled = true;
        }
        private void Reset_BTN_Click(object sender, EventArgs e)
        {
            try
            {
                Reset_BTN.Enabled = false;
                MainSerialPort.WriteLine("W");
                stopwatch.Reset();
                stopwatch.Start();
                while (stopwatch.ElapsedMilliseconds < 1000)
                {
                }
                stopwatch.Stop();
                Reset_BTN.Enabled = true;
            }
            catch (Exception)
            {
                MessageBox.Show("Error - connection problem");
                Reset_BTN.Enabled = true;
            }
        }

        private void Save_BTN_Click(object sender, EventArgs e)
        {
            try
            {
                Save_BTN.Enabled = false;
                MainSerialPort.WriteLine(GenerateDataToSend());
                stopwatch.Reset();
                stopwatch.Start();
                while (stopwatch.ElapsedMilliseconds < 1000)
                {
                }
                stopwatch.Stop();
                Save_BTN.Enabled = true;
            }
            catch (Exception)
            {
                MessageBox.Show("Error - connection problem");
                Save_BTN.Enabled = true;
            }
        }


        private void LabelVersion_Click(object sender, EventArgs e)
        {
        }
    }
}
