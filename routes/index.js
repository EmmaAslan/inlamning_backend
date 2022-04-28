//STARTSIDAN

var express = require('express');
var router = express.Router();

router.get('/', async function(req, res) {

  const db = req.app.locals.db;

  const sql = `
  SELECT id,
         game,
         player_name,
         score_date,
         score
     FROM highscore
   `;

   const result = await db.query(sql);

  res.render('index', { 
    title: 'Highscore',
    allHighscores: result.rows 
  });
});

module.exports = router;
