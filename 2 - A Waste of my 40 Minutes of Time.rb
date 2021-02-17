use_debug false

set :end, false

live_loop :notes do
  use_synth :chiplead
  use_synth_defaults amp: 0.5, width: 2, sustain: 0.1, release: 0.0
  
  play (choose chord :G3, :major7)
  play (choose chord :G2, :major7) if one_in 2
  sleep 0.1 * (choose [1,2,2,2,4,4])
  stop if get :end
end

live_loop :drums do
  use_synth :chipnoise
  use_synth_defaults attack: 0.01, release: (rrand 0.05, 0.1), amp: (rrand 0.3, 0.4)
  
  play freq_band: (rrand_i 1, 15)
  play freq_band: (rrand_i 1, 15) if one_in 2
  sleep 0.1 * (choose [1,2,2,2,2,2,4,4])
  stop if get :end
end

sleep 1.0
sample SAMPLE_DIR() + "A Waste of my 40 Minutes of Time.wav", amp: 7.0
sleep 70.0
set :end, true