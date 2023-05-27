const express = require('express');
const multer = require('multer');
let upload = multer({dest:'property/'});

const fs = require('fs');

const app = express();

const crypto = require('crypto');

const cookieSession = require('cookie-session');

let mysql = require('mysql');
const path = require('path');

let filenameToUpload = [
    {name: 'image_01', maxCount: 1},
    {name: 'image_02', maxCount: 1},
    {name: 'image_03', maxCount: 1},
    {name: 'image_04', maxCount: 1},
    {name: 'image_05', maxCount: 1},
];

app.set("view engine", "ejs");
app.set("views", "views");

//serve static
app.use("/css", express.static(__dirname+"/css")); 
app.use("/js", express.static(__dirname+"/js")); 
app.use("/property", express.static(__dirname+"/property")); 
app.use("/asset", express.static(__dirname+"/asset"));

app.use(express.urlencoded({extends: true}));
app.use(express.json());

//middle ware
app.use(cookieSession({
    name: 'session',
    keys: ['key1', 'key2', 'key3', 'key4'],
    maxAge: 26*60*60*100
}));

app.get("/", (req,res)=>{

    let conn=mysql.createConnection({
        host:"localhost",
        user:"root",
        password:"",
        database:"property"
    });

    conn.connect((err) =>{
        if(err) throw err;

        let conn=mysql.createConnection({
            host:"localhost",
            user:"root",
            password:"",
            database:"property"
        });

        conn.query(`SELECT * FROM properties`, (err, result, fields) =>{
            if(err) throw err;
            // console.log(result);
            res.status = 200;
            res.render("property_view",{prop: result});
        });
        
    });
});

app.get("/search", (req, res)=>{

    let keyword = req.query.keyword;

    let conn=mysql.createConnection({
        host:"localhost",
        user:"root",
        password:"",
        database:"property"
    });
    
    let sql = `SELECT * FROM properties WHERE real_estate_name LIKE '\%${keyword}\%' OR LOCATION LIKE '\%${keyword}\%' OR property_type LIKE '\%${keyword}\%' ;`
    conn.connect((err) =>{
        if(err) throw err;
        conn.query(sql, (err, result, fields) =>{
            if(err) throw err;
            // console.log(result);
            res.status = 200;
            res.render("property_view",{prop: result});
        });
    });

});



app.get("/property_detail/:id", (req, res)=>{

    let id = req.params.id || 0;
    let conn = mysql.createConnection({host: "localhost", user: "root",database: "property"});

    conn.connect(function(err) {
        if (err) throw err;
        
        let sql = "SELECT * FROM properties INNER JOIN users ON properties.owner_id = users.id_user WHERE id = "+id;
        conn.query(sql, function (err, result, fields) {
            if (err) throw err;
            res.render('property_detail', {item: result[0]});
            conn.end();
        });
    });

});

app.get("/login",(req, res)=>{

    let login_status = req.query.login_status;

    let status = {loginMess:""};

    if(login_status == 2)
    {
        status.loginMess="!!Log in fail!!";
    }

    res.render("login",{item:status});
    res.end();
});

app.post("/login", (req, res)=>{
    let email = req.body.email;
    let password = req.body.password;
    const hash = crypto.createHash('sha256').update(password).digest('base64');
    
    //check email and password

    let conn=mysql.createConnection({
        host:"localhost",
        user:"root",
        password:"",
        database:"property"
    });

    conn.connect((err) =>{
        if(err) throw err;
        let sqlCheck = `SELECT * FROM users WHERE email = ? AND password = ? `
        conn.query(sqlCheck,[email, hash] ,(err, result, fields) =>{
            if(err) throw err;
            if(result.length == 1)
            {
                req.session.username = result[0].name;
                req.session.userrole = result[0].role;
                req.session.email = result[0].email;
                req.session.userId = result[0].id_user;

                res.redirect("/dashboard");
                conn.end();
                res.end();
            }
            else
            {
                res.redirect("/login?login_status=2");
                conn.end();
                res.end();
            }          
        });
    });
});

app.get("/logout" , (req, res)=>{
    req.session = null;
    res.redirect('/');
});

app.get("/register",(req, res)=>{

    let ris_status = req.query.ris_status || 0;

    let status = {
        emailUsed:""
    }

    if(ris_status == 2){
        status.emailUsed="This email have been used!"
        res.render("register",{item:status});
        res.end();
    }
    else{
        res.render("register",{item:status});
        res.end();
    }
    
});


app.post("/register",(req, res) =>{

    let conn=mysql.createConnection({
        host:"localhost",
        user:"root",
        password:"",
        database:"property"
    });

    let email =req.body.email || "";
    let password = req.body.password || "";
    let name = req.body.name || "";
    let telephone = req.body.telephone || "";

    //check not same email
    let sqlCheck = `SELECT * from users WHERE email = ?`;

    conn.connect((err) =>{
        if(err) throw err;
        conn.query(sqlCheck,[email] ,(err, result, fields) =>{
            if(err) throw err;
            if(result.length > 0)
            {
                res.redirect("/register?ris_status=2");
            }
            else
            {
                const hash = crypto.createHash('sha256').update(password).digest('base64');
                let sql = `INSERT INTO users (id ,email, password, name, telephone, role) VALUES (0 ,?, ?, ?, ?, 'user');`
                
                    conn.query(sql,[email, hash, name, telephone], (err, result) =>{
                        if(err) throw err;
                        res.status = 200;
                        res.render("regis_success");
                        conn.end();
                        res.end();
                    });     
            }          
        });
    });
    
});

app.get('/dashboard', (req, res) => {
	let name = req.session.username;
	let role = req.session.userrole;

	if(name !== undefined) {

	    res.render('dashboard/index', {name: name, role: role});
	}
	else {

	    res.redirect('/');
	}
});

app.get('/dashboard/user', (req, res) => {
	let email = req.session.email;
	let role = req.session.userrole;
	if(email !== undefined) {

        let sqlCheck ="";
        if(role == 'admin')
        {
            sqlCheck = `SELECT * FROM users ORDER BY id_user`
        }
        else
        {
            sqlCheck = `SELECT * FROM users WHERE email =? ORDER BY id_user`;
        }


        let conn = mysql.createConnection({
            host: "localhost", 
            user: "root",
            database: "property"
        });

		conn.connect(function(err) {
			if (err) throw err;
			// let sql = "SELECT * FROM users WHERE email =?";
			conn.query(sqlCheck, [email], function (err, result, fields) {
				if (err) throw err;
				res.render('dashboard/user_manage', {role: role, users:result});
				conn.end();
			});
		});
	}
	else {
		res.redirect('/');
	}
});

app.post('/dashboard/user/edit', (req, res) => {
    let conn = mysql.createConnection(
        {host: "localhost", 
        user: "root",
        database: "property"
    });
    let id = req.body.id || 0;
    let newrole = req.body.newrole || '';
    
    conn.connect(function(err) {
        if (err) throw err;
        let sql = `UPDATE users SET role = ? WHERE id_user = ?;`
        conn.query(sql,[newrole, id], function (err, result) {
            if (err) throw err;
            res.redirect('/dashboard/user');
            conn.end();
        });
    });
});

app.get('/dashboard/property', (req, res) => {
	let email = req.session.email;
	let role = req.session.userrole;
	
	if(email !== undefined) {
        let conn = mysql.createConnection({
            host: "localhost", 
            user: "root",
            database: "property"
        });

        conn.connect((err)=>{
            if (err) throw err;
            let sql = "SELECT * FROM properties";

            if(role != "admin") {
                sql = "SELECT * FROM properties WHERE owner_id = \"" + req.session.userId+ "\"";
            }

            conn.query(sql, function (err, result, fields) {
                if (err) throw err;
                res.render('dashboard/property_manage', {role: role, items: result});
                conn.end();
            });
        });
	}
	else {
		res.redirect('/');
	}
});

app.get('/dashboard/property/edit', (req, res) => {
    let email = req.session.email;
    let role = req.session.userrole;
    let id = req.query.id || 0;

    if(email !== undefined) {
        let conn = mysql.createConnection({
            host: "localhost", 
            user: "root",
            database: "property"
        });

    conn.connect((err) => {
        if (err) throw err;
        let sql = "SELECT * FROM properties WHERE id = " + id;
        conn.query(sql, function (err, result, fields) {
            if (err) throw err;
            res.render('dashboard/property_manage_edit', {item: result[0]});
            conn.end();
        });
    });
       
    }
    else {
        res.redirect('/');
    }
});

app.post('/dashboard/property/edit', (req, res) => {
    let conn = mysql.createConnection({host: "localhost", user: "root",
     database: "property"
    });
    
    let id = req.body.id || 0;
    let real_estate_name = req.body.real_estate_name || '';
    let lat = req.body.lat || 0;
    let lon = req.body.lon || 0;
    let LOCATION = req.body.LOCATION || '';
    let property_type = req.body.property_type || '';
    let TRANSACTION = req.body.TRANSACTION || '';
    let SALE_TERMS = req.body.SALE_TERMS || '';
    let SALE_PRICE = req.body.SALE_PRICE || 0;
    let RENT_PRICE = req.body.RENT_PRICE || 0;
    let COMMON_CHARGES = req.body.COMMON_CHARGES || 0;
    let DECORATION_STYLE = req.body.DECORATION_STYLE || '';
    let BEDROOMS = req.body.BEDROOMS || 0;
    let BATHROOMS = req.body.BATHROOMS || 0;
    let DIRECTION_OF_ROOM = req.body.DIRECTION_OF_ROOM || '';
    let UNIT_SIZE = req.body.UNIT_SIZE || 0;
    let LAND_AREA = req.body.LAND_AREA || 0;
    let INROOM_FACILITIES = req.body.INROOM_FACILITIES || '';
    let PUBLIC_FACILITIES = req.body.PUBLIC_FACILITIES || '';

    conn.connect(function(err) {
        if (err) throw err;
        let sql =   `UPDATE properties SET real_estate_name = ?, lat = ?, lon = ?, LOCATION = ?, property_type = ?, TRANSACTION = ?, SALE_TERMS = ?, SALE_PRICE = ?, RENT_PRICE = ?, COMMON_CHARGES = ?, DECORATION_STYLE = ?, BEDROOMS = ?, BATHROOMS = ?, DIRECTION_OF_ROOM = ?, UNIT_SIZE = ?, LAND_AREA = ?, INROOM_FACILITIES = ?, PUBLIC_FACILITIES = ?  WHERE id = ?;`
        let values = [real_estate_name, parseFloat(lat), parseFloat(lon), LOCATION, property_type, TRANSACTION , SALE_TERMS, parseFloat(SALE_PRICE), parseFloat(RENT_PRICE), parseFloat(COMMON_CHARGES), DECORATION_STYLE, parseInt(BEDROOMS), parseInt(BATHROOMS), DIRECTION_OF_ROOM, parseFloat(UNIT_SIZE), parseFloat(LAND_AREA), INROOM_FACILITIES, PUBLIC_FACILITIES, id]

        conn.query(sql, values, function (err, result) {
            if (err) throw err;
            res.redirect('/dashboard/property/edit?id='+id);
            conn.end();
        });
    });
       
});

app.get('/dashboard/property/create', (req, res) => {
	let email = req.session.email;
	if(email !== undefined) {
		res.render('dashboard/property_manage_create');
	}
	else {
		res.redirect('/');
	}
});

app.post('/dashboard/property/create',upload.fields(filenameToUpload) ,(req, res) => {

    let conn = mysql.createConnection({host: "localhost", user: "root",database: "property"});

    conn.connect( (err) => {
        let sql1 = `SELECT * FROM properties ORDER BY id DESC LIMIT 0,1;`;
        conn.query(sql1, (err, result1, fields) =>{
            if(err) throw err;
            let lastestProd_id = parseInt(result1[0].id)+1;
            let dir = `./property/${lastestProd_id}_prop_id`;

            //create new directory
            if (!fs.existsSync(dir)){
                fs.mkdirSync(dir, { recursive: true });
            }

            let targetPath1 = path.join(__dirname,dir+"/"+req.files.image_01[0].originalname);
            let targetPath2 = path.join(__dirname,dir+"/"+req.files.image_02[0].originalname);
            let targetPath3 = path.join(__dirname,dir+"/"+req.files.image_03[0].originalname);
            let targetPath4 = path.join(__dirname,dir+"/"+req.files.image_04[0].originalname);
            let targetPath5 = path.join(__dirname,dir+"/"+req.files.image_05[0].originalname);

            let file_01 =`${lastestProd_id}_prop_id`+"/" + req.files.image_01[0].originalname;
            let file_02 =`${lastestProd_id}_prop_id`+"/" + req.files.image_02[0].originalname;
            let file_03 =`${lastestProd_id}_prop_id`+"/" + req.files.image_03[0].originalname;
            let file_04 =`${lastestProd_id}_prop_id`+"/" + req.files.image_04[0].originalname;
            let file_05 =`${lastestProd_id}_prop_id`+"/" + req.files.image_05[0].originalname;

            let id = req.body.id || 0;
            let real_estate_name = req.body.real_estate_name || '';
            let lat = req.body.lat || 0;
            let lon = req.body.lon || 0;
            let LOCATION = req.body.LOCATION || '';
            let property_type = req.body.property_type || '';
            let TRANSACTION = req.body.TRANSACTION || '';
            let SALE_TERMS = req.body.SALE_TERMS || '';
            let SALE_PRICE = req.body.SALE_PRICE || 0;
            let RENT_PRICE = req.body.RENT_PRICE || 0;
            let COMMON_CHARGES = req.body.COMMON_CHARGES || 0;
            let DECORATION_STYLE = req.body.DECORATION_STYLE || '';
            let BEDROOMS = req.body.BEDROOMS || 0;
            let BATHROOMS = req.body.BATHROOMS || 0;
            let DIRECTION_OF_ROOM = req.body.DIRECTION_OF_ROOM || '';
            let UNIT_SIZE = req.body.UNIT_SIZE || 0;
            let LAND_AREA = req.body.LAND_AREA || 0;
            let INROOM_FACILITIES = req.body.INROOM_FACILITIES || '';
            let PUBLIC_FACILITIES = req.body.PUBLIC_FACILITIES || '';

            let image_01 = file_01 || '';
            let image_02 = file_02 || '';
            let image_03 = file_03 || '';
            let image_04 = file_04 || '';
            let image_05 = file_05 || '';
            let owner_id = req.session.userId;
            
            //upload file1
            if (path.extname(req.files.image_01[0].originalname).toLowerCase() === ".png" ||
                path.extname(req.files.image_01[0].originalname).toLowerCase() === ".jpg" ||
                path.extname(req.files.image_01[0].originalname).toLowerCase() === ".jpeg" ) 
            {
                fs.rename(req.files.image_01[0].path, targetPath1, err => {
                    if (err) return handleError(err, res);
                   
                });
            } 
            else 
            {
                fs.unlink(tempPath, err => {
                    if (err) return handleError(err, res);
                });
            }

             //upload file2
             if (path.extname(req.files.image_02[0].originalname).toLowerCase() === ".png" ||
             path.extname(req.files.image_02[0].originalname).toLowerCase() === ".jpg" ||
             path.extname(req.files.image_02[0].originalname).toLowerCase() === ".jpeg" ) 
            {
                fs.rename(req.files.image_02[0].path, targetPath2, err => {
                    if (err) return handleError(err, res);
                });
            } 
            else 
            {
                fs.unlink(tempPath, err => {
                    if (err) return handleError(err, res);
                });
            }

            //upload file3
            if (path.extname(req.files.image_03[0].originalname).toLowerCase() === ".png" ||
            path.extname(req.files.image_03[0].originalname).toLowerCase() === ".jpg" ||
            path.extname(req.files.image_03[0].originalname).toLowerCase() === ".jpeg" ) 
            {
                fs.rename(req.files.image_03[0].path, targetPath3, err => {
                    if (err) return handleError(err, res);
                });
            } 
            else 
            {
                fs.unlink(tempPath, err => {
                    if (err) return handleError(err, res);
                });
            }

            //upload file4
            if (path.extname(req.files.image_04[0].originalname).toLowerCase() === ".png" ||
            path.extname(req.files.image_04[0].originalname).toLowerCase() === ".jpg" ||
            path.extname(req.files.image_04[0].originalname).toLowerCase() === ".jpeg" ) 
            {
                fs.rename(req.files.image_04[0].path, targetPath4, err => {
                    if (err) return handleError(err, res);
                });
            } 
            else 
            {
                fs.unlink(tempPath, err => {
                    if (err) return handleError(err, res);
                });
            }

            //upload file5
            if (path.extname(req.files.image_05[0].originalname).toLowerCase() === ".png" ||
            path.extname(req.files.image_05[0].originalname).toLowerCase() === ".jpg" ||
            path.extname(req.files.image_05[0].originalname).toLowerCase() === ".jpeg" ) 
            {
                fs.rename(req.files.image_05[0].path, targetPath5, err => {
                    if (err) return handleError(err, res);
                });
            } 
            else 
            {
                fs.unlink(tempPath, err => {
                    if (err) return handleError(err, res);
                });
            }

            let sql = "INSERT INTO properties " +
            "(real_estate_name, lat, lon, LOCATION, " +
            "property_type, TRANSACTION, SALE_TERMS, SALE_PRICE, " +
            "RENT_PRICE, COMMON_CHARGES, DECORATION_STYLE, " +
            "BEDROOMS, BATHROOMS, DIRECTION_OF_ROOM, UNIT_SIZE, " +
            "LAND_AREA, INROOM_FACILITIES, PUBLIC_FACILITIES, " +
            "image_01, image_02, image_03, image_04, image_05, " +
            "owner_id) VALUES ?";
        
            let values = [[real_estate_name, lat, lon, LOCATION,
            property_type, TRANSACTION, SALE_TERMS, SALE_PRICE,
            RENT_PRICE, COMMON_CHARGES, DECORATION_STYLE,
            BEDROOMS, BATHROOMS, DIRECTION_OF_ROOM, UNIT_SIZE,
            LAND_AREA, INROOM_FACILITIES, PUBLIC_FACILITIES,
            image_01, image_02, image_03, image_04, image_05,
            owner_id]];
        
            conn.query(sql, [values], function (err, result) {
                if (err) throw err;
                res.redirect('/dashboard/property');
                conn.end();
            });
            
        });
    });

});

app.listen(8080, ()=>{
    console.log("app start...");
});

