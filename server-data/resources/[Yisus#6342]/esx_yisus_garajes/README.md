 if you want the impound of police and mecano to work, paste those lines when you take your duty:

 ```
exports.ft_libs:EnableArea("esx_eden_garage_area_police_mecanodeletepoint")
exports.ft_libs:EnableArea("esx_eden_garage_area_police_mecanospawnpoint")
exports.ft_libs:EnableArea("esx_eden_garage_area_Bennys_mecanodeletepoint")
exports.ft_libs:EnableArea("esx_eden_garage_area_Bennys_mecanospawnpoint")
```

 and offduty:
```
exports.ft_libs:DisableArea("esx_eden_garage_area_police_mecanodeletepoint")
exports.ft_libs:DisableArea("esx_eden_garage_area_police_mecanospawnpoint")
exports.ft_libs:DisableArea("esx_eden_garage_area_Bennys_mecanodeletepoint")
exports.ft_libs:DisableArea("esx_eden_garage_area_Bennys_mecanospawnpoint")
```