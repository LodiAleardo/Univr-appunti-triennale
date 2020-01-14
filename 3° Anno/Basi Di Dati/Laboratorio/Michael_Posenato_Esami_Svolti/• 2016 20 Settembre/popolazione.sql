INSERT INTO autostrada VALUES
('A1', 'Autostrada del Sole', 'Autostrade per l''Italia', '761'),
('A2', 'Autostrada del Mediterraneo', 'Autostrade per l''Italia', '432.2'),
('A22', 'Autostrada del Brennero', 'Gestione regionale', '315');


INSERT INTO comune VALUES
('123456', 'Bagnara Calabra', '34657', '234.4'),
('172839', 'Scilla', '45214', '199.4'),
('718231', 'Calenzano', '34587', '6487.2'),
('321654', 'Pieve Fissiraga', '9864', '1657.15'),
('458745', 'Pieve Bassa', '1244', '995.15');


INSERT INTO raggiunge VALUES
('A1', '718231', '0'),
('A1', '321654', '3'),
('A1', '458745', '6'),
('A2', '172839', '1'),
('A2', '123456', '1');
# ce n'erano altri, ma la mannaggia non ho salvato il file.