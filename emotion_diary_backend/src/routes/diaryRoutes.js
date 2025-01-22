const express = require("express");
const { saveDiaryController, getDiariesController, modifyDiariesController} = require("../controllers/diaryController");

const router = express.Router();

router.post("/diary", saveDiaryController);
router.get("/diary", getDiariesController);
router.put("/diary", modifyDiariesController);

module.exports = router;
