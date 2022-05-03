var express = require("express");
var router = express.Router();

// GET ex. /games/tetris
router.get("/:urlSlug", async function (req, res) {
  const urlSlug = req.params.urlSlug;

  const db = req.app.locals.db;

  const sql = `
  SELECT game.id,
        game.name as game_name,
        game.description as description,
        game.genre as genre,
        game.image_url as image_url,
        game.release_year as release_year,
        game.url_slug as url_slug
    FROM game
    WHERE url_slug = $1
  `;

  const result = await db.query(sql, [urlSlug]);

  const game = result.rows[0];

  const sql2 = `
SELECT game.name as game_name,
          highscore.game_id as highscore_game,
          highscore.player_name as highscore_player_name,
          highscore.score_date as highscore_score_date,
          highscore.score as highscore_score
     FROM game
     INNER JOIN highscore
             ON highscore.game_id = game.id      
       WHERE game.url_slug = $1
       ORDER BY highscore.score DESC LIMIT 10;
`;

  const result2 = await db.query(sql2, [urlSlug]);

  res.render("games/details", {
    title: game.name,
    game,
    highscore: result2.rows,
  });
});

module.exports = router;
