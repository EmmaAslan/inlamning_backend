// SÖKSIDAN

var express = require('express');
var router = express.Router();

router.get('/', async function(req, res, next) {
  const searchTerm = req.query.q;

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
      WHERE name ILIKE '%' || $1 || '%'
  `;

  const result = await db.query(sql, [searchTerm])

  res.render('search', { 
      title: 'Sökresultat',
      games: result.rows,
      searchTerm
    });
});

module.exports = router;
