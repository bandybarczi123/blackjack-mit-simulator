# ======================================================================
# MIT BLACKJACK SIMULATOR: CORE ENGINE
# ======================================================================
import random
import pandas as pd

VALORES_HILO = {
    '2': 1, '3': 1, '4': 1, '5': 1, '6': 1, '7': 0, '8': 0, '9': 0,
    '10': -1, 'J': -1, 'Q': -1, 'K': -1, 'A': -1
}

def simular_mesa_7_puestos(tipo_racha):
    palos = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'] * 4
    zapato = palos * 6
    random.shuffle(zapato) # El Lavado (Chemin)
    
    if tipo_racha == "POSITIVO":
        zapato = sorted(zapato, key=lambda x: random.random() if x in ['10','J','Q','K','A'] else random.random() + 0.3)
    elif tipo_racha == "NEGATIVO":
        zapato = sorted(zapato, key=lambda x: random.random() if x in ['2','3','4','5','6'] else random.random() + 0.3)

    # Barajado Cruzado (Bloques A, B, C, D) y Corte Forense de Casino
    cuarto = len(zapato) // 4
    A, B, C, D = zapato[0:cuarto], zapato[cuarto:cuarto*2], zapato[cuarto*2:cuarto*3], zapato[cuarto*3:]
    monton_medio = []
    for i in range(cuarto):
        monton_medio.extend([A[i], D[i], B[i], C[i]])
    zapato_final = monton_medio[random.randint(52, 100):] + monton_medio[0:random.randint(52, 100)]
    zapato_final.pop(0) # Carta Quemada del Carro
    return pd.DataFrame(zapato_final)
