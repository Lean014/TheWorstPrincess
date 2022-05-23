import nl.tue.id.oocsi.*;
import processing.sound.*;

/************************************************************************************************
 Code for M1.2 Leanne van Hees project
 With special thanks to Rick van Schie, who explained a lot about classes and OOP to me, again and again. :)
 
 Subscribe to channel: TheWorstPrincess
 Use this page for testing: https://oocsi.id.tue.nl/test/visual
 URLs and just made QRs of them:
 https://oocsi.id.tue.nl/send/TheWorstPrincess/1-armour
 https://oocsi.id.tue.nl/send/TheWorstPrincess/2-sky
 https://oocsi.id.tue.nl/send/TheWorstPrincess/3-tea
 https://oocsi.id.tue.nl/send/TheWorstPrincess/4-nasal-spray
 https://oocsi.id.tue.nl/send/TheWorstPrincess/5-tower
 https://oocsi.id.tue.nl/send/TheWorstPrincess/5-dress
 https://oocsi.id.tue.nl/send/TheWorstPrincess/6-dragon-air
 https://oocsi.id.tue.nl/send/TheWorstPrincess/7-pants-on-fire
 
 // More information how to run an OOCSI server
 // can be found here: https://iddi.github.io/oocsi/)
 ************************************************************************************************/

OOCSI oocsi;  //CLASS and instance
SoundFile RightQR, WrongQR, BeginSound, Scenario0Sound, Scenario1Sound, Scenario2Sound, Scenario3Sound, Scenario4Sound, Scenario5Sound, Scenario6Sound, Scenario7Sound;
//ArrayList<User> users = new ArrayList<User>();
//int numUsersNeeded = 3;
//making a list of user typer
User [] users = new User[3]; // looping back to the class User

String parameter = "";
String[] roles = {"dragon", "prince", "princess"};
boolean[] roleTaken = {false, false, false};

String tempUserId;
String scannedQR;
boolean usersListFull = false;
boolean usersComplete = false;

boolean checkIfRolesAreAssigned = false; // if three users are found, roles will be assigned ONCE
int userRole = 0; // userroles, 0 for dragon, 1 for prince, 2 for princess

boolean QR5towerScanned = false;
String QR5towerScannedBy = "";

boolean QR5dressScanned = false;
String QR5dressScannedBy = "";

boolean QR6scanned = false;
String QR6scannedBy = "";

enum StatesQR { //different states during interaction
  DEFAULT, // equals 0
    QR1, // equals 1 first part of the 'story'
    QR2, // equals 2
    QR3, // 3
    QR4, // 4
    QR5, //new part of the story 5
    QR5tower, // 5
    QR5dress, //5
    QR6, // 6
    QR7, // 7
    END, // play end sound
};
StatesQR stateQR;

void setup() {
  size(800, 600);
  //setupControl();
  LoadSounds();

  stateQR = StatesQR.DEFAULT;
  
  //if (!BeginSound.isPlaying()) { 
  //  BeginSound.play();
  //}
    if (!Scenario3Sound.isPlaying()) { 
    Scenario3Sound.play();
  }

  // connect to OOCSI server
  oocsi = new OOCSI(this, "TheWorstPrincess_1", "oocsi.id.tue.nl"); //"unique name or clientLister", "oocsi.example.net"
  oocsi.subscribe("TheWorstPrincess");
}

// loop
void draw() {
  background(0);
}

//functions

//handleOOCSIEvent
void handleOOCSIEvent(OOCSIEvent message) {
  // print out the "intensity" value in the message from channel "TheWorstPrincess"
  scannedQR = message.getString("parameter");
  tempUserId = message.getString("userId");

  AssignUserId();
  
  if (BeginSound.isPlaying()) { //makes sure no dubbel sounds are playing. when people enter the next room and scann another qr code the new sound starts playing.
    return;
  }
  
  readQR(message.getString("parameter"), message.getString("userId"));
}

void assigningRoles() { // Gives every user own unique role
  for (User user : users) {
    user.role = roles[userRole];
    userRole++;
    println(user.userId, " acts as ", user.role); //one specific user.userValues " acts as " role
  }
  return;
}

void WrongQRSound() {
  if (!WrongQR.isPlaying()) { 
    WrongQR.play();
  }
  return;
}
void RightQRSound() {
  if (!RightQR.isPlaying()) { 
    RightQR.play();
  }
  return;
}

//Read QR code received from OOCSIEvent
void readQR(String QRCode, String UserId) {
  // Identify three users
  for (int i =0; i < users.length; i++) {
    if (users[i] == null) {
      usersComplete = false;
    } else {
      usersComplete = true;
    }
  }
  //See if users are ready for role assigning
  if (usersComplete == true && checkIfRolesAreAssigned == false) {
    // Assign roles
    checkIfRolesAreAssigned = true; // don't give roles again
    println("Assigning roles...");

    // Actually assigning specific roles to specific users 
    assigningRoles();
    println("roles are assigned");
    //play sound
    if (!Scenario0Sound.isPlaying()) { 
      Scenario0Sound.play();
    }
    stateQR = StatesQR.QR1; //switch case from default to QR1 for now the interaction part starts
    return;
  }

  // Interaction
  if (checkIfRolesAreAssigned == true) {
    println("To interaction");
    interaction(QRCode, UserId);
  }
}

void interaction(String QRCode, String UserId) {

  for (User user : users) {

    //if (user.userId != UserId) { //what user did scan the QR?
    if (!user.userId.equals(UserId)) { //what user did scan the QR?
      //println(user.userId, "not equal to ", UserId);
      continue;
    }
    switch (stateQR) {

    case QR1:
      println ("You are in part 1 of the story, you need to scan QR #1!");
      if (user.role != "prince") {
        println("It is not your turn.");
        WrongQRSound();
      } else if (user.role == "prince" && !QRCode.equals("1-armour")) { //equals??
        println("Try another QR code. You tried: ", QRCode, "with role: ", user.role);        
        WrongQRSound();
      } else {
        println("This is the right QR code!");
        //play sound
        if (!Scenario1Sound.isPlaying()) { 
          Scenario1Sound.play();
        }
        stateQR = StatesQR.QR2; //go to part 2 of the story and not able to return to part 1
      }
      break;

    case QR2:
      println ("You are in part 2 of the story, you need to scan QR #2!");
      if (user.role != "dragon") {
        println("It is not your turn.");
        WrongQRSound();
      } else if (user.role.equals("dragon") && !QRCode.equals("2-sky")) {
        println("Try another QR code.");
        WrongQRSound();
      } else {
        println("This is the right QR code!");
        //play sound
        if (!Scenario2Sound.isPlaying()) { 
          Scenario2Sound.play();
        }
        stateQR = StatesQR.QR3; //go to part 3 of the story and not able to return to part 2
      }
      break;

    case QR3:
      println ("You are in part 3 of the story, you need to scan QR #3!");
      if (user.role != "princess") {
        println("It is not your turn.");
        WrongQRSound();
      } else if (user.role == "princess" && !QRCode.equals("3-tea")) {
        println("Try another QR code.");
        WrongQRSound();
      } else {
        println("This is the right QR code!");
        //play sound
        if (!Scenario3Sound.isPlaying()) { 
          Scenario3Sound.play();
        }
        stateQR = StatesQR.QR4; //go to part 4 of the story and not able to return to part 3
      }
      break;

    case QR4:
      println ("You are in part 4 of the story, you need to scan QR #4!");
      if (user.role != "dragon") {
        println("It is not your turn.");
        WrongQRSound();
      } else if (user.role.equals("dragon") && !QRCode.equals("4-nasal-spray")) {
        println("Try another QR code.");
        WrongQRSound();
      } else {
        println("This is the right QR code!");
        //play sound
        if (!Scenario4Sound.isPlaying()) { 
          Scenario4Sound.play();
        }
        stateQR = StatesQR.QR5; //go to part 5 of the story and not able to return to part 4
      }
      break;

    case QR5:
      println("You are in part 5 of the story, you need to scan TWO QR codes #5!");
      if (user.role == "dragon") { //each other option is the prince or princess
        println("It is not your turn.");
        WrongQRSound();
        QR5towerScanned = false;
        QR5dressScanned = false;
      } else if (QRCode.equals("5-tower")) {
        println("ONE scanned QR code is right, 5-tower.");
        RightQRSound();
        QR5towerScanned = true;
        QR5towerScannedBy = user.role;
        if (QR5dressScanned == true && QR5dressScannedBy == user.role) {
          QR5dressScannedBy = "";
        }
      } else if (QRCode.equals("5-dress")) {
        println ("ONE scanned QR code is right, 5-dress.");
        RightQRSound();
        QR5dressScanned = true;
        QR5dressScannedBy = user.role;
        if (QR5towerScanned == true && QR5towerScannedBy == user.role) {
          QR5towerScannedBy = "";
        }
      } else {
        println("Try TWO other QR codes.");
        WrongQRSound();
        QR5towerScanned = false;
        QR5dressScanned = false;
      }
      if (QR5towerScanned == true && QR5dressScanned == true //check if both QR5s are scanned after eachother.
        && QR5towerScannedBy != QR5dressScannedBy
        && QR5towerScannedBy != "" && QR5dressScannedBy != "") { //check if QR5s are scanned by prince and princess
        //play sound
        println("These are the TWO right QR codes!");
        //play sound
        if (!Scenario5Sound.isPlaying()) { 
          Scenario5Sound.play();
        }
        stateQR = StatesQR.QR6; //go to part 6 of the story and not able to return to part 5
      }
      break;

    case QR6:
      println("You are in part 6 of the story, you need to scan TWO QR codes #6!");
      if (user.role == "prince") { //each other option is the dragon or princess
        println("It is not your turn.");
        WrongQRSound();
        QR6scanned = false; //makes sure that QR6 is scanned in follow up without scanning another QR in between
      } else if (!QRCode.equals("6-dragon-air")) {
        println("Try another QR code.");
        WrongQRSound();
        QR6scanned = false; //makes sure that QR6 is scanned in follow up
      } else if (QR6scanned == false) {
        QR6scanned = true;
        QR6scannedBy = user.role;
        println ("Scan the same QR with other role");
        RightQRSound();
      } else if (QR6scanned == true && QR6scannedBy != user.role && QR6scannedBy != "") {
        println ("QR6 is scanned twice.");
        //play sound
        if (!Scenario6Sound.isPlaying()) { 
          Scenario6Sound.play();
        }
        stateQR = StatesQR.QR7; //go to part 7 of the story and not able to return to part 6
      }
      break;

    case QR7:
      println ("You are in part 7 of the story, you need to scan QR #7!");
      if (user.role != "prince") {
        println("It is not your turn.");
        WrongQRSound();
      } else if (user.role == "prince" && !QRCode.equals("7-pants-on-fire")) {
        println("Try another QR code.");
        WrongQRSound();
      } else {
        println("This is the right QR code!");
        //play sound
        if (!Scenario7Sound.isPlaying()) { 
          Scenario7Sound.play();
        }
        stateQR = StatesQR.END; //go to part END of the story and not able to return to part 7
      }
      break;

    case END:
      println("End of the story!");
      break;

    default:
      println ("This is not part of the atraction.");
      break;
    }
  }
}
