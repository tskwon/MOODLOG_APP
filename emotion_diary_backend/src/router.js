const express = require(`express`);
const router = express.Router();

const multer = require(`multer`);
const upload = require('../src/config/multer');
//const authenticateToken = require('./middleware/authenticate');


/*아래는 controller 추가시 path에 맞게 재작성 부탁드립니다.*/
const webController = require('./web/controller');
//const apiFeedController = require('./api/feed');
const fileController = require('./api/file/controller');//이거 프로필 사진 관련해서 해야하는데 어떻게 작성할지 고민 중요
/*여기까지*/





const apiUserController = require('./api/user/controller');
const { logRequestTime } = require('./middleware/log')//이거 응답 레이턴시 관련서 보실거면 저희 실습때 했던 log파일 넣어서 돌리시면 됨
router.use(logRequestTime);

router.get('/',webController.home);
//router.post('/auth/register', apiUserController.register);
router.post('/auth/register',upload.single('profileImage'), apiUserController.register);
router.post('/auth/login', apiUserController.login);

//router.use(authenticateToken);

router.get('/api/user/my', apiUserController.show);
//router.post('/api/user/my', apiUserController.update);
router.post('/api/user/my',upload.single('profileImage'),apiUserController.update);

module.exports = router;