const { getDB } = require("../config/db");


const getLastDay = (year, month) => {
  // 2월 처리
  if (month === 2) {
    return (year % 4 === 0 && (year % 100 !== 0 || year % 400 === 0)) ? 29 : 28;
  }

  // 1월 ~ 7월
  if (month <= 7) {
    return (month % 2 === 1) ? 31 : 30;
  } else {
    // 8월 이후
    return (month % 2 === 0) ? 31 : 30;
  }
};



const getDiariesByMonth= async (userId, year, month) => {
    const startOfMonth = `${year}-${String(month).padStart(2, '0')}-01`;
    const endOfMonth = `${year}-${String(month).padStart(2, '0')}-${getLastDay(year, month)}`;
    const db = getDB("emotionDiary");
    const collection = db.collection("diaries");

    const diaries = await collection
      .find({
        userId: userId, // 사용자 ID로 필터링
        date: {
          $gte: startOfMonth, // 시작 날짜 이상
          $lte: endOfMonth,   // 종료 날짜 이하
        },
      })
      .sort({ date: 1 }) // 날짜순 정렬
      .toArray(); // 결과를 배열로 변환

    return diaries;
};

module.exports = { getDiariesByMonth };