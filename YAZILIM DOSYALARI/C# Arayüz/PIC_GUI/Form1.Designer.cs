namespace PIC_GUI
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.groupRed = new System.Windows.Forms.GroupBox();
            this.redLEDOFF = new System.Windows.Forms.Button();
            this.redONLED = new System.Windows.Forms.Button();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.label6 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.cmbStopBits = new System.Windows.Forms.ComboBox();
            this.cmbDataBits = new System.Windows.Forms.ComboBox();
            this.cmbParity = new System.Windows.Forms.ComboBox();
            this.cmbBaudRate = new System.Windows.Forms.ComboBox();
            this.cmbPortName = new System.Windows.Forms.ComboBox();
            this.groupYellow = new System.Windows.Forms.GroupBox();
            this.yellowLEDOFF = new System.Windows.Forms.Button();
            this.yellowLEDON = new System.Windows.Forms.Button();
            this.groupGreen = new System.Windows.Forms.GroupBox();
            this.greenLEDOFF = new System.Windows.Forms.Button();
            this.greenLEDON = new System.Windows.Forms.Button();
            this.btnExit = new System.Windows.Forms.Button();
            this.btnConnect = new System.Windows.Forms.Button();
            this.label1 = new System.Windows.Forms.Label();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.listBox1 = new System.Windows.Forms.ListBox();
            this.button1 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.groupRed.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.groupYellow.SuspendLayout();
            this.groupGreen.SuspendLayout();
            this.groupBox1.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupRed
            // 
            this.groupRed.Controls.Add(this.redLEDOFF);
            this.groupRed.Controls.Add(this.redONLED);
            this.groupRed.Enabled = false;
            this.groupRed.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupRed.Location = new System.Drawing.Point(12, 10);
            this.groupRed.Name = "groupRed";
            this.groupRed.Size = new System.Drawing.Size(156, 172);
            this.groupRed.TabIndex = 0;
            this.groupRed.TabStop = false;
            this.groupRed.Text = "KIRMIZI LED";
            this.groupRed.Enter += new System.EventHandler(this.groupRed_Enter);
            // 
            // redLEDOFF
            // 
            this.redLEDOFF.BackColor = System.Drawing.Color.Transparent;
            this.redLEDOFF.BackgroundImage = global::PIC_GUI.Properties.Resources.led_lamp_red_off;
            this.redLEDOFF.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.redLEDOFF.FlatAppearance.BorderColor = System.Drawing.Color.Red;
            this.redLEDOFF.FlatAppearance.BorderSize = 2;
            this.redLEDOFF.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Red;
            this.redLEDOFF.Font = new System.Drawing.Font("Calibri", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.redLEDOFF.Location = new System.Drawing.Point(12, 38);
            this.redLEDOFF.Name = "redLEDOFF";
            this.redLEDOFF.Size = new System.Drawing.Size(137, 105);
            this.redLEDOFF.TabIndex = 1;
            this.redLEDOFF.UseVisualStyleBackColor = false;
            this.redLEDOFF.Click += new System.EventHandler(this.redLEDOFF_Click);
            // 
            // redONLED
            // 
            this.redONLED.BackColor = System.Drawing.Color.Transparent;
            this.redONLED.BackgroundImage = global::PIC_GUI.Properties.Resources.led_lamp_red_on;
            this.redONLED.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.redONLED.FlatAppearance.BorderColor = System.Drawing.Color.Red;
            this.redONLED.FlatAppearance.BorderSize = 2;
            this.redONLED.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Red;
            this.redONLED.Font = new System.Drawing.Font("Calibri", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.redONLED.Location = new System.Drawing.Point(11, 37);
            this.redONLED.Name = "redONLED";
            this.redONLED.Size = new System.Drawing.Size(137, 105);
            this.redONLED.TabIndex = 0;
            this.redONLED.UseVisualStyleBackColor = false;
            this.redONLED.Visible = false;
            this.redONLED.Click += new System.EventHandler(this.redONLED_Click);
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.label6);
            this.groupBox2.Controls.Add(this.label5);
            this.groupBox2.Controls.Add(this.label4);
            this.groupBox2.Controls.Add(this.label3);
            this.groupBox2.Controls.Add(this.label2);
            this.groupBox2.Controls.Add(this.cmbStopBits);
            this.groupBox2.Controls.Add(this.cmbDataBits);
            this.groupBox2.Controls.Add(this.cmbParity);
            this.groupBox2.Controls.Add(this.cmbBaudRate);
            this.groupBox2.Controls.Add(this.cmbPortName);
            this.groupBox2.Location = new System.Drawing.Point(502, 12);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(250, 170);
            this.groupBox2.TabIndex = 1;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "COM Port Ayarları";
            this.groupBox2.Enter += new System.EventHandler(this.groupBox2_Enter);
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.Location = new System.Drawing.Point(15, 137);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(58, 14);
            this.label6.TabIndex = 19;
            this.label6.Text = "Stop Bits:";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(15, 109);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(57, 14);
            this.label5.TabIndex = 18;
            this.label5.Text = "Data Bits";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(15, 81);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(40, 14);
            this.label4.TabIndex = 17;
            this.label4.Text = "Parity:";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(15, 53);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(66, 14);
            this.label3.TabIndex = 16;
            this.label3.Text = "Baud Rate:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(15, 25);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(58, 14);
            this.label2.TabIndex = 15;
            this.label2.Text = "COM Port:";
            // 
            // cmbStopBits
            // 
            this.cmbStopBits.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbStopBits.FormattingEnabled = true;
            this.cmbStopBits.Items.AddRange(new object[] {
            "1",
            "2",
            "3"});
            this.cmbStopBits.Location = new System.Drawing.Point(89, 137);
            this.cmbStopBits.Name = "cmbStopBits";
            this.cmbStopBits.Size = new System.Drawing.Size(138, 22);
            this.cmbStopBits.TabIndex = 14;
            this.cmbStopBits.Text = "Select Stop Bits";
            // 
            // cmbDataBits
            // 
            this.cmbDataBits.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbDataBits.FormattingEnabled = true;
            this.cmbDataBits.Items.AddRange(new object[] {
            "7",
            "8",
            "9"});
            this.cmbDataBits.Location = new System.Drawing.Point(89, 109);
            this.cmbDataBits.Name = "cmbDataBits";
            this.cmbDataBits.Size = new System.Drawing.Size(138, 22);
            this.cmbDataBits.TabIndex = 13;
            this.cmbDataBits.Text = "Select Data Bits";
            // 
            // cmbParity
            // 
            this.cmbParity.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbParity.FormattingEnabled = true;
            this.cmbParity.Items.AddRange(new object[] {
            "None",
            "Even",
            "Odd"});
            this.cmbParity.Location = new System.Drawing.Point(89, 81);
            this.cmbParity.Name = "cmbParity";
            this.cmbParity.Size = new System.Drawing.Size(138, 22);
            this.cmbParity.TabIndex = 12;
            this.cmbParity.Text = "Select Parity";
            // 
            // cmbBaudRate
            // 
            this.cmbBaudRate.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbBaudRate.FormattingEnabled = true;
            this.cmbBaudRate.Items.AddRange(new object[] {
            "1200",
            "2400",
            "4800",
            "9600",
            "19200",
            "38400",
            "57600",
            "115200"});
            this.cmbBaudRate.Location = new System.Drawing.Point(89, 53);
            this.cmbBaudRate.Name = "cmbBaudRate";
            this.cmbBaudRate.Size = new System.Drawing.Size(138, 22);
            this.cmbBaudRate.TabIndex = 11;
            this.cmbBaudRate.Text = "Select Baude Rate";
            // 
            // cmbPortName
            // 
            this.cmbPortName.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbPortName.FormattingEnabled = true;
            this.cmbPortName.Location = new System.Drawing.Point(89, 22);
            this.cmbPortName.Name = "cmbPortName";
            this.cmbPortName.Size = new System.Drawing.Size(138, 22);
            this.cmbPortName.TabIndex = 10;
            this.cmbPortName.Text = "Select Port Name";
            // 
            // groupYellow
            // 
            this.groupYellow.Controls.Add(this.yellowLEDOFF);
            this.groupYellow.Controls.Add(this.yellowLEDON);
            this.groupYellow.Enabled = false;
            this.groupYellow.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupYellow.Location = new System.Drawing.Point(175, 10);
            this.groupYellow.Name = "groupYellow";
            this.groupYellow.Size = new System.Drawing.Size(156, 172);
            this.groupYellow.TabIndex = 2;
            this.groupYellow.TabStop = false;
            this.groupYellow.Text = "SARI LED";
            this.groupYellow.Enter += new System.EventHandler(this.groupYellow_Enter);
            // 
            // yellowLEDOFF
            // 
            this.yellowLEDOFF.BackColor = System.Drawing.Color.Transparent;
            this.yellowLEDOFF.BackgroundImage = global::PIC_GUI.Properties.Resources.led_lamp_yellow_off;
            this.yellowLEDOFF.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.yellowLEDOFF.FlatAppearance.BorderColor = System.Drawing.Color.Red;
            this.yellowLEDOFF.FlatAppearance.BorderSize = 2;
            this.yellowLEDOFF.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Red;
            this.yellowLEDOFF.Font = new System.Drawing.Font("Calibri", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.yellowLEDOFF.Location = new System.Drawing.Point(6, 39);
            this.yellowLEDOFF.Name = "yellowLEDOFF";
            this.yellowLEDOFF.Size = new System.Drawing.Size(137, 105);
            this.yellowLEDOFF.TabIndex = 1;
            this.yellowLEDOFF.UseVisualStyleBackColor = false;
            this.yellowLEDOFF.Click += new System.EventHandler(this.yellowLEDOFF_Click);
            // 
            // yellowLEDON
            // 
            this.yellowLEDON.BackColor = System.Drawing.Color.Transparent;
            this.yellowLEDON.BackgroundImage = global::PIC_GUI.Properties.Resources.led_lamp_yellow_on;
            this.yellowLEDON.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.yellowLEDON.FlatAppearance.BorderColor = System.Drawing.Color.Red;
            this.yellowLEDON.FlatAppearance.BorderSize = 2;
            this.yellowLEDON.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Red;
            this.yellowLEDON.Font = new System.Drawing.Font("Calibri", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.yellowLEDON.Location = new System.Drawing.Point(8, 39);
            this.yellowLEDON.Name = "yellowLEDON";
            this.yellowLEDON.Size = new System.Drawing.Size(137, 105);
            this.yellowLEDON.TabIndex = 0;
            this.yellowLEDON.UseVisualStyleBackColor = false;
            this.yellowLEDON.Visible = false;
            this.yellowLEDON.Click += new System.EventHandler(this.yellowLEDON_Click);
            // 
            // groupGreen
            // 
            this.groupGreen.Controls.Add(this.greenLEDOFF);
            this.groupGreen.Controls.Add(this.greenLEDON);
            this.groupGreen.Enabled = false;
            this.groupGreen.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupGreen.Location = new System.Drawing.Point(337, 10);
            this.groupGreen.Name = "groupGreen";
            this.groupGreen.Size = new System.Drawing.Size(159, 172);
            this.groupGreen.TabIndex = 3;
            this.groupGreen.TabStop = false;
            this.groupGreen.Text = "YEŞİL LED";
            this.groupGreen.Enter += new System.EventHandler(this.groupGreen_Enter);
            // 
            // greenLEDOFF
            // 
            this.greenLEDOFF.BackColor = System.Drawing.Color.Transparent;
            this.greenLEDOFF.BackgroundImage = global::PIC_GUI.Properties.Resources.led_lamp_green_off;
            this.greenLEDOFF.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.greenLEDOFF.FlatAppearance.BorderColor = System.Drawing.Color.Red;
            this.greenLEDOFF.FlatAppearance.BorderSize = 2;
            this.greenLEDOFF.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Red;
            this.greenLEDOFF.Font = new System.Drawing.Font("Calibri", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.greenLEDOFF.Location = new System.Drawing.Point(10, 39);
            this.greenLEDOFF.Name = "greenLEDOFF";
            this.greenLEDOFF.Size = new System.Drawing.Size(137, 105);
            this.greenLEDOFF.TabIndex = 1;
            this.greenLEDOFF.UseVisualStyleBackColor = false;
            this.greenLEDOFF.Click += new System.EventHandler(this.greenLEDOFF_Click);
            // 
            // greenLEDON
            // 
            this.greenLEDON.BackColor = System.Drawing.Color.Transparent;
            this.greenLEDON.BackgroundImage = global::PIC_GUI.Properties.Resources.led_lamp_green_on;
            this.greenLEDON.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.greenLEDON.FlatAppearance.BorderColor = System.Drawing.Color.Red;
            this.greenLEDON.FlatAppearance.BorderSize = 2;
            this.greenLEDON.FlatAppearance.MouseDownBackColor = System.Drawing.Color.Red;
            this.greenLEDON.Font = new System.Drawing.Font("Calibri", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.greenLEDON.Location = new System.Drawing.Point(10, 38);
            this.greenLEDON.Name = "greenLEDON";
            this.greenLEDON.Size = new System.Drawing.Size(137, 105);
            this.greenLEDON.TabIndex = 0;
            this.greenLEDON.UseVisualStyleBackColor = false;
            this.greenLEDON.Visible = false;
            this.greenLEDON.Click += new System.EventHandler(this.greenLEDON_Click);
            // 
            // btnExit
            // 
            this.btnExit.Font = new System.Drawing.Font("Calibri", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnExit.Image = global::PIC_GUI.Properties.Resources.Delete;
            this.btnExit.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnExit.Location = new System.Drawing.Point(653, 193);
            this.btnExit.Name = "btnExit";
            this.btnExit.Size = new System.Drawing.Size(99, 43);
            this.btnExit.TabIndex = 6;
            this.btnExit.Text = "Çıkış";
            this.btnExit.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnExit.UseVisualStyleBackColor = true;
            this.btnExit.Click += new System.EventHandler(this.btnExit_Click);
            // 
            // btnConnect
            // 
            this.btnConnect.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnConnect.Image = global::PIC_GUI.Properties.Resources.Left;
            this.btnConnect.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnConnect.Location = new System.Drawing.Point(520, 193);
            this.btnConnect.Name = "btnConnect";
            this.btnConnect.Size = new System.Drawing.Size(127, 43);
            this.btnConnect.TabIndex = 5;
            this.btnConnect.Text = "&Bağlan";
            this.btnConnect.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnConnect.UseVisualStyleBackColor = true;
            this.btnConnect.Click += new System.EventHandler(this.btnConnect_Click);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.label1.Location = new System.Drawing.Point(8, 491);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(132, 24);
            this.label1.TabIndex = 7;
            this.label1.Text = "Sefa Kocaman";
            this.label1.Click += new System.EventHandler(this.label1_Click_1);
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.button2);
            this.groupBox1.Controls.Add(this.button1);
            this.groupBox1.Controls.Add(this.listBox1);
            this.groupBox1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.groupBox1.Location = new System.Drawing.Point(12, 193);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(502, 295);
            this.groupBox1.TabIndex = 8;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Veri Çekme";
            // 
            // listBox1
            // 
            this.listBox1.FormattingEnabled = true;
            this.listBox1.ItemHeight = 20;
            this.listBox1.Location = new System.Drawing.Point(7, 35);
            this.listBox1.Name = "listBox1";
            this.listBox1.Size = new System.Drawing.Size(336, 244);
            this.listBox1.TabIndex = 0;
            // 
            // button1
            // 
            this.button1.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.button1.Location = new System.Drawing.Point(366, 102);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(118, 32);
            this.button1.TabIndex = 1;
            this.button1.Text = "Veriyi_Çek";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // button2
            // 
            this.button2.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(162)));
            this.button2.Location = new System.Drawing.Point(366, 149);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(118, 34);
            this.button2.TabIndex = 2;
            this.button2.Text = "Veriyi_Sil";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(764, 537);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.btnExit);
            this.Controls.Add(this.btnConnect);
            this.Controls.Add(this.groupGreen);
            this.Controls.Add(this.groupYellow);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupRed);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.Name = "Form1";
            this.Text = "Controlling a PIC Microcontroller from a PC Graphical User Interface (GUI)";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.Form1_FormClosing);
            this.Load += new System.EventHandler(this.Form1_Load);
            this.groupRed.ResumeLayout(false);
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.groupYellow.ResumeLayout(false);
            this.groupGreen.ResumeLayout(false);
            this.groupBox1.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.GroupBox groupRed;
        private System.Windows.Forms.Button redONLED;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ComboBox cmbStopBits;
        private System.Windows.Forms.ComboBox cmbDataBits;
        private System.Windows.Forms.ComboBox cmbParity;
        private System.Windows.Forms.ComboBox cmbBaudRate;
        private System.Windows.Forms.ComboBox cmbPortName;
        private System.Windows.Forms.Button redLEDOFF;
        private System.Windows.Forms.GroupBox groupYellow;
        private System.Windows.Forms.Button yellowLEDOFF;
        private System.Windows.Forms.Button yellowLEDON;
        private System.Windows.Forms.GroupBox groupGreen;
        private System.Windows.Forms.Button greenLEDOFF;
        private System.Windows.Forms.Button greenLEDON;
        private System.Windows.Forms.Button btnConnect;
        private System.Windows.Forms.Button btnExit;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.ListBox listBox1;
    }
}

