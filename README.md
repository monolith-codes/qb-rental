# **qb-rental**

## **Vehicle rental system for the QBCore Framework**

**Dependencies:**
 - [qb-core](https://github.com/qbcore-framework/qb-core)
 - [qb-target](https://github.com/qbcore-framework/qb-target)
 - [qb-menu](https://github.com/qbcore-framework/qb-menu)
 - onesync enabled
 
**Installation:** 
 - git clone repository into your resource folder
 - add ensure qb-rental into your server.cfg

**Configuration:**

    Config.Rentals  = {
	    [0] = {
		    id  =  "gokart",
		    pedhash  =  "a_m_y_business_03",
		    title  =  "GoKart",
		    icon  =  "fas fa-box-circle-check",
		    event  =  "",
		    spawnpoint  =  vector4(-342.1813, -1954.3203, 21.6034, 52.3220),
		    carspawn  =  vector4(109.9739, -1088.61, 28.302, 345.64),
		    vehiclelist  =  "gokart"
	    }
    }
    
    Config.VehicleList  = {
	    ["gokart"] = {
		    [0] = {
			    name  =  "GoKart 2",
			    model  =  "kart",
			    price  =  1000,
			    returnprice  =  200,
		    },
		    [1] = {
			    name  =  "GoKart 1",
			    model  =  "kart",
			    price  =  550,
			    returnprice  =  100,
		    },
	    }
    }
