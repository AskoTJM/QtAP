// Mode switches, switches console logging on/off on some parts
const debugMode = false
const verboseMode = true
const thisFileName = "littlehelper.js"

// Function to get all the contact data from the Cloud JSON and transferring it to jsonData
// Status: Working
function getDataFromCloud(getTheUrl){
    if(verboseMode)
        console.log(thisFileName+":getDataFromCloud() Run")

    var xhr = new XMLHttpRequest
        xhr.onreadystatechange = function() {
          if (xhr.readyState === XMLHttpRequest.DONE) {        
              abStack.jsonABData = JSON.parse(xhr.responseText);
              if(debugMode)
                console.log(thisFileName+":getDataFromCloud() abStack.jsonABData size: " + JSON.stringify(abStack.jsonABData));
              outputJSONData();
          }
        }
        xhr.open("GET", Qt.resolvedUrl(getTheUrl));
        xhr.send();
        if(verboseMode)
            console.log(thisFileName+":getDataFromCloud() finished");
}


// Function to upload data to Cloud
// Input: URL for Heroku, object with data
// if id value is set update, if not new contact data.
// Replaces separate Update and Add new Contact functions
function sendContactDataToCloud(getTheUrl, jsonToSend){
    if(verboseMode)
        console.log(thisFileName+":sendContactDataToCloud() Run")

    var xhr = new XMLHttpRequest
        xhr.onreadystatechange = function() {
          if (xhr.readyState === XMLHttpRequest.DONE) {

          }

        }
    // If "id" field is empty, it's new contact data.
    if(jsonToSend.id === ""){
       xhr.open("POST", Qt.resolvedUrl(getTheUrl))
       if(debugMode)
        console.log("JsonDataPOST: " + JSON.stringify(jsonToSend) );
    }
    // If "id" field has number, were updating existing contact.
    // Maybe run script to check from local data if that ID number actually exists?
    // if(searchFromJSON([id_number], "id", true) !== "")
    if(jsonToSend.id !== ""){
        xhr.open("PUT", Qt.resolvedUrl(getTheUrl+"/"+jsonToSend.id));
        if(debugMode)
            console.log("JsonDataPUT: " + JSON.stringify(jsonToSend) );
    }
    xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    delete jsonToSend.id;    
    xhr.send(JSON.stringify(jsonToSend));
    if(debugMode)
        console.log("JsonData: " + JSON.stringify(jsonToSend) );
}



// Function to output data from jsonData and appending it to abJSONModel
// to generate listView of it.
function outputJSONData(){
    if(verboseMode)
        console.log(thisFileName+":outputJSONData() Run")

    abJSONModel.clear()
    // Why undefined
    //console.log("outputJSONDATA abStack.jsonABData size: " + JSON.stringify(abStack.jsonABData.length));

    for (var x in abStack.jsonABData) {
        var jsonObject = abStack.jsonABData[x]
        abJSONModel.append({"lastname": jsonObject["lastname"]
                               , "firstname": jsonObject["firstname"]
                               , "id": jsonObject["id"]
                               , "mobile": jsonObject["mobile"]
                               , "email": jsonObject["email"]})
        if(debugMode)
            console.log(thisFileName+":outputJSONData() -> Content of abJSONModel: " + x + " " + abJSONModel.get(x).lastname +", "+ abJSONModel.get(x).firstname)

    }
}



// function to search from local data( abStack.jsonData )
// Status: Working
// Input: searchFromJSON(String to search, Field to search from, search for exactMatch true/false)
// Returns: Arrays of indexes of the matches in jsonData
function searchFromJSON(searchString, searchField, exactMatch){
    if(verboseMode)
        console.log(thisFileName+":searchFromJSON()-> Run")

    // Array to save result indexes
    var foundAtIndex = [];

    var searchStringI = /"searchString"/i ;
    if(debugMode)
        console.log(thisFileName+":searchFromJSON()-> started.");
    for (var x in abStack.jsonABData) {
        if(debugMode)
            console.log(thisFileName+":searchFromJSON()-> Transferring from jsonABData to jsonObject.");
        var jsonObject = abStack.jsonABData[x];
        var searchStringResult = jsonObject[searchField];
        if(debugMode)
            console.log(thisFileName+":searchFromJSON()-> Lets check.");

    // If we need exact match. This works.
        if(exactMatch === true){
            if( searchStringResult === searchString ){
                //foundAtIndex = x;
                if(verboseMode)
                    console.log(thisFileName+":searchFromJSON()-> Found exact match at index: "+x);
                foundAtIndex.push(x);
            }else{
                if(verboseMode)
                    console.log(thisFileName+":searchFromJSON()-> Not found exact match. :( ");
            }
    // when only partial match is needed
        }else{
        //Strings to lower case
            searchStringResult = searchStringResult.toLowerCase();
            searchString = searchString.toLowerCase();
            if(searchStringResult.match(searchString) ){
                if(verboseMode)
                    console.log(thisFileName+":searchFromJSON()->Found at least partial match at index: " + x);
                foundAtIndex.push(x);
            }else{
                if(verboseMode)
                    console.log(thisFileName+":searchFromJSON()-> Not found. :( ");
            }
        }
    }
    return foundAtIndex;
}

// function to open/create Sqlite database
// Status: WIP
// Input: -
// Output: -

function getDataFromLocalDB(){
    if(verboseMode)
        console.log(thisFileName+":getDataFromLocalDB() Run")

    var db =  LocalStorage.openDatabaseSync("AddressBookDB", "1.0", "QtPhone Addressbook Local Database", 1000000);

    try {
            db.transaction(function (tx) {
                tx.executeSql('CREATE TABLE IF NOT EXISTS AddressBook(id INTEGER,firstname TEXT,lastname TEXT,mobile TEXT,email TEXT)')
                //tx.executeSql('INSERT INTO AddressBook VALUES(?, ?, ?, ?, ?)', [ '333','hello', 'world','12131','a@c.com' ]);
                //tx.executeSql('DELETE FROM AddressBook');
                if(debugMode)
                    console.log("In Database: " + JSON.stringify(tx.executeSql('SELECT * FROM AddressBook')));
                var rs = tx.executeSql('SELECT * FROM AddressBook');

                let inputToDB = [];

                for (var i = 0; i < rs.rows.length; i++) {
                    let jsonObject = {};
                    jsonObject.id = rs.rows.item(i).id;
                    jsonObject.firstname = rs.rows.item(i).firstname;
                    jsonObject.lastname = rs.rows.item(i).lastname;
                    jsonObject.mobile = rs.rows.item(i).mobile;
                    jsonObject.email = rs.rows.item(i).email;

                    if(debugMode)
                        console.log(thisFileName+":getDataFromLocalDB()-> Content of jsonObject: " + JSON.stringify(jsonObject));
                    inputToDB[inputToDB.length] = jsonObject;
                    if(debugMode)
                        console.log(thisFileName+":getDataFromLocalDB()-> Content of inputToDB" + JSON.stringify(inputToDB));

                }
                abStack.jsonABData = inputToDB;
                if(debugMode)
                    console.log(thisFileName+":getDataFromLocalDB()-> content of jsonABData is: " + JSON.stringify(abStack.jsonABData));
                outputJSONData();
            })
        } catch (err) {
            console.log("Error in "+thisFileName+":getDataFromLocalDB() in database: " + err)
        };
}

// function to save abStack.jsonAbData to Local DB
// Status: Working
// Input: -
// Output: -
function saveDataToLocalDB(){
    if(verboseMode)
        console.log(thisFileName+":saveDataToLocal() Run")

    var db =  LocalStorage.openDatabaseSync("AddressBookDB", "1.0", "QtPhone Addressbook Local Database", 1000000);

    if(abStack.jsonABData === undefined){
        if(verboseMode)
            console.log(thisFileName+":saveDataToLocalDB() script didn't run because abStack.jsonAbData is empty.")
    }else{
        try {
                db.transaction(function (tx) {
                //Create table if it doesn't exists
                    tx.executeSql('CREATE TABLE IF NOT EXISTS AddressBook(id INTEGER,firstname TEXT,lastname TEXT,mobile TEXT,email TEXT)')
                    for (var x in abStack.jsonABData) {
                        var jsonObject = abStack.jsonABData[x]
                        tx.executeSql('INSERT INTO AddressBook VALUES(?, ?, ?, ?, ?)', [ jsonObject["id"],
                                                                                        jsonObject["firstname"],
                                                                                        jsonObject["lastname"],
                                                                                        jsonObject["mobile"],
                                                                                        jsonObject["email"] ]);
                        if(debugMode)
                            console.log("saveDataToLocalDB From abJSONModel: " + x + " " + abJSONModel.get(x).lastname +", "+ abJSONModel.get(x).firstname);
                    }
                if(debugMode)
                    console.log("In Database: " + JSON.stringify(tx.executeSql('SELECT * FROM AddressBook')));
                })
        } catch (err) {
            console.log(thisFileName+":saveDataToLocalDB()-> Error: " + err)
        };
    }
    if(debugMode)
        console.log(thisFileName+":SaveDataToLocalDB()-> SqLite DB contains: " + getLocalDBSize()) ;
    //abAddressView.abSqLiteDataCounterText.Text = "Test";
}

// function to get number of rows from local SqLite
// Status: WIP
// Input: -
// Output: Number of rows in local SqLite Database
function getLocalDBSize(){
    if(verboseMode)
        console.log(thisFileName+":getLocalDBSize()-> Run")

    var numberOfRowsInSqLite
    var db =  LocalStorage.openDatabaseSync("AddressBookDB", "1.0", "QtPhone Addressbook Local Database", 1000000);
    try {
        db.transaction(function (tx) {
            var rs = tx.executeSql('SELECT * FROM AddressBook');
            //return numberOfRowsInSqLite = rs.rows.length;
            if(debugMode)
                console.log(thisFileName+":getLocalDBSize()-> Addressess in SqLite: " + JSON.stringify(rs.rows.length));
            //abSqLiteDataCounterText.text = JSON.stringify(rs.rows.lenght);
        })
    } catch (err) {
            console.log(thisFileName+":getLocalDBSize()-> Error : " + err)
    };

}


// function to clear local temporary data
// Status: Working.
// Input: -
// Output: -

function clearLocalDB(){
    if(verboseMode)
        console.log(thisFileName+":clearLocalDB() Run")

    var db =  LocalStorage.openDatabaseSync("AddressBookDB", "1.0", "QtPhone Addressbook Local Database", 1000000);
    try{
         db.transaction(function (tx) {
            tx.executeSql('DELETE FROM AddressBook');
            if(debugMode)
                console.log(thisFileName+":clearLocalDB() -> Local Sqlite database cleared.");
        })
    } catch (err) {
        console.log(thisFileName+":clearLocalDB()-> Error : " + err)
    };
}
function clearAddressListView(){
// Clear ListView, temporarily here to make testing easier.
    if(verboseMode)
        console.log(thisFileName+":clearAddressListView() Run")

    abJSONModel.clear();
    if(debugMode)
        console.log(thisFileName+":clearAddressListView()-> Count now: " + abJSONModel.count);
}


// Function to clear abStack.jsonABData
// Status: For some reason abStack.jsonABData counter shows '9' after clearing?
function clearABData(){
    if(verboseMode)
        console.log(thisFileName+":clearABData() Run")

    abStack.jsonABData = "";
    //abStack.jsonABData = 'undefined';
    if(debugMode)
        console.log(thisFileName+":clearABData() -> jsonABData content now:" + JSON.stringify(abStack.jsonABData));

}

//From https://gist.github.com/endel/321925f6cafa25bbfbde

// Function to add zero padding when showing data in Listview
// Status: Working
// (1).pad(3) // => "001"
//(10).pad(3) // => "010"
//(100).pad(3) // => "100"

Number.prototype.pad = function(size) {
  var s = String(this);
  while (s.length < (size || 2)) {s = "0" + s;}
  return s;
}
