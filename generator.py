import multiprocessing as mp
import random
import numpy as np


CUTOFF = 200
INITIAL_AMOUNT = 50
DECAY_CONSTANT = 0.02407
TRIALS = 500


def run_trial(trial):
    i = 0
    output = list()
    amount = INITIAL_AMOUNT
    while i < CUTOFF:
        output.append([trial, i, amount])
        new_amount = 0
        for _ in range(amount):
            if random.random() > DECAY_CONSTANT:
                new_amount += 1
        amount = new_amount
        i += 1
    return output


def main():
    pool = mp.Pool(4)
    results = pool.map(run_trial, range(TRIALS))
    pool.close()
    # print(results)
    savedata = np.array(results)
    np.savetxt("randomWalk.csv", savedata.reshape(
        TRIALS*CUTOFF, 3), delimiter=",")


if __name__ == '__main__':
    main()
