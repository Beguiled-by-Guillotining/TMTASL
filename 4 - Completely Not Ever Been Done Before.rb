set :end, false
set :gettingLouder, true
set :end2, false

define :talk do |samp|
  sleep (rrand 0, 2)
  sample samp, amp: (rrand 1.0, 3.0), rate: [1 / (rrand 1.0, 1.5), (rrand 1.0, 1.5)].choose
  sleep (rrand 8, 15)
  stop if get :end
end

live_loop :takumi do
  talk SAMPLE_DIR() + "takumi.wav"
end

live_loop :mizuki do
  talk SAMPLE_DIR() + "mizuki.wav"
end

live_loop :hans do
  talk SAMPLE_DIR() + "hans.wav"
end

live_loop :chantal do
  talk SAMPLE_DIR() + "chantal.wav"
end

sleep 40.0

amp = 0.0
cutoff = 130
live_loop :ambi do
  c = synth :bnoise, sustain: 2.0, amp: amp, cutoff: cutoff, cutoff_slide: 2.0
  amp += 0.1 if get :gettingLouder
  sleep 2.0
  if get :end2
    cutoff -= 13
    control c, cutoff: (cutoff > 0 ? cutoff : 0)
    stop if cutoff <= 0
  end
end

sleep 15.0
set :end, true

sleep 7.0
set :gettingLouder, false
sleep 7.0
set :end2, true
sleep 16.0
sample :ambi_drone, release: 0.5