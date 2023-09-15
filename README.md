# **qb-rental**

### **Vehicle rental system for the QBCore Framework**

 <img width=500px  src="https://i.imgur.com/t6AI4C2.jpg" alt="Alt Text"/>

**Dependencies:**
 - [qb-core](https://github.com/qbcore-framework/qb-core)
 - [qb-target](https://github.com/qbcore-framework/qb-target)
 - [qb-menu](https://github.com/qbcore-framework/qb-menu)
 - onesync must be enabled
 
**Features:**
 - rent vehicles and turn them back to get a deposit back
 - multiple rent npcs with custom vehicle list
 - server sided vehicle spawning
 - vehicle spawnslot system
 - 0ms resmon
 - language support

**Installation:** 
 - git clone repository into your resource folder
 - add ensure qb-rental into your server.cfg

**Configuration:**

    Config.Rentals  = {
		[1] = {
		 	id  =  "normal_01",
			pedhash  =  "a_m_y_business_03",
			title = "Normal Vehicle Rental",
			icon  =  "fas fa-box-circle-check",
			event  =  "",
			spawnpoint = vector4(x,y,z,h),
			carspawns = {
				[1] = vector4(x,y,z,h),
			        [2] = vector4(x,y,z,h),
			        [3] = vector4(x,y,z,h),
			},
			vehiclelist  =  "vehlist01"
		},
		[2] = {
			id  =  "normal_02",
			pedhash  =  "a_m_y_business_03",
		        title = "Normal Vehicle Rental",
			icon  =  "fas fa-box-circle-check",
			event  =  "",
		        spawnpoint = vector4(x,y,z,h),
			carspawns = {
				[1] = vector4(x,y,z,h),
		            	[2] = vector4(x,y,z,h),
		            	[3] = vector4(x,y,z,h),
			},
			vehiclelist  =  "vehlist01"
		}
    }
    Config.VehicleList  = {
		["vehlist01"] = {
			[1] = {
				name = "Car 1",
				model  =  "car1",
				price  =  1000,
				returnprice  =  200,
			},
			[2] = {
				name  =  "Car 2",
				model  =  "car2",
				price  =  550,
				returnprice  =  100,
			},
		},
		["vehlist02"] = {
			[1] = {
				name = "Car 3",
				model  =  "car3",
				price  =  1000,
				returnprice  =  200,
			},
			[2] = {
				name  =  "Car 2",
				model  =  "car2",
				price  =  550,
				returnprice  =  100,
			},
		}
    }
