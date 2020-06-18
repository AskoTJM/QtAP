
function getDataFromHeroku(){

    console.log("Hmmm1")
    var xhr = new XMLHttpRequest
        console.log("Hmmm2")
        xhr.onreadystatechange = function() {
          if (xhr.readyState === XMLHttpRequest.DONE) {
            console.log("Hmmm3")
        // New test code
            jsonData = xhr.responseText
            var objectArray = JSON.parse(xhr.responseText)
        // chug data to safety
            abStack.jsonData = objectArray
            //console.log("Hmmm4 "+ objectArray.email)
              for (var x in objectArray) {
                  //var jsonObject = objectArray[x]
                  var jsonObject = abStack.jsonData[x]
                  console.log("Very hmm " + x + " " + jsonObject["email"]) // Object.keys(objectArray).length)
                  //console.log("Very hmm " + x + " " + abStack.jsonData["email"])
              }
            //
            var dataString = xhr.responseText
            //console.log("Hmmm4 "+ dataString)

            abStack.jsonData = JSON.parse(dataString)
          }
        }
        console.log("Hmmm5")
        xhr.open("GET", Qt.resolvedUrl("https://qtphone.herokuapp.com/contact"))
        xhr.send()
        console.log("Hmmm6")
}

