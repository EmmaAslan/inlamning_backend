var express = require("express");
var router = express.Router();

router.get("/", async function (req, res) {
  const db = req.app.locals.db;

  const sql = `
 SELECT DISTINCT ON (game.name)
 game.name as game_name,
 game.url_slug,
 highscore.game_id as game_id,
 highscore.player_name as player_name,
 highscore.score_date as score_date,
 highscore.score as score
FROM game
INNER JOIN highscore
       ON highscore.game_id = game.id
ORDER BY game.name, highscore.score DESC 
`;

  const result = await db.query(sql);

  res.render("index", {
    title: "Highscore",
    allHighscores: result.rows,
  });
});

module.exports = router;
