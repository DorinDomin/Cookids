 <p align="center">
 <img src="https://upload.wikimedia.org/wikipedia/commons/3/34/FlightGear_Logo.svg" width="80" height="80">
</p>

# Flight Simulatur 

#### Creators: 
##### Shira Turgeman & Noa Elishmereni
#####  [our GitHub](https://github.com/noaElish/ex3)

### **Basic information**
* Purpose of this extercise-
Create code that allows remote control of an aircraft.

* Links we used for this project:
   * [FlightGear simulator](https://www.flightgear.org/)
   * the two lines we inserted the flight gear:
     "--telnet=socket,in,10,127.0.0.1,5402,tcp"
     "--generic=socket,out,10,127.0.0.1,5400,tcp,generic_small"

* Files we used for this project:
   * Fly.txt
   * Generic_small.xml

### **important classes, variables and objects:**
* Class command-
   * open data server command
   * connect control command
   * define var command
   * loop command
   * print command
   * sleep command
* Class SymbolTable- holds Three maps:
   * symbolMap: for the variables objects.
   * simMap: for the simulator objects.
   * commandMap: for all the command variable.
   
### **how does it work?**
Our program receives a file and breaks it into parts using the **lexer** function. We checked which of the strings were commands, and created a map that holds commands as the key, and a value that is a command variable from Of the right type. 
  * for example: we inserted the command "open data server" into the map, with a variable "OpenServerCommand" as the value.
  
after inserting the map with all the right commands, we started to execute each commnad by turn usuing the **parser** function. for the server and the client, we opened two different threads that runs simultaneously, and two different sockets.
next, the parser executed all of the variables. for each one, we check the direction of the arrow, and accordingly changes the values in the maps.
we also payed attention to the loops in the file, and made a command variable that is responsible to take care of such cases.

through the whole run of the programm, we received values from the simulator (using the server socket), and sending value to the simulator (using the client socket). that way, the connection stay open through the whole run.

after wer'e done with the file, the programm prints "done" and we can close the sockets, and the threads.

#### **spacial notes- for the coures team**
when debbuging our programm, we used different printing (to follow the some of the problem when trying to solve it). after finishing debugging, the plane worked fine. we started deleteing the prints, but some of them interfered the programm from reasons we dont know (sence they are only prints for the programmer and not real code realted to the programm), so that we had to keep some of them and print empty srting instead. when running the code you may incounter some of the empty lines. we let the course team know about that.
