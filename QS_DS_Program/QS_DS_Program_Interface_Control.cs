using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QS_DS_Program
{
    public partial class QS_DS_Program : Form
    {
        private List<Button> MainComponentsButtons = new List<Button>();
        private List<Label> MainComponentsLabels = new List<Label>();
        private List<ComboBox> MainComponentsCombo = new List<ComboBox>();
        private List<Button> TopButtons = new List<Button>();

        private List<Label> GeneralLabels = new List<Label>();
        private List<NumericUpDown> GeneralNumerics = new List<NumericUpDown>();
        private List<ProgressBar> GeneralBar = new List<ProgressBar>();

        private List<CheckBox> QSCheckbox = new List<CheckBox>();
        private List<Button> QSButton = new List<Button>();
        private List<Label> QS1Labels = new List<Label>();
        private List<NumericUpDown> QS1Numerics = new List<NumericUpDown>();

        private List<Label> QS2Labels = new List<Label>();
        private List<NumericUpDown> QS2Numerics = new List<NumericUpDown>();

        private List<CheckBox> DSCheckbox = new List<CheckBox>();
        private List<Button> DSButton = new List<Button>();
        private List<Label> DS1Labels = new List<Label>();
        private List<NumericUpDown> DS1Numerics = new List<NumericUpDown>();

        private List<CheckBox> CheckBoxData = new List<CheckBox>();
        private List<NumericUpDown> NumericData = new List<NumericUpDown>();

        private void AssignItems()
        {
            MainComponentsLabels.Add(Label1);
            MainComponentsCombo.Add(comboBox1);
            MainComponentsButtons.Add(Refresh_BTN);
            MainComponentsButtons.Add(Connect_BTN);

            TopButtons.Add(Read_BTN);
            TopButtons.Add(Save_BTN);
            TopButtons.Add(Reset_BTN);

            GeneralLabels.Add(LabelGeneral1);
            GeneralNumerics.Add(Pulses);
            GeneralLabels.Add(LabelRPMCur);
            GeneralLabels.Add(RPMRead);
            GeneralLabels.Add(LabelSensorOutput);
            GeneralLabels.Add(LabelSensorReading);
            GeneralLabels.Add(LabelVersion);
            GeneralLabels.Add(LabelSensorDirection);
            GeneralBar.Add(ProgressBarSensor);

            QSCheckbox.Add(QSEnable_Check);
            QSCheckbox.Add(Push_Check_QS);
            QSCheckbox.Add(Pull_Check_QS);
            QSButton.Add(CutTest_BTN);

            QS1Labels.Add(LabelQS1);
            QS1Labels.Add(LabelQS2);
            QS1Labels.Add(LabelQS3);
            QS1Labels.Add(LabelQS4);
            QS1Labels.Add(LabelQS5);
            QS1Labels.Add(LabelQS6);
            QS1Labels.Add(LabelQS7);
            QS1Labels.Add(LabelQS8);
            QS1Labels.Add(LabelQS9);
            QS1Labels.Add(LabelQS10);
            QS1Labels.Add(LabelQS11);

            QS1Numerics.Add(PreDelayQS);
            QS1Numerics.Add(CutTime1);
            QS1Numerics.Add(CutTime2);
            QS1Numerics.Add(CutTime3);
            QS1Numerics.Add(CutTime4);
            QS1Numerics.Add(CutTime5);
            QS1Numerics.Add(CutTime6);
            QS1Numerics.Add(CutTime7);
            QS1Numerics.Add(CutTime8);
            QS1Numerics.Add(QSForce);
            QS1Numerics.Add(MinRPMQS);


            QS2Labels.Add(LabelQS1);
            QS2Labels.Add(LabelCutTime);
            QS2Labels.Add(LabelQS10);
            QS2Labels.Add(LabelQS11);
            QS2Numerics.Add(PreDelayQS);
            QS2Numerics.Add(CutTime1);
            QS2Numerics.Add(QSForce);
            QS2Numerics.Add(MinRPMQS);

            DSCheckbox.Add(DSEnable_Check);
            DSButton.Add(BlipTest_BTN);
            DSCheckbox.Add(Push_Check_DS);
            DSCheckbox.Add(Pull_Check_DS);
            DS1Labels.Add(LabelDS1);
            DS1Labels.Add(LabelDS2);
            DS1Labels.Add(LabelDS3);
            DS1Labels.Add(LabelDS4);
            DS1Labels.Add(LabelDS5);
            DS1Labels.Add(LabelDS6);
            DS1Labels.Add(LabelDS7);
            DS1Labels.Add(LabelDS8);
            DS1Labels.Add(LabelDS9);
            DS1Labels.Add(LabelDS10);
            DS1Labels.Add(LabelDS11);
            DS1Labels.Add(LabelDS12);
            DS1Numerics.Add(PreDelayDS);
            DS1Numerics.Add(BlipTime1);
            DS1Numerics.Add(BlipTime2);
            DS1Numerics.Add(BlipTime3);
            DS1Numerics.Add(BlipTime4);
            DS1Numerics.Add(BlipTime5);
            DS1Numerics.Add(BlipTime6);
            DS1Numerics.Add(BlipTime7);
            DS1Numerics.Add(BlipTime8);
            DS1Numerics.Add(DSForce);
            DS1Numerics.Add(MinRPMDS);
            DS1Numerics.Add(MaxRPMDS);


            CheckBoxData.Add(QSEnable_Check);
            CheckBoxData.Add(DSEnable_Check);
            CheckBoxData.Add(Push_Check_QS);


            NumericData.Add(Pulses);
            NumericData.Add(PreDelayQS);
            NumericData.Add(CutTime1);
            NumericData.Add(CutTime2);
            NumericData.Add(CutTime3);
            NumericData.Add(CutTime4);
            NumericData.Add(CutTime5);
            NumericData.Add(CutTime6);
            NumericData.Add(CutTime7);
            NumericData.Add(CutTime8);
            NumericData.Add(QSForce);
            NumericData.Add(MinRPMQS);
            NumericData.Add(PreDelayDS);
            NumericData.Add(BlipTime1);
            NumericData.Add(BlipTime2);
            NumericData.Add(BlipTime3);
            NumericData.Add(BlipTime4);
            NumericData.Add(BlipTime5);
            NumericData.Add(BlipTime6);
            NumericData.Add(BlipTime7);
            NumericData.Add(BlipTime8);
            NumericData.Add(DSForce);
            NumericData.Add(MinRPMDS);
            NumericData.Add(MaxRPMDS);
        }
        private void DisableFunctionAll()
        {
            Tabs_All.Visible = false;
            Tabs_All.TabPages.Remove(GeneralPage);
            Tabs_All.TabPages.Remove(QSPage);
            Tabs_All.TabPages.Remove(DSPage);

            for (int i = 0; i < TopButtons.Count; i++)
            {
                TopButtons[i].Visible = false;
            }
            for (int i = 0; i < GeneralLabels.Count; i++)
            {
                GeneralLabels[i].Visible = false;
            }

            for (int i = 0; i < GeneralNumerics.Count; i++)
            {
                GeneralNumerics[i].Visible = false;
            }
            for (int i = 0; i < GeneralBar.Count; i++)
            {
                GeneralBar[i].Visible = false;
            }
            for (int i = 0; i < QSCheckbox.Count; i++)
            {
                QSCheckbox[i].Visible = false;
            }
            for (int i = 0; i < QSButton.Count; i++)
            {
                QSButton[i].Visible = false;
            }
            for (int i = 0; i < QS1Labels.Count; i++)
            {
                QS1Labels[i].Visible = false;
            }
            for (int i = 0; i < QS1Numerics.Count; i++)
            {
                QS1Numerics[i].Visible = false;
            }
            for (int i = 0; i < QS2Labels.Count; i++)
            {
                QS2Labels[i].Visible = false;
            }
            for (int i = 0; i < QS2Numerics.Count; i++)
            {
                QS2Numerics[i].Visible = false;
            }
            for (int i = 0; i < DSCheckbox.Count; i++)
            {
                DSCheckbox[i].Visible = false;
            }
            for (int i = 0; i < DSButton.Count; i++)
            {
                DSButton[i].Visible = false;
            }
            for (int i = 0; i < DS1Labels.Count; i++)
            {
                DS1Labels[i].Visible = false;
            }
            for (int i = 0; i < DS1Numerics.Count; i++)
            {
                DS1Numerics[i].Visible = false;
            }
        }

        private void DisableFunctionsWorking()
        {
            Tabs_All.Visible = false;
            Tabs_All.TabPages.Remove(GeneralPage);
            Tabs_All.TabPages.Remove(QSPage);
            Tabs_All.TabPages.Remove(DSPage);

            for (int i = 0; i < GeneralLabels.Count; i++)
            {
                GeneralLabels[i].Visible = false;
            }

            for (int i = 0; i < GeneralNumerics.Count; i++)
            {
                GeneralNumerics[i].Visible = false;
            }
            for (int i = 0; i < GeneralBar.Count; i++)
            {
                GeneralBar[i].Visible = false;
            }
            for (int i = 0; i < QSCheckbox.Count; i++)
            {
                QSCheckbox[i].Visible = false;
            }
            for (int i = 0; i < QSButton.Count; i++)
            {
                QSButton[i].Visible = false;
            }
            for (int i = 0; i < QS1Labels.Count; i++)
            {
                QS1Labels[i].Visible = false;
            }
            for (int i = 0; i < QS1Numerics.Count; i++)
            {
                QS1Numerics[i].Visible = false;
            }
            for (int i = 0; i < QS2Labels.Count; i++)
            {
                QS2Labels[i].Visible = false;
            }
            for (int i = 0; i < QS2Numerics.Count; i++)
            {
                QS2Numerics[i].Visible = false;
            }
            for (int i = 0; i < DSCheckbox.Count; i++)
            {
                DSCheckbox[i].Visible = false;
            }
            for (int i = 0; i < DSButton.Count; i++)
            {
                DSButton[i].Visible = false;
            }
            for (int i = 0; i < DS1Labels.Count; i++)
            {
                DS1Labels[i].Visible = false;
            }
            for (int i = 0; i < DS1Numerics.Count; i++)
            {
                DS1Numerics[i].Visible = false;
            }


        }

        private string GenerateCheckBoxData()
        {
            string message = "";
            for (int i = 0; i < CheckBoxData.Count; i++)
            {
                message += CheckBoxData[i].Checked ? "1," : "0,";
            }
            return message;
        }

        private string GenerateNumericData()
        {
            string message = "";
            if (NumericData[0].Value <= decimal.Parse("0,5"))
            {
                message += "0.5,";
            }
            else if (NumericData[0].Value == decimal.Parse("1,0"))
            {
                message += "1.0,";
            }
            else if (NumericData[0].Value == decimal.Parse("2,0"))
            {
                message += "2.0,";
            }
            else if (NumericData[0].Value == decimal.Parse("3,0"))
            {
                message += "3.0,";
            }
            else if (NumericData[0].Value == decimal.Parse("4,0"))
            {
                message += "4.0,";
            }
            for (int i = 1; i < NumericData.Count; i++)
            {
                message += NumericData[i].Value + ",";
            }
            return message;
        }
        private void SetRPMSensor(string RPM, string sensor)
        {
            RPMRead.Text = RPM;
            int sensorValue = Int32.Parse(sensor);
            LabelSensorReading.Text = "" + (sensorValue - 2000);
            ProgressBarSensor.Value = sensorValue;
            LabelSensorDirection.Text = sensorValue > 2000 ? "Pull" : sensorValue < 2000 ? "Push" : "---";
        }
        private void FunctionsEnableConnection()
        {
            for (int i = 0; i < TopButtons.Count; i++)
            {
                TopButtons[i].Visible = true;
            }
            Connect_BTN.Text = "Disconnect";
            comboBox1.Enabled = false;
            Refresh_BTN.Enabled = false;
        }

        private void FunctionsEnableGeneral()
        {
            Tabs_All.TabPages.Add(GeneralPage);
            for (int i = 0; i < GeneralLabels.Count; i++)
            {
                GeneralLabels[i].Visible = true;
            }
            for (int i = 0; i < GeneralNumerics.Count; i++)
            {
                GeneralNumerics[i].Visible = true;
            }
            for (int i = 0; i < GeneralBar.Count; i++)
            {
                GeneralBar[i].Visible = true;
            }
        }

        private void FunctionsShowTable()
        {
            Tabs_All.Visible = true;
        }

        private void FunctionsBase()
        {
            Connect_BTN.Text = "Connect";
            DisableFunctionAll();
            comboBox1.Enabled = true;
            Refresh_BTN.Enabled = true;
        }
        private void FunctionsAssignValues(string[] splitData)
        {
            FunctionsEnableGeneral();
            LabelVersion.Text = "v" + splitData[1] + "." + splitData[2];
            if (splitData[3].Equals("1"))
            {
                FunctionsEnableQS1();
            }
            else if (splitData[3].Equals("2"))
            {
                FunctionsEnableQS2();
            }
            if (splitData[4].Equals("1"))
            {
                FunctionsEnableDS1();
            }

            for (int i = 0; i < CheckBoxData.Count - 1; i++)
            {
                CheckBoxData[i].Checked = splitData[5 + i].Equals("1") ? true : false;
            }

            if (splitData[7].Equals("0"))
            {
                Pull_Check_QS.Checked = true;
                Push_Check_QS.Checked = false;
                Pull_Check_DS.Checked = false;
                Push_Check_DS.Checked = true;
            }
            else if (splitData[7].Equals("1"))
            {
                Push_Check_QS.Checked = true;
                Pull_Check_QS.Checked = false;
                Push_Check_DS.Checked = false;
                Pull_Check_DS.Checked = true;
            }

            Pulses.Value = Decimal.Parse(splitData[8], NumberStyles.AllowDecimalPoint, CultureInfo.InvariantCulture);

            for (int i = 1; i < NumericData.Count; i++)
            {
                NumericData[i].Value = Int32.Parse(splitData[i + 8]);
            }
        }

        private void FunctionsEnableQS1()
        {
            Tabs_All.TabPages.Add(QSPage);
            for (int i = 0; i < QSCheckbox.Count; i++)
            {
                QSCheckbox[i].Visible = true;
            }
            for (int i = 0; i < QSButton.Count; i++)
            {
                QSButton[i].Visible = true;
            }
            for (int i = 0; i < QS1Labels.Count; i++)
            {
                QS1Labels[i].Visible = true;
            }
            for (int i = 0; i < QS1Numerics.Count; i++)
            {
                QS1Numerics[i].Visible = true;
            }
        }

        private void FunctionsEnableQS2()
        {
            Tabs_All.TabPages.Add(QSPage);
            for (int i = 0; i < QSCheckbox.Count; i++)
            {
                QSCheckbox[i].Visible = true;
            }
            for (int i = 0; i < QSButton.Count; i++)
            {
                QSButton[i].Visible = true;
            }
            for (int i = 0; i < QS2Labels.Count; i++)
            {
                QS2Labels[i].Visible = true;
            }
            for (int i = 0; i < QS2Numerics.Count; i++)
            {
                QS2Numerics[i].Visible = true;
            }
        }

        private void FunctionsEnableDS1()
        {
            Tabs_All.TabPages.Add(DSPage);
            for (int i = 0; i < DSCheckbox.Count; i++)
            {
                DSCheckbox[i].Visible = true;
            }
            for (int i = 0; i < DSButton.Count; i++)
            {
                DSButton[i].Visible = true;
            }
            for (int i = 0; i < DS1Labels.Count; i++)
            {
                DS1Labels[i].Visible = true;
            }
            for (int i = 0; i < DS1Numerics.Count; i++)
            {
                DS1Numerics[i].Visible = true;
            }
        }

        private void FillComboBox()
        {
            comboBox1.Items.Clear();
            foreach (string s in System.IO.Ports.SerialPort.GetPortNames())
            {
                comboBox1.Items.Add(s);
            }
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        private void MinRPMDS_ValueChanged(object sender, EventArgs e)
        {
            if (MinRPMDS.Value > (MaxRPMDS.Value - Int32.Parse("500")))
            {
                MinRPMDS.Value = (MaxRPMDS.Value - Int32.Parse("500"));
            }
        }

        private void MaxRPMDS_ValueChanged(object sender, EventArgs e)
        {
            if (MaxRPMDS.Value < (MinRPMDS.Value + Int32.Parse("500")))
            {
                MaxRPMDS.Value = (MinRPMDS.Value + Int32.Parse("500"));
            }
        }

        private void Pulses_ValueChanged(object sender, EventArgs e)
        {
            if (Pulses.Value == 0)
            {
                Pulses.Value = decimal.Parse("0,5");
            }
            else if (Pulses.Value == decimal.Parse("1,5"))
            {
                Pulses.Value = 1;
            }
        }

        private void Pull_Check_QS_CheckedChanged(object sender, EventArgs e)
        {
            if (Pull_Check_QS.Checked)
            {
                Push_Check_QS.Checked = false;
                Pull_Check_DS.Checked = false;
                Push_Check_DS.Checked = true;
            }
            else if (!Pull_Check_QS.Checked)
            {
                Push_Check_QS.Checked = true;
                Pull_Check_DS.Checked = true;
                Push_Check_DS.Checked = false;
            }
        }

        private void Push_Check_QS_CheckedChanged(object sender, EventArgs e)
        {
            if (Push_Check_QS.Checked)
            {
                Pull_Check_QS.Checked = false;
                Pull_Check_DS.Checked = true;
                Push_Check_DS.Checked = false;
            }
            else if (!Push_Check_QS.Checked)
            {
                Pull_Check_QS.Checked = true;
                Pull_Check_DS.Checked = false;
                Push_Check_DS.Checked = true;
            }
        }

        private void Pull_Check_DS_CheckedChanged(object sender, EventArgs e)
        {
            if (Pull_Check_DS.Checked)
            {
                Push_Check_DS.Checked = false;
                Pull_Check_QS.Checked = false;
                Push_Check_QS.Checked = true;
            }
            else if (!Pull_Check_DS.Checked)
            {
                Push_Check_DS.Checked = true;
                Pull_Check_QS.Checked = true;
                Push_Check_QS.Checked = false;
            }
        }

        private void Push_Check_DS_CheckedChanged(object sender, EventArgs e)
        {
            if (Push_Check_DS.Checked)
            {
                Pull_Check_DS.Checked = false;
                Pull_Check_QS.Checked = true;
                Push_Check_QS.Checked = false;
            }
            else if (!Push_Check_DS.Checked)
            {
                Pull_Check_DS.Checked = true;
                Pull_Check_QS.Checked = false;
                Push_Check_QS.Checked = true;
            }
        }
    }
}
