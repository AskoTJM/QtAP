
// Function to get all the contact data from the Cloud JSON and transferring it to jsonData
// Status: Working
function getDataFromCloud(getTheUrl){

    var xhr = new XMLHttpRequest
        xhr.onreadystatechange = function() {
          if (xhr.readyState === XMLHttpRequest.DONE) {        
              abStack.jsonABData = JSON.parse(xhr.responseText)
              outputJSONData()
          }
        }
        xhr.open("GET", Qt.resolvedUrl(getTheUrl))
        xhr.send()
        console.log("function getDataFromCloud finished")
}




// Function to upload data to Cloud
// Input: URL for Heroku, object with data
// if id value is set update, if not new contact data.
// Replaces separate Update and Add new Contact functions
function sendContactDataToCloud(getTheUrl, jsonToSend){
    var xhr = new XMLHttpRequest
        xhr.onreadystatechange = function() {
          if (xhr.readyState === XMLHttpRequest.DONE) {

          }

        }
    // If "id" field is empty, it's new contact data.
    if(jsonToSend.id === ""){
       xhr.open("POST", Qt.resolvedUrl(getTheUrl))
       console.log("JsonDataPOST: " + JSON.stringify(jsonToSend) );
    }
    // If "id" field has number, were updating existing contact.
    // Maybe run script to check from local data if that ID number actually exists?
    // if(searchFromJSON([id_number], "id", true) !== "")
    if(jsonToSend.id !== ""){
       xhr.open("PUT", Qt.resolvedUrl(getTheUrl+"/"+jsonToSend.id));
       console.log("JsonDataPUT: " + JSON.stringify(jsonToSend) );
    }
    xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    delete jsonToSend.id;
    xhr.send(JSON.stringify(jsonToSend));
    console.log("JsonData: " + JSON.stringify(jsonToSend) );
}



// Function to output data from jsonData and appending it to abJSONModel
// to generate listView of it.
// ? Not sure if this is necessary? Can we skip this and generate ListView from jsonData directly?
function outputJSONData(){
    abJSONModel.clear()
    for (var x in abStack.jsonABData) {
        var jsonObject = abStack.jsonABData[x]
        //console.log("outputJSONDataToConsole_phase_1 " + x + " " + jsonObject["lastname"])
        abJSONModel.append({"lastname": jsonObject["lastname"]
                               , "firstname": jsonObject["firstname"]
                               , "id": jsonObject["id"]
                               , "mobile": jsonObject["mobile"]
                               , "email": jsonObject["email"]})
        console.log("outputJSONData From abJSONModel: " + x + " " + abJSONModel.get(x).lastname +", "+ abJSONModel.get(x).firstname)

    }
}



// function to search from local data( abStack.jsonData )
// Status: Working
// Input: searchFromJSON(String to search, Field to search from, search for exactMatch true/false)
// Returns: Arrays of indexes of the matches in jsonData
function searchFromJSON(searchString, searchField, exactMatch){
// Array to save result indexes
    var foundAtIndex = [];
    var searchStringI = /"searchString"/i ;
    console.log("searchFromJSON");
    for (var x in abStack.jsonABData) {
        console.log("Transferring.");
        var jsonObject = abStack.jsonABData[x];
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
// Status: Working
// (1).pad(3) // => "001"
//(10).pad(3) // => "010"
//(100).pad(3) // => "100"
// Used to add zero padding when showing in ListView

Number.prototype.pad = function(size) {
  var s = String(this);
  while (s.length < (size || 2)) {s = "0" + s;}
  return s;
}
