import de.bezier.data.sql.*;

ArrayList<InputField> inputFields = new ArrayList<InputField>();

SQLite database;
int page = 0;

ButtonField createAccount;
ButtonField login;

void setup() {
  size(1000, 500);
  inputFields.add(new InputField(new PVector(200, 150), new PVector(270, 50), color(255), "Username", 25, color(200)));
  inputFields.add(new InputField(new PVector(200, 205), new PVector(270, 50), color(255), "Password", 25, color(200)));
  inputFields.add(new InputField(new PVector(200, 260), new PVector(270, 50), color(255), "Email", 25, color(200)));

  createAccount = new ButtonField(new PVector(200, 400), new PVector(200, 50), color(255), "Create Account", 25, color(150));
  login = new ButtonField(new PVector(500, 400), new PVector(170, 50), color(255), "Login", 25, color(150));

  database = new SQLite(this, "Users.sqlite");
}

void draw() {
  createAccount.display();
  login.display();

  for (InputField i : inputFields) {
    i.display();
  }
}

void mousePressed() {
  createAccount.clicked();
  login.clicked();
  for (InputField i : inputFields) {
    i.clicked();
  }

  if (createAccount.isClicked) {
    String tempUsername = "";
    String tempPassword = "";
    String tempEmail = "";
    for (InputField i : inputFields) {
      if(i.text == "Username"){tempUsername = i.input;}
      if(i.text == "Password"){tempPassword = i.input;}
      if(i.text == "Email"){tempEmail = i.input;}
      println(tempEmail);
    }
    addAccount(tempUsername, tempPassword, tempEmail);
    createAccount.isClicked = false;
  }
  if (login.isClicked) {
    login();
    login.isClicked = false;
  }
}

void keyPressed() {
  if (keyCode != SHIFT && keyCode != ALT) {
    for (InputField i : inputFields) {
      i.addInput(key);
    }
    if (keyCode == BACKSPACE ) {
      for (InputField i : inputFields) {
        if (i.isClicked) {
          i.removeInput();
        }
      }
    }
  }
}

void login() {
}

void addAccount(String username, String password, String email) {
  if (database.connect()) {
    database.query("INSERT INTO User (ID,Name,Mail,Pass) VALUES ( '35','"+username+"','"+email+"', '"+password+"');");
  } else {
    println("Database failed to connect");
  }
}

void getData() {
  if (database.connect()) {
    database.query("SELECT ID, Name, Mail, Pass FROM User");

    while (database.next()) {
      println(
        "ID: " + database.getInt("ID") + 
        ", \t Name: " + database.getString("Name") + 
        ", \t Mail: " + database.getString("Mail") + 
        ", \t Password: " + database.getString("Pass")
        );
    }
  } else {
    println("Database failed to connect");
  }
}
