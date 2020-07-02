// Function to get data from the URL JSON and transfering it to jsonData
function getDataFromCloud(getTheUrl){

    //console.log("getDataFromCloud_phase_1")
    var xhr = new XMLHttpRequest
        //console.log("getDataFromCloud_phase_2")
        xhr.onreadystatechange = function() {
          if (xhr.readyState === XMLHttpRequest.DONE) {
        //    console.log("getDataFromCloud_phase_3")
        // New test code
            jsonData = xhr.responseText
            var objectArray = JSON.parse(xhr.responseText)
        // chug data to safety
            abStack.jsonData = objectArray
                outputJSONData()
          }
        }
        //console.log("getDataFromCloud_phase_5")
        xhr.open("GET", Qt.resolvedUrl(getTheUrl))
        xhr.send()
        console.log("function getDataFromCloud run")
}

// Function to check if ID exists in cloud.
// Is this necessary? Why not just update local database and check from that?
function checkIfIdExistsInCloud(getTheUrl, idToCheck){

    var xhr = new XMLHttpRequest
        console.log("checkIfIdExistsInCloud_phase_1")
        xhr.onreadystatechange = function() {
          if (xhr.readyState === XMLHttpRequest.DONE) {
            console.log("checkIfIdExistsInCloud_phase_2")

            //jsonData = xhr.responseText
            var objectArray = JSON.parse(xhr.responseText)


          }
        }
    xhr.open("GET", Qt.resolvedUrl(getTheUrl))
    xhr.send()
    console.log("function checkIfIdExistsInCloud run")
}

// Function to output data from jsonData and appending it to abJSONModel
// to generate listView of it.
// ? Not sure if this is necessary? Can we skip this and generate ListView from jsonData directly?
function outputJSONData(){
    abJSONModel.clear()
    for (var x in abStack.jsonData) {
        var jsonObject = abStack.jsonData[x]
        //console.log("outputJSONDataToConsole_phase_1 " + x + " " + jsonObject["lastname"])
        abJSONModel.append({"lastname": jsonObject["lastname"]
                               , "firstname": jsonObject["firstname"]
                               , "id": jsonObject["id"]
                               , "mobile": jsonObject["mobile"]
                               , "email": jsonObject["email"]})
        console.log("outputJSONData From abJSONModel: " + x + " " + abJSONModel.get(x).lastname +", "+ abJSONModel.get(x).firstname)

    }
}


// Currently not working. Issues with writing to global properties
// Workaround: For now the same code is in addressbook.qml where needed.
function dataToContactView(index){
    var jsonObject = abStack.jsonData[index]
    abContactViewIdField = jsonObject["id"]
    abContactViewFirstNameField = jsonObject["firstname"]
    abContactViewLastNameField = jsonObject["lastname"]
    abContactViewNumberField = jsonObject["mobile"]
    abContactViewEmailField = jsonObject["email"]
}


// function to search JSON for results
// Input: String to search, Field to search from
// Output: index of the contact in jsonData
function searchFromJSON(searchString, searchField){
    var foundAtIndex;
    console.log("searchFromJSON");
    for (var x in abStack.jsonData) {
        console.log("Transferring.");
        var jsonObject = abStack.jsonData[x];
//        var searchFieldModified = '"'+ searchField +'"';
//        var searchStringResult;
        var searchStringResult = jsonObject[searchField];
        console.log("Lets check.");
        if( searchStringResult === searchString ){
            //foundAtIndex = jsonObject(currentIndex);
            console.log("Found!!! At index: "+x);
        }else{
            console.log("Not found");
        }
    }

    return foundAtIndex;
}

//From https://gist.github.com/endel/321925f6cafa25bbfbde
// (1).pad(3) // => "001"
//(10).pad(3) // => "010"
//(100).pad(3) // => "100"
// Can be used to add zero padding

Number.prototype.pad = function(size) {
  var s = String(this);
  while (s.length < (size || 2)) {s = "0" + s;}
  return s;
}

//
//Contactlist-API

//Get all contacts

    //http-GET

    //https://qtphone.herokuapp.com/contact
//Status: Working

//Get Contact BY ID

    //http-GET

    //https://qtphone.herokuapp.com/contact/x

    //WHERE x=id-value



//Add Contact

    //http-POST

    //https://qtphone.herokuapp.com/contact

    //with fields:

    //firstname

    //lastname

    //mobile

    //email


//Update Contact

    //http-PUT

    //https://qtphone.herokuapp.com/contact/x

    //WHERE x=id-value

    //and fields
    //firstname

    //lastname

    //mobile

    //email

//In the application implement all those operations. So that you can get, add and update contacts.
//If you have still time left, you can figure out yourself what more you could implement. Here are a couple of examples:

//-Search a contact
//Example there is a person named Matti Mainio, if you start to type “Mat” or “Mai” ->you will see all the contacts which has those substrings. I didn’t implement that in the API, so you will have to get all contacts and filter in the app.

//-Save to local database
//Study if it is possible to use SQLite in QtAndroid and if possible save the data to SQLite database.
//Then the user can use the contact-list also without Internet-connection.
//You can the add features like “sync to Remote-database” and/or “sync to Local-database”.
