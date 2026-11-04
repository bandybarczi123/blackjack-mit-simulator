-- ======================================================================
-- SCRIPT DE AUDITORÍA FORENSE: CASINO IGAMING TRANSACTIONAL TRACKING
-- ======================================================================

-- 1. IDENTIFICACIÓN DE APUESTAS AGRESIVAS BAJO CONTEO REAL POSITIVO
-- Filtra transacciones donde el True Count es >= 3 y el dimensionamiento de apuesta supera el mínimo
SELECT id_mano, conteo_real, monto_apuesta, resultado_mano, flujo_caja_acumulado
FROM simulacion_transaccional
WHERE conteo_real >= 3 AND monto_apuesta >= 80
ORDER BY monto_apuesta DESC;

-- 2. DETECCIÓN DE ANOMALÍAS Y CONTROL DE MERMAS EN ZAPATO FRÍO
-- Alerta de riesgo si hay apuestas altas consecutivas cuando el carro está en negativo (posible fraude)
SELECT id_mano, conteo_real, monto_apuesta, resultado_mano
FROM simulacion_transaccional
WHERE conteo_real <= -2 AND monto_apuesta > 20;

-- 3. RENDIMIENTO ACUMULADO Y RATIO DE EXTREMO (BUSTER DE LA BANCA)
-- Calcula la tasa de fracaso (Bust) del Dealer cuando muestra cartas débiles (4, 5, 6)
SELECT carta_banca, COUNT(*) as total_manos,
       SUM(CASE WHEN resultado_banca = 'Bust' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) as porcentaje_bust
FROM registros_paño_forense
WHERE carta_banca IN ('4', '5', '6')
GROUP BY carta_banca;
-- ======================================================================
-- FORENSIC AUDITING SCRIPT: CASINO IGAMING TRANSACTIONAL TRACKING
-- ======================================================================

-- 1. IDENTIFICATION OF AGGRESSIVE BETS UNDER HIGH POSITIVE TRUE COUNT
-- Filters transactions where the True Count is >= 3 and bet sizing exceeds the minimum
SELECT hand_id, true_count, bet_amount, hand_result, accrued_cash_flow
FROM transactional_simulation
WHERE true_count >= 3 AND bet_amount >= 80
ORDER BY bet_amount DESC;

-- 2. ANOMALY DETECTION AND LEAKAGE CONTROL IN COLD SHOE SCENARIOS
-- Risk alert for consecutive high bets during negative shoe counts (potential fraud)
SELECT hand_id, true_count, bet_amount, hand_result
FROM transactional_simulation
WHERE true_count <= -2 AND bet_amount > 20;

-- 3. CUMULATIVE PERFORMANCE AND DEALER BUST RATIO
-- Calculates the failure rate (Bust) of the Dealer when showing weak upcards (4, 5, 6)
SELECT dealer_upcard, COUNT(*) as total_hands,
       SUM(CASE WHEN dealer_outcome = 'Bust' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) as bust_percentage
FROM forensic_table_logs
WHERE dealer_upcard IN ('4', '5', '6')
GROUP BY dealer_upcard;
