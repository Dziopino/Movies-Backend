-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 18, 2026 at 10:04 PM
-- Wersja serwera: 10.4.32-MariaDB
-- Wersja PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cinemix`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `films`
--

CREATE TABLE `films` (
  `id` int(11) NOT NULL,
  `poster_url` varchar(500) DEFAULT NULL,
  `rating` decimal(3,1) DEFAULT NULL CHECK (`rating` >= 1 and `rating` <= 10),
  `release_date` date DEFAULT NULL,
  `duration` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `films`
--

INSERT INTO `films` (`id`, `poster_url`, `rating`, `release_date`, `duration`) VALUES
(1, 'obsession.webp', 7.8, '2025-09-06', 108),
(2, 'starWarsTheMandalorianAndGrogu.webp', 6.5, '2026-05-20', 132),
(3, 'ladiesFirst.webp', 5.7, '2026-05-22', 93),
(4, 'fjord.webp', 7.8, '2026-05-18', 146),
(5, 'altarBoys.webp', 7.0, '2025-11-21', 110),
(6, 'drama.webp', 7.1, '2026-04-01', 105),
(7, 'theHailMaryProject.webp', 7.9, '2026-03-14', 156),
(8, 'theSilentFriend.webp', 7.2, '2025-07-05', 145),
(9, 'alpha.webp', 5.7, '2026-04-24', 95),
(10, 'tomClancyJackRyanGhostWar.webp', 5.3, '2026-05-20', 105),
(11, 'mortalKombat2.webp', 6.5, '2026-05-06', 116),
(12, 'wutheringHeights.webp', 5.9, '2026-02-13', 136),
(13, 'bride.webp', 5.3, '2026-03-04', 126),
(14, 'homeland.webp', 7.0, '2026-05-14', 82),
(15, 'theGoodBoy.webp', 7.3, '2025-09-05', 110),
(16, 'odyssey.webp', 7.5, '2026-07-06', 172),
(17, 'mastersOfTheUniverse.webp', 6.4, '2026-07-03', 141),
(18, 'invitation.webp', 7.4, '2026-01-24', 108),
(19, 'backroomsNoWayOut.webp', 6.4, '2026-05-07', 105),
(20, 'scaryMovie.webp', 4.9, '2026-06-03', 95),
(21, 'dayOfRevelation.webp', 5.8, '2026-06-10', 145),
(22, 'theSheepDetectives.webp', 7.1, '2026-05-02', 109),
(23, 'hokum.webp', 5.9, '2026-03-14', 107),
(24, 'interstellar.webp', 8.0, '2026-10-05', 169),
(25, 'evilDeadBurn.webp', 6.2, '2026-07-08', 110),
(26, 'troy.webp', 7.4, '2026-05-14', 163),
(27, 'leCoseNonDette.webp', 7.1, '2026-01-29', 114),
(28, 'toyStory5.webp', 7.6, '2026-05-28', 102),
(29, 'theMummy.webp', 5.5, '2026-04-17', 133),
(30, 'oppenheimer.webp', 7.9, '2023-07-21', 180);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `film_genres`
--

CREATE TABLE `film_genres` (
  `film_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `film_genres`
--

INSERT INTO `film_genres` (`film_id`, `genre_id`) VALUES
(1, 1),
(2, 6),
(3, 3),
(4, 2),
(5, 2),
(5, 3),
(6, 2),
(6, 3),
(6, 8),
(7, 6),
(8, 2),
(9, 5),
(10, 5),
(11, 7),
(12, 13),
(13, 1),
(14, 2),
(15, 5),
(16, 2),
(16, 7),
(16, 14),
(17, 7),
(17, 14),
(18, 2),
(18, 3),
(19, 1),
(19, 6),
(20, 3),
(21, 5),
(21, 6),
(22, 15),
(23, 1),
(24, 6),
(25, 1),
(26, 16),
(27, 2),
(27, 3),
(28, 3),
(28, 17),
(28, 18),
(29, 1),
(30, 2),
(30, 19);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `film_translations`
--

CREATE TABLE `film_translations` (
  `id` int(11) NOT NULL,
  `film_id` int(11) NOT NULL,
  `language_code` varchar(5) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `film_translations`
--

INSERT INTO `film_translations` (`id`, `film_id`, `language_code`, `title`, `description`) VALUES
(1, 1, 'en', 'Obsession', 'Bear ( Michael Johnston ), platonically in love with his friend Nikki ( Inde Navarrette ), wants to win her heart and decides to fulfill his dream with a cheap wish-granting toy called \"One Wish Willow.\" The toy actually works, and he gets exactly what he asked for, but he soon discovers that some desires come with a dark, sinister price.'),
(2, 2, 'en', 'Star Wars: The Mandalorian and Grogu', 'The sinister Empire has fallen, and Imperial warlords remain scattered across the galaxy. The fledgling New Republic, striving to protect everything the Rebellion has fought for, turns to the legendary Mandalorian bounty hunter Din Djarin and his young apprentice, Grogu , for aid .'),
(3, 3, 'en', 'Ladies first', 'Damien Sachs ( Sacha Baron Cohen ) seems to have it all: money, power, and an endless string of fleeting affairs. As he prepares to take over as CEO of a leading advertising agency, his life is suddenly turned upside down as he awakens to his worst nightmare—a parallel reality ruled by women. Once a dominant figure in the boardroom, he must swallow his pride and compete with the uncompromising and confident Alex Fox ( Rosamund Pike ). When the rules of the game change and Alex is at the peak of his powers, a brilliant showdown erupts between the two in this subversive, satirical comedy about the consequences of role reversal.'),
(4, 4, 'en', 'Fjord', 'The Gheorghiu family, whose father is from Romania and whose mother is from Norway, moves to the woman\'s hometown, a small and isolated Norwegian village. There, they develop a close friendship with the neighboring Halberg family. However\r\n, the situation changes when questions arise about the treatment of the children. From that moment on, the Gheorghiu family\'s lives are completely disrupted. They suddenly find themselves the center of attention from the authorities and under increasingly intense, oppressive scrutiny.'),
(5, 5, 'en', 'Altar boys', 'A group of teenage altar boys, frustrated by the indifference of adults and Church institutions toward social injustice, decide to implement their own, unconventional plan for moral renewal. Armed with youthful rebellion and their own interpretation of Scripture, they bug a confessional to better understand their neighbors. Masked like Zorro and with ambitions worthy of Robin Hood, they become judges in their neighborhood, helping those in need and meting out punishment for sins. However, their mission turns into a dangerous game, and the boys, applying their own idealistic code of honor, begin to walk the fine line between good and evil. Real life in the housing estate blends with a mission straight out of superhero comics, but instead of capes, the heroes wear surplices.'),
(6, 6, 'en', 'The Drama', 'Beautiful, wealthy, and in love. Their upcoming wedding will be merely the icing on the cake. Unless, of course, it doesn\'t happen at all. A few days before the ceremony, shocking information about the bride-to-be\'s past is revealed, casting her in a very dark light. Will the groom-to-be find enough love, understanding, and empathy to understand and forgive? Or perhaps there\'s nothing to forgive? Perhaps it\'s enough to accept that the person you want to spend the rest of your life with is simply someone completely different from what you imagined? If you think about it, it might even be fun. Unless, of course, it turns out to be dangerous.'),
(7, 7, 'en', 'Project Hail Mary', 'Science teacher Ryland Grace ( Ryan Gosling ) wakes up on a spaceship light-years from home with no memory of who he is or how he got there. As his memory returns, he begins to unravel his mission: to solve the mystery of a mysterious substance causing the sun to fade. He must use his scientific knowledge and unconventional ideas to save everything on Earth from destruction, but an unexpected friendship means he may not have to do it alone.'),
(8, 8, 'en', 'Stille Freundin', 'In the heart of the university\'s botanical garden, a magnificent ginkgo biloba tree grows. Over the course of a century, it becomes a silent witness and participant in the story of three strangers. A determined girl fights for a place in the botany department, seeking refuge from the prejudices of the male-dominated academic world in the tree\'s shade. A lonely student, who has never paid much attention to plants, finds solace in its silent presence after a life of turmoil. A Hong Kong neurologist (played by Tony Leung , known from Wong Kar-Wai\'s films ) begins to question his scientific beliefs after an encounter with the tree, discovering a profound connection between the visible and the intangible.'),
(9, 9, 'en', 'Apex', 'A grieving woman testing her limits in the Australian wilderness is unexpectedly drawn into a deadly game with a ruthless adversary.'),
(10, 10, 'en', 'Jack Ryan: Ghost War', 'In the new film, Jack Ryan reluctantly returns to the world of espionage when an international covert mission uncovers a deadly conspiracy, forcing him to confront a relentless special operations unit under immense time pressure. Operating in real time, with lives at stake and the threat mounting with every passing moment, Jack reunites with veteran CIA operative Mike November ( Michael Kelly ) and former CIA director James Greer ( Wendell Pierce ). Their combined experience is their only advantage against an enemy who knows their every move. Aided by an unlikely new partner—the astute MI6 agent Emma Marlowe ( Sienna Miller )—Jack and his team navigate a treacherous web of intrigue, confronting pasts they long thought closed. This is their most personal and risky mission yet.'),
(11, 11, 'en', 'Mortal Kombat II', 'Shao Khan\'s ( Martyn Ford ) dominance must finally be broken. So monk Liu Kang ( Ludi Lin ), former elite soldier Sonya Blade ( Jessica McNamee ), her mentor Jax Briggs ( Mehcad Brooks ), and fallen former MMA champion Cole Young ( Lewis Tan ) reunite to save Earth. This time, with Johnny Cage ( Karl Urban ) on their side, the group plunges into brutal battles where more than just physicality is at stake.'),
(12, 12, 'en', 'Wuthering Heights', '\"Wuthering Heights,\" directed by Emerald Fennell, is a bold and original take on one of the greatest love stories of all time. Margot Robbie and Jacob Elordi star as Cathy and Heathcliff, whose forbidden romantic passion eventually turns toxic. The film is a monumental tale of lust, love, and madness.'),
(13, 13, 'en', 'The Bride!', 'Frankenstein\'s lonely monster ( Bale ) travels to 1930s Chicago. There, he asks groundbreaking researcher Dr. Euphronious (five-time Oscar nominee Annette Bening ) to create a companion for him. Together, they revive a murdered young woman, and thus a bride ( Buckley ) is born. The consequences of this act neither of them could have foreseen: murder, possessiveness, an untamed and radical cultural movement, and a wild and wild romance between two outcasts!'),
(14, 14, 'en', 'Homeland', '\"Homeland\" tells the story of the relationship between Thomas Mann ( Hanns Zischler ), winner of the Nobel Prize in Literature, and his daughter Erika ( Sandra Hüller ), an actress and writer. Set at the height of the Cold War, father and daughter embark on a difficult, emotional journey in a black Buick across a ruined Germany – from Frankfurt under American control to Weimar under Soviet influence. For the first time since the war, Mann returns to his homeland, having previously made the difficult decision to emigrate to the United States.'),
(15, 15, 'en', 'The Good Boy', 'Nineteen-year-old Tommy ( Anson Boon ) enjoys his carefree life, filled with substance abuse and reckless violence. One night, he is kidnapped by a stranger, Chris ( Stephen Graham ). Waking up in the basement of a secluded house, he finds himself caught in the middle of a dysfunctional family dynamic. Chris and his mysterious wife, Kathryn ( Andrea Riseborough ), attempt to mold him into a \"good boy\" through a forced and peculiar rehabilitation. This subversive tale of freedom and control shows how, forced to read books and learn manners, Tommy has only one thought in mind: how to escape.'),
(16, 1, 'pl', 'Obsesja', 'Bear (Michael Johnston) platonicznie zakochany w swojej przyjaciółce Nikki (Inde Navarrette), chce zdobyć serce ukochanej i postanawia spełnić swoje marzenie za pomocą taniej zabawki spełniające życzenia \"One Wish Willow\". Zabawka naprawdę działa i chłopak otrzymuje dokładnie to, o co prosił, ale wkrótce odkrywa, że niektóre pragnienia mają mroczną, złowrogą cenę.'),
(17, 2, 'pl', 'Gwiezdne wojny: Mandalorianin i Grogu', 'Złowrogie Imperium upadło, a imperialni watażkowie wciąż są rozproszeni po całej galaktyce. Nowo powstała Nowa Republika, która stara się chronić wszystko, o co walczyła Rebelia, zwraca się o pomoc do legendarnego mandaloriańskiego łowcy nagród, Dina Djarina, i jego młodego ucznia, Grogu.'),
(18, 3, 'pl', 'Panie przodem', 'Damien Sachs (Sacha Baron Cohen) zdaje się mieć wszystko: pieniądze, władzę i niekończący się ciąg przelotnych romansów. Gdy szykuje się do objęcia stanowiska CEO w czołowej agencji reklamowej, jego życie nagle wywraca się do góry nogami - budzi się bowiem w świecie ze swojego najgorszego koszmaru - równoległej rzeczywistości rządzonej przez kobiety. Niegdyś dominował w sali zarządu, a teraz musi przełknąć dumę i stanąć do rywalizacji z bezkompromisową i pewną siebie Alex Fox (Rosamund Pike). Gdy zasady gry się zmieniają, a Alex jest u szczytu formy, między tą dwójką rozpoczyna się błyskotliwa potyczka w przewrotnej, satyrycznej komedii, opowiadającej o skutkach odwrócenia założonych ról.'),
(19, 4, 'pl', 'Fjord', 'Rodzina Gheorghiu, w której ojciec pochodzi z Rumunii, a matka z Norwegii, przeprowadza się do rodzinnej miejscowości kobiety, niewielkiej i odizolowanej norweskiej wioski. Tam nawiązują bliską przyjacielską relację z sąsiadującą rodziną Halbergów.\r\nSytuacja zmienia się, gdy pojawiają się wątpliwości dotyczące sposobu, w jaki traktowane są dzieci. Od tego momentu życie rodziny Gheorghiu zostaje całkowicie zaburzone. Niespodziewanie znajdują się w centrum zainteresowania władz i pod coraz silniejszą, przytłaczającą kontrolą.'),
(20, 5, 'pl', 'Ministranci', 'Grupa nastoletnich ministrantów, sfrustrowana obojętną postawą dorosłych i instytucji Kościoła wobec niesprawiedliwości społecznej, postanawia wdrożyć własny, nietypowy plan odnowy moralnej. Uzbrojeni w młodzieńczy bunt i własną interpretację Pisma Świętego zakładają podsłuch… w konfesjonale, aby lepiej poznać swoich sąsiadów. Zamaskowani niczym Zorro i z ambicjami na miarę Robin Hooda, stają się sędziami w swoim osiedlowym świecie, pomagając potrzebującym i wymierzając kary za grzechy. Jednak ich misja zamienia się w niebezpieczną grę, a chłopcy, stosując własny, idealistyczny kodeks honorowy, zaczynają balansować na cienkiej granicy między dobrem a złem. Prawdziwe życie blokowiska miesza się z misją wprost z komiksów o superbohaterach, ale zamiast peleryn, bohaterowie noszą komże.'),
(21, 6, 'pl', 'Drama', 'Piękni, zamożni i zakochani. Ich zbliżający się ślub będzie jedynie postawieniem kropki nad \"i\". No chyba, że do niego wcale nie dojdzie. Na kilka dni przed ceremonią, na jaw wychodzi szokująca informacja o przeszłości przyszłej panny młodej, która stawia ją w bardzo mrocznym świetle. Czy przyszły pan młody znajdzie w sobie tyle miłości, wyrozumiałości i empatii, by zrozumieć i wybaczyć? A może tu nie ma nic do wybaczania? Może wystarczy zaakceptować fakt, że osoba, z którą chce się spędzić resztę życia jest po prostu kimś zupełnie innym niż nam się wydawało? Gdyby się nad tym spokojnie zastanowić, to może być nawet zabawne. Chyba, że okaże się niebezpieczne.'),
(22, 7, 'pl', 'Projekt Hail Mary', 'Nauczyciel nauk ścisłych Ryland Grace (Ryan Gosling) budzi się na statku kosmicznym lata świetlne od domu, nie pamiętając, kim jest ani jak się tam znalazł. Gdy wraca mu pamięć, zaczyna odkrywać swoją misję: rozwiązać zagadkę tajemniczej substancji powodującej wygaśnięcie słońca. Musi wykorzystać swoją wiedzę naukową i niekonwencjonalne pomysły, aby ocalić wszystko na Ziemi przed zagładą, ale nieoczekiwana przyjaźń oznacza, że być może nie będzie musiał robić tego sam.'),
(23, 8, 'pl', 'Milcząca przyjaciółka', 'W sercu uniwersyteckiego ogrodu botanicznego rośnie okazały miłorząb japoński (gingko biloba), który na przestrzeni wieku staje się niemym świadkiem i uczestnikiem historii trojga nieznajomych. Zdeterminowana dziewczyna walczy o miejsce na wydziale botaniki, szukając w cieniu drzewa schronienia przed uprzedzeniami zdominowanego przez mężczyzn świata nauki. Samotny student, który nigdy nie zwracał uwagi na rośliny, w jego milczącej obecności odnajduje punkt oparcia po życiowym zawirowaniu. Neurolog z Hong-Kongu (w tej roli znany z filmów Wonga Kar-Waia Tony Leung) pod wpływem kontaktu z drzewem zaczyna kwestionować swoje naukowe przekonania, odkrywając głęboką więź między tym, co widzialne, a tym, co nieuchwytne.'),
(24, 9, 'pl', 'Alfa', 'Pogrążona w żalu kobieta, która sprawdza swoje granice w australijskiej dziczy, zostaje niespodziewanie wciągnięta w śmiertelnie niebezpieczną grę z bezwzględnym przeciwnikiem.'),
(25, 10, 'pl', 'Tom Clancy: Jack Ryan - Wojna duchów', 'W nowym filmie Jack Ryan niechętnie wraca do świata szpiegostwa, gdy międzynarodowa tajna misja ujawnia śmiertelny spisek, zmuszając go do konfrontacji z nieokiełznaną jednostką operacji specjalnych pod ogromną presją czasu. Działając w czasie rzeczywistym, gdy stawką jest ludzkie życie, a zagrożenie narasta z każdą chwilą, Jack ponownie łączy siły z doświadczonym agentem CIA Mikiem Novemberem (Michael Kelly) oraz byłym szefem CIA Jamesem Greerem (Wendell Pierce). Ich wspólne doświadczenie to jedyna przewaga w starciu z przeciwnikiem, który zna każdy ich ruch. Wspierani przez nieoczywistą nową partnerkę – niezwykle bystrą agentkę MI6 Emmę Marlowe (Sienna Miller) – Jack i jego zespół poruszają się w zdradzieckiej sieci intryg, mierząc się z przeszłością, którą już dawno uznali za zamkniętą. To najbardziej osobista i ryzykowna misja, z jaką kiedykolwiek przyszło im się zmierzyć.'),
(26, 11, 'pl', 'Mortal Kombat II', 'Dominacja Shao Khana (Martyn Ford) wreszcie musi zostać przerwana. Dlatego mnich Liu Kang (Ludi Lin), była elitarną żołnierka Sonya Blade (Jessica McNamee), jej mentor Jax Briggs (Mehcad Brooks) oraz upadły były mistrz MMA Cole Young (Lewis Tan) ponownie łączą siły, by ocalić Ziemię. Tym razem wsparcia udziela im Johnny Cage (Karl Urban), a cała grupa rzuca się w wir brutalnych walk, w których stawką jest coś więcej niż tylko własna fizyczność.'),
(27, 12, 'pl', 'Wichrowe wzgórza', '\"Wichrowe wzgórza\" w reżyserii Emerald Fennell to odważna i oryginalna wersja jednej z największych historii miłosnych wszech czasów. Margot Robbie i Jacob Elordi wcielają się w Cathy i Heathcliffa, których zakazana, romantyczna namiętność z czasem staje się toksyczna. Film jest monumentalną opowieścią o pożądaniu, miłości i szaleństwie.'),
(28, 13, 'pl', 'Panna młoda!', 'Samotny potwór Frankensteina (Bale) udaje się w latach 30. XX wieku do Chicago. Tam prosi dokonującą przełomowych odkryć badaczkę, doktor Euphronious (pięciokrotnie nominowana do Oscara Annette Bening), o stworzenie mu towarzyszki. Wspólnie ożywiają zamordowaną młodą kobietę i tak oto rodzi się panna młoda (Buckley). Następstw tego czynu żadne z nich nie mogło przewidzieć. Są to morderstwa, zaborczość, nieokiełznany i radykalny ruch kulturowy oraz dziki i szalony romans dwójki wyrzutków!'),
(29, 14, 'pl', 'Ojczyzna', '\"Ojczyzna\" opowiada o relacji między Thomasem Mannem (Hanns Zischler), laureatem Nagrody Nobla w dziedzinie literatury, a jego córką Eriką (Sandra Hüller) – aktorką i pisarką. Akcja rozgrywa się w szczytowym okresie zimnej wojny. Ojciec i córka wyruszają w trudną, pełną emocji podróż czarnym Buickiem przez zrujnowane Niemcy – z Frankfurtu pod kontrolą amerykańską do Weimaru pod wpływem sowieckim. Po raz pierwszy od wojny Mann wraca do swojej ojczyzny, po tym jak podjął wcześniej trudną decyzję o emigracji do Stanów Zjednoczonych.'),
(30, 15, 'pl', 'Dobry chłopiec', 'Dziewiętnastoletni Tommy (Anson Boon) lubi swoje beztroskie, pełne używek i lekkomyślnej przemocy życie. Pewnej nocy zostaje porwany przez nieznajomego, Chrisa (Stephen Graham). Budząc się w piwnicy położonego na uboczu domu, chłopak trafia w sam środek dysfunkcyjnej rodzinnej dynamiki. Chris i jego tajemnicza żona Kathryn (Andrea Riseborough) próbują uczynić z niego \"dobrego chłopca\" poprzez wymuszoną i specyficzną resocjalizację. Ta przewrotna opowieść o wolności i kontroli pokazuje, jak zmuszony do czytania książek i uczenia się manier Tommy, myśli tylko o jednym - jak stamtąd uciec.'),
(61, 16, 'pl', 'Odyseja', '\"Odyseja\" to historia Odyseusza, królu Itaki, podczas jego długiej i pełnej niebezpieczeństw podróży powrotnej do domu po wojnie trojańskiej. Opisuje jego spotkania z mitycznymi istotami, takimi jak cyklop Polifem, syreny oraz nimfa Kalipso. Król robi wszystko by wrócić do ukochanej żony Penelopy.'),
(62, 16, 'en', 'The Odyssey', '\"The Odyssey\" tells the story of Odysseus, King of Ithaca, on his long and perilous journey home after the Trojan War. It describes his encounters with mythical creatures such as the Cyclops Polyphemus, the Sirens, and the nymph Calypso. The King does everything he can to return to his beloved wife, Penelope.'),
(63, 17, 'pl', 'Władcy Wszechświata', 'Adam jest na co dzień księciem Eterni, lecz gdy zachodzi taka potrzeba po wypowiedzeniu słów \"Na potęgę Posępnego Czerepu, mocy przybywaj!\" staje się herosem znanym jako He-man.\r\nTym razem He-man decyduje się na wyprawę przeciwko potężnemu i okrutnemu Szkieletorowi aby ocalić swoją planetę oraz uchronić sekrety Zamku Grayskull.'),
(64, 17, 'en', 'Masters of the Universe', 'Adam is normally the prince of Eternia, but when necessary, after uttering the words \"By the power of Grayskull, power is come!\", he becomes the hero known as He-man.\r\nThis time, He-man decides to embark on a journey against the powerful and cruel Skeletor to save his planet and protect the secrets of Castle Grayskull.'),
(65, 18, 'en', 'The Invitation ', 'Joe and Angela have been married for over a decade. On the surface, their relationship seems almost exemplary: a harmonious, peaceful life in a decent neighborhood, a successful child, and a decent financial situation. However, beneath the surface lie mutual resentments, petty conflicts, and above all, boredom and routine. When Joe and Angela invite a pair of mysterious neighbors to dinner one evening, their casual and friendly conversation begins to turn into a game of ambiguity. What had previously been hidden comes to light, and unspoken desires of the mind and body begin to take on a dangerously real form. Will both couples sleep in their own beds tonight?'),
(66, 18, 'pl', 'Zaproszenie', 'Joe i Angela są małżeństwem z kilkunastoletnim stażem. Z pozoru ich związek wydaje się wręcz wzorcowy: zgodne, spokojne życie w porządnej dzielnicy, udane dziecko, niezły status materialny. Jednak pod powierzchnią kryją się wzajemne pretensje, drobne konflikty, a przede wszystkim nuda i rutyna. Gdy pewnego wieczoru Joe i Angela zapraszają na kolację parę tajemniczych sąsiadów, swobodna i przyjacielska rozmowa zaczyna zmieniać się w pełną dwuznaczności grę. To, co dotąd skrywane, wychodzi na jaw, a niewypowiedziane pragnienia ducha i ciała zaczynają nabierać niebezpiecznie realnych kształtów. Czy obie pary pójdą dziś spać we własnych łóżkach?'),
(67, 19, 'en', 'Backrooms', 'In the basement of his shop, Clark stumbles upon a passageway leading to a disturbing, seemingly empty maze of endless corridors. When he tells his therapist, she believes he may be hallucinating, presaging a deterioration in his mental state. Things change when Clark stops attending appointments—the concerned therapist sets out to discover what has happened to him. During her search, she finds herself in a reality where time loses meaning, space undergoes strange transformations, and something unnatural lurks beyond the limits of visibility.'),
(68, 19, 'pl', 'Backrooms. Bez wyjścia', 'Clark natrafia w podziemiach swojego sklepu na przejście do niepokojącej, na pierwszy rzut oka pustej plątaniny niekończących się korytarzy. Kiedy opowiada o tym swojej terapeutce, kobieta uznaje, że mogą to być omamy zapowiadające pogorszenie jego stanu psychicznego. Sytuacja zmienia się, gdy Clark przestaje przychodzić na wizyty — zaniepokojona terapeutka postanawia odkryć, co się z nim stało. W trakcie poszukiwań trafia do rzeczywistości, gdzie czas traci sens, przestrzeń ulega dziwnym przemianom, a poza granicą widzialności kryje się coś nienaturalnego.'),
(69, 20, 'en', 'Scary Movie', 'Twenty-six years after escaping a masked killer resembling Ghostface, the legendary foursome once again find themselves targeted by a mysterious killer. Cindy, Brenda, Ray, and Shorty must reunite as absurd and bloody situations begin to multiply around them.\r\nThe film satirically pokes fun at contemporary horror films attempting to reinvent established franchises. Alongside returning characters, new characters are introduced, and the film is filled with boundary-pushing humor and pop culture references.'),
(70, 20, 'pl', 'Straszny film', 'Dwadzieścia sześć lat po tym, jak udało im się ujść z życiem przed zamaskowanym zabójcą przypominającym Ghostface’a, legendarna czwórka ponownie staje się celem tajemniczego mordercy. Cindy, Brenda, Ray i Shorty muszą jeszcze raz połączyć siły, gdy wokół nich zaczynają mnożyć się kolejne absurdalne i krwawe sytuacje.\r\nFilm w satyryczny sposób wyśmiewa współczesne kino grozy próbujące odświeżyć znane marki. Obok powracających bohaterów pojawiają się nowe postacie, a całość pełna jest przekraczającego granice humoru i nawiązań do popkultury.'),
(71, 21, 'en', 'Disclosure Day', 'A weather forecaster ( Emily Blunt ) sparks panic and speculation after she suddenly begins speaking a mysterious alien language during a live broadcast. Speculations of extraterrestrial contact begin.\r\nCybersecurity analyst Daniel ( Josh O\'Connor ) realizes he may be the only person who, though unsure how, understands this language and can translate it into English. He believes humanity has a right to know the truth, so he decides to make the aliens\' message public.\r\n\r\nThis decision brings him into conflict with the government, represented by Agent Scanlon ( Colin Firth ), who will stop at nothing to prevent the truth from being revealed.'),
(72, 21, 'pl', 'Dzień objawienia', 'Prezenterka pogody (Emily Blunt) wywołuje panikę i uruchamia falę spekulacji po tym, jak w czasie transmisji na żywo nagle zaczyna mówić w tajemniczym obcym języku. Zaczynają się spekulacje o kontakcie z istotami pozaziemskimi.\r\nAnalityk ds. cyberbezpieczeństwa Daniel (Josh O\'Connor) orientuje się, że prawdopodobnie jest jedyną osobą, która choć nie wie jak to możliwe, rozumie ten język i może przetłumaczyć go na angielski. Jego zdaniem ludzkość ma prawo poznać prawdę, więc postanawia upublicznić przesłanie od obcych.\r\n\r\nTa decyzja prowadzi go do konfliktu ze stroną rządową, reprezentowaną przez agenta Scanlona (Colin Firth), która nie cofnie się przed niczym, by nie dopuścić do ujawnienia prawdy.'),
(73, 22, 'en', 'The Sheep Detectives', 'George Hardy ( Hugh Jackman ) is a shepherd who loves his sheep and raises them solely for their wool. Every night, he reads them crime stories, pretending the sheep understand, unaware that they not only understand them but also spend hours discussing the crime.\r\n\r\nWhen George is found mysteriously dead, the sheep immediately realize it was murder and believe they know all about solving it. Local policeman Tim Derry ( Nicholas Braun ), on the other hand, has never solved a major crime in his life, so the sheep decide they\'ll have to solve it themselves—even if that means leaving their meadow for the first time and facing the fact that the human world isn\'t as simple as it seems in books.'),
(74, 22, 'pl', 'Sprawiedliwość owiec', 'George Hardy (Hugh Jackman) to pasterz, który kocha swoje owce i hoduje je wyłącznie dla wełny. Każdej nocy czyta im na głos kryminały, udając, że owce je rozumieją, nie podejrzewając, że nie tylko je rozumieją, ale także godzinami dyskutują o tym, kto jest sprawcą zbrodni.\r\n\r\nKiedy George zostaje znaleziony martwy w tajemniczych okolicznościach, owce od razu zdają sobie sprawę, że było to morderstwo i uważają, że wiedzą wszystko o tym, jak je rozwiązać. Z drugiej strony lokalny policjant Tim Derry (Nicholas Braun) nigdy w życiu nie rozwiązał poważnej zbrodni, więc owce dochodzą do wniosku, że będą musiały rozwiązać ją same - nawet jeśli oznacza to opuszczenie swojej łąki po raz pierwszy i zmierzenie się z faktem, że świat ludzi nie jest tak prosty, jak wydaje się w książkach.'),
(75, 23, 'en', 'Hokum', 'Popular horror author Ohm Bauman arrives at a remote old inn to scatter the ashes of his parents. When he discovers that, according to local legend, the place is haunted by an ancient witch, he begins asking dangerous questions. It soon becomes clear that Ohm\'s arrival there is no accident, and that the legend holds a seed of nightmarish truth. Further terrifying discoveries lead him to horrific events from the past, witnessed within the inn\'s walls.'),
(76, 23, 'pl', 'Hokum', 'Autor popularnych horrorów, Ohm Bauman, przyjeżdża do położonego na odludziu starego zajazdu, by w okolicy rozsypać prochy swoich rodziców. Gdy odkrywa, że miejsce to, zgodnie z lokalną legendą, nawiedzone jest przez starożytną wiedźmę, zaczyna zadawać niebezpieczne pytania. Wkrótce okaże się, że Ohm nie znalazł się tu przypadkiem, a legenda ma w sobie ziarno koszmarnej prawdy. Kolejne przerażające odkrycia prowadzą go do potwornych wydarzeń z przeszłości, których świadkiem były mury zajazdu.'),
(77, 24, 'en', 'Interstellar', 'Due to humanity\'s mistakes in the 20th century, Earth is teetering on the brink of destruction. States have collapsed, and their governments have lost power. A barely functioning economy can\'t even provide food for the people. However, when the possibility of space-time travel is discovered, scientists from the remnants of NASA undertake its exploration, thus becoming the last hope for humanity and their planet.'),
(78, 24, 'pl', 'Interstellar', 'Na skutek błędów popełnionych przez ludzkość w XX w. Ziemia staje na krawędzi zagłady. Nastąpił upadek państw, a ich rządy straciły władzę. Szczątkowo funkcjonująca gospodarka nie jest w stanie zapewnić ludziom nawet żywności. Gdy jednak odkryta zostaje możliwość podróżowania w czasoprzestrzeni, naukowcy wywodzący się z resztek organizacji NASA podejmują się jej zbadania, tym samym stając się ostatnią deską ratunku dla ludzi i ich planety.'),
(79, 25, 'en', 'Evil Dead: Fire', 'After her husband\'s death, a woman seeks solace with her in-laws in their secluded home in the wilderness. Peace quickly turns to nightmare as, one by one, family members fall victim to a dark force and are transformed into Deadites, possessed by demonic forces summoned from the Necronomicon Ex-Mortis.\r\nFaced with this growing evil, she discovers a terrifying truth: vows made in life endure even in death.'),
(80, 25, 'pl', 'Martwe zło: Ogień', 'Po śmierci męża kobieta szuka ukojenia u teściów w ich odosobnionym domu na pustkowiu. Spokój szybko zamienia się w koszmar, gdy kolejni członkowie rodziny, jeden po drugim, padają ofiarą mrocznej siły i przemieniają się w Deadites, opętanych przez demoniczne moce przywołane z księgi Necronomicon Ex-Mortis.\r\nW obliczu narastającego zła kobieta odkrywa przerażającą prawdę: przysięgi złożone za życia nie tracą mocy nawet po śmierci.'),
(81, 26, 'en', 'Troy', 'People have been fighting for centuries. Some for power, others for glory or honor, and some for love. In ancient Greece, the passion that united the most famous lovers in world literature—Paris, Prince of Troy ( Orlando Bloom ) and Helen ( Diane Kruger ), Queen of Sparta—ignited a war that brought an entire civilization to ruins. Helen\'s abduction is an insult that her husband, King Menelaus ( Brendan Gleeson ), cannot let go. An affront to Menelaus is an affront to the entire family. The queen\'s husband\'s brother, the powerful king of Mycenae, Agamemnon, soon unites numerous Greek tribes and leads them to Troy to fight in defense of his brother\'s tarnished honor. In reality, honor is merely a convenient pretext; Agamemnon\'s true motive for embarking on this expedition is greed—he must conquer Troy to gain control of the Aegean Sea, which will ensure his kingdom\'s undisputed leadership. Troy is a great city, surrounded by mighty walls, ruled by King Priam ( Peter Toole ) and defended by the valiant Prince Hector ( Eric Bana ). No one has ever breached the city walls. However, the key to victory or defeat in the Trojan War lies with one man – Achilles ( Brad Pitt ), considered the greatest warrior alive. Arrogant, rebellious, and invincible, Achilles serves no one and nothing; he is interested only in his own glory. It is his great desire for glory that leads him to the gates of Troy under Agamemnon\'s banner, but his fate will be decided by love. Two worlds fight for honor and power. Thousands will die in the quest for glory. Love will bring destruction to an entire nation.'),
(82, 26, 'pl', 'Troja\r\n\r\n\r\n', 'Ludzie walczą od stuleci. Niektórzy ze względu na władzę, inni z powodu chwały lub honoru, niektórzy zaś z miłości. W starożytnej Grecji namiętność, jaka połączyła parę najbardziej znanych kochanków w literaturze świata - Parysa, księcia Troi (Orlando Bloom) i Helenę (Diane Kruger), królową Sparty, stała się przyczyną wojny, za której przyczyną legła w ruinach cała cywilizacja. Porwanie Heleny to obraza, której mąż, król Menelaos (Brendan Gleeson), nie może puścić płazem. Afront dla Menelaosa to afront dla całej rodziny brat męża królowej, potężny król Myken, Agamemnon, jednoczy wkrótce wokół siebie liczne plemiona Greków i prowadzi je pod Troję, by walczyć w obronie splamionego honoru swego brata. W rzeczywistości honor jest jedynie wygodnym pretekstem, prawdziwą przyczyną wyruszenia Agamemnona na wyprawę jest chciwość musi zdobyć Troję, by zdobyć panowanie nad morzem Egejskim, co zapewni jego królestwu niekwestionowane przywództwo. Troja to wielkie miasto, otoczone potężnymi murami, włada nim król Priam (Peter Toole), broni go waleczny książę Hektor (Eric Bana). Nikt nigdy nie przełamał murów miasta. Kluczem do zwycięstwa lub porażki w wojnie trojańskiej jest jednak jeden człowiek - Achilles (Brad Pitt), którego uważa się za najlepszego żyjącego wojownika. Arogancki, buntowniczy i niepokonany Achilles nie służy nikomu i niczemu, interesuje go wyłącznie własna chwała. To właśnie wielka żądza chwały prowadzi go pod wrota Troi pod sztandarem Agamemnona, lecz o jego losie zadecyduje miłość. Dwa światy walczą o honor i władzę. Tysiące ludzi zginie w poszukiwaniu chwały. Miłość przyniesie zagładę całemu narodowi.'),
(83, 27, 'en', 'What We Don\'t Tell Each Other', 'Carlo and Elisa live in Rome, building a seemingly successful relationship. He\'s a university philosophy professor and a writer struggling with a creative crisis. She, in turn, is a talented, brilliant journalist whose columns appear in international lifestyle magazines. Their relationship, spanning two decades, is increasingly plagued by routine and distance.\r\n\r\nTo regain their former energy, they decide to travel to Morocco with their longtime friends, Anna and Paolo, and their thirteen-year-old daughter, Vittoria—an intelligent, inquisitive, and eccentric teenager. It turns out they\'re also going through a serious crisis, which affects the girl most. Vittoria, who can\'t get along with her parents, finds support in Carlo, forming a close bond with him. This is only the beginning of the problems to come...'),
(84, 27, 'pl', 'O czym sobie nie mówimy', 'Carlo i Elisa mieszkają w Rzymie, tworząc z pozoru udany związek. On jest profesorem filozofii na uniwersytecie i pisarzem walczącym z kryzysem twórczym. Ona z kolei to utalentowana, błyskotliwa dziennikarka, której felietony ukazują się w międzynarodowych magazynach lifestylowych. Do ich trwającego od dwóch dekad związku wkrada się coraz więcej rutyny oraz dystansu.\r\n\r\nAby odzyskać dawną energię, decydują się na wyjazd do Maroka w towarzystwie wieloletnich przyjaciół: Anny i Paola oraz ich trzynastoletniej córki Vittorii - inteligentnej, dociekliwej i ekscentrycznej nastolatki. Okazuje się, że także oni przeżywają poważny kryzys, który najbardziej odbija się na dziewczynce. Vittoria, która nie może dogadać się z rodzicami, znajduje oparcie w Carlu, nawiązując z nim bliską więź. To dopiero początek nadchodzących problemów…'),
(85, 28, 'en', 'Toy Story 5', 'Bonnie\'s parents buy her a Lilypad tablet—a gadget that all children already have. The device captures the girl\'s attention. Wanting to prove it\'s better than toys, it connects its owner with her ballet friends. Cowgirl Jessie has doubts this connection will develop into a true friendship. She and Mustang hide in Bonnie\'s suitcase and go on a sleepover with her. '),
(86, 28, 'pl', 'Toy Story 5', 'Rodzice kupują Bonnie tablet Lilypad – gadżet, który mają już wszystkie dzieci. Urządzenie zagarnia całą uwagę dziewczynki. Chcąc udowodnić, że jest lepsze od zabawek, kontaktuje swoją właścicielkę z koleżankami z baletu. Kowbojka Jessie ma wątpliwości, czy ta znajomość przerodzi się w prawdziwą przyjaźń. Wraz z Mustangiem ukrywa się w walizce Bonnie i rusza z nią na nocowankę. '),
(87, 29, 'en', 'The Mummy', 'A young girl, Katie ( Natalie Grace ), the daughter of a journalist, mysteriously disappears without a trace in the desert. Eight years later, the grieving family is shocked when she suddenly reappears, seemingly unharmed. However, what initially seems like a joyful reunion quickly turns into a nightmare as her loved ones begin to understand that the returned girl is profoundly changed and harbors an otherworldly, sinister force linked to an ancient curse.'),
(88, 29, 'pl', 'Mumia: Film Lee Cronina', 'Młoda dziewczyna Katie (Natalie Grace), córka dziennikarza, tajemniczo znika bez śladu na pustyni. Osiem lat później cierpiąca rodzina przeżywa szok, gdy nagle pojawia się ponownie, pozornie cała i zdrowa. Jednak to, co początkowo wydaje się radosnym spotkaniem, szybko przeradza się w koszmar, gdy bliscy zaczynają rozumieć, że dziewczyna, która wróciła, jest głęboko odmieniona i skrywa w sobie pozaziemską, złowrogą siłę związaną ze starożytną klątwą.'),
(89, 30, 'en', 'Oppenheimer', 'During World War II,  Oppenheimer was director of the Manhattan nuclear weapons program. Besides his work on atomic weapons, Oppenheimer  had remarkable achievements in other fields of physics, including the study of black holes and cosmic rays. After developing the atomic bomb, he devoted the rest of his life to efforts to limit the spread of nuclear weapons. He was accused by the American government and intelligence agencies of ties to the communist movement and espionage. In the 1950s, he was denied access to classified documents. It was not until President Kennedy achieved his political rehabilitation  that Oppenheimer  is considered a symbol of pacifism and opposition to the proliferation of nuclear weapons.'),
(90, 30, 'pl', 'Oppenheimer', 'Oppenheimer w czasie II wojny światowej był dyrektorem programu rozwoju broni jądrowej \"Manhattan\".  Poza działalnością związaną z bronią atomową Oppenheimer miał ogromne osiągnięcia w innych dziedzinach fizyki, między innymi w badaniach czarnych dziur oraz promieniowania kosmicznego. Resztę życia po opracowaniu bomby atomowej poświęcił na działalność na rzecz ograniczania rozprzestrzeniania się broni jądrowej. Był oskarżany przez amerykański rząd i służby o powiązania z ruchem komunistycznym oraz działalność szpiegowską. W latach 50. został pozbawiony dostępu do tajnych dokumentów. Dopiero prezydent Kennedy dokonał jego politycznej rehabilitacji. Oppenheimer jest dziś uznawany za jeden z symboli pacyfizmu i sprzeciwu wobec rozprzestrzeniania broni atomowej.');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `genres`
--

CREATE TABLE `genres` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `genres`
--

INSERT INTO `genres` (`id`, `name`) VALUES
(4, 'action'),
(14, 'adventure'),
(17, 'animation'),
(19, 'biographical'),
(26, 'body horror'),
(3, 'comedy'),
(10, 'crime'),
(15, 'crime comedy'),
(2, 'drama'),
(18, 'family\r\n'),
(7, 'fantasy'),
(16, 'historical drama'),
(1, 'horror'),
(13, 'melodrama'),
(11, 'musical'),
(8, 'romance'),
(9, 'romantic comedy'),
(6, 'sci-Fi'),
(5, 'thriller'),
(12, 'western');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `languages`
--

CREATE TABLE `languages` (
  `code` varchar(5) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`code`, `name`) VALUES
('en', 'English'),
('pl', 'Polish');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `password` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `avatar_url` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `created_at` date DEFAULT current_timestamp(),
  `role` tinyint(1) NOT NULL DEFAULT 0,
  `status` enum('ACTIVE','BANNED','SUSPENDED') NOT NULL DEFAULT 'ACTIVE',
  `suspended_until` datetime DEFAULT NULL,
  `ban_reason` varchar(255) DEFAULT NULL,
  `banned_at` datetime DEFAULT NULL,
  `banned_by` int(11) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `language_code` varchar(5) DEFAULT 'en',
  `reset_token` varchar(255) DEFAULT NULL,
  `reset_token_expiry` datetime DEFAULT NULL,
  `suspend_reason` varchar(255) DEFAULT NULL,
  `suspended_at` datetime DEFAULT NULL,
  `suspended_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `password`, `username`, `avatar_url`, `email`, `created_at`, `role`, `status`, `suspended_until`, `ban_reason`, `banned_at`, `banned_by`, `bio`, `language_code`, `reset_token`, `reset_token_expiry`, `suspend_reason`, `suspended_at`, `suspended_by`) VALUES
(1, '$2b$10$Es87v11WUTL9JPouu8Rpm.seoqi8mKjfU4nkFCcm3zmBDLfHrjRJK', 'sdad', NULL, 'ada@dsad', '2026-05-30', 0, 'ACTIVE', NULL, NULL, NULL, NULL, 'Lubie filmy', 'pl', NULL, NULL, 'iiko', '2026-07-26 18:43:58', 27),
(5, '$2b$10$KclL0BMKWGPuLXmbUWMZPu2Rsh/0lcLO4MoALB92DKgBh.nWMLbgS', 'Emilda', NULL, 'emil@gmail.com', '2026-05-30', 0, 'ACTIVE', NULL, NULL, NULL, NULL, 'lubie filmy 1234543sdasdsa', 'pl', NULL, NULL, NULL, NULL, NULL),
(6, '$2b$10$JHC7UvGXdaIXisObAod7X.GKVLf4FMlBFAjr2gANku0j3etqT5Uvy', 'Emil2', NULL, 'emil2@gmail.com', '2026-05-30', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, 'dsada', '2026-07-23 21:10:20', 16),
(9, '$2b$10$bAEG6YWArmmq3AHG9aTFzeK5qANkWDtz20Gx63Ij56NdIb1DUsRQu', 'Emil', '/uploads/c3b6a32b5a2539df9cf76ce4721df704.webp', 'filip.dziopa@gmail.com', '2026-05-30', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', '9a768d9ab7d766e88edd9ec71b47c2d638044d4c8df1f91e3593fa77becc52ce', '2026-07-18 19:34:45', 'dsada', '2026-07-23 21:10:22', 16),
(10, '$2b$10$DmNtEkdKkQzCy5peIP8z7emLcvEK1lfn2YnwIz07SKlJXdUQ21hWa', 'proba', NULL, 'proba@gmail.com', '2026-05-31', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, 'dsadsa', '2026-07-23 21:10:25', 16),
(11, '$2b$10$k0UZUidJChNWviHwGOpBuehyO844VLOLtb7oDelcibw.EcJS4H6Yq', 'test', NULL, 'test@t', '2026-05-31', 0, 'ACTIVE', NULL, NULL, NULL, NULL, 'My bio', 'pl', NULL, NULL, 'dasd', '2026-07-23 21:10:29', 16),
(12, '$2b$10$Q2iRAHG/ThhVV5V6lRqMkeeosM3DZr0U6sxG4HRvtGLGFQpfqxpT2', 'test', NULL, 'test@2', '2026-05-31', 0, 'ACTIVE', NULL, NULL, NULL, NULL, 'Nie ma opisu bo nie ma długopisu', 'pl', NULL, NULL, 'dsad', '2026-07-23 21:10:31', 16),
(13, '$2b$10$sbV4OklU8VjFGkmejZpByuJm2fh.BIkysTlqLWBwmsXvvzKgpzBxW', 'guest', NULL, 'Filip@1', '2026-06-26', 0, 'ACTIVE', NULL, NULL, NULL, NULL, 'bio', 'en', NULL, NULL, 'dassda', '2026-07-23 21:10:34', 16),
(15, '$2b$10$lgjzWtfjGRkVwWh1PxSIW.6dqOTZ.xF43GRdAgEtaHgVViO1Qb8IK', 'Filipfs', '/uploads/21bbb392927c8aa55e1357268718efd9.webp', 'Filip@2', '2026-06-30', 0, 'ACTIVE', NULL, NULL, NULL, NULL, 'dsasdss', 'pl', NULL, NULL, 'dsada', '2026-07-23 21:10:37', 16),
(16, '$2b$10$aC2dqkn.1WfnQfBabEeHK.ywYgLTPIoFjtbJFS40422uAHl5Ij3Lu', 'filipDziopa2', '/uploads/9a28a3c27a311f167bee6907942afbf0.webp', 'filip.dziopa2@gmail.com', '2026-07-10', 1, 'ACTIVE', NULL, NULL, NULL, NULL, 'dsdas', 'pl', 'a2d6366017e377726a36b6cf9f5841063f48a19ddc65a81d447dd929da877731', '2026-07-23 00:42:47', NULL, NULL, NULL),
(17, '$2b$10$cnviKJ/Qyy.MF4/p0eyQB.sRRsHG7WZsaydUuvrBaZe4HHdnA.gQm', 'Filip98', NULL, 'Filip98@gmail.com', '2026-07-11', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'pl', NULL, NULL, 'dasda', '2026-07-23 21:10:41', 16),
(18, '$2b$10$69naqYyByxJ/ILZOf7x7.eecg2cHrMhaYZLk3htlYdk8H8oTZl5VK', 'Filip99@gmail.com', NULL, 'Filip99@gmail.com', '2026-07-11', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, 'dsada', '2026-07-23 21:10:44', 16),
(21, '$2b$10$aJZBvAM9wPPnt3rzZPH2tePXRBYSgeXfgbEGH0NTqGqIw0tTa8giC', 'Filip123', NULL, 'filip.dziopa3@gmail.com', '2026-07-18', 1, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, 'okok', '2026-07-26 18:44:45', 27),
(22, '$2b$10$k6usLnDpIax4ugrcN7k4i.YArE1A.GA4LeQ1X5qoW2VmbrgyiE5o6', 'Filip', NULL, 'filip.dziopa4@gmail.com', '2026-07-18', 0, 'BANNED', NULL, 'ko', '2026-07-26 18:47:28', 16, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(23, '$2b$10$vg4KlS2udN/d02bC58ceL.98N/cc6ZQn9SpmKkQiyzLsjTEKMxrj2', 'Filip123', '/uploads/87502bd62282b1b1809e9cefc6bc48ad.webp', 'filip.dziopa5@gmail.com', '2026-07-18', 0, 'ACTIVE', NULL, NULL, NULL, NULL, 'dsad', 'en', NULL, NULL, 'jko', '2026-07-26 18:47:36', 16),
(24, '$2b$10$UPOqW6eC0mfu.8SGvPicRO2DkFhEUChY5X5V4U1qK1q58WgqiBhsW', 'Filip', NULL, 'filip.dziopa6@gmail.com', '2026-07-18', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(25, '$2b$10$hnBDEaIUgupzNr5KtBBlHOOGYdYTU4ui/FF0wTVzZq1RWLR036ruq', 'Filip', NULL, 'filip.dziopa7@gmail.com', '2026-07-18', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(27, '$2b$10$I7T2qg7lCrstKi9eBy7PK.u84/0atv/ylry9cqI.zExk7T09S4WEi', 'karina', '/uploads/1a96bc617be0f0893ac3b5da8f9b766e.webp', 'krnnyga07@gmail.com', '2026-07-19', 1, 'ACTIVE', NULL, NULL, NULL, NULL, 'sucz', 'en', NULL, NULL, NULL, NULL, NULL),
(28, '$2b$10$zb.S7V2Tk5KqX.XxV2GTS.066RUhV9enEW5Q/cs/y.uKZSPXD36rC', 'Filip', NULL, 'filip.dziopa11@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(29, '$2b$10$ippjUesK5qJjuQ.HPXcdTeXSMYsObus8EXMWkOMHQ9ASyOczXYNzO', 'Filip', NULL, 'filip.dziopa12@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(30, '$2b$10$UmsrKVgHhgfgPT9oUHMkO.KVOIPICIwHRmV8oMNCvD01DK/hCWCV.', 'Filip', NULL, 'filip.dziopa13@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(31, '$2b$10$ztDbvIhS4OBlFLnK0XHpRuvcAebi6l5XJZ.zbILcSarGtqtevZ4Am', 'Filip', NULL, 'filip.dziopa14@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(32, '$2b$10$372d7d494e47b8973cb3183b42ccac26', 'Test1', NULL, 'Test1@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(33, '$2b$10$85b1c0a76e4f83772f5953b9a393ec81', 'Test2', NULL, 'Test2@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(34, '$2b$10$f9fbe5c06c66c4ebe8663b3cff7fad84', 'Test3', NULL, 'Test3@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(35, '$2b$10$8c8d0e30c14d2f112fd45c2315ebd2b5', 'Test4', NULL, 'Test4@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(36, '$2b$10$ae6922e4b1bf3306dbcc197f0d993b43', 'Test5', NULL, 'Test5@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(37, '$2b$10$aa2bc7d4cfcd4e7c0d6f67883747fe78', 'Test6', NULL, 'Test6@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(38, '$2b$10$2d0a6b785d7e926a53b700773509ef0b', 'Test7', NULL, 'Test7@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(39, '$2b$10$fb599d0c55108be3e99e9b396424512e', 'Test8', NULL, 'Test8@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(40, '$2b$10$b53574a8be2c5622a945f951d6418049', 'Test9', NULL, 'Test9@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(41, '$2b$10$aecb42db1bf4d0860be300bf7c99f73b', 'Test10', NULL, 'Test10@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(42, '$2b$10$805972b1a5dd47555ed636c499457662', 'Test11', NULL, 'Test11@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(43, '$2b$10$feb71dbd24761787e765844b946d28ab', 'Test12', NULL, 'Test12@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(44, '$2b$10$4246db765e763dd926a730a53194fd5f', 'Test13', NULL, 'Test13@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(45, '$2b$10$7529f5df9ae202c3b5d97344ddee0397', 'Test14', NULL, 'Test14@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(46, '$2b$10$58445419e8076521a322d2525a0592e8', 'Test15', NULL, 'Test15@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(47, '$2b$10$cd9ec2d50780581419ddea04d293818a', 'Test16', NULL, 'Test16@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(48, '$2b$10$707524b5b7bcaf458cfadc258114a98c', 'Test17', NULL, 'Test17@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(49, '$2b$10$3f80b0294def1404c6d762fe78eeb557', 'Test18', NULL, 'Test18@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(50, '$2b$10$afc9491923223aca2100e0e10d484b87', 'Test19', NULL, 'Test19@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(51, '$2b$10$6224a4977ebef364c6848322a50f1ada', 'Test20', NULL, 'Test20@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(52, '$2b$10$81891533129e81005b980123542776cd', 'Test21', NULL, 'Test21@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(53, '$2b$10$675cd529ac3d165a50c24ad29f774e8c', 'Test22', NULL, 'Test22@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(54, '$2b$10$5cdef0a48bdd0210d1d2217aed415547', 'Test23', NULL, 'Test23@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(55, '$2b$10$dd6f84de0dc4e017f9d3f0bd5dac98e4', 'Test24', NULL, 'Test24@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(56, '$2b$10$3d41ab240bb0e4ef5b8ee44b3040227e', 'Test25', NULL, 'Test25@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(57, '$2b$10$c2445321cb9ed08f090ec70137e31d55', 'Test26', NULL, 'Test26@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(58, '$2b$10$b13cadc0cf7a1f85c3f45637b824c0cd', 'Test27', NULL, 'Test27@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(59, '$2b$10$8e7f412790358a24caefd60147be2906', 'Test28', NULL, 'Test28@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(60, '$2b$10$51ed20285c7d43ff7db7535dabe4519b', 'Test29', NULL, 'Test29@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(61, '$2b$10$8d7f40b15ad5b58ff756ce8c56ddee29', 'Test30', NULL, 'Test30@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(62, '$2b$10$30d3ccbd23f0a14963a8c04c2c079bc8', 'Test31', NULL, 'Test31@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(63, '$2b$10$c60eccd09d7be54a09f89ab941d3b9a4', 'Test32', NULL, 'Test32@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(64, '$2b$10$f709c9951aee11d9579cb504fd9bd84a', 'Test33', NULL, 'Test33@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(65, '$2b$10$69dc7e5776cc724e309afe69c46bba46', 'Test34', NULL, 'Test34@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(66, '$2b$10$8238dd0956c2c9e94cea0d942091abc9', 'Test35', NULL, 'Test35@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(67, '$2b$10$c1fa48aeb2dfaa13cc1e3f42fdd6880a', 'Test36', NULL, 'Test36@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(68, '$2b$10$f49411041eba57b5e805eb720049130b', 'Test37', NULL, 'Test37@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(69, '$2b$10$1a753237adc4d7d3fc78865b169df968', 'Test38', NULL, 'Test38@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(70, '$2b$10$9fa8d8c8f6c675ec8a2762db977d2724', 'Test39', NULL, 'Test39@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(71, '$2b$10$aa794dbc3303717ade941175508a458d', 'Test40', NULL, 'Test40@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(72, '$2b$10$d92ccb900270c04e6f2baefbde896a13', 'Test41', NULL, 'Test41@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(73, '$2b$10$de4ceb810b34a736a6f92685b5f93b87', 'Test42', NULL, 'Test42@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(74, '$2b$10$fc65622b89248006f7743aa50e3558a8', 'Test43', NULL, 'Test43@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(75, '$2b$10$2f3823eedb2d660a98ce5fd49c0a7536', 'Test44', NULL, 'Test44@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(76, '$2b$10$27a66f7cfbc1154069703fe129d6d10c', 'Test45', NULL, 'Test45@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(77, '$2b$10$62ed2cec65027ffe463d76b6be1e1b47', 'Test46', NULL, 'Test46@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(78, '$2b$10$90cf5c8a52b9a3e7276d71d729e1c400', 'Test47', NULL, 'Test47@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(79, '$2b$10$e71c4fdef888cfd0d29f0ec40fbdb4d8', 'Test48', NULL, 'Test48@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(80, '$2b$10$760e1430baee78a11d04addbcedd078a', 'Test49', NULL, 'Test49@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(81, '$2b$10$556269d0ab43df89700f474a24a62737', 'Test50', NULL, 'Test50@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(82, '$2b$10$a4e31bb1526b1cbf753b55c30da81a88', 'Test51', NULL, 'Test51@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(83, '$2b$10$13ad5af09b6d699362601f08d2c95648', 'Test52', NULL, 'Test52@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(84, '$2b$10$d4dd3f504a6f35859baec142af81f583', 'Test53', NULL, 'Test53@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(85, '$2b$10$80e0c1f97c0ffd29dd5e138cde841f8d', 'Test54', NULL, 'Test54@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(86, '$2b$10$a18db5b497617a8dd5673b24a6108263', 'Test55', NULL, 'Test55@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(87, '$2b$10$3bf43d5bbbdd744b55eb561b90666b3e', 'Test56', NULL, 'Test56@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(88, '$2b$10$acab141968362d8c5e7429ffc370c220', 'Test57', NULL, 'Test57@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(89, '$2b$10$c813824f640358c79d683541efaa5093', 'Test58', NULL, 'Test58@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(90, '$2b$10$8acea5328e6f53af60399131d9481ec0', 'Test59', NULL, 'Test59@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(91, '$2b$10$5ce98e8ca4ca3e5a7a050679571bbe0e', 'Test60', NULL, 'Test60@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(92, '$2b$10$26057a3e6958ada177150e64aad06432', 'Test61', NULL, 'Test61@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(93, '$2b$10$248430dc06877d9c9ae9a2a2444bb2ce', 'Test62', NULL, 'Test62@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(94, '$2b$10$bcad8480d820dafdd90521fcc07e0922', 'Test63', NULL, 'Test63@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(95, '$2b$10$12b15f24c2ce3217fa004907e88b9953', 'Test64', NULL, 'Test64@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(96, '$2b$10$705a5955616a5c9c68799a38d8fc9283', 'Test65', NULL, 'Test65@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(97, '$2b$10$1ee2093ad9e9508468c3892112303542', 'Test66', NULL, 'Test66@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(98, '$2b$10$a7c32328f051e36e15d08257545a08ab', 'Test67', NULL, 'Test67@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(99, '$2b$10$d6a094dae1d6316aaf771c14cb08dbae', 'Test68', NULL, 'Test68@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(100, '$2b$10$7730c77abcda4c53826aba19f7380c9d', 'Test69', NULL, 'Test69@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(101, '$2b$10$3ace7c78bbe4f19ad18b7d6ea1e53bef', 'Test70', NULL, 'Test70@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(102, '$2b$10$607ef2d686fa151c01d695fc5e88cc99', 'Test71', NULL, 'Test71@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(103, '$2b$10$1864b743321c80ff29a7484b42eab3d8', 'Test72', NULL, 'Test72@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(104, '$2b$10$a8e1b5bed627106460063a912cdf8a8b', 'Test73', NULL, 'Test73@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(105, '$2b$10$38422aebe9355a5486855a9fe8d32700', 'Test74', NULL, 'Test74@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(106, '$2b$10$84886dab07e558d3959c9db8b2250faf', 'Test75', NULL, 'Test75@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(107, '$2b$10$ab0663adfc6bff123f9be8d3f4eaa490', 'Test76', NULL, 'Test76@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(108, '$2b$10$6a6d3382d14859d1fb90e91d0021d862', 'Test77', NULL, 'Test77@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(109, '$2b$10$140c812c51b9d8fad10fede455f644a9', 'Test78', NULL, 'Test78@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(110, '$2b$10$0c43e3f312a9b505338eeb0806e1f928', 'Test79', NULL, 'Test79@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(111, '$2b$10$696113af152094d9a61dd354d0b02a53', 'Test80', NULL, 'Test80@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(112, '$2b$10$59cb9ebceb1fefedb389555650aa2169', 'Test81', NULL, 'Test81@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(113, '$2b$10$4c6737e00f7feb921bf4455652067348', 'Test82', NULL, 'Test82@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(114, '$2b$10$2065772e4f081e28980e31c036c8e00d', 'Test83', NULL, 'Test83@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(115, '$2b$10$b958eb344400408b354f43c401342604', 'Test84', NULL, 'Test84@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(116, '$2b$10$eb710b80c904a29e93298a2755f5b674', 'Test85', NULL, 'Test85@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(117, '$2b$10$3217ca98a2b9182e3bbbaa70cc269588', 'Test86', NULL, 'Test86@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(118, '$2b$10$87549f645e84f4f469fbfe64fb054ac9', 'Test87', NULL, 'Test87@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(119, '$2b$10$6232b66bd02e8b55436cd9d36744ecc6', 'Test88', NULL, 'Test88@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(120, '$2b$10$6622708498c656e7bb19bbb385071b00', 'Test89', NULL, 'Test89@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(121, '$2b$10$c6e77a0adff15c41de526a0470acc056', 'Test90', NULL, 'Test90@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(122, '$2b$10$f64aece59df78b3379fe2501983853f4', 'Test91', NULL, 'Test91@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(123, '$2b$10$17790e04bb6e875232e55d5d8d6d9b55', 'Test92', NULL, 'Test92@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(124, '$2b$10$fa724324ec20457806ddeb3a2fd34a3a', 'Test93', NULL, 'Test93@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(125, '$2b$10$b0fde03e56d201ede250544957e4e690', 'Test94', NULL, 'Test94@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(126, '$2b$10$722045931076b0bfa0b7458c735770cf', 'Test95', NULL, 'Test95@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(127, '$2b$10$92af49f2e486a929e7b6442d5c7e155b', 'Test96', NULL, 'Test96@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(128, '$2b$10$aad23181e5da32629f1db8c9002ace9e', 'Test97', NULL, 'Test97@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(129, '$2b$10$74527446f56eb1681d9b4e4540106015', 'Test98', NULL, 'Test98@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(130, '$2b$10$b7f56c584efc9c76b748f3240d6d925e', 'Test99', NULL, 'Test99@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(131, '$2b$10$97786c3ceabb1d10bfc854c543a9a321', 'Test100', NULL, 'Test100@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(132, '$2b$10$d6fa82b81dbf715af6277c440baa59c9', 'Test101', NULL, 'Test101@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(133, '$2b$10$73d117141070a57512d6092cd7c808b3', 'Test102', NULL, 'Test102@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(134, '$2b$10$a58336872fef15e029ab8671bcd51cbb', 'Test103', NULL, 'Test103@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(135, '$2b$10$97d40ed85c3c23258687dd60ed4ccd90', 'Test104', NULL, 'Test104@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(136, '$2b$10$bf7d4441a1bd58d64fb00d8f944d1b01', 'Test105', NULL, 'Test105@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(137, '$2b$10$c465051eca71f5c7349ac1368e4252f5', 'Test106', NULL, 'Test106@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(138, '$2b$10$4eacd41b0ed8e9e6b0df49fef130f12a', 'Test107', NULL, 'Test107@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(139, '$2b$10$26cd833ae3e107af4a93cfa426a03fa4', 'Test108', NULL, 'Test108@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(140, '$2b$10$c399191fda1d160dadbfbf4fefabd880', 'Test109', NULL, 'Test109@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(141, '$2b$10$25de1a6fadac065dc879d0b65b4e894b', 'Test110', NULL, 'Test110@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(142, '$2b$10$28e78776f983dca6c180241c56cec161', 'Test111', NULL, 'Test111@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(143, '$2b$10$3dd21364ffba6feb2d34f76658703c05', 'Test112', NULL, 'Test112@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(144, '$2b$10$dbd06312fef395e171df9e70950bfaf8', 'Test113', NULL, 'Test113@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(145, '$2b$10$a6985049447c035ec677c592c2498fe6', 'Test114', NULL, 'Test114@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(146, '$2b$10$e8f0a115f04e230107aaba5e72e64e7f', 'Test115', NULL, 'Test115@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(147, '$2b$10$c7e44db7bde9aae4d1ab4e8cfe187bca', 'Test116', NULL, 'Test116@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(148, '$2b$10$3f630d7d4986f689f79d661a9eb55afd', 'Test117', NULL, 'Test117@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(149, '$2b$10$3c5d54947919cbe7dd035095d5b734f7', 'Test118', NULL, 'Test118@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(150, '$2b$10$eb4546b965ab7c4846e3bb7557031678', 'Test119', NULL, 'Test119@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(151, '$2b$10$5cd42ef2eafeb8199113d8b60a1082f6', 'Test120', NULL, 'Test120@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(152, '$2b$10$6cb62d3a2ff3f2ace83dfe6fc7c9e8ac', 'Test121', NULL, 'Test121@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(153, '$2b$10$4df922334adf5ee51dfd15f9116a3988', 'Test122', NULL, 'Test122@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(154, '$2b$10$e2b3cba80510db64da40b0d6b49cbdd5', 'Test123', NULL, 'Test123@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(155, '$2b$10$27e79113e9a1ac41ce7a91e92c2d4cc8', 'Test124', NULL, 'Test124@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(156, '$2b$10$11b974f1a3d962d80aa05784c41d6a7e', 'Test125', NULL, 'Test125@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(157, '$2b$10$35d2400e41e70974151d238d9d2fa38b', 'Test126', NULL, 'Test126@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(158, '$2b$10$51d6de4fd24f473e496c640e72198244', 'Test127', NULL, 'Test127@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(159, '$2b$10$aadbac9d67febff935b4134b08618ee7', 'Test128', NULL, 'Test128@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(160, '$2b$10$93e7a5d878c56cd153385e8522516812', 'Test129', NULL, 'Test129@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(161, '$2b$10$3a877cf9b24b92a722fa01b9bd83705c', 'Test130', NULL, 'Test130@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(162, '$2b$10$f91aa1b23298b95285dfe83943d0b48b', 'Test131', NULL, 'Test131@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(163, '$2b$10$3b9ea31bc73529d08094c7ead7ade6dc', 'Test132', NULL, 'Test132@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(164, '$2b$10$75ec96026a3a743def7f7ec13391363e', 'Test133', NULL, 'Test133@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(165, '$2b$10$68f47a9265725ce520fc2f81387a5111', 'Test134', NULL, 'Test134@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(166, '$2b$10$5ca1d08a1ce50860093fc3eb7d9bcea2', 'Test135', NULL, 'Test135@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(167, '$2b$10$5ccdbb6fa21921c02ee89bea9f875f36', 'Test136', NULL, 'Test136@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(168, '$2b$10$a2eafc8e1db39f1f658d203545471c00', 'Test137', NULL, 'Test137@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(169, '$2b$10$4a6dcccce4816d34a9eb35287fe8817c', 'Test138', NULL, 'Test138@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(170, '$2b$10$155d2fbd8724fd92d4048bdd84fdfb52', 'Test139', NULL, 'Test139@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(171, '$2b$10$0b5579a3cc845b6eb90ec87574b991ab', 'Test140', NULL, 'Test140@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(172, '$2b$10$7173ac83d05ddf83f035cbdaf567ba29', 'Test141', NULL, 'Test141@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(173, '$2b$10$71614351838c7dcaca861cf970dab301', 'Test142', NULL, 'Test142@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(174, '$2b$10$5ddd32ac8194438f3ff2354c730ccd8b', 'Test143', NULL, 'Test143@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(175, '$2b$10$035b323e9dec42274e5040eef033b30d', 'Test144', NULL, 'Test144@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(176, '$2b$10$7aac97c3ffc7c1cdb890e555c799df74', 'Test145', NULL, 'Test145@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(177, '$2b$10$409b8f76f87b10f7c6ca1c1a30a2b39d', 'Test146', NULL, 'Test146@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(178, '$2b$10$7eadee2bd8e0cd2636c39206d487287d', 'Test147', NULL, 'Test147@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(179, '$2b$10$286dcbf2fc465f2b511512df377c2564', 'Test148', NULL, 'Test148@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(180, '$2b$10$c23a96d95ac79f66488ca2ba23b94d72', 'Test149', NULL, 'Test149@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(181, '$2b$10$751665d57ca87b7d797b149ef09bb9db', 'Test150', NULL, 'Test150@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(183, '$2b$10$08032a9d729648ee48c025e8eae4d845', 'Test151', NULL, 'Test151@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(184, '$2b$10$dcf7d28dc6d70b0df87cc0c1518b10a0', 'Test152', NULL, 'Test152@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(185, '$2b$10$eb6aecf84086272d80916ab691275194', 'Test153', NULL, 'Test153@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(186, '$2b$10$8940c2d64675a83d751c658114b3b00b', 'Test154', NULL, 'Test154@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(187, '$2b$10$2aaad66c400e0440fdc9c697b1dc74a4', 'Test155', NULL, 'Test155@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(188, '$2b$10$25ebc036e2f9e81a825806161ce48601', 'Test156', NULL, 'Test156@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(189, '$2b$10$66fa8d4f3d7e07e2787e623b249eb7c4', 'Test157', NULL, 'Test157@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(190, '$2b$10$e857411af71f299d5f45dd6c52fb3aef', 'Test158', NULL, 'Test158@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(191, '$2b$10$2d320e2608a70bf490ecd258f6510a8c', 'Test159', NULL, 'Test159@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(192, '$2b$10$42bbe6182c1b3021d7fbb0d1aa35a947', 'Test160', NULL, 'Test160@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(193, '$2b$10$d2a3e8e6c7de6662b4efca8e7ead8a01', 'Test161', NULL, 'Test161@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(194, '$2b$10$83483686289465b68e15f96f8301d3cf', 'Test162', NULL, 'Test162@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(195, '$2b$10$b2743e1c1b8508c2902173f8c740abe6', 'Test163', NULL, 'Test163@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(196, '$2b$10$a3ccf5b9b380c24cf8b2a20f356223a7', 'Test164', NULL, 'Test164@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(197, '$2b$10$f6a95e304ada99b3dc483d279e0023b7', 'Test165', NULL, 'Test165@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(198, '$2b$10$de206c85d433f57389641773ef4e0e3a', 'Test166', NULL, 'Test166@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(199, '$2b$10$ca0124dd12b351ef75f65d7bd7453be4', 'Test167', NULL, 'Test167@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(200, '$2b$10$38070860ad1e9abdb770bd3bd32a8e4a', 'Test168', NULL, 'Test168@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(201, '$2b$10$fcca6945dee5b75b817de26bf32196e0', 'Test169', NULL, 'Test169@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(202, '$2b$10$898abdeaa9c42300b648c1375b061bc3', 'Test170', NULL, 'Test170@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(203, '$2b$10$6c13cecf62d54a4867168a179a84cd25', 'Test171', NULL, 'Test171@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(204, '$2b$10$878534e3fe0d5a92dbc8d75f4868d5cb', 'Test172', NULL, 'Test172@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(205, '$2b$10$20aa2857f2be2e1672bfd8dd2e9a6709', 'Test173', NULL, 'Test173@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(206, '$2b$10$3f0f8ff8e49a1783e31f985765fb40bb', 'Test174', NULL, 'Test174@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(207, '$2b$10$8904ec8fbead012a4ba4856fb273376a', 'Test175', NULL, 'Test175@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(208, '$2b$10$2c6aaa84474ac2735bc65e97c658a737', 'Test176', NULL, 'Test176@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(209, '$2b$10$560f1b8419a91a896ff79fe9e5e40c86', 'Test177', NULL, 'Test177@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(210, '$2b$10$5176662956fbb920d9a8214f22d6e1ed', 'Test178', NULL, 'Test178@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(211, '$2b$10$5d46eab6063f738020bd34babccf1cf3', 'Test179', NULL, 'Test179@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(212, '$2b$10$24a1d5dec1fbeb4962314fa952f5af46', 'Test180', NULL, 'Test180@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(213, '$2b$10$675649362bcf7dc7debe6e14e3f1ea5d', 'Test181', NULL, 'Test181@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(214, '$2b$10$fccbf8c37ea4c29b36c64c4bb93457b0', 'Test182', NULL, 'Test182@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(215, '$2b$10$338fdf56b744643530c2185abcece0b3', 'Test183', NULL, 'Test183@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(216, '$2b$10$187fcd55da57aa293a7e80c4ed04d0fb', 'Test184', NULL, 'Test184@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(217, '$2b$10$979517131a38c0402ac84f524c20b502', 'Test185', NULL, 'Test185@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(218, '$2b$10$1b6595d0bb43a46e3f5713eeedbfbcc3', 'Test186', NULL, 'Test186@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(219, '$2b$10$c99e1f9417b1b1a4b433d06879e40daf', 'Test187', NULL, 'Test187@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(220, '$2b$10$b5895f928524631e468c98fc5f8dd314', 'Test188', NULL, 'Test188@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(221, '$2b$10$d1c02c6eb61ee4c9f7fd82ebc6efc9b1', 'Test189', NULL, 'Test189@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(222, '$2b$10$58f3bb0269a4d8c8e5251f289ada5bc7', 'Test190', NULL, 'Test190@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(223, '$2b$10$0c9fab4c01999e133c17487d3367bd9d', 'Test191', NULL, 'Test191@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(224, '$2b$10$9feef523df245a3cfb491fbda9550184', 'Test192', NULL, 'Test192@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(225, '$2b$10$1e1ac10868c2f46b63611441fce680b6', 'Test193', NULL, 'Test193@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(226, '$2b$10$bf545dc4788dd51d86343f5fa99ce822', 'Test194', NULL, 'Test194@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(227, '$2b$10$776e733baa94f898e3847d7626c5d207', 'Test195', NULL, 'Test195@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(228, '$2b$10$b9bf032d8ed243273f846288ab8e0672', 'Test196', NULL, 'Test196@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(229, '$2b$10$22f0a7dafafa780eb76082d321d81fdd', 'Test197', NULL, 'Test197@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(230, '$2b$10$76866142f1f575b3ba828852982ad087', 'Test198', NULL, 'Test198@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(231, '$2b$10$fc1f9d7317ac6f93f76fa54723e73367', 'Test199', NULL, 'Test199@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(232, '$2b$10$d9c41f4a527d04e466d3f7ad6139cfe1', 'Test200', NULL, 'Test200@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(233, '$2b$10$e422eca4a3e690908ca94087dd6939cb', 'Test201', NULL, 'Test201@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(234, '$2b$10$fb8abb7b32d691f3db93b5f545097c6d', 'Test202', NULL, 'Test202@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(235, '$2b$10$f6a2d6fc2ba1075f1a3a98cbde7d35cb', 'Test203', NULL, 'Test203@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(236, '$2b$10$6acf44a073f7a3a87bb264b49a6517e8', 'Test204', NULL, 'Test204@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(237, '$2b$10$c70a375d76d1ca2840b5be555d3038e6', 'Test205', NULL, 'Test205@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(238, '$2b$10$f48f67efee260752de174d32fd0430d4', 'Test206', NULL, 'Test206@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(239, '$2b$10$23d6ab46d158f533c62cda82ea86e864', 'Test207', NULL, 'Test207@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(240, '$2b$10$8941253e0c55151e44247616b9b527a0', 'Test208', NULL, 'Test208@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(241, '$2b$10$227b3cc352aed76ee8cddfde62cda06e', 'Test209', NULL, 'Test209@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(242, '$2b$10$28413905e7f6a0f9e65fe90174da062f', 'Test210', NULL, 'Test210@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(243, '$2b$10$49611ce478d9c5c710614ed43c5c3636', 'Test211', NULL, 'Test211@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(244, '$2b$10$543d8522dc85878485f0852e37e1b692', 'Test212', NULL, 'Test212@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(245, '$2b$10$8b1afcad965bce57124486e545c2a151', 'Test213', NULL, 'Test213@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(246, '$2b$10$3b052e9868fd597dab27ae83a33b17b4', 'Test214', NULL, 'Test214@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(247, '$2b$10$f2512d5bcf710fc51a794259b03e7ce1', 'Test215', NULL, 'Test215@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(248, '$2b$10$0d0209dbc7891755d049e454d389b2c6', 'Test216', NULL, 'Test216@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(249, '$2b$10$0372eb747d683d8f3b544818c9e38da0', 'Test217', NULL, 'Test217@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(250, '$2b$10$df199611d2d79ea41d2e6397bfd8b80f', 'Test218', NULL, 'Test218@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(251, '$2b$10$c8040a6eb49cf9e881cc9e2b6fd3b417', 'Test219', NULL, 'Test219@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(252, '$2b$10$fa2cccaa02ba4c24692f7344d3164fbc', 'Test220', NULL, 'Test220@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(253, '$2b$10$610cd633487716b30778f6e54dc3bbb7', 'Test221', NULL, 'Test221@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(254, '$2b$10$4ea6048973cb0722f88312bce87bed4b', 'Test222', NULL, 'Test222@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(255, '$2b$10$3ae1d21b410730935d651dbdbe3414d7', 'Test223', NULL, 'Test223@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(256, '$2b$10$d4e569c929c6047dda8f5b95a0bc78ff', 'Test224', NULL, 'Test224@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(257, '$2b$10$3892a99d91e1d426292033b17ca26c3d', 'Test225', NULL, 'Test225@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(258, '$2b$10$6211db6590e91b014ec4a3576a24d5cf', 'Test226', NULL, 'Test226@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(259, '$2b$10$d039dd722b32785273fa466115506ec8', 'Test227', NULL, 'Test227@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(260, '$2b$10$73774f3bbf37cfcaacf06f40ff0b22be', 'Test228', NULL, 'Test228@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(261, '$2b$10$4173e1a3801c0145e58626a5c389b828', 'Test229', NULL, 'Test229@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(262, '$2b$10$e9ea519decf31ac87d127fd1d54b4b4d', 'Test230', NULL, 'Test230@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(263, '$2b$10$26fa8373dfa8f9b6770a8d4e1879525e', 'Test231', NULL, 'Test231@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(264, '$2b$10$44d4d95a84d9ac0bd6a9322bf6e6f6e3', 'Test232', NULL, 'Test232@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(265, '$2b$10$5329d99602fa5822a3f2f8ffc3660da1', 'Test233', NULL, 'Test233@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(266, '$2b$10$7fb6a13c3e78a651c3c45337773cf33e', 'Test234', NULL, 'Test234@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(267, '$2b$10$279a049040143675c622bb867e378b8a', 'Test235', NULL, 'Test235@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(268, '$2b$10$55e68cf94e008e478cb8c891ed8f0341', 'Test236', NULL, 'Test236@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(269, '$2b$10$023bea3107b891db13670381a524cf18', 'Test237', NULL, 'Test237@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(270, '$2b$10$a40394d22f6f2b681778b24a26b01997', 'Test238', NULL, 'Test238@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(271, '$2b$10$597c003d35918c50a3c4b721142e3789', 'Test239', NULL, 'Test239@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(272, '$2b$10$f54da8d7c27f0bddee04a3ac19297079', 'Test240', NULL, 'Test240@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(273, '$2b$10$68c26ca72d8020811188eccb76489718', 'Test241', NULL, 'Test241@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(274, '$2b$10$e1ed856bae99268ca7f8dcb6357cfb93', 'Test242', NULL, 'Test242@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(275, '$2b$10$fc6002d1c02e0b68b7aded9e35d9cc5f', 'Test243', NULL, 'Test243@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(276, '$2b$10$4504e6a34326b18f5721460d1ded25d2', 'Test244', NULL, 'Test244@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(277, '$2b$10$6cdefb362f5aacce7613ad4bc409b8f1', 'Test245', NULL, 'Test245@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(278, '$2b$10$a73ab73fbf64a069b5c34707d21c02f4', 'Test246', NULL, 'Test246@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(279, '$2b$10$5b0f290105d59a6c91e62244562e372c', 'Test247', NULL, 'Test247@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(280, '$2b$10$046c9b5f70649c492fd17d550b5bdb09', 'Test248', NULL, 'Test248@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(281, '$2b$10$2e8b1f4189d3fab306bff6e6a4f5fc0c', 'Test249', NULL, 'Test249@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(282, '$2b$10$2dd343cf076e4bfab7144c3fe4f6ca99', 'Test250', NULL, 'Test250@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(283, '$2b$10$9f89e31e9fe3863e3dfb148d208b688c', 'Test251', NULL, 'Test251@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `users` (`id`, `password`, `username`, `avatar_url`, `email`, `created_at`, `role`, `status`, `suspended_until`, `ban_reason`, `banned_at`, `banned_by`, `bio`, `language_code`, `reset_token`, `reset_token_expiry`, `suspend_reason`, `suspended_at`, `suspended_by`) VALUES
(284, '$2b$10$9434db5f44b5f7c5e383be3e4d9e5b89', 'Test252', NULL, 'Test252@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(285, '$2b$10$19757435e3a851e8c74a5e9b7999d314', 'Test253', NULL, 'Test253@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(286, '$2b$10$43a2b41a0b94dd0e181a0e7ccf1550b4', 'Test254', NULL, 'Test254@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(287, '$2b$10$9afee95fe2034d559fe72ffcc33acce6', 'Test255', NULL, 'Test255@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(288, '$2b$10$982e213e2b97bd870dd915700d3ed99b', 'Test256', NULL, 'Test256@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(289, '$2b$10$f2782bd916af9eccb2fb0e4ebb18743b', 'Test257', NULL, 'Test257@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(290, '$2b$10$19972c9348750079c730131b8a1df0a3', 'Test258', NULL, 'Test258@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(291, '$2b$10$531cc10eed8510dba4e5f834752011ae', 'Test259', NULL, 'Test259@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(292, '$2b$10$3f1ab632bd70f0e11ab0814c85db1813', 'Test260', NULL, 'Test260@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(293, '$2b$10$81e4e8f3f7f90ef9403af93bef10d07e', 'Test261', NULL, 'Test261@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(294, '$2b$10$70643885ec7a5138df5d5fd5e29e2fd7', 'Test262', NULL, 'Test262@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(295, '$2b$10$8036734a67c07a26115c9fdce7642bd4', 'Test263', NULL, 'Test263@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(296, '$2b$10$f1d498b123d59aaa98bb2d9970a1d29f', 'Test264', NULL, 'Test264@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(297, '$2b$10$001380fe117549a355f56af4830f2676', 'Test265', NULL, 'Test265@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(298, '$2b$10$d58a11cfb6a44bf064d45cf0bc741108', 'Test266', NULL, 'Test266@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(299, '$2b$10$c322ecc4f022a77ab98249ec423f61df', 'Test267', NULL, 'Test267@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(300, '$2b$10$2968d51e3745141b3138fbefd97c2abf', 'Test268', NULL, 'Test268@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(301, '$2b$10$51366b18f7652ca0b1ece378a7a47ad1', 'Test269', NULL, 'Test269@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(302, '$2b$10$0fba4d9970eb881ef90373839d37add8', 'Test270', NULL, 'Test270@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(303, '$2b$10$c157ee9dee9b88cfc1ff7253f96cd111', 'Test271', NULL, 'Test271@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(304, '$2b$10$bd0464fb3c47a1c904ea6853932c6c2e', 'Test272', NULL, 'Test272@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(305, '$2b$10$d03b238a2bc6998e8465739f2e9daa81', 'Test273', NULL, 'Test273@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(306, '$2b$10$159b331a1e611ff444b4d56208f162fa', 'Test274', NULL, 'Test274@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(307, '$2b$10$bd673d01549a567d620f1b70116bbd72', 'Test275', NULL, 'Test275@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(308, '$2b$10$c2177119c6b98156e6b7be0ee4cc23d6', 'Test276', NULL, 'Test276@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(309, '$2b$10$c305bc6d17aab4012243b32063b5dad3', 'Test277', NULL, 'Test277@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(310, '$2b$10$92185967a0b9475a8e2ebb338b9150e2', 'Test278', NULL, 'Test278@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(311, '$2b$10$e91c2d2aeaf253fe97d2c5e8a74c3e33', 'Test279', NULL, 'Test279@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(312, '$2b$10$e1b321489aa076aa95c75d3a94807df8', 'Test280', NULL, 'Test280@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(313, '$2b$10$ffba97e37ddbbcec83acaf8ac5725230', 'Test281', NULL, 'Test281@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(314, '$2b$10$bbec16a6af6692160428f751a4ef5c5d', 'Test282', NULL, 'Test282@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(315, '$2b$10$78e066f5d2490d988e99ae3e5431f436', 'Test283', NULL, 'Test283@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(316, '$2b$10$dd947c1e800de2f3e43d2532df0d7073', 'Test284', NULL, 'Test284@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(317, '$2b$10$8377c295914cfe6a9b5ea0d8cd05fe1a', 'Test285', NULL, 'Test285@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(318, '$2b$10$c9d3d4752d4cee20fb4b1d7044f81232', 'Test286', NULL, 'Test286@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(319, '$2b$10$12110425d9ca30ecd5b3c56064960383', 'Test287', NULL, 'Test287@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(320, '$2b$10$e15a1f2d5c0d24676b0d67cf389a7a4f', 'Test288', NULL, 'Test288@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(321, '$2b$10$e3eb72d448030d8e4e9ca9e2a25438e5', 'Test289', NULL, 'Test289@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(322, '$2b$10$1eb6ff83e1f76e908f929ed7da071dbb', 'Test290', NULL, 'Test290@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(323, '$2b$10$ba71d5ee7e40c9f22097a6f016852376', 'Test291', NULL, 'Test291@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(324, '$2b$10$836678df965803dd052aae5e1c6a122d', 'Test292', NULL, 'Test292@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(325, '$2b$10$66139c22b70b023e35faf6700ff8acec', 'Test293', NULL, 'Test293@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(326, '$2b$10$1b81b16f1f16c73f8093be8a989578b3', 'Test294', NULL, 'Test294@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(327, '$2b$10$331de8212160f11247e2f3bd1fcde8a4', 'Test295', NULL, 'Test295@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(328, '$2b$10$4998e6d77217f5601ae85b1ff8c8a1e0', 'Test296', NULL, 'Test296@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(329, '$2b$10$bc7039dfe9fbf8aaf84deb9787ea228b', 'Test297', NULL, 'Test297@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(330, '$2b$10$fced9cd561d629586763239c915656b3', 'Test298', NULL, 'Test298@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(331, '$2b$10$b801055f560d710db3fb280e81d51d82', 'Test299', NULL, 'Test299@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(332, '$2b$10$1c571e730b3b79ac48d6a048589df6ae', 'Test300', NULL, 'Test300@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(333, '$2b$10$dfb714988076e758563cc694b43260e9', 'Test301', NULL, 'Test301@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(334, '$2b$10$4a46e130372c42f71ac85595d245d2f7', 'Test302', NULL, 'Test302@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(335, '$2b$10$a7ed39249749ad3945868b9616cc3e0f', 'Test303', NULL, 'Test303@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(336, '$2b$10$6f7357465e409c653acf7064614e2054', 'Test304', NULL, 'Test304@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(337, '$2b$10$6aaab9f26d0a90096d605272a22fcc4a', 'Test305', NULL, 'Test305@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(338, '$2b$10$37e26523cf8a47f4e8077ef472b1a3a5', 'Test306', NULL, 'Test306@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(339, '$2b$10$6088c526ddcefbebe9e3e86b4b5cf3fa', 'Test307', NULL, 'Test307@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(340, '$2b$10$d4e8d84e287b974062101c5dd2fd0442', 'Test308', NULL, 'Test308@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(341, '$2b$10$c9909c19a40507e8c1f87c9a69c41e2b', 'Test309', NULL, 'Test309@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(342, '$2b$10$a40688c86eea3b75df3eb22681fd77f6', 'Test310', NULL, 'Test310@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(343, '$2b$10$6352db85ef113d3c06fe976b2979feeb', 'Test311', NULL, 'Test311@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(344, '$2b$10$aedcec42d0766a0ae32dc8e35681c337', 'Test312', NULL, 'Test312@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(345, '$2b$10$149c6ceb9c6d7fe00ce21066f7dcf873', 'Test313', NULL, 'Test313@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(346, '$2b$10$11feab4242a60e860a38f79d5eab2bc4', 'Test314', NULL, 'Test314@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(347, '$2b$10$19199f9742759264cabad1cf399a8ae2', 'Test315', NULL, 'Test315@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(348, '$2b$10$3bdf9292b0b72835ea232450e338a229', 'Test316', NULL, 'Test316@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(349, '$2b$10$a0de227ce8a0eb7a6b6026ce141b3500', 'Test317', NULL, 'Test317@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(350, '$2b$10$46e7c5db04a5bef8ac024826471ac6e2', 'Test318', NULL, 'Test318@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(351, '$2b$10$d45b44bdfba5ef0048a6f4a05d73e3b9', 'Test319', NULL, 'Test319@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(352, '$2b$10$22dbd20fd55eed5b3ceed45fb7654138', 'Test320', NULL, 'Test320@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(353, '$2b$10$edcc719324c1f6ea6e02e1efcc180955', 'Test321', NULL, 'Test321@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(354, '$2b$10$2c7143d49c5cede4011a764e183c6c7f', 'Test322', NULL, 'Test322@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(355, '$2b$10$fb66ca0120a5bfc27ff20dddb118049c', 'Test323', NULL, 'Test323@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(356, '$2b$10$cbe78811f436bb7c505c5d42a49fbc0f', 'Test324', NULL, 'Test324@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(357, '$2b$10$14a0fe0774948e91ea1883e4bd6da0d0', 'Test325', NULL, 'Test325@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(358, '$2b$10$5326cec9b5ef0cb381a4573a486e4146', 'Test326', NULL, 'Test326@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(359, '$2b$10$479e97a8a9e336a70e2029bc153d5e81', 'Test327', NULL, 'Test327@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(360, '$2b$10$e96bfcf87e30ac9e165ceb1ac6553777', 'Test328', NULL, 'Test328@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(361, '$2b$10$50052a02d9aafb949dc4ce9cfde563b3', 'Test329', NULL, 'Test329@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(362, '$2b$10$901c08af6e7de78d8cc178f3ea6dc65e', 'Test330', NULL, 'Test330@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(363, '$2b$10$d81687aaee6c7b48397736d2a11a7780', 'Test331', NULL, 'Test331@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(364, '$2b$10$07a2983a4ebff992e73759431db4fac8', 'Test332', NULL, 'Test332@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(365, '$2b$10$0a8d6f1114a1b9357e4dac3c53e82d49', 'Test333', NULL, 'Test333@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(366, '$2b$10$bd3955ce3fd027abf339c67872e3d078', 'Test334', NULL, 'Test334@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(367, '$2b$10$70fa38f9bbb5847c007dd87a67b7f3ee', 'Test335', NULL, 'Test335@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(368, '$2b$10$c4b25ccb256a4e80871660d827558e56', 'Test336', NULL, 'Test336@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(369, '$2b$10$5d13e3fac787f3a63ed3b66a3f2a9fa5', 'Test337', NULL, 'Test337@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(370, '$2b$10$01253d42e8e70dd3c9cf826791012ace', 'Test338', NULL, 'Test338@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(371, '$2b$10$e83097ad2391030e041ade27fa4e8f3c', 'Test339', NULL, 'Test339@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(372, '$2b$10$ae4ebfe8151fb1bf2dbe67c2014466eb', 'Test340', NULL, 'Test340@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(373, '$2b$10$2b2328d72fba6172c34e7d01a2ec12b7', 'Test341', NULL, 'Test341@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(374, '$2b$10$caba093e319dafe3f4098ed14b1c0265', 'Test342', NULL, 'Test342@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(375, '$2b$10$ad22c7bde89aaf47741591726641c894', 'Test343', NULL, 'Test343@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(376, '$2b$10$63bf9b642b7bb832a696322089218e37', 'Test344', NULL, 'Test344@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(377, '$2b$10$0760f8cf4660e18b6f8c22c13f4fea42', 'Test345', NULL, 'Test345@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(378, '$2b$10$f0b61b1d94f0f029e8d269a800089a06', 'Test346', NULL, 'Test346@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(379, '$2b$10$9388f5b6318474b427d00654a6b0f5e6', 'Test347', NULL, 'Test347@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(380, '$2b$10$9f5fca5ceaf5c37fd3ec74861b945844', 'Test348', NULL, 'Test348@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(381, '$2b$10$5d612ae451194e4e430f7655bcc52750', 'Test349', NULL, 'Test349@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(382, '$2b$10$aa009804a83aa99ed07fdbfdcef78981', 'Test350', NULL, 'Test350@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(383, '$2b$10$af1cc76b477367e293fdf4f934482ff7', 'Test351', NULL, 'Test351@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(384, '$2b$10$c5d30a37f44ed4c41e3b1ea9e26523b1', 'Test352', NULL, 'Test352@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(385, '$2b$10$6c09a026ef0ed45bd00f786c7387c09b', 'Test353', NULL, 'Test353@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(386, '$2b$10$ea54c9d4de617d10b726760e17a4d33a', 'Test354', NULL, 'Test354@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(387, '$2b$10$455868f6d7d28f26cf77b745c0bd18f0', 'Test355', NULL, 'Test355@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(388, '$2b$10$75c5b8b21248cf2294e625bda7f623e9', 'Test356', NULL, 'Test356@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(389, '$2b$10$72fa300cf95e2260fbd096ab4f405191', 'Test357', NULL, 'Test357@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(390, '$2b$10$aadf6088b593d73a7d55058e5b4609bf', 'Test358', NULL, 'Test358@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(391, '$2b$10$efd29c73ea4e3a449b3aaddaf4686997', 'Test359', NULL, 'Test359@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(392, '$2b$10$8aebeaba75ff9bded8ed81edcba40019', 'Test360', NULL, 'Test360@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(393, '$2b$10$c3116f589af81c8956b89ff91c429ee0', 'Test361', NULL, 'Test361@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(394, '$2b$10$375969e0bb71bb05bd3be4801156221c', 'Test362', NULL, 'Test362@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(395, '$2b$10$36d21592274d8b6d57b039aabc12e67f', 'Test363', NULL, 'Test363@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(396, '$2b$10$06a1d7ebda0e0ed860514edeee5d6a01', 'Test364', NULL, 'Test364@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(397, '$2b$10$9e10fe3ac25a6f7ac424f2004475c1a5', 'Test365', NULL, 'Test365@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(398, '$2b$10$a4f79810bceab9cc8b3ad9c3de0feeac', 'Test366', NULL, 'Test366@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(399, '$2b$10$86d05863cfab766234c2da670ae50b1d', 'Test367', NULL, 'Test367@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(400, '$2b$10$affe0f9828f3188a64f83d7785472b77', 'Test368', NULL, 'Test368@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(401, '$2b$10$4de253f1b9014e9c1b8cbd0287033601', 'Test369', NULL, 'Test369@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(402, '$2b$10$696865485ae8933ae77fb006102a3bb4', 'Test370', NULL, 'Test370@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(403, '$2b$10$70019d8585b8b4edec9e8b98c89f804b', 'Test371', NULL, 'Test371@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(404, '$2b$10$36dcab2cefecd6756e2e07ae22b42498', 'Test372', NULL, 'Test372@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(405, '$2b$10$824229740d4e949ba3ab63d2a6c284a2', 'Test373', NULL, 'Test373@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(406, '$2b$10$cf419342505ba713d62be061351865cd', 'Test374', NULL, 'Test374@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(407, '$2b$10$73389db9c7094b9e6dc86e95c058f779', 'Test375', NULL, 'Test375@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(408, '$2b$10$37fafa66e70d6c87dcbf7cebe9db69f3', 'Test376', NULL, 'Test376@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(409, '$2b$10$93eca71aa1e4ac38b94debafde59eb9b', 'Test377', NULL, 'Test377@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(410, '$2b$10$461df9c58894e89922fc3ce8c12e66ce', 'Test378', NULL, 'Test378@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(411, '$2b$10$6f60659dda01cdc7d0fee36f52bc9937', 'Test379', NULL, 'Test379@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(412, '$2b$10$70cc9d3f2fc0dfff2e3d639606982422', 'Test380', NULL, 'Test380@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(413, '$2b$10$bdde5b10ea86ecf40d104ab646b93905', 'Test381', NULL, 'Test381@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(414, '$2b$10$123067916bc42371a116e0335ce5697e', 'Test382', NULL, 'Test382@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(415, '$2b$10$07ccdc01927899b22aa5922d75ac9438', 'Test383', NULL, 'Test383@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(416, '$2b$10$e050ce57b3f7b0cef6fd5ffabc256c13', 'Test384', NULL, 'Test384@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(417, '$2b$10$634011c790e552a7e912287d07cb8b27', 'Test385', NULL, 'Test385@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(418, '$2b$10$5d4c21ea1e2ed282e1a6295eebdb7af0', 'Test386', NULL, 'Test386@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(419, '$2b$10$a8036c2a482e3fbedfe0640cf3e82575', 'Test387', NULL, 'Test387@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(420, '$2b$10$139bedead9417db866c06a857edd0a93', 'Test388', NULL, 'Test388@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(421, '$2b$10$4107c0a0188b780f4d9e0c8e25e6fb0f', 'Test389', NULL, 'Test389@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(422, '$2b$10$2093853ec1d86e6d7f31325b6a295f67', 'Test390', NULL, 'Test390@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(423, '$2b$10$e5945f51b7479599c829894254a4ca8e', 'Test391', NULL, 'Test391@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(424, '$2b$10$5636949b47fe9f08e5c5a65b95ba3818', 'Test392', NULL, 'Test392@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(425, '$2b$10$3a71d3a15daa019ef054620adef1ef04', 'Test393', NULL, 'Test393@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(426, '$2b$10$2c5feebd1a4ad8ef93d2077e41e3d5fb', 'Test394', NULL, 'Test394@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(427, '$2b$10$716de800a6fe28782ad91579537a92ee', 'Test395', NULL, 'Test395@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(428, '$2b$10$4cdf083b6e0d9ae22b84829e06a98140', 'Test396', NULL, 'Test396@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(429, '$2b$10$756e391f8ddddbdbeb120e71b8d32fb0', 'Test397', NULL, 'Test397@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(430, '$2b$10$a168bb3ee32f5a46996dbd2d71e0b759', 'Test398', NULL, 'Test398@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(431, '$2b$10$415c43878e4c31ebcd1560aa67111cce', 'Test399', NULL, 'Test399@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(432, '$2b$10$64c0599adb5a57b14a219b804c912304', 'Test400', NULL, 'Test400@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(433, '$2b$10$b2c355535a32acd3a625483bd09f5398', 'Test401', NULL, 'Test401@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(434, '$2b$10$b008a053178af6f3ce1bd526a5b688c7', 'Test402', NULL, 'Test402@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(435, '$2b$10$5e739a2b38474a567dbd461935152741', 'Test403', NULL, 'Test403@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(436, '$2b$10$8d7e71fa41180124762d01f3a5ea1089', 'Test404', NULL, 'Test404@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(437, '$2b$10$62449b79a2c8127fec611ed7694b826c', 'Test405', NULL, 'Test405@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(438, '$2b$10$cbd19fcf0afa4e9d24136f306eecf5ae', 'Test406', NULL, 'Test406@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(439, '$2b$10$c75867e7017780fa47ccc8ef0a00c7b0', 'Test407', NULL, 'Test407@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(440, '$2b$10$c10658835d04a1ef80063b900bf555c4', 'Test408', NULL, 'Test408@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(441, '$2b$10$d642c0be041062ec4015ca61dc27a7ad', 'Test409', NULL, 'Test409@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(442, '$2b$10$0f51eaa4ce09ef56bd74f9c7417343fe', 'Test410', NULL, 'Test410@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(443, '$2b$10$e7cc9ede632620b7390fb5ad94688906', 'Test411', NULL, 'Test411@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(444, '$2b$10$4aea6e0e8688a37487dcdfda0808a04d', 'Test412', NULL, 'Test412@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(445, '$2b$10$ac4c8a5f16a87261dbfda386bd27eabd', 'Test413', NULL, 'Test413@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(446, '$2b$10$1b78c6291ecb7a60c533d4e7237146ab', 'Test414', NULL, 'Test414@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(447, '$2b$10$a2f154931a9cf96668ab6f366c880a5d', 'Test415', NULL, 'Test415@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(448, '$2b$10$dd04d11e6d8ce4a585473535866b9f6e', 'Test416', NULL, 'Test416@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(449, '$2b$10$f7b5d0c42cc1e2f19745c6549eb7a7d1', 'Test417', NULL, 'Test417@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(450, '$2b$10$165a589a33569c2f24add4646e22be88', 'Test418', NULL, 'Test418@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(451, '$2b$10$24b0511277044c269920292f5d5ee4be', 'Test419', NULL, 'Test419@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(452, '$2b$10$c7f268f3de298ab69c1773951ab79fa8', 'Test420', NULL, 'Test420@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(453, '$2b$10$62970f67231ce3213194e7e81b1ac2c1', 'Test421', NULL, 'Test421@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(454, '$2b$10$4630f4d4c9a446e4a732e150a9948fc1', 'Test422', NULL, 'Test422@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(455, '$2b$10$ab8659dd54b1a018f3bc64f05218598f', 'Test423', NULL, 'Test423@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(456, '$2b$10$6fa5a4325b35c0d56acef27f42968db9', 'Test424', NULL, 'Test424@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(457, '$2b$10$09b2d4c8260e00759fa10c21905b59a8', 'Test425', NULL, 'Test425@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(458, '$2b$10$f30ba0d2ca87e837365a730df2e248a8', 'Test426', NULL, 'Test426@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(459, '$2b$10$bdb5e7877bf3d6d4323214c5b607d5af', 'Test427', NULL, 'Test427@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(460, '$2b$10$d09bf4ddb7108ad66dd0183048da99dc', 'Test428', NULL, 'Test428@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(461, '$2b$10$3e02c4e67b1945d5ea6d2cad63864bd8', 'Test429', NULL, 'Test429@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(462, '$2b$10$37711d2375a7e3e1108bb0bb0ef3f62d', 'Test430', NULL, 'Test430@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(463, '$2b$10$31c901da0e2dfb159eb9bd07aacda220', 'Test431', NULL, 'Test431@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(464, '$2b$10$6bda64443fa12dddeeb3f720c0113265', 'Test432', NULL, 'Test432@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(465, '$2b$10$1581a367dd6ae58a55a1af33ee193c08', 'Test433', NULL, 'Test433@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(466, '$2b$10$f17ba5333bde7b1153932902c0b53187', 'Test434', NULL, 'Test434@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(467, '$2b$10$855688abb960cdbada4052543deea4b3', 'Test435', NULL, 'Test435@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(468, '$2b$10$129e5f4c86380e884ec0b55425100b0a', 'Test436', NULL, 'Test436@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(469, '$2b$10$55e6077fe377fed37bc7cd854ff94ab2', 'Test437', NULL, 'Test437@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(470, '$2b$10$29dc9e95b8bd7fb75511caf16e1571f7', 'Test438', NULL, 'Test438@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(471, '$2b$10$244d3423b853cabfbebc9dafab1a35da', 'Test439', NULL, 'Test439@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(472, '$2b$10$3639a1ca89f8f8d3e2ba1b44019941ed', 'Test440', NULL, 'Test440@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(473, '$2b$10$c16c73f2b8139c4e75089d306361eec3', 'Test441', NULL, 'Test441@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(474, '$2b$10$97956f125377ab8c343c0b438457a9fc', 'Test442', NULL, 'Test442@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(475, '$2b$10$3dd9f3a4e69f0f5190c8d0df340f71a7', 'Test443', NULL, 'Test443@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(476, '$2b$10$4a1debeb5dd14dc60e964315bc598139', 'Test444', NULL, 'Test444@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(477, '$2b$10$211c7db15f1a81d4d9b638c72b82aa68', 'Test445', NULL, 'Test445@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(478, '$2b$10$9a9d045ec7b83bdfa336c634b6e29af3', 'Test446', NULL, 'Test446@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(479, '$2b$10$784e7292628485a920c8c776a05865b1', 'Test447', NULL, 'Test447@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(480, '$2b$10$24a8724b2f0b8a030579875a7d7a3046', 'Test448', NULL, 'Test448@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(481, '$2b$10$09cd41502871490da99d70f42f440aea', 'Test449', NULL, 'Test449@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(482, '$2b$10$1a061977aaa123b61ab1b45ee3608dcf', 'Test450', NULL, 'Test450@gmail.com', '2026-07-22', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(483, '$2b$10$Q1cPxkvg939YCIaukN8V3.kThqQzgP5aGcA4R5cOTENKdlLEgyijq', 'Laura123', '/uploads/0867887443ba57338e8195e37312efb5.webp', 'laura@gmail.com', '2026-07-23', 1, 'ACTIVE', NULL, NULL, NULL, NULL, 'Nie ma opisu bo nie ma długopisu', 'pl', NULL, NULL, NULL, NULL, NULL),
(484, '$2b$10$67C7DrzyYmdn01dwjFWzmO2PN3nD4vRem5hlCoWghbP4oIqOKegr6', 'Filip64', '/uploads/a45cffe737eaa5c0321edfb94c491612.webp', 'filip.dziopa43@gmail.com', '2026-07-29', 0, 'BANNED', NULL, ' bnh', '2026-08-14 19:15:56', 16, 'dsa', 'pl', NULL, NULL, NULL, NULL, NULL),
(485, '$2b$10$TYHAEk7UW1r7t/z5xuIn5uWCPAhByaOmSWKk5Xld2QJ4KCMxMa52G', 'FilipAdmin', NULL, 'filip.dziopaAdmin@gmail.com', '2026-07-29', 1, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(486, '$2b$10$e8jJhWpldt6NM0Eu8l9fcufGrKVGC6iwAhxLpo65fLukMIQOlURvy', 'filipAdmin2', NULL, 'filip.dziopaAdmin2@gmail.com', '2026-07-29', 1, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(487, '$2b$10$2F/A0UdC8rhLY1mE8uzKBucvfsLJCmf29C0XzSzP16rwQYFMoy/16', 'Admin', NULL, 'filip.dziopaAdmin3@gmail.com', '2026-07-29', 1, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(489, '$2b$10$l83kyUGLUJt8BRgj7bk2/uFli2qQYRhgiNF9IRGslNGkYv7qnpGoe', 'Filip', NULL, 'filip.dziopaAdmin5@gmail.com', '2026-07-29', 1, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(490, '$2b$10$rwdHe0BVk/lL05TdIdxmvO4LV6t.5c5WLoRI8qDKBuUuFQgSIgoEi', 'Filip', NULL, 'filip.dziopa123234@gmail.com', '2026-08-16', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'pl', NULL, NULL, NULL, NULL, NULL),
(492, '$2b$10$Cdy.sv2VQsFoRl2ji4AEgeCp1M6GyFCZg6sOguqAjOCJhDg1D4/eK', 'testuser', NULL, 'test@example.com', '2026-08-18', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL),
(493, '$2b$10$nJc0p60CuddhS4E0mKyQxurg3pL80moyGW1CIgAN7tX1wAfzYl6Au', 'testuser', NULL, 'existing@example.com', '2026-08-18', 0, 'ACTIVE', NULL, NULL, NULL, NULL, NULL, 'en', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `user_activity`
--

CREATE TABLE `user_activity` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `action` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `user_favorites`
--

CREATE TABLE `user_favorites` (
  `user_id` int(11) NOT NULL,
  `film_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_favorites`
--

INSERT INTO `user_favorites` (`user_id`, `film_id`, `created_at`) VALUES
(1, 8, '2026-05-31 00:07:11'),
(1, 9, '2026-05-31 00:07:11'),
(5, 1, '2026-05-31 03:08:46'),
(5, 2, '2026-05-31 01:44:59'),
(5, 3, '2026-05-31 03:07:06'),
(5, 4, '2026-06-02 02:23:24'),
(5, 5, '2026-05-31 01:42:02'),
(5, 6, '2026-05-31 01:42:01'),
(5, 7, '2026-05-31 01:41:48'),
(5, 10, '2026-05-31 01:45:12'),
(5, 12, '2026-05-31 01:45:11'),
(5, 14, '2026-05-31 01:45:06'),
(9, 1, '2026-07-18 19:20:01'),
(9, 3, '2026-07-18 19:19:52'),
(10, 1, '2026-05-31 00:58:08'),
(10, 2, '2026-05-31 00:59:49'),
(10, 3, '2026-05-31 00:58:06'),
(10, 4, '2026-05-31 00:58:10'),
(10, 11, '2026-05-31 00:58:13'),
(11, 1, '2026-05-31 02:30:00'),
(11, 2, '2026-05-31 03:02:13'),
(11, 3, '2026-05-31 03:31:02'),
(11, 4, '2026-05-31 03:30:46'),
(11, 5, '2026-05-31 03:31:03'),
(11, 6, '2026-05-31 03:31:03'),
(11, 7, '2026-05-31 02:30:56'),
(11, 11, '2026-05-31 02:30:57'),
(11, 12, '2026-05-31 02:30:58'),
(11, 14, '2026-05-31 02:30:59'),
(11, 15, '2026-05-31 02:30:59'),
(12, 1, '2026-05-31 03:38:46'),
(12, 2, '2026-05-31 03:38:54'),
(12, 3, '2026-06-26 22:22:44'),
(12, 7, '2026-05-31 03:38:33'),
(13, 1, '2026-06-30 01:12:07'),
(13, 2, '2026-06-30 00:36:52'),
(13, 3, '2026-06-30 00:36:32'),
(13, 4, '2026-06-26 23:11:46'),
(13, 6, '2026-06-29 21:32:15'),
(13, 7, '2026-06-27 14:31:28'),
(13, 8, '2026-06-29 23:19:00'),
(13, 9, '2026-06-27 01:33:13'),
(13, 10, '2026-06-29 23:19:01'),
(13, 11, '2026-06-27 01:33:11'),
(13, 14, '2026-06-27 15:04:17'),
(13, 15, '2026-06-27 14:32:20'),
(15, 1, '2026-07-11 00:18:59'),
(15, 2, '2026-07-11 01:28:50'),
(15, 3, '2026-07-11 01:28:52'),
(15, 4, '2026-07-10 23:24:38'),
(15, 5, '2026-07-11 01:28:53'),
(15, 6, '2026-07-10 19:18:07'),
(15, 8, '2026-07-10 19:05:56'),
(15, 10, '2026-07-10 19:18:06'),
(15, 12, '2026-07-10 23:24:40'),
(15, 15, '2026-07-10 19:06:13'),
(16, 1, '2026-07-23 18:45:59'),
(16, 2, '2026-07-18 17:50:42'),
(16, 3, '2026-07-18 18:28:23'),
(16, 5, '2026-07-10 20:15:20'),
(16, 6, '2026-07-23 20:07:24'),
(16, 7, '2026-07-10 20:15:18'),
(16, 8, '2026-07-10 20:15:19'),
(16, 9, '2026-07-23 20:07:25'),
(16, 11, '2026-07-23 20:07:11'),
(16, 12, '2026-07-23 20:07:11'),
(16, 13, '2026-07-23 20:07:12'),
(16, 14, '2026-07-23 19:07:41'),
(16, 15, '2026-07-23 18:21:23'),
(16, 16, '2026-07-23 20:07:13'),
(16, 17, '2026-07-23 20:07:13'),
(16, 18, '2026-07-23 20:07:13'),
(16, 19, '2026-08-14 20:16:56'),
(16, 20, '2026-07-23 20:07:15'),
(16, 21, '2026-07-23 20:07:16'),
(16, 22, '2026-07-23 20:07:16'),
(16, 23, '2026-07-23 20:07:17'),
(16, 24, '2026-07-23 20:07:18'),
(16, 25, '2026-07-23 20:07:18'),
(16, 26, '2026-07-23 20:07:19'),
(16, 27, '2026-08-14 19:36:09'),
(16, 28, '2026-08-14 20:18:37'),
(16, 29, '2026-07-26 00:28:59'),
(16, 30, '2026-07-23 20:07:21'),
(17, 2, '2026-07-11 03:03:38'),
(17, 3, '2026-07-11 03:03:37'),
(17, 6, '2026-07-11 03:03:42'),
(17, 7, '2026-07-11 03:03:40'),
(22, 3, '2026-07-18 17:58:07'),
(23, 1, '2026-07-18 18:23:39'),
(23, 2, '2026-07-18 18:23:38'),
(23, 3, '2026-07-18 18:23:39'),
(23, 4, '2026-07-18 18:23:37'),
(27, 1, '2026-07-19 20:35:54'),
(27, 2, '2026-07-22 23:00:30'),
(27, 3, '2026-07-19 20:35:57'),
(27, 6, '2026-07-19 20:35:55'),
(27, 7, '2026-07-19 20:35:56'),
(27, 12, '2026-07-19 20:35:59'),
(27, 14, '2026-07-19 20:36:01'),
(27, 27, '2026-07-26 18:41:27'),
(27, 28, '2026-07-26 18:41:27'),
(27, 29, '2026-07-26 18:41:26'),
(27, 30, '2026-07-26 18:41:25'),
(483, 1, '2026-07-23 17:02:56'),
(483, 2, '2026-07-23 17:03:05'),
(483, 6, '2026-07-23 17:03:07'),
(483, 7, '2026-07-23 17:03:06'),
(483, 11, '2026-07-23 17:03:07'),
(485, 27, '2026-07-29 00:38:08'),
(490, 28, '2026-08-16 18:37:49'),
(490, 29, '2026-08-16 18:37:48'),
(490, 30, '2026-08-16 18:37:48');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `user_watched`
--

CREATE TABLE `user_watched` (
  `user_id` int(11) NOT NULL,
  `film_id` int(11) NOT NULL,
  `watched_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_watched`
--

INSERT INTO `user_watched` (`user_id`, `film_id`, `watched_at`) VALUES
(5, 3, '2026-05-31 01:41:40'),
(5, 4, '2026-05-31 01:41:45'),
(5, 5, '2026-05-31 01:42:03'),
(5, 6, '2026-05-31 01:42:01'),
(5, 7, '2026-05-31 01:42:04'),
(5, 10, '2026-05-31 01:45:09'),
(5, 12, '2026-05-31 01:45:10'),
(5, 14, '2026-05-31 01:45:06'),
(9, 1, '2026-07-18 19:20:02'),
(11, 1, '2026-05-31 03:30:53'),
(11, 2, '2026-05-31 03:30:54'),
(11, 4, '2026-05-31 03:27:14'),
(11, 7, '2026-05-31 03:30:56'),
(11, 9, '2026-05-31 03:31:05'),
(11, 10, '2026-05-31 03:31:05'),
(11, 11, '2026-05-31 03:30:52'),
(11, 12, '2026-05-31 03:30:51'),
(11, 13, '2026-05-31 03:31:07'),
(11, 14, '2026-05-31 03:30:55'),
(11, 15, '2026-05-31 02:36:15'),
(12, 2, '2026-05-31 03:38:54'),
(12, 3, '2026-06-26 22:22:44'),
(12, 7, '2026-05-31 03:38:32'),
(13, 1, '2026-06-30 01:42:27'),
(13, 2, '2026-06-30 01:42:26'),
(13, 3, '2026-06-30 01:42:27'),
(13, 4, '2026-06-30 01:42:28'),
(15, 1, '2026-07-10 23:52:18'),
(15, 2, '2026-07-11 00:45:48'),
(15, 3, '2026-07-10 19:05:55'),
(15, 6, '2026-07-10 19:18:07'),
(15, 7, '2026-07-10 19:18:08'),
(15, 8, '2026-07-10 19:05:56'),
(15, 12, '2026-07-10 23:24:40'),
(15, 15, '2026-07-10 19:06:14'),
(16, 1, '2026-07-23 18:46:00'),
(16, 3, '2026-07-18 16:04:32'),
(16, 5, '2026-07-18 16:16:04'),
(16, 6, '2026-07-18 16:16:04'),
(16, 7, '2026-07-10 20:15:18'),
(16, 8, '2026-07-10 20:15:19'),
(16, 14, '2026-07-23 20:52:47'),
(16, 15, '2026-07-23 20:52:45'),
(16, 16, '2026-07-23 20:52:45'),
(16, 17, '2026-07-23 20:52:46'),
(16, 18, '2026-07-23 20:52:46'),
(16, 19, '2026-07-23 20:52:43'),
(16, 20, '2026-07-23 20:52:43'),
(16, 21, '2026-07-23 20:52:42'),
(16, 22, '2026-07-23 20:52:42'),
(16, 23, '2026-07-23 20:52:39'),
(16, 24, '2026-07-23 20:52:39'),
(16, 25, '2026-07-23 20:52:40'),
(16, 26, '2026-07-23 20:52:41'),
(16, 27, '2026-07-23 20:52:38'),
(16, 28, '2026-07-23 20:52:37'),
(16, 29, '2026-07-23 20:06:39'),
(16, 30, '2026-07-23 20:52:37'),
(17, 2, '2026-07-11 03:03:38'),
(17, 4, '2026-07-11 03:03:39'),
(17, 6, '2026-07-11 03:03:41'),
(17, 7, '2026-07-11 03:03:41'),
(23, 1, '2026-07-18 18:23:28'),
(23, 2, '2026-07-18 18:23:27'),
(23, 3, '2026-07-18 18:23:27'),
(23, 4, '2026-07-18 18:23:26'),
(27, 2, '2026-07-22 23:00:30'),
(27, 6, '2026-07-19 20:36:09'),
(27, 7, '2026-07-19 20:36:10'),
(27, 12, '2026-07-19 20:36:12'),
(483, 1, '2026-07-23 17:02:57'),
(490, 27, '2026-08-16 18:37:51'),
(490, 29, '2026-08-16 18:37:50');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `films`
--
ALTER TABLE `films`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `film_genres`
--
ALTER TABLE `film_genres`
  ADD PRIMARY KEY (`film_id`,`genre_id`),
  ADD KEY `genre_id` (`genre_id`);

--
-- Indeksy dla tabeli `film_translations`
--
ALTER TABLE `film_translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `film_id` (`film_id`,`language_code`),
  ADD KEY `fk_language` (`language_code`);

--
-- Indeksy dla tabeli `genres`
--
ALTER TABLE `genres`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indeksy dla tabeli `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`code`);

--
-- Indeksy dla tabeli `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `fk_user_language` (`language_code`),
  ADD KEY `fk_user_banned_by` (`banned_by`),
  ADD KEY `fk_user_suspended_by` (`suspended_by`);

--
-- Indeksy dla tabeli `user_activity`
--
ALTER TABLE `user_activity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indeksy dla tabeli `user_favorites`
--
ALTER TABLE `user_favorites`
  ADD PRIMARY KEY (`user_id`,`film_id`),
  ADD KEY `film_id` (`film_id`);

--
-- Indeksy dla tabeli `user_watched`
--
ALTER TABLE `user_watched`
  ADD PRIMARY KEY (`user_id`,`film_id`),
  ADD KEY `film_id` (`film_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `films`
--
ALTER TABLE `films`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `film_translations`
--
ALTER TABLE `film_translations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=94;

--
-- AUTO_INCREMENT for table `genres`
--
ALTER TABLE `genres`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=510;

--
-- AUTO_INCREMENT for table `user_activity`
--
ALTER TABLE `user_activity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `film_genres`
--
ALTER TABLE `film_genres`
  ADD CONSTRAINT `film_genres_ibfk_1` FOREIGN KEY (`film_id`) REFERENCES `films` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `film_genres_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `film_translations`
--
ALTER TABLE `film_translations`
  ADD CONSTRAINT `film_translations_ibfk_1` FOREIGN KEY (`film_id`) REFERENCES `films` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_language` FOREIGN KEY (`language_code`) REFERENCES `languages` (`code`) ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_user_banned_by` FOREIGN KEY (`banned_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_user_language` FOREIGN KEY (`language_code`) REFERENCES `languages` (`code`),
  ADD CONSTRAINT `fk_user_suspended_by` FOREIGN KEY (`suspended_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `user_activity`
--
ALTER TABLE `user_activity`
  ADD CONSTRAINT `user_activity_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `user_favorites`
--
ALTER TABLE `user_favorites`
  ADD CONSTRAINT `user_favorites_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_favorites_ibfk_2` FOREIGN KEY (`film_id`) REFERENCES `films` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_watched`
--
ALTER TABLE `user_watched`
  ADD CONSTRAINT `user_watched_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_watched_ibfk_2` FOREIGN KEY (`film_id`) REFERENCES `films` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
