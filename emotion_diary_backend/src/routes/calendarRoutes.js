const express = require("express");
const { getDiariesController } = require("../controllers/calendarController");

const router = express.Router();

router.get("/calendar", getDiariesController);

module.exports = router;
