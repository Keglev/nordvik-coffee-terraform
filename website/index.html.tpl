<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Nordvik Coffee — Small-Batch Artisan Roastery</title>
<link rel="icon" href="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'%3E%3Ctext y='.9em' font-size='90'%3E%E2%98%95%EF%B8%8F%3C/text%3E%3C/svg%3E">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,9..144,300..900;1,9..144,300..900&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
  :root{
    --cream:#f4ecdf;
    --cream-2:#ece0cb;
    --espresso:#2b1a12;
    --espresso-2:#3d2817;
    --brown:#5c3b24;
    --brown-light:#8a5a35;
    --rust:#c1612f;
    --rust-light:#e07a3f;
    --gold:#d9a84e;
    --text-soft:#6b5842;
    --radius:18px;
    --maxw:1180px;
  }
  *{margin:0;padding:0;box-sizing:border-box;}
  html{scroll-behavior:smooth;}
  body{
    font-family:'Inter',system-ui,sans-serif;
    background:var(--cream);
    color:var(--espresso);
    overflow-x:hidden;
  }
  h1,h2,h3,.logo{font-family:'Fraunces',serif;}
  a{color:inherit;text-decoration:none;}
  img{max-width:100%;display:block;}
  .wrap{max-width:var(--maxw);margin:0 auto;padding:0 28px;}
  .reveal{opacity:0;transform:translateY(24px);transition:opacity .7s ease,transform .7s ease;}
  .reveal.in{opacity:1;transform:translateY(0);}

  /* NAV */
  header{
    position:fixed;top:0;left:0;right:0;z-index:100;
    backdrop-filter:blur(10px);
    background:rgba(244,236,223,0.78);
    border-bottom:1px solid rgba(43,26,18,0.08);
    transition:background .3s ease;
  }
  nav.wrap{display:flex;align-items:center;justify-content:space-between;height:78px;}
  .logo{font-size:22px;font-weight:600;letter-spacing:.3px;display:flex;align-items:center;gap:10px;}
  .logo .mark{
    width:34px;height:34px;border-radius:50%;
    background:conic-gradient(from 210deg,var(--rust),var(--gold),var(--brown-light),var(--rust));
    box-shadow:inset 0 0 0 3px var(--cream);
  }
  nav ul{display:flex;gap:36px;list-style:none;}
  nav ul a{font-size:14.5px;font-weight:500;color:var(--espresso-2);position:relative;padding-bottom:4px;}
  nav ul a::after{content:"";position:absolute;left:0;bottom:0;width:0;height:2px;background:var(--rust);transition:width .25s ease;}
  nav ul a:hover::after{width:100%;}
  .nav-cta{
    background:var(--espresso);color:var(--cream);
    padding:10px 22px;border-radius:999px;font-size:14px;font-weight:600;
    transition:transform .2s ease, background .2s ease;
  }
  .nav-cta:hover{background:var(--rust);transform:translateY(-2px);}
  .menu-btn{display:none;background:none;border:none;cursor:pointer;flex-direction:column;gap:5px;}
  .menu-btn span{width:24px;height:2px;background:var(--espresso);display:block;}

  /* HERO */
  .hero{
    position:relative;
    min-height:100vh;
    display:flex;align-items:center;
    padding-top:78px;
    background:
      radial-gradient(circle at 85% 20%, rgba(224,122,63,0.35), transparent 45%),
      radial-gradient(circle at 10% 90%, rgba(217,168,78,0.25), transparent 50%),
      linear-gradient(160deg,var(--cream) 0%, var(--cream-2) 60%, #e6d6b8 100%);
    overflow:hidden;
  }
  .hero::before{
    content:"";position:absolute;inset:0;
    background-image:radial-gradient(rgba(43,26,18,0.05) 1.5px, transparent 1.5px);
    background-size:22px 22px;
    mask-image:linear-gradient(to bottom, black, transparent 70%);
  }
  .hero-grid{
    display:grid;grid-template-columns:1.1fr .9fr;gap:60px;align-items:center;
    position:relative;z-index:2;width:100%;
  }
  .eyebrow{
    display:inline-flex;align-items:center;gap:8px;
    font-size:13px;font-weight:600;letter-spacing:1.5px;text-transform:uppercase;
    color:var(--brown-light);margin-bottom:22px;
  }
  .eyebrow::before{content:"";width:28px;height:1px;background:var(--rust);}
  .hero h1{
    font-size:clamp(42px,6vw,72px);
    font-weight:600;line-height:1.05;letter-spacing:-1px;
    color:var(--espresso);
  }
  .hero h1 em{font-style:italic;color:var(--rust);font-weight:500;}
  .hero p.lead{
    margin-top:24px;font-size:18px;line-height:1.7;color:var(--text-soft);
    max-width:460px;
  }
  .hero-actions{display:flex;gap:16px;margin-top:38px;flex-wrap:wrap;}
  .btn{
    display:inline-flex;align-items:center;gap:8px;
    padding:15px 30px;border-radius:999px;font-weight:600;font-size:15px;
    cursor:pointer;border:none;transition:transform .2s ease, box-shadow .2s ease;
  }
  .btn-primary{background:var(--rust);color:#fff;box-shadow:0 10px 30px -10px rgba(193,97,47,.7);}
  .btn-primary:hover{transform:translateY(-3px);box-shadow:0 14px 34px -8px rgba(193,97,47,.8);}
  .btn-ghost{background:transparent;color:var(--espresso);border:1.5px solid rgba(43,26,18,0.25);}
  .btn-ghost:hover{border-color:var(--espresso);background:rgba(43,26,18,0.04);}

  .hero-stats{display:flex;gap:36px;margin-top:56px;}
  .stat b{font-family:'Fraunces',serif;font-size:30px;display:block;color:var(--espresso);}
  .stat span{font-size:13px;color:var(--text-soft);}

  .cup-wrap{position:relative;display:flex;justify-content:center;align-items:center;height:460px;}
  .cup{
    position:relative;width:280px;height:280px;border-radius:50%;
    background:radial-gradient(circle at 35% 30%, #4a2f1c, #2b1a12 70%);
    box-shadow:0 40px 70px -20px rgba(43,26,18,.55), inset 0 -10px 30px rgba(0,0,0,.4), inset 0 8px 20px rgba(255,255,255,.08);
    animation:float 6s ease-in-out infinite;
  }
  .cup::after{
    content:"";position:absolute;inset:14px;border-radius:50%;
    background:radial-gradient(circle at 40% 35%, #6b4327, #3d2817 75%);
  }
  .steam{position:absolute;top:-10px;left:50%;width:70px;height:140px;transform:translateX(-50%);opacity:.55;}
  .steam i{
    position:absolute;bottom:0;width:10px;height:70px;border-radius:50px;
    background:linear-gradient(to top, rgba(255,255,255,.6), transparent);
    animation:steam 3.5s ease-in-out infinite;
  }
  .steam i:nth-child(1){left:10px;animation-delay:0s;}
  .steam i:nth-child(2){left:30px;animation-delay:.8s;}
  .steam i:nth-child(3){left:50px;animation-delay:1.6s;}
  .bean{
    position:absolute;border-radius:50% 50% 50% 0;
    background:linear-gradient(135deg,var(--brown-light),var(--espresso-2));
    opacity:.9;
  }
  @keyframes float{0%%,100%%{transform:translateY(0) rotate(0deg);}50%%{transform:translateY(-14px) rotate(3deg);}}
  @keyframes steam{0%%{transform:translateY(0) scaleY(1);opacity:.5;}50%%{transform:translateY(-50px) scaleY(1.3);opacity:0;}100%%{transform:translateY(-70px);opacity:0;}}

  /* MARQUEE */
  .marquee{
    background:var(--espresso);color:var(--cream-2);
    padding:18px 0;overflow:hidden;white-space:nowrap;
  }
  .marquee-track{display:inline-flex;gap:50px;animation:scroll 28s linear infinite;}
  .marquee span{font-family:'Fraunces',serif;font-style:italic;font-size:18px;opacity:.85;display:inline-flex;align-items:center;gap:50px;}
  .marquee span::after{content:"☕";opacity:.6;}
  @keyframes scroll{from{transform:translateX(0);}to{transform:translateX(-50%);}}

  /* SECTION GENERIC */
  section{padding:120px 0;}
  .section-head{max-width:620px;margin-bottom:64px;}
  .section-head .eyebrow{margin-bottom:16px;}
  .section-head h2{font-size:clamp(30px,4vw,44px);font-weight:600;line-height:1.15;letter-spacing:-.5px;}
  .section-head p{margin-top:16px;color:var(--text-soft);font-size:16.5px;line-height:1.7;}

  /* STORY */
  .story{background:var(--cream);}
  .story-grid{display:grid;grid-template-columns:1fr 1fr;gap:70px;align-items:center;}
  .story-art{
    position:relative;height:420px;border-radius:var(--radius);
    background:linear-gradient(135deg,#8a5a35,#3d2817);
    overflow:hidden;
  }
  .story-art .texture{
    position:absolute;inset:0;
    background-image:repeating-linear-gradient(45deg, rgba(255,255,255,.04) 0 2px, transparent 2px 10px);
  }
  .story-art .badge{
    position:absolute;bottom:24px;left:24px;right:24px;
    background:rgba(244,236,223,.92);backdrop-filter:blur(6px);
    border-radius:14px;padding:18px 20px;
    display:flex;align-items:center;gap:14px;
  }
  .story-art .badge .n{font-family:'Fraunces',serif;font-size:26px;color:var(--rust);font-weight:600;}
  .story-art .badge .t{font-size:12.5px;color:var(--text-soft);line-height:1.4;}
  .story p{color:var(--text-soft);line-height:1.8;font-size:16px;margin-bottom:18px;}
  .story h2{font-size:clamp(28px,3.6vw,38px);margin-bottom:22px;font-weight:600;}

  /* MENU / PRODUCTS */
  .menu{background:linear-gradient(180deg,var(--cream) 0%, var(--cream-2) 100%);}
  .menu-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:28px;}
  .card{
    background:var(--cream);border-radius:var(--radius);padding:34px 28px;
    border:1px solid rgba(43,26,18,0.08);
    transition:transform .3s ease, box-shadow .3s ease, border-color .3s ease;
    position:relative;overflow:hidden;
  }
  .card:hover{transform:translateY(-8px);box-shadow:0 24px 40px -18px rgba(43,26,18,.25);border-color:transparent;}
  .card .bean-icon{
    width:52px;height:52px;border-radius:50% 50% 50% 6px;
    background:linear-gradient(135deg,var(--rust-light),var(--brown));
    margin-bottom:22px;position:relative;
  }
  .card .bean-icon::after{content:"";position:absolute;inset:0;margin:auto;width:2px;height:70%;top:15%;left:50%;background:rgba(255,255,255,.5);border-radius:2px;}
  .card h3{font-size:21px;margin-bottom:10px;font-weight:600;}
  .card p{color:var(--text-soft);font-size:14.5px;line-height:1.7;margin-bottom:18px;}
  .card .price{display:flex;justify-content:space-between;align-items:center;border-top:1px dashed rgba(43,26,18,.15);padding-top:16px;}
  .card .price b{font-family:'Fraunces',serif;font-size:20px;color:var(--rust);}
  .tag{font-size:11px;font-weight:700;letter-spacing:.5px;text-transform:uppercase;color:var(--brown-light);background:rgba(138,90,53,.12);padding:4px 10px;border-radius:999px;}

  /* PROCESS */
  .process{background:var(--espresso);color:var(--cream);}
  .process .section-head p{color:#c7b59e;}
  .process .eyebrow{color:var(--gold);}
  .steps{display:grid;grid-template-columns:repeat(4,1fr);gap:28px;}
  .step{position:relative;padding-left:0;}
  .step .num{
    font-family:'Fraunces',serif;font-size:50px;font-weight:300;color:var(--rust-light);
    opacity:.8;margin-bottom:14px;display:block;
  }
  .step h3{font-size:18px;margin-bottom:10px;font-weight:600;}
  .step p{font-size:14px;color:#b8a488;line-height:1.7;}
  .step-line{height:1px;background:linear-gradient(90deg,rgba(217,168,78,.5),transparent);margin:20px 0;}

  /* TESTIMONIALS */
  .testimonials{background:var(--cream);}
  .t-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:26px;}
  .t-card{background:var(--cream-2);border-radius:var(--radius);padding:30px;}
  .stars{color:var(--gold);letter-spacing:3px;margin-bottom:16px;font-size:16px;}
  .t-card p{font-size:15px;line-height:1.75;color:var(--espresso-2);margin-bottom:22px;}
  .t-person{display:flex;align-items:center;gap:12px;}
  .t-avatar{width:42px;height:42px;border-radius:50%;background:linear-gradient(135deg,var(--rust-light),var(--brown-light));flex-shrink:0;}
  .t-person b{font-size:14px;display:block;}
  .t-person span{font-size:12.5px;color:var(--text-soft);}

  /* REVIEW FORM */
  .review-panel{
    display:grid;grid-template-columns:.85fr 1.15fr;gap:40px;
    background:var(--cream-2);border-radius:var(--radius);padding:40px;margin-bottom:50px;
  }
  .review-form h3{font-size:22px;font-weight:600;margin-bottom:8px;}
  .review-form p.hint{font-size:14px;color:var(--text-soft);margin-bottom:22px;}
  .star-picker{display:flex;gap:8px;margin-bottom:20px;}
  .star-picker button{
    background:none;border:none;cursor:pointer;font-size:28px;line-height:1;
    color:rgba(43,26,18,0.2);transition:color .15s ease, transform .15s ease;padding:0;
  }
  .star-picker button.active, .star-picker button:hover{color:var(--gold);transform:scale(1.1);}
  .review-form label{display:block;font-size:13px;font-weight:600;color:var(--espresso-2);margin-bottom:6px;}
  .review-form input, .review-form textarea{
    width:100%;padding:13px 16px;border-radius:12px;border:1.5px solid rgba(43,26,18,0.15);
    font-family:inherit;font-size:14.5px;background:var(--cream);color:var(--espresso);margin-bottom:18px;resize:vertical;
  }
  .review-form input:focus, .review-form textarea:focus{outline:none;border-color:var(--rust);}
  .form-msg{font-size:14px;margin-top:-6px;margin-bottom:14px;min-height:20px;}
  .form-msg.ok{color:#3f7d3a;}
  .form-msg.err{color:var(--rust);}
  .review-list{display:flex;flex-direction:column;gap:16px;max-height:480px;overflow-y:auto;padding-right:6px;}
  .review-list .t-card{padding:22px 24px;}
  .review-list .meta{display:flex;justify-content:space-between;align-items:baseline;margin-bottom:4px;}
  .review-list .meta .date{font-size:12px;color:var(--text-soft);}
  .review-empty, .review-loading{color:var(--text-soft);font-size:14.5px;padding:20px 0;}
  @media (max-width:900px){.review-panel{grid-template-columns:1fr;}}

  /* CTA / NEWSLETTER */
  .cta{
    position:relative;background:linear-gradient(135deg,var(--rust) 0%, var(--brown) 100%);
    border-radius:32px;margin:0 28px;padding:70px 56px;color:#fff;overflow:hidden;
    max-width:calc(var(--maxw) - 56px);margin-left:auto;margin-right:auto;
  }
  .cta::before{
    content:"";position:absolute;right:-60px;top:-60px;width:260px;height:260px;border-radius:50%;
    background:rgba(255,255,255,.08);
  }
  .cta-grid{display:flex;justify-content:space-between;align-items:center;gap:40px;flex-wrap:wrap;position:relative;z-index:2;}
  .cta h2{font-size:clamp(26px,3.4vw,38px);font-weight:600;max-width:460px;line-height:1.2;}
  .cta p{opacity:.85;margin-top:12px;max-width:420px;font-size:15px;}
  .cta-form{display:flex;gap:10px;flex-wrap:wrap;}
  .cta-form input{
    padding:15px 20px;border-radius:999px;border:none;min-width:240px;font-size:14.5px;
    font-family:inherit;background:rgba(255,255,255,.15);color:#fff;
  }
  .cta-form input::placeholder{color:rgba(255,255,255,.7);}
  .cta-form .btn-primary{background:var(--espresso);}

  /* FOOTER */
  footer{background:var(--espresso);color:#b8a488;padding:70px 0 30px;}
  .footer-grid{display:grid;grid-template-columns:1.4fr 1fr 1fr 1fr;gap:40px;margin-bottom:50px;}
  footer .logo{color:var(--cream);}
  footer p.desc{margin-top:16px;font-size:14px;line-height:1.7;max-width:280px;}
  footer h4{color:var(--cream);font-size:14px;margin-bottom:18px;letter-spacing:.5px;text-transform:uppercase;}
  footer ul{list-style:none;display:flex;flex-direction:column;gap:11px;}
  footer ul a{font-size:14px;color:#b8a488;transition:color .2s;}
  footer ul a:hover{color:var(--cream);}
  .footer-bottom{
    border-top:1px solid rgba(255,255,255,.08);padding-top:26px;
    display:flex;justify-content:space-between;font-size:13px;color:#8a7a62;flex-wrap:wrap;gap:10px;
  }

  @media (max-width:980px){
    nav ul, .nav-cta{display:none;}
    .menu-btn{display:flex;}
    .hero-grid{grid-template-columns:1fr;}
    .cup-wrap{height:300px;order:-1;}
    .story-grid{grid-template-columns:1fr;}
    .menu-grid{grid-template-columns:1fr 1fr;}
    .steps{grid-template-columns:1fr 1fr;}
    .t-grid{grid-template-columns:1fr;}
    .footer-grid{grid-template-columns:1fr 1fr;}
  }
  @media (max-width:600px){
    .menu-grid{grid-template-columns:1fr;}
    .steps{grid-template-columns:1fr;}
    .footer-grid{grid-template-columns:1fr;}
    .cta{padding:44px 26px;margin:0 16px;}
    .hero-stats{gap:24px;}
  }
</style>
</head>
<body>

<header>
  <nav class="wrap">
    <a href="#" class="logo"><span class="mark"></span>Nordvik Coffee</a>
    <ul>
      <li><a href="#story">Our Story</a></li>
      <li><a href="#menu">Roasts</a></li>
      <li><a href="#process">Process</a></li>
      <li><a href="#reviews">Reviews</a></li>
    </ul>
    <a href="#cta" class="nav-cta">Order Now</a>
    <button class="menu-btn" aria-label="menu"><span></span><span></span><span></span></button>
  </nav>
</header>

<section class="hero">
  <div class="wrap hero-grid">
    <div>
      <div class="eyebrow">Small-Batch · Single Origin</div>
      <h1>Coffee, roasted<br>with <em>purpose</em>.</h1>
      <p class="lead">Nordvik Coffee sources rare micro-lots from family farms and roasts them in small batches, a few days before they reach your cup.</p>
      <div class="hero-actions">
        <a href="#menu" class="btn btn-primary">Explore Roasts →</a>
        <a href="#story" class="btn btn-ghost">Our Story</a>
      </div>
      <div class="hero-stats">
        <div class="stat"><b>12+</b><span>Origin Farms</span></div>
        <div class="stat"><b>48hr</b><span>Roast to Ship</span></div>
        <div class="stat"><b id="heroRating">—★</b><span id="heroReviewCount">Reviews</span></div>
      </div>
    </div>
    <div class="cup-wrap">
      <div class="steam"><i></i><i></i><i></i></div>
      <div class="cup"></div>
    </div>
  </div>
</section>

<div class="marquee">
  <div class="marquee-track">
    <span>Ethiopia Yirgacheffe</span><span>Colombia Huila</span><span>Guatemala Antigua</span><span>Sumatra Mandheling</span><span>Kenya AA</span>
    <span>Ethiopia Yirgacheffe</span><span>Colombia Huila</span><span>Guatemala Antigua</span><span>Sumatra Mandheling</span><span>Kenya AA</span>
  </div>
</div>

<section class="story" id="story">
  <div class="wrap story-grid">
    <div class="reveal">
      <div class="story-art">
        <div class="texture"></div>
        <div class="badge">
          <span class="n">15</span>
          <span class="t">Years perfecting the art of<br>small-batch roasting.</span>
        </div>
      </div>
    </div>
    <div class="reveal">
      <div class="eyebrow">Our Story</div>
      <h2>Founded on a mountainside, built on patience.</h2>
      <p>Nordvik began in 2010 when our founder spent a year traveling coffee-growing regions, cupping lots at sunrise with farmers who'd worked the same soil for generations.</p>
      <p>We still buy direct from those relationships — paying above fair-trade rates — and roast every batch in-house, in small drums, listening for the exact second each bean hits its peak.</p>
      <a href="#menu" class="btn btn-ghost">Meet the Roasts →</a>
    </div>
  </div>
</section>

<section class="menu" id="menu">
  <div class="wrap">
    <div class="section-head reveal">
      <div class="eyebrow">The Lineup</div>
      <h2>Roasts worth waking up for.</h2>
      <p>Each bag is roasted to order and dated, so you always know exactly how fresh your coffee is.</p>
    </div>
    <div class="menu-grid">
      <div class="card reveal">
        <span class="tag">Light Roast</span>
        <div class="bean-icon"></div>
        <h3>Ethiopia Yirgacheffe</h3>
        <p>Floral and bright with notes of bergamot, blueberry, and raw honey. Washed process.</p>
        <div class="price"><span>250g bag</span><b>$19</b></div>
      </div>
      <div class="card reveal">
        <span class="tag">Medium Roast</span>
        <div class="bean-icon"></div>
        <h3>Colombia Huila</h3>
        <p>Balanced and juicy — caramel sweetness, red apple acidity, soft chocolate finish.</p>
        <div class="price"><span>250g bag</span><b>$17</b></div>
      </div>
      <div class="card reveal">
        <span class="tag">Dark Roast</span>
        <div class="bean-icon"></div>
        <h3>Sumatra Mandheling</h3>
        <p>Deep and earthy with cedar, dark cocoa, and a long syrupy, low-acid body.</p>
        <div class="price"><span>250g bag</span><b>$18</b></div>
      </div>
    </div>
  </div>
</section>

<section class="process" id="process">
  <div class="wrap">
    <div class="section-head reveal">
      <div class="eyebrow">How It's Made</div>
      <h2>From mountain to mug, in four steps.</h2>
      <p>Transparency isn't a buzzword here — every bag lists the farm, the harvest date, and the roast date.</p>
    </div>
    <div class="steps">
      <div class="step reveal"><span class="num">01</span><h3>Source</h3><p>Direct relationships with farmers across 12 origin countries, visited yearly.</p></div>
      <div class="step reveal"><span class="num">02</span><h3>Cup & Select</h3><p>Every lot is cupped blind by our roasters before a single bag is bought.</p></div>
      <div class="step reveal"><span class="num">03</span><h3>Roast</h3><p>Small 12kg batches, roasted to order, never sitting in a warehouse.</p></div>
      <div class="step reveal"><span class="num">04</span><h3>Ship</h3><p>Sealed and shipped within 48 hours of roasting, straight to your door.</p></div>
    </div>
  </div>
</section>

<section class="testimonials" id="reviews">
  <div class="wrap">
    <div class="section-head reveal">
      <div class="eyebrow">Loved By Coffee People</div>
      <h2>Don't just take our word for it.</h2>
    </div>
    <div class="review-panel reveal">
      <div class="review-form">
        <h3>Share your experience</h3>
        <p class="hint">Tried a bag? Tell other coffee people what you thought.</p>
        <form id="reviewForm">
          <label>Your rating</label>
          <div class="star-picker" id="starPicker" data-rating="0">
            <button type="button" data-val="1">★</button>
            <button type="button" data-val="2">★</button>
            <button type="button" data-val="3">★</button>
            <button type="button" data-val="4">★</button>
            <button type="button" data-val="5">★</button>
          </div>
          <label for="revName">Name</label>
          <input id="revName" maxlength="60" placeholder="Your name" required>
          <label for="revComment">Review</label>
          <textarea id="revComment" rows="4" maxlength="600" placeholder="What did you think of the roast?" required></textarea>
          <div class="form-msg" id="formMsg"></div>
          <button type="submit" class="btn btn-primary" id="submitBtn">Submit Review</button>
        </form>
      </div>
      <div>
        <h3 style="font-size:22px;font-weight:600;margin-bottom:16px;">What people are saying</h3>
        <div class="review-list" id="reviewList">
          <div class="review-loading">Loading reviews…</div>
        </div>
      </div>
    </div>
  </div>
</section>

<section id="cta">
  <div class="cta reveal">
    <div class="cta-grid">
      <div>
        <h2>Get fresh-roasted coffee at your door, every month.</h2>
        <p>Join the Nordvik subscription — cancel anytime, free shipping on every bag.</p>
      </div>
      <form class="cta-form" onsubmit="event.preventDefault(); this.querySelector('input').value=''; this.querySelector('button').textContent='Thanks! ✓';">
        <input type="email" placeholder="your@email.com" required>
        <button class="btn btn-primary" type="submit">Subscribe</button>
      </form>
    </div>
  </div>
</section>

<footer>
  <div class="wrap">
    <div class="footer-grid">
      <div>
        <a href="#" class="logo"><span class="mark"></span>Nordvik Coffee</a>
        <p class="desc">Small-batch coffee, roasted with purpose and shipped within 48 hours, direct from farm relationships we've built for over a decade.</p>
      </div>
      <div>
        <h4>Shop</h4>
        <ul><li><a href="#menu">All Roasts</a></li><li><a href="#cta">Subscriptions</a></li><li><a href="#">Gift Cards</a></li></ul>
      </div>
      <div>
        <h4>Company</h4>
        <ul><li><a href="#story">Our Story</a></li><li><a href="#process">Process</a></li><li><a href="#">Wholesale</a></li></ul>
      </div>
      <div>
        <h4>Support</h4>
        <ul><li><a href="#">Contact</a></li><li><a href="#">Shipping</a></li><li><a href="#">FAQ</a></li></ul>
      </div>
    </div>
    <div class="footer-bottom">
      <span>© 2026 Nordvik Coffee. All rights reserved.</span>
      <span>Roasted & shipped from our mountainside roastery.</span>
    </div>
  </div>
</footer>

<script>
  document.querySelector('.menu-btn').addEventListener('click', function(){
    document.querySelector('nav ul').style.display = document.querySelector('nav ul').style.display === 'flex' ? 'none' : 'flex';
  });
  const obs = new IntersectionObserver((entries)=>{
    entries.forEach(e=>{ if(e.isIntersecting){ e.target.classList.add('in'); } });
  },{threshold:0.15});
  document.querySelectorAll('.reveal').forEach(el=>obs.observe(el));

  const REVIEWS_API = '${api_endpoint}';

  function escapeHtml(str){
    return str.replace(/[&<>"']/g, c => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
  }
  function formatDate(iso){
    try{ return new Date(iso).toLocaleDateString(undefined,{year:'numeric',month:'short',day:'numeric'}); }
    catch(e){ return ''; }
  }
  function renderReviews(reviews){
    const list = document.getElementById('reviewList');
    if(!reviews.length){ list.innerHTML = '<div class="review-empty">No reviews yet — be the first to leave one!</div>'; return; }
    list.innerHTML = reviews.map(r => `
      <div class="t-card">
        <div class="meta">
          <div class="stars">$${'★'.repeat(r.rating)}$${'☆'.repeat(5-r.rating)}</div>
          <span class="date">$${formatDate(r.createdAt)}</span>
        </div>
        <p>"$${escapeHtml(r.comment)}"</p>
        <div class="t-person"><div class="t-avatar"></div><div><b>$${escapeHtml(r.name)}</b></div></div>
      </div>
    `).join('');
  }

  async function loadReviews(){
    try{
      const res = await fetch(REVIEWS_API);
      const data = await res.json();
      renderReviews(data.reviews || []);
      const count = data.count || 0;
      const avg = data.averageRating || 0;
      const heroRating = document.getElementById('heroRating');
      const heroCount  = document.getElementById('heroReviewCount');
      if(count > 0){
        heroRating.textContent = avg.toFixed(1) + '★';
        heroCount.textContent  = count.toLocaleString() + ' Review' + (count === 1 ? '' : 's');
      } else {
        heroRating.textContent = '—★';
        heroCount.textContent  = 'Reviews';
      }
    }catch(e){
      document.getElementById('reviewList').innerHTML = '<div class="review-empty">Couldn\'t load reviews right now.</div>';
    }
  }
  loadReviews();

  const starPicker = document.getElementById('starPicker');
  starPicker.addEventListener('click', (e)=>{
    const btn = e.target.closest('button');
    if(!btn) return;
    const val = parseInt(btn.dataset.val, 10);
    starPicker.dataset.rating = val;
    [...starPicker.children].forEach(b => b.classList.toggle('active', parseInt(b.dataset.val,10) <= val));
  });

  document.getElementById('reviewForm').addEventListener('submit', async (e)=>{
    e.preventDefault();
    const msg = document.getElementById('formMsg');
    const btn = document.getElementById('submitBtn');
    const rating = parseInt(starPicker.dataset.rating || '0', 10);
    const name = document.getElementById('revName').value.trim();
    const comment = document.getElementById('revComment').value.trim();

    if(rating < 1){ msg.textContent = 'Please pick a star rating.'; msg.className='form-msg err'; return; }

    btn.disabled = true; btn.textContent = 'Submitting…';
    msg.textContent=''; msg.className='form-msg';
    try{
      const res = await fetch(REVIEWS_API, {
        method:'POST',
        headers:{'Content-Type':'application/json'},
        body: JSON.stringify({name, comment, rating})
      });
      const data = await res.json();
      if(!res.ok){ throw new Error(data.error || 'Something went wrong'); }
      msg.textContent = 'Thanks for your review!'; msg.className='form-msg ok';
      document.getElementById('reviewForm').reset();
      starPicker.dataset.rating = 0;
      [...starPicker.children].forEach(b => b.classList.remove('active'));
      loadReviews();
    }catch(err){
      msg.textContent = err.message; msg.className='form-msg err';
    }finally{
      btn.disabled = false; btn.textContent = 'Submit Review';
    }
  });
</script>

</body>
</html>
