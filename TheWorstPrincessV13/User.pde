class User {
  public // calling function/data/varible oudside of the class/ user2.userId
    String userId = ""; // kleine letter want is een instance van een class
  String role = "";

  //ArrayList<String> scannedCodes = new ArrayList<String>();

  User(String Id) { //constructor // functie in een class
    userId = Id;
  }

  //public void addQRCode(String QRCode) {
  //  scannedCodes.add(QRCode);          // Adds QR code to users list of scanned codes
  //}
}

void AssignUserId() {
  //store a new user id in userArray array if a new user ID was scanned
  if (IsExistingUser(tempUserId) == false && usersListFull == false) {

    //add new user with user ID
    for (int i =0; i < users.length; i++) {
      if (users[i] == null) {
        users[i] = new User(tempUserId);
        break;
      }
    }
    println("new user registered with ID: " + tempUserId);
  }
}

boolean IsExistingUser(String Id) {
  for (User user : users) {    //type user, name user, loop trough the list users 
    if (user != null) { //does there exist somthing on the list user?// bestaat er iets op de plek van user?
      if (user.userId.equals(Id)) { //if the users exists, check the ID //als er een gebruiker bestaat, check het id
        println("user already exists");
        return true;
      }
    }
  }
  return false;
}
