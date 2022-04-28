//SIDA FÖR ATT LÄGGA TILL NYTT SPEL

var express = require('express');
var router = express.Router();

router.get('/', function(req, res, next) {

  res.render('admin/games/new', { 
      title: 'Lägg till spel' ,
      allGames: {}
    });
});

module.exports = router;