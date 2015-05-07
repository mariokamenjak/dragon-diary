// PageWithBottomEdge.qml
/*
  This file is part of instantfx
  Copyright (C) 2014 Stefano Verzegnassi

    This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License 3 as published by
  the Free Software Foundation.

    This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
  along with this program. If not, see http://www.gnu.org/licenses/.
*/

import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Web 0.2
import QtQuick.Window 2.0
import Ubuntu.Connectivity 1.0
import U1db 1.0 as U1db

Page {
    id: page

    //readonly property alias head: header
    default property alias containerData: container.data

    property alias bottomEdgePanelData: bottomEdgeContainer.data
    property alias bottomEdgeTitle: tipLabel.text

    property real bottomEdgePageOpacity: 0.85

    property bool bottomEdgeEnabled: true

    /*CustomHeader {
        id: header

        Connections {
            target: bottomEdge
            onPositionChanged: {
                if (bottomEdge.position < (bottomEdge.height / 2))
                    header.opacity = (bottomEdge.position / bottomEdge.height) * 2
                if (bottomEdge.position > (bottomEdge.height / 2))
                    header.opacity = 1
            }
        }
    }*/
    /*!

                A Database is very simple to create. It only needs an id and a path where the file will be created. A Database is a model, which can be used by elements, such as the ListView further in this example.

                U1db.Database {
                    id: aDatabase
                    path: "aDatabase3"
                }

            */

            U1db.Database {
                id: aDatabase
                path: "aDatabase3.9"
            }

            /*!

                A Document can be declared at runtime. It requires at the very least a unique 'docId', but that alone won't do anything special. The snipet below snippet demonstrates the basic requirements.

                In addition to this, this example displays text from the database for a specific docId and id key in a text area called 'documentContent. To update the text area at startup with either the default value or a value from the database the onCompleted function is utilized, which is also demonstrated below.

                U1db.Document {
                    id: aDocument
                    database: aDatabase
                    docId: 'helloworld'
                    create: true
                    defaults: { "helloworld":"Hello World" }

                    Component.onCompleted: {
                        documentContent.text = aDocument.contents.helloworld
                    }

                }

            */

           U1db.Document {
                id: aDocument
                database: aDatabase
                docId: 'date'
                create: true
                defaults: { "date":"Help entry\n-add the corresponding date in the upper text field,press save and then change this lower textbox into what happened today,then press save again.\n-you can also edit the entry by editing the lower textbox and just saving\n-you can use the arrow buttons to switch between entries.\n-keep in mind the most recent entry will be  to the right,the oldest one to the left." }

                Component.onCompleted: {
                    documentContent.text = aDocument.contents.date
                }

            }

           function switchToPreviousDocument(documentObject){

              aDocument.docId = getPreviousDocumentId(documentObject)

              }

           function switchToNextDocument(){

              aDocument.docId = getNextDocumentId(aDocument)

            }


           function getPreviousDocumentId(documentObject){

               if(typeof documentObject!='undefined'){

                   /*!

                     The listDocs method retrieves all the docId values from the current database. In this demonstration the values are put into an array, which is then checked to locate the docId for the current and previous documents within the database.

                   var documentIds = {}

                   documentIds = documentObject.database.listDocs()

                   for(var i = 0; i < documentIds.length; i++){

                       if(documentIds[i]===documentObject.docId && i > 0){
                           return documentIds[i-1]
                       }
                       else if(documentIds[i]===documentObject.docId && i==0){
                           return documentIds[documentIds.length-1]
                       }

                   }

                     */

                   var documentIds = {}

                   documentIds = documentObject.database.listDocs()

                   for(var i = 0; i < documentIds.length; i++){

                       if(documentIds[i]===documentObject.docId && i > 0){
                           return documentIds[i-1]
                       }
                       else if(documentIds[i]===documentObject.docId && i==0){
                           return documentIds[documentIds.length-1]
                       }

                   }

                   return documentIds[0]

               }

               else{

                   print("Error!")

                   return ''
               }


           }

           function getNextDocumentId(documentObject){

               if(typeof documentObject!='undefined'){

                   var documentIds = documentObject.database.listDocs()

                   for(var i = 0; i < documentIds.length; i++){

                       if(documentIds[i]===documentObject.docId && i < (documentIds.length-1)){
                           return documentIds[i+1]
                       }
                       else if(documentIds[i]===documentObject.docId && i==(documentIds.length-1)){
                           return documentIds[0]
                       }

                   }

                   return documentIds[0]

               }

               else{

                   print("Error!")

                   return ''
               }


           }

            function getCurrentDocumentKey(contentsObject){

                if(typeof contentsObject!='undefined'){

                    var keys = Object.keys(contentsObject);

                    return keys[0]

                }

                else{

                    return ''
                }



            }


            function updateContentWindow(documentText, addressBarText) {

                // Somewhere below need to check for things like invalid docId

                if(documentText!==addressBarText) {

                    /*!

                    These steps demonstrate the creation of a temporary document, based on a copy of the global document. This will then be used to determine if there is already a document in the database with the same docId as the address bar, and additionally with a key id with the same name.

                    var tempDocument = {}
                    var tempFieldName = addressBarText;
                    var tempContents = {};

                    tempDocument = aDocument
                    tempDocument.docId = addressBarText;

                    tempContents = tempDocument.contents

                    NOTE: For simplicity sake this example sometimes uses the same value for both the docId and the key id, as seen here. Real life implimentations can and will differ, and this will be demonstrated elsewhere in the example code.

                    */

                    var tempDocument = {}
                    var tempFieldName = addressBarText;
                    var tempContents = {};

                    tempDocument = aDocument
                    tempDocument.docId = addressBarText;

                    tempContents = tempDocument.contents

                    if(typeof tempContents !='undefined' && typeof tempContents[tempFieldName]!='undefined') {

                        //aDocument = tempDocument
                        documentContent.text = tempContents[tempFieldName]

                    }
                    else {

                        /*!

                        Here the contents of the temporary document are modified, which then replaces the global document.

                        documentContent.text = 'More Hello World...';

                        tempContents = {}
                        tempContents[tempFieldName] = documentContent.text
                        tempDocument.contents = tempContents
                        aDocument = tempDocument

                        */

                        documentContent.text = 'New entry...\nWhat happened today?';

                        tempContents = {}
                        tempContents[tempFieldName] = documentContent.text
                        tempDocument.contents = tempContents
                        //aDocument = tempDocument

                    }

                }
                else {

                    /*!

                    In this instance the current document's content is updated from the text view. The unique key and docId are not modified because the database already contains a record with those properties.

                    tempContents = {}
                    tempFieldName = getCurrentDocumentKey(aDocument.contents)
                    tempContents[tempFieldName] = documentContent.text
                    aDocument.contents = tempContents

                    */

                    tempContents = {}
                    tempFieldName = getCurrentDocumentKey(aDocument.contents)
                    tempContents[tempFieldName] = documentContent.text
                    aDocument.contents = tempContents

                }

            }

    Column {
        Rectangle {
                                 anchors.bottom: parent.bottom

                                 color: "#00FFFFFF"
        Rectangle {

                                   width: units.gu(45)
                                   anchors.bottom: parent.bottom

        /*TextArea{

                                        id: documentContent

                                        selectByMouse : false

                                        x: units.gu(1)
                                        y: units.gu(1)
                                        width: units.gu(43)
                                        height: units.gu(58)
                                        color: "#000000"

                                    }

                                     */

                                    TextArea{

                                        id: documentContent

                                        selectByMouse : false

                                        x: units.gu(1)
                                        y: units.gu(9)
                                        width: units.gu(43)
                                        height: units.gu(58)
                                        color: "#000000"

                                    }

                                 }

                                 // This rectangle contains our navigation controls

                                 Rectangle {

                                      width: units.gu(43)
                                      height: units.gu(5)
                                      anchors.top: addressBarArea.bottom
                                      x: units.gu(1.5)
                                      color: "#00FFFFFF"

                                      Row{

                                         width: units.gu(43)
                                         height: units.gu(5)
                                         anchors.verticalCenter: parent.verticalCenter
                                         spacing: units.gu(2)

                                         Button {
                                         text: "<"
                                         width:units.gu(7)
                                         onClicked: updateContentWindow(switchToPreviousDocument(aDocument), addressBar.text)
                                         color:"orange"
                                         }

                                         Button {
                                         text: "Save"
                                         onClicked: updateContentWindow(getCurrentDocumentKey(aDocument.contents),addressBar.text)
                                         color:"orange"
                                         }
                                         Button {
                                         text: ">"
                                         width:units.gu(7)
                                         onClicked: updateContentWindow(switchToNextDocument(aDocument), addressBar.text)
                                         color:"orange"
                                         }



                                      }

                                  }

                                  Rectangle {

                                    id: addressBarArea

                                    width: units.gu(48)
                                    height: units.gu(5)
                                    anchors.top: parent.top

                                    TextField {

                                            id: addressBar

                                            width: parent.width
                                            anchors.verticalCenter: parent.verticalCenter
                                            x: units.gu(1)


                                            hasClearButton: false

                                            /*!
                                                There is an object within in the 'aDocument' model defined earlier called 'contents', which contains a key called 'helloworld', which represents a search string.  In our example the key will represent the name of a document in the database, which will be displayed in the address bar. Displaying the key is demonstrated here:

                                            text: displayKey(aDocument.contents)

                                            function displayKey(documentObject){

                                                var keys = Object.keys(documentObject);

                                                return keys[0]

                                            }

                                            */

                                            text: getCurrentDocumentKey(aDocument.contents)


                                            onAccepted: {

                                                onClicked: updateContentWindow(getCurrentDocumentKey(aDocument.contents),addressBar.text)

                                            }
                                        }
                                }
    }
    }





    Item {
        id: container

        clip: true

        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
    }

    // tip
    UbuntuShape {
        id: tip

        visible: page.bottomEdgeEnabled
        color: Qt.rgba(0.0, 0.0, 0.0, 0.3)

        // Size from the official PageWithBottomEdge component
        width: tipLabel.paintedWidth + units.gu(6)
        height: units.gu(4)

        y: page.height - units.gu(3) + (bottomEdge.height - bottomEdge.position)
        anchors.horizontalCenter: parent.horizontalCenter

        Label {
            id: tipLabel

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }
            text: "test"

            fontSize: "x-small"
            height: units.gu(2)
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }

    // bottom edge panel
    Panel {
        id: bottomEdge

        enabled: page.bottomEdgeEnabled
        visible: page.bottomEdgeEnabled
        locked: !page.bottomEdgeEnabled

        height: units.gu(10)

        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }


        Rectangle {
            height: 1
            color: "black"
            opacity: bottomEdgePageOpacity * (page.height - bottomEdge.position) / page.height

            anchors.fill: parent
        }

        Item {
            id: bottomEdgeContainer

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                //bottom: closeButton.top
            }
        }
        Button {
        text: "Help"
        onClicked: updateContentWindow(getCurrentDocumentKey(aDocument.contents),'date')
        color:"orange"
        }



    }
}
