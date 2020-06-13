import QtQuick 2.4

contact{


    ListModel{
        id: contactData

    }



    Component{
        function getData(){
            id: getData
            var req = new XMLHttpRequest;
                    req.open("GET", "https://qtphone.herokuapp.com/contact");
            req.onload = function() {
                        var objectArray = JSON.parse(req.responseText);
                        if (objectArray.errors !== undefined) {
                            console.log("Error : " + objectArray.errors[0].message)
                        } else {
                            for (var key in objectArray.statuses) {
                                var jsonObject = objectArray.statuses[key];
                                //tweets.append(jsonObject);
                                console.log(jsonObject);
                            }
                        }
                        wrapper.isLoaded()
                    }
                    req.send();
        }
    }
}

