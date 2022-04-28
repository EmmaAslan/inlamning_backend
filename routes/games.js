//DETALJSIDAN FÖR VARJE SPEL

var express = require('express');
var router = express.Router();

router.get('/:urlSlug', async function(req, res) {

  const urlSlug = req.params.urlSlug;
  //const games = req.app.locals.games;
 const db = req.app.locals.db;

 const sql = `
 SELECT id,
        name,
        description,
        genre,
        image_url,
        release_year,
        url_slug
    FROM game
    WHERE url_slug = $1
  `;

  const result = await db.query(sql, [urlSlug]);

  const game = result.rows[0];

  const sql2 = `
  SELECT id,
        game,
        player_name,
        score_date,
        score
    FROM highscore
    ORDER BY highscore.score DESC
  `;

  // WHERE highscore.game = $1
  // 



  // const sql2 = `
  // SELECT game.name as game_name,
  //        highscore.game as highscore_game,
  //        highscore.player_name as highscore_player_name,
  //        highscore.score_date as highscore_score_date,
  //        highscore.score as highscore_score
  //   FROM game
  //   INNER JOIN game_highscore
  //           ON game_highscore.game_id = game.id
  //   INNER JOIN highscore
  //           ON highscore.id = game_highscore.highscore_id
  //     WHERE game.url_slug = $1
  //     ORDER BY highscore.score;
  // `
  const result2 = await db.query(sql2);
 // const highscores = result2.rows[0];

  res.render('games/details', { 
      title: game.name, 
      game,
      highscore: result2.rows
      // highscores
    });
});

module.exports = router;