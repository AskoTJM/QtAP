// Place to retire functions not used.


// Function to get data from the Cloud with specific ID and transfering it to jsonData
// Status: Retired, Working, same as getDataFromCloud() or some cases we can change it to do both jobs
// Maybe change to use it something else than jsonData, so we don't overwrite tempoprary local data?
function getDataFromCloudWithId(getTheUrl){

    var xhr = new XMLHttpRequest
        xhr.onreadystatechange = function() {
          if (xhr.readyState === XMLHttpRequest.DONE) {
            abStack.jsonABData = JSON.parse(xhr.responseText)
            outputJSONData()
          }
        }
        xhr.open("GET", Qt.resolvedUrl(getTheUrl))
        xhr.send()
        console.log("function getDataFromCloudWithId finished")
}

// Function to send new contact to Heroku
// Status: deprecated, replaced by sendContactDataToCloud()
function sendContactToCloud(getTheUrl){

    var jsonToSend = {"firstname":"Allo","lastname":"Hello","mobile":"555 54321","email":"allo@hello.coc"};

    console.log("sendContactToCloud_phase_1")
    var xhr = new XMLHttpRequest
        console.log("sendContactToCloud_phase_2")
        xhr.onreadystatechange = function() {
          if (xhr.readyState === XMLHttpRequest.DONE) {

          }
        }
        console.log("sendContactToCloud_phase_5")
        if(jsonToSend["id"] === ""){
           xhr.open("POST", Qt.resolvedUrl(getTheUrl))
        }


        xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        console.log("JsonObject: " + jsonToSend);
        xhr.send(JSON.stringify(jsonToSend));
        console.log("function sendContactToCloud finished.")
}

// Function to update contact information
// Status: deprecated, replaced by sendContactDataToCloud()
function updateContactInCloud(getTheUrl, jsonToSend){

    //var jsonToSend = {"firstname":"Jello","lastname":"Hallo","mobile":"515 12345","email":"Jello@Hallo.oco"};
    if(jsonToSend.id === ""){
        delete jsonToSend.id;
        console.log("ID null.");
        var xhr = new XMLHttpRequest
            xhr.onreadystatechange = function() {
              if (xhr.readyState === XMLHttpRequest.DONE) {
                //console.log("updateContactInCloud_phase_3: " + xhr.responseText)
              }

            }
            xhr.open("PUT", Qt.resolvedUrl(getTheUrl));
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            console.log("JsonObject: " + JSON.stringify(jsonToSend) );
            console.log("function updateContactInCloud finished.");
    }else{
        console.log("ID not null.");
        delete jsonToSend.id;
        console.log("JsonObject: " + JSON.stringify(jsonToSend) );
    }
}

// Function to check if ID exists in cloud.
// Is this necessary? Why not just update local database and check from that?
// Just use by searchFromJSON([id_number],id,true), run getDataFromCloud() first if fresh data needed.
// Status: deprecated and not working.
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


// Currently not working. Issues with writing to global properties
// Temporary fix: For now the same code is in addressbook.qml where needed.
function dataToContactView(index){
    var jsonObject = abStack.jsonABData[index]
    abContactViewIdField = jsonObject["id"]
    abContactViewFirstNameField = jsonObject["firstname"]
    abContactViewLastNameField = jsonObject["lastname"]
    abContactViewNumberField = jsonObject["mobile"]
    abContactViewEmailField = jsonObject["email"]
}
