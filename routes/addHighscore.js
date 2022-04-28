//SIDA FÖR ATT LÄGGA TILL NYTT HIGHSCORE

var express = require('express');
var router = express.Router();

router.get('/', function(req, res, next) {

  res.render('admin/score/new', { 
      title: 'Lägg till highscore',
      allScores: {}
    });
});

module.exports = router;