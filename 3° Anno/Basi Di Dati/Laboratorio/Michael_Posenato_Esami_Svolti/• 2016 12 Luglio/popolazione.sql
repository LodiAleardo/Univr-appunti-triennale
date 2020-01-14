INSERT INTO ospedale VALUES
('vr_bt', 'Ospedale Borgo Trento'),
('vr_br', 'Ospedale Borgo Roma');

INSERT INTO divisione VALUES
('car_bt', 'vr_bt', 'cardiologia', '15'),
('cch_bt', 'vr_bt', 'cardiochirurgia', '25'),
('car_br', 'vr_br', 'cardiologia', '10'),
('cch_br', 'vr_br', 'cardiochirurgia', '30');


INSERT INTO paziente VALUES
('AAAAAA11P22L333M', 'Mario', 'Rossi', 'Veneto', 'ITA'), 
('BBBBBB11P22L333M', 'Tizio', 'Austriaco', 'Abruzzo', 'AUS'), 
('CCCCCC11P22L333M', 'jacques', 'Fastidioso', 'Sicilia', 'FRA'), 
('DDDDDD11P22L333M', 'Tizio', 'Svizzero', 'Lombardia', 'SVI'); --ricoverata solo a br


INSERT INTO ricovero VALUES
('car_bt', 'AAAAAA11P22L333M', 'desc' ,'urgente' 		,'2019-01-01' ,'2019-01-03'),
('cch_bt', 'BBBBBB11P22L333M', 'desc' ,'non urgente' 	,'2019-01-01' ,'2019-01-04'),
('car_br', 'DDDDDD11P22L333M', 'desc' ,'urgente' 		,'2019-01-01' ,'2019-01-2'),
('cch_br', 'DDDDDD11P22L333M', 'desc' ,'non urgente' 	,'2019-02-02' ,'2019-02-05'),
('car_bt', 'AAAAAA11P22L333M', 'desc' ,'urgente' 		,'2019-03-03' ,'2019-03-10'),
('car_bt', 'AAAAAA11P22L333M', 'desc' ,'non urgente' 	,'2019-04-04' ,'2019-04-09'),
('car_bt', 'AAAAAA11P22L333M', 'desc' ,'non urgente' 	,'2019-05-05' ,'2019-05-10');

-- con 2 ricoveri non urgenti del veneto, e solo 1 urgente a borgo trento
