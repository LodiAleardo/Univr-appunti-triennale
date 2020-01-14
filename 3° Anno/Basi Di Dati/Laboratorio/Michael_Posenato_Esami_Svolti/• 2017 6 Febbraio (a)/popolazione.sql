INSERT INTO TEMPO_T VALUES
('1-0-0-1', 1, 0, 0, 1),
('1-3-1-3', 1, 3, 1, 3),
('5-0-5-0', 5, 0, 5, 0),
('1-4-4-1', 1, 4, 4, 1),
('1-1-1-1', 1, 1, 0, 1);

INSERT INTO esercizio VALUES
('bench press', 'principiante', 'petto'),
('squat', 'intermedio', 'gambe'),
('deadlift', 'avanzato', 'gambe'),
('pull-up', 'intermedio', 'schiena'),
('lounges', 'principiante', 'gambe'),
('box jumps', 'principiante', 'gambe'),
('kick back', 'principiante', 'braccia');

INSERT INTO programma VALUES
('TOTAL_BODY', 'principiante'),
('TOTAL_LEGS', 'principiante'),
('CHEST_PUMP', 'intermedio'),
('ARM_PUMP', 'principiante'),
('BACK_TOTAL', 'avanzato');


# distribuisco TOTAL_BODY su tre giorni.
# TOTAL_LEGS contenga almeno 1 esercizio di gambe livello principiante
# e non contenga esercizi di petto, duri inoltre almeno 45 minuti
INSERT INTO esercizio_in_programma VALUES
('TOTAL_BODY', 'bench press', 'LUN', '1', '5', '12', '1-3-1-3', '180'),
('TOTAL_BODY', 'squat', 'MER', '2', '5', '12', '1-3-1-3', '180'),
('TOTAL_BODY', 'pull-up','VEN', '3', '5', '12', '1-3-1-3', '180'),

('TOTAL_LEGS', 'squat', 'LUN', '1', '11', '15', '1-4-4-1', '180'),
('TOTAL_LEGS', 'deadlift', 'MAR', '2', '13', '5', '5-0-5-0', '180'),
('TOTAL_LEGS', 'lounges', 'GIO', '3', '14', '5', '1-4-4-1', '180'),
('TOTAL_LEGS', 'box jumps', 'VEN', '4', '17', '15', '5-0-5-0', '180');