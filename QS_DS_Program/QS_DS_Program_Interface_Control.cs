﻿using System;
using System.Collections.Generic;
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

        private LinkedList<CheckBox> CheckBoxData = new LinkedList<CheckBox>();
        private LinkedList<NumericUpDown> NumericData = new LinkedList<NumericUpDown>();

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


            CheckBoxData.AddLast(QSEnable_Check);
            CheckBoxData.AddLast(Push_Check_QS);
            CheckBoxData.AddLast(DSEnable_Check);

            NumericData.AddLast(Pulses);
            NumericData.AddLast(PreDelayQS);
            NumericData.AddLast(CutTime1);
            NumericData.AddLast(CutTime2);
            NumericData.AddLast(CutTime3);
            NumericData.AddLast(CutTime4);
            NumericData.AddLast(CutTime5);
            NumericData.AddLast(CutTime6);
            NumericData.AddLast(CutTime7);
            NumericData.AddLast(CutTime8);
            NumericData.AddLast(QSForce);
            NumericData.AddLast(MinRPMQS);
            NumericData.AddLast(PreDelayDS);
            NumericData.AddLast(BlipTime1);
            NumericData.AddLast(BlipTime2);
            NumericData.AddLast(BlipTime3);
            NumericData.AddLast(BlipTime4);
            NumericData.AddLast(BlipTime5);
            NumericData.AddLast(BlipTime6);
            NumericData.AddLast(BlipTime7);
            NumericData.AddLast(BlipTime8);
            NumericData.AddLast(DSForce);
            NumericData.AddLast(MinRPMDS);
            NumericData.AddLast(MaxRPMDS);
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

        private void SetRPMSensor(string RPM, string sensor)
        {
            RPMRead.Text = RPM;
            LabelSensorReading.Text = String.Empty + (Int32.Parse(sensor) - 2000);
            ProgressBarSensor.Value = Int32.Parse(sensor);
        }
        private void FunctionsEnableConnection()
        {
            for (int i = 0; i < TopButtons.Count; i++)
            {
                TopButtons[i].Visible = true;
            }
            Connect_BTN.Text = "Disconnect";
        }

        private void FunctionsEnableGeneral()
        {

            Tabs_All.Visible = true;
            Tabs_All.TabPages.Add(GeneralPage);

        }

        private void FunctionsEnableQS1()
        {

        }

        private void FunctionsEnableQS2()
        {

        }

        private void FunctionsEnableDS1()
        {

        }
    }
}
