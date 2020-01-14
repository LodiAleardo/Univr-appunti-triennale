INSERT INTO ingrediente(id, nome, calorie, grassi, proteine, carboidrati) VALUES
('I001','uovo','128','51','48','1'),
('I002','burro','717','81','10','9'),
('I003','zucchero','392','1','1','98');


INSERT INTO ricetta VALUES
('R001', 'baccala'' alla vicentina', 'Veneto', '4', '80'),
('R002', 'lampascioni fritti', 'Puglia', '4', '45'),
('R003', 'Papassini di Ittiri', 'Sardegna', '4', '100');


INSERT INTO composizione(ingrediente, ricetta, quantita) VALUES
('I001', 'R001', '100'),
('I001', 'R002', '45'),
('I001', 'R003', '50'),
('I003', 'R001', '60'),
('I002', 'R002', '110'),
('I002', 'R003', '210');
