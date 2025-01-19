const { connect } = require('./index');

exports.query = async (model, operation, ...args) => {
  try {
    await connect();
    const result = await model[operation](...args);
    return result;
  } catch (error) {
    console.error('MongoDB 쿼리 실패:', error);
    throw error;
  }
};
