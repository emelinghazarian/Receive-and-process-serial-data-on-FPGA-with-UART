# The components of the system are:
  servo motor, encoder, driver (Copley Controls - Accelnet R23-055-10), power supply for driver and motor, FPGA (Lattice - U5ECP family - F-25U5LFE)

In this system, encoder provides real-time feedback about the position of the motor and sends it to the driver. 
The 232RS communication processes the data in the FPGA and we see the final output through an LED on the FPGA.

# There are 4 modules: 
1- in_filter module: This module is designed in such a way that filters the short and transient noises in the input. 
2- serial module: This module should process the control commands it receives from the encoder.
3- driveok module: This module is designed to identify the OK character in the received data.
4- trigdetector module: In the previous module, every time the OK character was recognized, DTog would change its status. IN order to see the output in FPGA,
   we define a led that lights up every time DTog changes its status. This will mean that the data is recognized as valid.

![image](https://github.com/user-attachments/assets/ff41a7d3-62a5-4375-8f20-403813955d3f)

Implementation on FPGA:

![image](https://github.com/user-attachments/assets/8509f7f7-bd73-4ae5-a064-773584a2e569)
