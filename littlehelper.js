
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
                               , "id": jsonObject["id"]})
        console.log("outputJSONData From abJSONModel: " + x + " " + abJSONModel.get(x).lastname +", "+ abJSONModel.get(x).firstname)

    }
}

