//SIDAN MED LISTA ÖVER ALLA SPEL

var express = require('express');
var router = express.Router();

router.get('/', async function(req, res) {

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
   `;
 
   const result = await db.query(sql);
 
   //const game = result.rows[0];

  res.render('admin/games', { 
      title: 'Lista över spel',
      allGames: result.rows
    });
});


// router.get('/', async function(req, res) {

//   res.render('admin/games/new', { 
//       title: 'Lägg till spel',
//       allGames: {}
//     });
// });

module.exports = router;