import RPi.GPIO as GPIO
import time
import subprocess as sp
from dotenv import load_dotenv
import os

# Load environment variables from .env file
load_dotenv('vars.env')

# Read the GPIO pin, temperature thresholds, and fan speeds from the environment
FAN_PIN = int(os.getenv("FAN_PIN"))
PHASE1_TEMP = float(os.getenv("PHASE1_TEMP"))
PHASE2_TEMP = float(os.getenv("PHASE2_TEMP"))
PHASE3_TEMP = float(os.getenv("PHASE3_TEMP"))

PHASE1_SPEED = float(os.getenv("PHASE1_SPEED"))
PHASE2_SPEED = float(os.getenv("PHASE2_SPEED"))
PHASE3_SPEED = float(os.getenv("PHASE3_SPEED"))

# Initialize GPIO
GPIO.setmode(GPIO.BOARD)
GPIO.setup(FAN_PIN, GPIO.OUT)

p = GPIO.PWM(FAN_PIN, 50)
p.start(0)

last_duty_cycle = None  # Track the last duty cycle applied

try:
    while True:
        # Read the CPU temperature
        temp = sp.getoutput("vcgencmd measure_temp|egrep -o '[0-9]*\.[0-9]*'")
        temp = float(temp)

        # Determine the desired duty cycle based on temperature
        if temp < PHASE1_TEMP:
            desired_duty_cycle = 0
        elif PHASE1_TEMP <= temp < PHASE2_TEMP:
            desired_duty_cycle = PHASE1_SPEED
        elif PHASE2_TEMP <= temp < PHASE3_TEMP:
            desired_duty_cycle = PHASE2_SPEED
        else:
            desired_duty_cycle = PHASE3_SPEED

        # Change the duty cycle only if it's different from the last one
        if desired_duty_cycle != last_duty_cycle:
            print(f"Temp changed to {temp}C, speed changed to: {int(desired_duty_cycle)}%")
            p.ChangeDutyCycle(desired_duty_cycle)
            last_duty_cycle = desired_duty_cycle  # Update the last applied duty cycle

        time.sleep(2)  # Delay to reduce CPU usage and avoid constant polling

except KeyboardInterrupt:
    pass

finally:
    # Clean up the GPIO settings
    print("Stopping fan..")
    p.stop()  # Stop the PWM
    GPIO.cleanup()  # Clean up GPIO setup
    print("Stopped.")
