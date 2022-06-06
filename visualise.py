import numpy as np
import matplotlib.pyplot as plt

CUTOFF = 200
INITIAL_AMOUNT = 50
DECAY_CONSTANT = 0.02407
TRIALS = 500


def main():
    data = np.loadtxt("randomWalk.csv", delimiter=",")
    ax = plt.axes()
    # for trial in range(TRIALS):
    # print(np.shape(data))
    #mapping = np.where()
    # print(mapping)
    #   trial_data = data[data[:, 0] == trial, :]
    #print(trial_data[:, 1])
    ax.scatter(data[:, 1], data[:, 2], s=1, color="blue",
               alpha=1/TRIALS, marker="o")
    xs = np.linspace(0, CUTOFF, 1000)
    ax.plot(xs, INITIAL_AMOUNT*np.exp(-DECAY_CONSTANT * xs), color="black")
    ax.set_xlabel("Year")
    ax.set_ylabel("Amount")
    # ax.set_title(f"# of Trials:{TRIALS},Decay Constant:{DECAY_CONSTANT},Initial Amount:{INITIAL_AMOUNT},Cutoff Time:{CUTOFF}")
    plt.savefig("RandomWalk.png", dpi=1200)


if __name__ == '__main__':
    main()
