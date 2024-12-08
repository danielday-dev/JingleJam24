{
  "resourceType": "GMRoom",
  "resourceVersion": "1.0",
  "name": "rm_win",
  "creationCodeFile": "rooms/rm_win/RoomCreationCode.gml",
  "inheritCode": false,
  "inheritCreationOrder": false,
  "inheritLayers": false,
  "instanceCreationOrder": [
    {"name":"inst_6084FDCE_1","path":"rooms/rm_win/rm_win.yy",},
    {"name":"inst_7A4FFBA3","path":"rooms/rm_win/rm_win.yy",},
    {"name":"inst_33B67E3D","path":"rooms/rm_win/rm_win.yy",},
    {"name":"inst_6343FDA4","path":"rooms/rm_win/rm_win.yy",},
    {"name":"inst_3DC89C80","path":"rooms/rm_win/rm_win.yy",},
    {"name":"inst_44AA1879","path":"rooms/rm_win/rm_win.yy",},
  ],
  "isDnd": false,
  "layers": [
    {"resourceType":"GMRInstanceLayer","resourceVersion":"1.0","name":"GUI","depth":0,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"instances":[
        {"resourceType":"GMRInstance","resourceVersion":"1.0","name":"inst_7A4FFBA3","colour":4294967295,"frozen":false,"hasCreationCode":false,"ignore":false,"imageIndex":0,"imageSpeed":1.0,"inheritCode":false,"inheritedItemId":null,"inheritItemSettings":false,"isDnd":false,"objectId":{"name":"obj_gui_roomGoto","path":"objects/obj_gui_roomGoto/obj_gui_roomGoto.yy",},"properties":[
            {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_gui_interactable_base","path":"objects/obj_gui_interactable_base/obj_gui_interactable_base.yy",},"propertyId":{"name":"text","path":"objects/obj_gui_interactable_base/obj_gui_interactable_base.yy",},"value":"Back to Main Menu",},
            {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_gui_roomGoto","path":"objects/obj_gui_roomGoto/obj_gui_roomGoto.yy",},"propertyId":{"name":"targetRoom","path":"objects/obj_gui_roomGoto/obj_gui_roomGoto.yy",},"value":"rm_menu",},
          ],"rotation":0.0,"scaleX":4.0,"scaleY":1.0,"x":224.0,"y":256.0,},
        {"resourceType":"GMRInstance","resourceVersion":"1.0","name":"inst_33B67E3D","colour":4294967295,"frozen":false,"hasCreationCode":false,"ignore":false,"imageIndex":0,"imageSpeed":1.0,"inheritCode":false,"inheritedItemId":null,"inheritItemSettings":false,"isDnd":false,"objectId":{"name":"obj_winlose_label","path":"objects/obj_winlose_label/obj_winlose_label.yy",},"properties":[
            {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_gui_interactable_base","path":"objects/obj_gui_interactable_base/obj_gui_interactable_base.yy",},"propertyId":{"name":"text","path":"objects/obj_gui_interactable_base/obj_gui_interactable_base.yy",},"value":"Time is believed to be no more.",},
          ],"rotation":0.0,"scaleX":9.333334,"scaleY":0.6875,"x":96.0,"y":96.0,},
        {"resourceType":"GMRInstance","resourceVersion":"1.0","name":"inst_6343FDA4","colour":4294967295,"frozen":false,"hasCreationCode":false,"ignore":false,"imageIndex":0,"imageSpeed":1.0,"inheritCode":false,"inheritedItemId":null,"inheritItemSettings":false,"isDnd":false,"objectId":{"name":"obj_winlose_label","path":"objects/obj_winlose_label/obj_winlose_label.yy",},"properties":[
            {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_gui_interactable_base","path":"objects/obj_gui_interactable_base/obj_gui_interactable_base.yy",},"propertyId":{"name":"text","path":"objects/obj_gui_interactable_base/obj_gui_interactable_base.yy",},"value":"You've won!",},
          ],"rotation":0.0,"scaleX":5.3333335,"scaleY":0.6875,"x":192.0,"y":64.0,},
        {"resourceType":"GMRInstance","resourceVersion":"1.0","name":"inst_3DC89C80","colour":4294967295,"frozen":false,"hasCreationCode":false,"ignore":false,"imageIndex":0,"imageSpeed":1.0,"inheritCode":false,"inheritedItemId":null,"inheritItemSettings":false,"isDnd":false,"objectId":{"name":"obj_winlose_label","path":"objects/obj_winlose_label/obj_winlose_label.yy",},"properties":[
            {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_gui_interactable_base","path":"objects/obj_gui_interactable_base/obj_gui_interactable_base.yy",},"propertyId":{"name":"text","path":"objects/obj_gui_interactable_base/obj_gui_interactable_base.yy",},"value":"Thank you for playing!!!",},
          ],"rotation":0.0,"scaleX":9.333334,"scaleY":0.6875,"x":96.0,"y":192.0,},
        {"resourceType":"GMRInstance","resourceVersion":"1.0","name":"inst_44AA1879","colour":4294967295,"frozen":false,"hasCreationCode":false,"ignore":false,"imageIndex":0,"imageSpeed":1.0,"inheritCode":false,"inheritedItemId":null,"inheritItemSettings":false,"isDnd":false,"objectId":{"name":"obj_winlose_label","path":"objects/obj_winlose_label/obj_winlose_label.yy",},"properties":[
            {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_gui_interactable_base","path":"objects/obj_gui_interactable_base/obj_gui_interactable_base.yy",},"propertyId":{"name":"text","path":"objects/obj_gui_interactable_base/obj_gui_interactable_base.yy",},"value":"But if that's so, where are we now?",},
          ],"rotation":0.0,"scaleX":9.333334,"scaleY":0.6875,"x":96.0,"y":128.0,},
      ],"layers":[],"properties":[],"userdefinedDepth":false,"visible":true,},
    {"resourceType":"GMRInstanceLayer","resourceVersion":"1.0","name":"Stars","depth":100,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"instances":[
        {"resourceType":"GMRInstance","resourceVersion":"1.0","name":"inst_6084FDCE_1","colour":4294967295,"frozen":false,"hasCreationCode":false,"ignore":false,"imageIndex":0,"imageSpeed":1.0,"inheritCode":false,"inheritedItemId":null,"inheritItemSettings":false,"isDnd":false,"objectId":{"name":"obj_starManager","path":"objects/obj_starManager/obj_starManager.yy",},"properties":[],"rotation":0.0,"scaleX":1.0,"scaleY":1.0,"x":-32.0,"y":-96.0,},
      ],"layers":[],"properties":[],"userdefinedDepth":false,"visible":true,},
    {"resourceType":"GMRBackgroundLayer","resourceVersion":"1.0","name":"Background","animationFPS":15.0,"animationSpeedType":0,"colour":4280161288,"depth":200,"effectEnabled":true,"effectType":null,"gridX":32,"gridY":32,"hierarchyFrozen":false,"hspeed":0.0,"htiled":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"inheritSubLayers":true,"inheritVisibility":true,"layers":[],"properties":[],"spriteId":null,"stretch":false,"userdefinedAnimFPS":false,"userdefinedDepth":false,"visible":true,"vspeed":0.0,"vtiled":false,"x":0,"y":0,},
  ],
  "parent": {
    "name": "Rooms",
    "path": "folders/Rooms.yy",
  },
  "parentRoom": null,
  "physicsSettings": {
    "inheritPhysicsSettings": false,
    "PhysicsWorld": false,
    "PhysicsWorldGravityX": 0.0,
    "PhysicsWorldGravityY": 10.0,
    "PhysicsWorldPixToMetres": 0.1,
  },
  "roomSettings": {
    "Height": 360,
    "inheritRoomSettings": false,
    "persistent": false,
    "Width": 640,
  },
  "sequenceId": null,
  "views": [
    {"hborder":32,"hport":720,"hspeed":-1,"hview":360,"inherit":false,"objectId":null,"vborder":32,"visible":true,"vspeed":-1,"wport":1280,"wview":640,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":768,"hspeed":-1,"hview":768,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":1366,"wview":1366,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":768,"hspeed":-1,"hview":768,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":1366,"wview":1366,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":768,"hspeed":-1,"hview":768,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":1366,"wview":1366,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":768,"hspeed":-1,"hview":768,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":1366,"wview":1366,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":768,"hspeed":-1,"hview":768,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":1366,"wview":1366,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":768,"hspeed":-1,"hview":768,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":1366,"wview":1366,"xport":0,"xview":0,"yport":0,"yview":0,},
    {"hborder":32,"hport":768,"hspeed":-1,"hview":768,"inherit":false,"objectId":null,"vborder":32,"visible":false,"vspeed":-1,"wport":1366,"wview":1366,"xport":0,"xview":0,"yport":0,"yview":0,},
  ],
  "viewSettings": {
    "clearDisplayBuffer": true,
    "clearViewBackground": false,
    "enableViews": true,
    "inheritViewSettings": false,
  },
  "volume": 1.0,
}