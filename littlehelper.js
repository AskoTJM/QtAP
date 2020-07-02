
function getDataFromCloud(getTheUrl){

    //console.log("getDataFromNet_phase_1")
    var xhr = new XMLHttpRequest
        //console.log("getDataFromNet_phase_2")
        xhr.onreadystatechange = function() {
          if (xhr.readyState === XMLHttpRequest.DONE) {
        //    console.log("getDataFromNet_phase_3")
        // New test code
            jsonData = xhr.responseText
            var objectArray = JSON.parse(xhr.responseText)
        // chug data to safety
            abStack.jsonData = objectArray
                outputJSONData()
          }
        }
        //console.log("getDataFromNet_phase_5")
        xhr.open("GET", Qt.resolvedUrl(getTheUrl))
        xhr.send()
        console.log("function getDataFromNet run")
}

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
function dataToContactView(index){
    var jsonObject = abStack.jsonData[index]
    abContactViewIdField = jsonObject["id"]
    abContactViewFirstNameField = jsonObject["firstname"]
    abContactViewLastNameField = jsonObject["lastname"]
    abContactViewNumberField = jsonObject["mobile"]
    abContactViewEmailField = jsonObject["email"]
}


// function to search JSON for results
function searchFromJSON(searchString, searchField){
    var foundAtIndex;
    for (var x in abStack.jsonData) {
        var jsonObject = abStack.jsonData[x]

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
