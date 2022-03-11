
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO.Ports;  //This is a namespace that contains the SerialPort class
using System.IO;
namespace PIC_GUI
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            updatePorts();           //Call this function everytime the page load 
                                     //to update port names
        }
      
        private SerialPort ComPort = new SerialPort();  //Initialise ComPort Variable as SerialPort
        private void updatePorts()
        {
            // Retrieve the list of all COM ports on your Computer
            string[] ports = SerialPort.GetPortNames();
            foreach (string port in ports)
            {
                cmbPortName.Items.Add(port);
            }
        }
        //whenever the connect button is clicked, it will check if the port is already open, call the disconnect function.
        // if the port is closed, call the connect function.
        private void btnConnect_Click(object sender, EventArgs e)
        {
            if (ComPort.IsOpen)
            {
                disconnect();                
            }
            else
            {
                connect();                
            }
        }
        private void connect()
        {
            bool error = false;

            // Check if all settings have been selected
            if (cmbPortName.SelectedIndex != -1 & cmbBaudRate.SelectedIndex != -1 & cmbParity.SelectedIndex != -1 & cmbDataBits.SelectedIndex != -1 & cmbStopBits.SelectedIndex != -1)
            {
                //if yes than Set The Port's settings
                ComPort.PortName = cmbPortName.Text;
                ComPort.BaudRate = int.Parse(cmbBaudRate.Text);      //convert Text to Integer
                ComPort.Parity = (Parity)Enum.Parse(typeof(Parity), cmbParity.Text); //convert Text to Parity
                ComPort.DataBits = int.Parse(cmbDataBits.Text);        //convert Text to Integer
                ComPort.StopBits = (StopBits)Enum.Parse(typeof(StopBits), cmbStopBits.Text);  //convert Text to stop bits

                try  //always try to use this try and catch method to open your port. 
                     //if there is an error your program will not display a message instead of freezing.
                {
                    //Open Port
                    ComPort.Open();
                }
                catch (UnauthorizedAccessException) { error = true; }
                catch (System.IO.IOException) { error = true; }
                catch (ArgumentException) { error = true; }

                if (error) MessageBox.Show(this, "Could not open the COM port. Most likely it is already in use, has been removed, or is unavailable.", "COM Port unavailable", MessageBoxButtons.OK, MessageBoxIcon.Stop);

            }
            else
            {
                MessageBox.Show("Please select all the COM Port Settings", "Controlling a PIC Microcontroller from a PC GUI", MessageBoxButtons.OK, MessageBoxIcon.Stop);

            }
            //if the port is open, Change the Connect button to disconnect, enable the send button.
            //and disable the groupBox to prevent changing configuration of an open port.
            if (ComPort.IsOpen)
            {
                btnConnect.Text = "Bağlantıyı Kes";
                groupRed.Enabled = true; //enable the red LED button
                groupYellow.Enabled = true; //enable the Yellow LED button
                groupGreen.Enabled = true; //enable the Green LED button               
            }
        }
        // Call this function to close the port.
        private void disconnect()
        {
            ComPort.Close();
            btnConnect.Text = "Bağlan";
            groupRed.Enabled = false; //disable the red LED button
            groupYellow.Enabled = false; //disable the Yellow LED button
            groupGreen.Enabled = false; //disable the Green LED button           

        }
        
        private void btnExit_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (ComPort.IsOpen) ComPort.Close();  //close the port if open when exiting the application.
        }

        private void redLEDOFF_Click(object sender, EventArgs e)
        {
            char[] buff = new char[1];
            buff[0] = '1'; //ASCII for 1.
            ComPort.Write(buff, 0, 1);
            redLEDOFF.Visible = false;
            redONLED.Visible = true;
            yellowLEDOFF.Visible = true;
            greenLEDOFF.Visible = true;
           
        }
        //Switch OFF all LEDs by sending '4'
        private void redONLED_Click(object sender, EventArgs e)
        {
            char[] buff = new char[1];
            buff[0] = '4'; //ASCII for 4.
            ComPort.Write(buff, 0, 1);
            redLEDOFF.Visible = true;
            redONLED.Visible = false;
        }

        private void yellowLEDOFF_Click(object sender, EventArgs e)
        {
            char[] buff = new char[1];
            buff[0] = '2'; //ASCII for 2.
            ComPort.Write(buff, 0, 1);
            yellowLEDOFF.Visible = false;
            yellowLEDON.Visible = true;
            greenLEDOFF.Visible = true;
            redLEDOFF.Visible = true;
        }

        private void yellowLEDON_Click(object sender, EventArgs e)
        {
            char[] buff = new char[1];
            buff[0] = '4'; //ASCII for 4.
            ComPort.Write(buff, 0, 1);
            yellowLEDOFF.Visible = true;
            yellowLEDON.Visible = false;
        }

        private void greenLEDOFF_Click(object sender, EventArgs e)
        {
            char[] buff = new char[1];
            buff[0] = '3'; //ASCII for 3.
            ComPort.Write(buff, 0, 1);
            greenLEDOFF.Visible = false;
            greenLEDON.Visible = true;
            yellowLEDOFF.Visible = true;
            redLEDOFF.Visible = true;
        }

        private void greenLEDON_Click(object sender, EventArgs e)
        {
            char[] buff = new char[1];
            buff[0] = '4'; //ASCII for 4.
            ComPort.Write(buff, 0, 1);
            greenLEDOFF.Visible = true;
            greenLEDON.Visible = false;
        }

        private void label1_Click(object sender, EventArgs e)
        { 


        }

        private void label1_Click_1(object sender, EventArgs e)
        {

        }

        private void groupRed_Enter(object sender, EventArgs e)
        {

        }

        private void groupYellow_Enter(object sender, EventArgs e)
        {

        }

        private void groupGreen_Enter(object sender, EventArgs e)
        {

        }

        private void groupBox2_Enter(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            StreamReader streamReader = File.OpenText(@"C:\Users\ASUS\Desktop\New Folder\DHT22Log.txt");
            string metin;
            while ((metin = streamReader.ReadLine()) != null)
            {
                listBox1.Items.Add(metin);
            }
            streamReader.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            listBox1.Items.Clear();
        }
    }
}
