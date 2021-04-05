# April 6, 2021 - MUSICAL INSTRUMENT

Description:
For this week's assignment I decided to do a multi-purposed musical instrument. What I created can:
 - Play musical notes using switches 
 - Change pitch using an ultrasonic sensor
 - And provides a constant beat using the servo


## Process

### Thought Process
I was a bit all over the place this week, because I was not sure what I wanted to do. To make things more complicated,I knew I wanted a varience in pitch for the 
notes and as Professor Shiloh had mentioned using the Servo to hit something, I wanted to include this as well for a baseline.

For the notes I decided to use three switches. As it concerns the pitch, it came down to the potentiometer or the ultrasonic sensor. I thought it would be easier
to change the pitch using the latter, so that's what I went with. For the baseline, I decided to use the toggle switch, so that when it is on, the servo's action
will continue. 

- To begin, as usual I did a schematic draft
- Then I wrote the code
- And finally I started on the schematic


### Code
The code was a bit of trial and error. I tried to be as object oriented as possible, so I utilized functions, as well as classes, and different Arduino tabs: One
to store the musical notes and another or the classes.

### Circuit
The circuit was a bit more complicated this week, particularly because I was using circuit elements that I had not used before. 
 - I started by adding the three switches
    - The Green for the note A
    - The Yellow for note B
    - The Red for note C
- Then I added the toner, the ultrasonic sensor, and the toggle switch.
- Next up were the resistors for all the switches
- Then I added the 5 Volts and GND Wires
- And lastly I added the wires to connect to the Arduino pins.

I had to take off the pieces quite a few times to find a good layout for everything.


## Challenges
 - Connecting the Ultrasonic sensor properly: It took be quite a bit of time to figure out how to setup the sensor and correct my code to match it. Initally when
 I uploaded the code, no distance was being measured. 
    - Solution: To figure out the problem, I looked in the Arduino examples for the Sensor example, and used that as a test for what I was doing wrong. It turns out that I had not put in the echo pin in Input mode, and I had set the ping Pin as output in setup. So by following the Arduino example I was able to figure out the 
