-- Q1
CREATE TABLE departments (
  department_id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Q2
ALTER TABLE people ADD department_id INT UNSIGNED AFTER email;
-- ? INT(10)にならない → 整数は型ごとにバイト数で最大値が決まっているので、桁数指定は不要？
-- ? INTはUNSIGNED（符号無し）で10桁

-- Q3
INSERT INTO departments (name)
VALUES
("営業"),
("開発"),
("経理"),
("人事"),
("情報システム");

INSERT INTO people (name, email, department_id, age, gender)
VALUES
("佐々木銀", "sasaki@gizumo.jp", 1, 26, 1),
("長谷川和彦", "hasegawa@gizumo.jp", 1, 44, 1),
("高木陽", "takagi@gizumo.jp", 1, 23, 1),
("酒井湊斗", "sakai@gizumo.jp", 2, 27, 1),
("小川奈々", "ogawa@gizumo.jp", 2, 32, 2),
("大久保蒼", "okubo@gizumo.jp", 2, 34, 1),
("平田司", "hirata@gizumo.jp", 2, 52, 1),
("大塚勝", "otuka@gizumo.jp", 3, 48, 1),
("夜神楓", "yagami@gizumo.jp", 4, 29, 2),
("河野美咲", "kawano@gizumo.jp", 5, 39, 2);

INSERT INTO reports (person_id, content)
VALUES
(7, "青年はぞくっとして、とうとうりんとうごかないように走りました。"),
(8, "つまりは私どもも天の川の水や、三角点の青じろい微光の中を見まわすとして、じき神さまの前に立って左手に時計を持って行った烏瓜のあかりのように立ちあがりました。"),
(9, "それはもうじきちかくに町か何かだったと考えてふり返って見ましたら、ずうっと前の方ではかすかにわらいました。"),
(10, "そのまっくらな島のまん中に、黒い大きな建物が四棟ばかり立って、まじめな顔をしてくださいその人はもう行ってしまいそうでした。"),
(11, "さあもうきっと僕は僕のために私のからだをおつかいください。"),
(12, "ジョバンニは、口笛を吹いたり笑ったりして、頭をやけに振りました。"),
(13, "鷺の方はレンズが薄いのでわずかの光る粒すなわち星がたくさん見えてきました。"),
(14, "僕たちといっしょに汽車に乗って行こう。"),
(15, "もうすっかり秋だねえカムパネルラが首をかしげました。"),
(16, "僕もう少し汽車へ乗ってから行くんだよう腰掛けたばかりの青年に言いましたけれども、どうしてもこの方たちの幸福だとも思いました。");

-- Q4
UPDATE people SET department_id = 1 WHERE gender = 2 AND department_id IS NULL;
UPDATE people SET department_id = 2 WHERE gender = 1 AND department_id IS NULL;
UPDATE people SET department_id = 3 WHERE gender IS NULL AND department_id IS NULL;

-- Q5
SELECT name, age FROM people WHERE gender = 1 ORDER BY age DESC;

-- Q6
SELECT
  `name`, `email`, `age` -- テーブル内の「name」「email」「age」というカラムを表示する
FROM
  `people` -- 「people」というテーブルを参照する
WHERE
  `department_id` = 1 -- カラム「department_id」の値が1のレコードのみを対象にする
ORDER BY
  `created_at`; -- 「created_at」カラムの日時を昇順に並び替える

-- Q7
SELECT name, age, gender FROM people WHERE (age BETWEEN 20 AND 29 AND gender = 2) OR (age BETWEEN 40 AND 49 AND gender = 1) ORDER BY gender DESC, age;

-- Q8
-- SELECT name, age, department_id FROM people WHERE department_id = 1 ORDER BY age;
SELECT
  p.name AS person_name,
  p.age,
  d.name AS department_name
FROM people p
JOIN departments d ON p.department_id = d.department_id
WHERE p.department_id = 1
ORDER BY p.age;

-- Q9
SELECT AVG(age) AS average_age FROM people WHERE department_id = 2;

-- Q10
SELECT
  p.name AS person_name,
  d.name AS department_name,
  r.content
FROM reports r
JOIN people p ON r.person_id = p.person_id
JOIN departments d ON d.department_id = p.department_id
;

-- Q11
SELECT p.name
FROM people p
LEFT OUTER JOIN reports r ON p.person_id = r.person_id
WHERE r.person_id IS NULL;