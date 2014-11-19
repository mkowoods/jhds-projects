from problem_set2  import *

trials = load_experiment('trials.npy')
spk_times = load_neuraldata('example_spikes.npy')
dir_rates = bin_spikes(trials, spk_times, time_bin=.2)

plt.subplot(2,2,1)
plt.bar(dir_rates[:,0], dir_rates[:,1], 45)
plt.xlim(0, 360)
plt.xlabel('Direction of Motion(Degrees)')
plt.ylabel('Firing Rates spikes/s')
plt.title('Example Neuron Tuning Curve')

plt.subplot(2, 2, 2, polar = True)
dir_rates = np.row_stack((dir_rates, dir_rates[0,:]))
dir_rates[8,0] = 360
plt.polar(np.deg2rad(dir_rates[:,0]), dir_rates[:,1], label = 'Firing Rates spikes/s')
plt.title('Example Neuron Tuning Curve')

plt.show()