
ALTER DATABASE nyhetflode CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS articles (
  img varchar(255) NOT NULL,
  title varchar(255) NOT NULL,
  content varchar(255) NOT NULL,
  publisher varchar(255) NOT NULL,
  publish_date DATETIME NOT NULL,
  src varchar(255) NOT NULL PRIMARY KEY
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS views_articles_lan (
  article_src varchar(255) NOT NULL,
  lan varchar(255) NOT NULL,
  views integer NOT NULL,
  PRIMARY KEY (article_src, lan),
  FOREIGN KEY (article_src) REFERENCES articles(src)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TRIGGER IF EXISTS add_article;

CREATE TRIGGER add_article
AFTER INSERT
ON articles FOR EACH ROW
INSERT INTO views_articles_lan(article_src, lan, views)
VALUES (NEW.src, "Stockholm", 0),
(NEW.src, "Västerbotten", 0),
(NEW.src, "Norrbotten", 0),
(NEW.src, "Uppsala", 0),
(NEW.src, "Södermanland", 0),
(NEW.src, "Östergötland", 0),
(NEW.src, "Jönköping", 0),
(NEW.src, "Kronoberg", 0),
(NEW.src, "Kalmar", 0),
(NEW.src, "Gotland", 0),
(NEW.src, "Blekinge", 0),
(NEW.src, "Skåne", 0),
(NEW.src, "Halland", 0),
(NEW.src, "Västra Götaland", 0),
(NEW.src, "Värmland", 0),
(NEW.src, "Örebro", 0),
(NEW.src, "Västmanland", 0),
(NEW.src, "Dalarna", 0),
(NEW.src, "Gävleborg", 0),
(NEW.src, "Västernorrland", 0),
(NEW.src, "Jämtland", 0);


INSERT INTO articles VALUES 
('https://cached-images.bonnier.news/swift/bilder/mly/8406158c-1317-4e44-80f5-b5e2affa1bcc.jpeg?interpolation=lanczos-none&crop=1.777778h:h;*,*&crop=w:0.5625w;*,*&downsize=1200:675&output-format=auto&output-quality=70',
	'En S-politik som leder till det svaga samhället',
	'Socialdemokraten Daniel Faterna som har haft regeringsmakten i 53 av 70 år. Det som krävs är att socialdemokrater och moderater tar tag i Sveriges problem och se...',
	'Dagens Industri',
	'2021-01-17 15:30:00',
	'https://www.di.se/debatt/en-s-politik-som-leder-till-det-svaga-samhallet/'),
('https://cached-images.bonnier.news/swift/bilder/mly/03ea1505-5fa4-43a6-9557-1b714ea25c3d.jpeg?interpolation=lanczos-none&crop=1.777778h:h;*,*&crop=w:0.5625w;*,*&downsize=1200:675&output-format=auto&output-quality=70',
	'Muller ansöker om konkurs för Spyker',
	'├är det spiken i kistan för den holländska sportbilstillverkaren Spyker? Det frågar sig holländska medier som rapporterar om att vd:n Victor Muller lämnat in en konkursansökan.',
	'Dagens Industri',
	'2021-01-17 15:39:05',
	'https://www.di.se/nyheter/muller-ansoker-om-konkurs-for-spyker/'),
('https://cached-images.bonnier.news/swift/bilder/mly/1215375b-9cf3-473b-af04-cf9705eac175.jpeg?interpolation=lanczos-none&fit=around%7C1024:576&crop=1024:h;center,top&output-quality=80&output-format=auto',
	'Johan Croneman: Nej Anna Hedenmo, uppgiften är inte att bygga broar',
	'SVT:s Anna Hedenmo hävdar att hon visst ställde kritiska frågor till SD:s Mattias Karlsson.',
	'Dagens Nyheter',
	'2021-01-18 12:06:02',
	'https://www.dn.se/kultur/johan-croneman-nej-anna-hedenmo-journalistikens-uppgift-ar-inte-att-bygga-broar/'),
('https://cached-images.bonnier.news/swift/bilder/mly/f8df0938-1a7f-4525-bb96-3b410a2ba0ee.jpeg?interpolation=lanczos-none&fit=around%7C1024:576&crop=1024:h;center,top&output-quality=80&output-format=auto',
	'Hattrick för 44-åriga Magnus Muhrun när AIK bjöd på ny målfest',
	'Det svänger om AIK bandy.Dagarna efter den historiska målfesten mot Vetlanda öste AIK in mål på nytt med tränaren Magnus Muhrun på isen.Den här gången',
	'Dagens Nyheter',
	'2021-01-17 15:27:08',
	'https://www.dn.se/sport/hattrick-for-44-ariga-muhren-nar-aik-bjod-pa-ny-malfest/'),
('https://cached-images.bonnier.news/swift/bilder/mly/90411ff9-94d5-4ca9-a003-b14512ec97a7.jpeg?interpolation=lanczos-none&fit=around%7C1024:576&crop=1024:h;center,top&output-quality=80&output-format=auto',
	'Pisachef: Pandemin förödande för vissa elever',
	'Pandemin har påverkat skolgången för elever världen över.',
	'Dagens Nyheter',
	'2021-01-17 15:56:49',
	'https://www.dn.se/sverige/pisachef-pandemin-forodande-for-vissa-elever/'),
('https://cached-images.bonnier.news/swift/bilder/mly/05c3b550-1725-46dd-be36-5c8080c4bd40.jpeg?interpolation=lanczos-none&fit=around%7C1024:576&crop=1024:h;center,top&output-quality=80&output-format=auto',
	'Enormt säkerhetspådrag i USA inför protester',
	'Säkerhetspådraget är enormt i många städer i USA på söndagen.',
	'Dagens Nyheter',
	'2021-01-17 16:47:52',
	'https://www.dn.se/varlden/enormt-sakerhetspadrag-i-usa-oro-for-vapnade-protester-i-delstaterna-allt-kan-handa/'),
('https://www.fastighetsvarlden.se/wp-content/uploads/2015/12/fastighetsvarlden-logo-large-4.png',
	'Bockasjö tecknar avtal med Apoteket - hyr ut 20.000 kvm',
	'Markarbetena påbörjas i dagarna och det nya logistikcentret kommer vara inflyttningsklart i februari 2022. Logistikcentret kommer ägas av Bockasjö',
	'Fastighetsvärlden',
	'2021-01-18 11:46:11',
	'https://www.fastighetsvarlden.se/notiser/bockasjo-tecknar-avtal-med-apoteket-hyr-ut-20-000-kvm/'),
('http://www.gp.se/image/policy:1.40069492:1610899149/image.jpg?f=Wide%26w=1200%26%24p%24f%24w=834285a',
	'Tidigare Saab-ägaren Spyker begärd i konkurs',
	'Det nederländska företaget Spyker, tidigare ägare av Saab Automobile, har begärts i konkurs, rapporterar TV4 Nyheterna. Sportbilsföretaget har inte tillverkat',
	'Göteborgs-Posten',
	'2021-01-17 15:59:00',
	'https://www.gp.se/ekonomi/tidigare-saab-%C3%A4garen-spyker-beg%C3%A4rd-i-konkurs-1.40069540'),
('http://www.gp.se/image/policy:1.40071387:1610900359/image.jpg?f=Wide%26w=1200%26%24p%24f%24w=834285a',
	'Musikproducenten Phil Spector är död',
	'Musikproducenten Phil Spector är död i sviterna av covid-19, rapporterar TMZ. Han satt i fängelse dömd för ett mord 2009. Det är källor till sajten TMZ som gör',
	'Göteborgs-Posten',
	'2021-01-17 16:06:00',
	'https://www.gp.se/kultur/kultur/musikproducenten-phil-spector-%C3%A4r-d%C3%B6d-1.40070483'),
('http://www.gp.se/image/policy:1.40070676:1610899690/image.jpg?f=Wide%26w=1200%26%24p%24f%24w=834285a',
	'Solbergs lyxproblem: \"Mål att göra det svårt\"',
	'Glenn Solberg har fått ett huvudbry inför gruppfinalen mot Egypten. Med Lucas Pellas och Hampus Wanne i högform är det frågan om vem som ska få chansen från',
	'Göteborgs-Posten',
	'2021-01-17 16:08:00',
	'https://www.gp.se/sport/solbergs-lyxproblem-m%C3%A5l-att-g%C3%B6ra-det-sv%C3%A5rt-1.40070679'),
('http://www.gp.se/image/policy:1.40107574:1610970433/image.jpg?f=Wide%26w=1200%26%24p%24f%24w=834285a',
	'Svensk i America\'s Cup-drama - nära att sjunka',
	'Mitt under kvalseglingen till America\'s Cup kapsejsade båten American Magic med svensken Anders Gustafsson ombord. \"är tacksam för att vi alla kom undan oskadda\",',
	'Göteborgs-Posten',
	'2021-01-18 11:47:00',
	'https://www.gp.se/sport/svensk-i-america-s-cup-drama-n%C3%A4ra-att-sjunka-1.40107675'),
('https://imengine.gota.infomaker.io?uuid=e3664f42-26e5-5756-81ec-84db30f75887&width=768&height=384&type=preview&source=false&q=90&z=100&x=0.000&y=0.150&crop_w=1.000&crop_h=0.688&function=cropresize',
	'\"Inte helt orealistiskt\" med festivalsommar',
	'Festivaljättarna laddar om med stora dragplåster och biljettsläpp.',
	'Kristianstadsbladet',
	'2021-01-17 18:00:00',
	'https://www.kristianstadsbladet.se/noje/inte-helt-orealistiskt-med-festivalsommar-d326383b/'),
('http://www.stromstadstidning.se/image/policy:1.40068676:1610896982/image.jpg?f=Wide%26w=1200%26%24p%24f%24w=834285a',
	'Nytt målrekord av Robert Lewandowski',
	'I sommar, om det nu blir ett EM, ställs fotbollslandslaget mot Polen och Robert Lewandowski. Förbundskaptenen Janne Andersson får hoppas att anfallaren inte',
	'Strömstads Tidning',
	'2021-01-17 15:22:00',
	'https://www.stromstadstidning.se/sport/nytt-m%C3%A5lrekord-av-robert-lewandowski-1.38863327'),
('https://www.sweclockers.com/artikel/31181/og-image','Qualcomm Snapdragon SC8280 är processor med hög prestanda för datorer',
	'Jätten i full gång att testa en prestandaorienterad ARM-processor med LPDDR5-minne för bärbara datorer.',
	'SweClockers',
	'2021-01-18 11:15:00',
	'https://www.sweclockers.com/nyhet/31181-qualcomm-snapdragon-sc8280-ar-processor-med-hog-prestanda-for-datorer');
