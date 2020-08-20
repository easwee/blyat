static func get_modifier_gfx(type: int):
	return ColorN(Globals.BRICK_TYPE_COLOR[type], 1)

static func create_save():
   Globals.storage.open(Globals.storage_path, File.WRITE)
   Globals.storage.store_var(Globals.storage_data)
   Globals.storage.close()

static func read_save():
   Globals.storage.open(Globals.storage_path, File.READ)
   var save_data = Globals.storage.get_var()
   Globals.storage.close()
   return save_data["highscore"]

static func save(high_score):    
   Globals.storage_data["highscore"] = high_score
   Globals.storage.open(Globals.storage_path, File.WRITE)
   Globals.storage.store_var(Globals.storage_data)
   Globals.storage.close()
