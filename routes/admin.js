var express = require('express');
var router = express.Router();

//GET /admin/games
router.get('/games', async (req, res) => {

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
     ORDER BY id
   `;
 
   const result = await db.query(sql);

  res.render('admin/games', { 
      title: 'Lista över spel',
      allGames: result.rows
    });
});

//GET /admin/games/new
router.get('/games/new', async (req, res) => {

  res.render('admin/games/new', { 
      title: 'Lägg till spel' ,
    });
});

//POST /games/new
router.post('/games/new', async (req, res) => {
  
  const {
    name,
    description,
    imageUrl,
    genre,
    releaseYear
  } = req.body;

  const gameProduct = {
    name,
    description,
    imageUrl,
    genre,
    releaseYear,
    urlSlug: generateURLSlug(name)
  }; 

  const db = req.app.locals.db;

  await saveGameProduct(gameProduct, db);

  res.redirect('/admin/games');
});

const generateURLSlug = (name) => 
    name.replace('-', '')
    .replace(' ', '-')
    .toLowerCase();

async function saveGameProduct(gameProduct, db) {
  
  const sql = `
    INSERT INTO game (
      name,
      description,
      genre,
      image_url,
      release_year,
      url_slug
    ) VALUES ($1, $2, $3, $4, $5, $6)
  `;

  await db.query(sql, [
    gameProduct.name,
    gameProduct.description,
    gameProduct.genre,
    gameProduct.imageUrl,
    gameProduct.releaseYear,
    gameProduct.urlSlug
  ]);
};

//GET /admin/score/new
router.get('/score/new', async (req, res) => {

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

    res.render('admin/score/new', { 
        title: 'Lägg till highscore',
        gameList: result.rows
      });
  });

//POST /admin/score/new
router.post('/score/new', async (req, res) => {
  
    const {
      game,
      playerName,
      scoreDate,
      score
    } = req.body;
  
    const highscore = {
      game,
      playerName,
      scoreDate,
      score
    }; 
  
    const db = req.app.locals.db;
  
    await saveHighscore(highscore, db);
  
    res.redirect('/admin/games');
  });

async function saveHighscore(highscore, db) {
    
    const sql = `
    INSERT INTO highscore (
        game_id,
        player_name,
        score_date,
        score
    ) VALUES ($1, $2, $3, $4)
    `;

    await db.query(sql, [
        highscore.game,
        highscore.playerName,
        highscore.scoreDate,
        highscore.score
    ]);
};

module.exports = router;