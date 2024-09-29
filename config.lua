Config = {}

-- Framework
Config.Framework = "qbcore" -- "esx" veya "qbcore" olarak ayarlanabilir

-- GPS Item
Config.GPSEquipment = "gps" -- GPS eşyasının adı

-- Inventory
Config.InventorySystem = "esx" -- "qbcore", "ox_inventory", "esx", "other_inventory" (diğer sistemler için düzenlenebilir)

-- Notify
Config.NotifySystem = "qbcore" -- "qbcore", "esx" veya "other" olarak ayarlanabilir

-- Minimap
Config.MinimapEnabled = true -- true yaparsanız minimap her zaman açık olur, false yaparsanız minimap kapalı kalır.

-- Notify
Config.Messages = {
    NoGPS = "GPS cihazınız yok!",         --- You don't have GPS
    GPSActivated = "GPS cihazı aktif!",   --- GPS activated
}
