const int trigPin = 13;
const int echoPin = 12;

const int trigPin2 = 4;
const int echoPin2 = 3;

void setup() {
// initialize serial communication:
Serial.begin(9600);
pinMode(trigPin, OUTPUT);
pinMode(trigPin2, OUTPUT);
pinMode(echoPin, INPUT);
pinMode(echoPin2, INPUT);
}

void loop()
{
float duration, duration2, cm, cm2;

digitalWrite(trigPin, LOW);
delayMicroseconds(2);
digitalWrite(trigPin, HIGH);
delayMicroseconds(10);
digitalWrite(trigPin, LOW);
duration = pulseIn(echoPin, HIGH);
cm = microsecondsToCentimeters(duration);

digitalWrite(trigPin2, LOW);
delayMicroseconds(2);
digitalWrite(trigPin2, HIGH);
delayMicroseconds(10);
digitalWrite(trigPin2, LOW);
duration2 = pulseIn(echoPin2, HIGH);
cm2 = microsecondsToCentimeters(duration2);

Serial.print('A');
Serial.print(cm-1);
Serial.print('B');
Serial.print(cm2-1);
Serial.println('E');



}


float microsecondsToCentimeters(float microseconds)
{
return microseconds / 29 / 2;
}
