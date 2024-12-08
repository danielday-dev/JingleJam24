{
  "resourceType": "GMObject",
  "resourceVersion": "1.0",
  "name": "obj_gui_roomGoto",
  "eventList": [
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","collisionObjectId":null,"eventNum":10,"eventType":7,"isDnD":false,},
  ],
  "managed": true,
  "overriddenProperties": [
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_gui_interactable_base","path":"objects/obj_gui_interactable_base/obj_gui_interactable_base.yy",},"propertyId":{"name":"text","path":"objects/obj_gui_interactable_base/obj_gui_interactable_base.yy",},"value":"___",},
  ],
  "parent": {
    "name": "GUI",
    "path": "folders/Objects/GUI.yy",
  },
  "parentObjectId": {
    "name": "obj_gui_interactable_base",
    "path": "objects/obj_gui_interactable_base/obj_gui_interactable_base.yy",
  },
  "persistent": false,
  "physicsAngularDamping": 0.1,
  "physicsDensity": 0.5,
  "physicsFriction": 0.2,
  "physicsGroup": 1,
  "physicsKinematic": false,
  "physicsLinearDamping": 0.1,
  "physicsObject": false,
  "physicsRestitution": 0.1,
  "physicsSensor": false,
  "physicsShape": 1,
  "physicsShapePoints": [],
  "physicsStartAwake": true,
  "properties": [
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"targetRoom","filters":[
        "GMRoom",
      ],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"0","varType":5,},
  ],
  "solid": false,
  "spriteId": {
    "name": "spr_gui_interactable_base",
    "path": "sprites/spr_gui_interactable_base/spr_gui_interactable_base.yy",
  },
  "spriteMaskId": null,
  "visible": true,
}