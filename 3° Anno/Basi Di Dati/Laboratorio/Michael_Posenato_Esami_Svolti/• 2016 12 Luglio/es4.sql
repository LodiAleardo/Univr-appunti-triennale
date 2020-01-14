# Indici da definire per migliorare le prestazioni delle query dell'esercizio 3
CREATE INDEX idx_ospedale_nome ON ospedale(nome varchar_pattern_ops);
CREATE INDEX idx_divisione_nome ON divisione(nome varchar_pattern_ops);
CREATE INDEX idx_ricovero_dataD ON ricovero(dataDimissione);
CREATE INDEX idx_ricovero_urgenza ON ricovero(urgenza varchar_pattern_ops);
CREATE INDEX idx_paziente_regione ON paziente(regione varchar_pattern_ops);
