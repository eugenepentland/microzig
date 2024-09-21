import serial
import time

def open_serial_port(port, baudrate):
    while True:
        try:
            ser = serial.Serial(port, baudrate, timeout=1)
            print(f"Connected to {port}")
            return ser
        except serial.SerialException as e:
            print(f"Failed to connect to {port}: {e}")
            print("Retrying in 2 seconds...")
            time.sleep(2)

def listen_to_serial(ser):
    try:
        while True:
            if ser.in_waiting > 0:
                data = ser.readline().decode('utf-8').rstrip()
                print(f"Received: {data}")
    except serial.SerialException as e:
        print(f"Serial connection lost: {e}")
        ser.close()

if __name__ == "__main__":
    port = 'COM4'
    baudrate = 115200

    while True:
        ser = open_serial_port(port, baudrate)
        listen_to_serial(ser)
