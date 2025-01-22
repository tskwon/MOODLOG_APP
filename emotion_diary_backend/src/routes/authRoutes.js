/*
const express = require("express");
const apiUserController = require('../controllers/userController');
const upload = require('../config/multer');

const router = express.Router();


//router.post('/register', upload.single('profileImage'),apiUserController.register);
router.post('/register', upload.single('profileImage'), (req, res, next) => {
    console.log("Request Body:", req.body);
    console.log("Uploaded File:", req.file);
    next();
  }, apiUserController.register);
router.post('/login', apiUserController.login);


router.post('/login', apiUserController.login);

// router.post('/api/user/my', apiUserController.update);
// router.get('/api/user/my', apiUserController.show);

module.exports = router;
*/
const express = require("express");
const apiUserController = require("../controllers/userController");
const upload = require("../config/multer");

const router = express.Router();

router.post(
  "/register",
  upload.single("profileImage"), 
  (req, res, next) => {
    console.log("Request Body:", req.body); 
    console.log("Uploaded File:", req.file); 
    next(); 
  },
  apiUserController.register 
);

router.post("/login", apiUserController.login);

module.exports = router;
