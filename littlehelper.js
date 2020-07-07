// Function to get all the contact data from the Cloud JSON and transferring it to jsonData
function getDataFromCloud(getTheUrl){

    //console.log("getDataFromCloud_phase_1")
    var xhr = new XMLHttpRequest
        //console.log("getDataFromCloud_phase_2")
        xhr.onreadystatechange = function() {
          if (xhr.readyState === XMLHttpRequest.DONE) {
        //    console.log("getDataFromCloud_phase_3")
        // New test code

        //Leftover from old code
            //jsonData = xhr.responseText
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

// Function to get data from the Cloud with specific ID and transfering it to jsonData
// Maybe change to use it something else than jsonData, so we don't overwrite tempoprary local data?
function getDataFromCloudWithId(getTheUrl){

    console.log("getDataFromCloudWithId_phase_1")
    var xhr = new XMLHttpRequest
        console.log("getDataFromCloudWithId_phase_2")
        xhr.onreadystatechange = function() {
          if (xhr.readyState === XMLHttpRequest.DONE) {
            console.log("getDataFromCloudWithId_phase_3")
            var objectArray = JSON.parse(xhr.responseText)
        // chug data to safety
            abStack.jsonData = objectArray
            outputJSONData()
          }
        }
        console.log("getDataFromCloudWithId_phase_5")
        xhr.open("GET", Qt.resolvedUrl(getTheUrl))
        xhr.send()
        console.log("function getDataFromCloudWithId run")
}


// Function to send new contact to Heroku

function sendContactToCloud(getTheUrl){

    console.log("sendContactToCloud_phase_1")
    var xhr = new XMLHttpRequest
        console.log("sendContactToCloud_phase_2")
        xhr.onreadystatechange = function() {
          if (xhr.readyState === XMLHttpRequest.DONE) {
            console.log("sendContactToCloud_phase_3")


                    //jsonData = xhr.responseText
            var objectArray = JSON.parse(xhr.responseText)
        // chug data to safety
            abStack.jsonData = objectArray
                outputJSONData()
          }
        }
        console.log("sendContactToCloud_phase_5")
        xhr.open("GET", Qt.resolvedUrl(getTheUrl))
        xhr.send()
        console.log("function getDataFromCloud run")
}

// Function to check if ID exists in cloud.
// Is this necessary? Why not just update local database and check from that?
// Just use by searchFromJSON([id_number],id,true), run getDataFromCloud() first if fresh data needed.
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
// Temporary fix: For now the same code is in addressbook.qml where needed.
function dataToContactView(index){
    var jsonObject = abStack.jsonData[index]
    abContactViewIdField = jsonObject["id"]
    abContactViewFirstNameField = jsonObject["firstname"]
    abContactViewLastNameField = jsonObject["lastname"]
    abContactViewNumberField = jsonObject["mobile"]
    abContactViewEmailField = jsonObject["email"]
}


// function to search from local data( abStack.jsonData )
// Input: searchFromJSON(String to search, Field to search from, search for exactMatch true/false)
// Returns: Arrays of indexes of the matches in jsonData
function searchFromJSON(searchString, searchField, exactMatch){
// Array to save result indexes
    var foundAtIndex = [];
    var searchStringI = /"searchString"/i ;
    console.log("searchFromJSON");
    for (var x in abStack.jsonData) {
        console.log("Transferring.");
        var jsonObject = abStack.jsonData[x];
        var searchStringResult = jsonObject[searchField];
        console.log("Lets check.");

    // If we need exact match. This works.
        if(exactMatch === true){
            if( searchStringResult === searchString ){
                //foundAtIndex = x;
                console.log("Found exact match at index: "+x);
                foundAtIndex.push(x);
            }else{
                console.log("Not found exact match. :( ");
            }
    // when only partial match is needed
        }else{
        //Strings to lower case
            searchStringResult = searchStringResult.toLowerCase();
            searchString = searchString.toLowerCase();
            if(searchStringResult.match(searchString) ){
                console.log("Found at least partial match at index: " + x);
                foundAtIndex.push(x);
            }else{
                console.log("Not found. :( ");
            }
        }
    }
    return foundAtIndex;
}

//From https://gist.github.com/endel/321925f6cafa25bbfbde
// (1).pad(3) // => "001"
//(10).pad(3) // => "010"
//(100).pad(3) // => "100"
// Used to add zero padding when showing in ListView

Number.prototype.pad = function(size) {
  var s = String(this);
  while (s.length < (size || 2)) {s = "0" + s;}
  return s;
}

//Status: Working
    //Contactlist-API

    //Get all contacts

        //http-GET

        //https://qtphone.herokuapp.com/contact


//Status: JS working. Waiting for implementation.
    //Get Contact BY ID

        //http-GET

        //https://qtphone.herokuapp.com/contact/x

        //WHERE x=id-value


//Status: Currently working on.
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

// Status: JS Script working, with both exact or non-exact results.
    //-Search a contact
    //Example there is a person named Matti Mainio, if you start to type “Mat” or “Mai” ->you will see all the contacts which has those substrings.
    //I didn’t implement that in the API, so you will have to get all contacts and filter in the app.


    //-Save to local database
    //Study if it is possible to use SQLite in QtAndroid and if possible save the data to SQLite database.
    //Then the user can use the contact-list also without Internet-connection.
    //You can the add features like “sync to Remote-database” and/or “sync to Local-database”.
