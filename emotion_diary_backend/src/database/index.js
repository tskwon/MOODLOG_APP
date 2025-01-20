const mongoose = require('mongoose');

let connection = null;

exports.connect = async () => {
  if (connection) return connection;

  try {
    //const uri = `mongodb://${process.env.DB_USERNAME}:${encodeURIComponent(process.env.DB_PASSWORD)}@${process.env.DB_HOST}:${process.env.DB_PORT}/${process.env.DB_DATABASE}`;
    //connection = await mongoose.connect(`mongodb://${process.env.DB_HOST}:${process.env.DB_PORT}/${process.env.DB_DATABASE}`, 
    const url = process.env.DB_DATABASE_URL;
    connection = await mongoose.connect(url,
    {
      //useNewUrlParser: true,
      //useUnifiedTopology: true,
      maxPoolSize: 10, // 연결 풀 크기 설정
    });
    console.log('MongoDB 연결 성공');
    return connection;
  } catch (error) {
    console.error('MongoDB 연결 실패:', error);
    throw error;
  }
};

