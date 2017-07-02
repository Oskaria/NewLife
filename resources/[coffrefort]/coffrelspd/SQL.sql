
CREATE TABLE `coffrelspd` (
  `id` int(11) NOT NULL,
  `identifier` varchar(50) NOT NULL,
  `solde` varchar(10) NOT NULL,
  `lasttransfert` varchar(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


ALTER TABLE `coffrelspd`
  ADD PRIMARY KEY (`id`);
COMMIT;


--Createur Nelyo  :   https://github.com/ElNelyo/cop-coffre

--Modification  : Irtas Momaki / Walter White