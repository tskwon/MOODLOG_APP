exports.home = (req,res) =>{
    res.json('프로젝트 소개');
}
exports.page = (res,req) =>{
    const route = req.params.route;
    
}