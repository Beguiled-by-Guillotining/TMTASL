eval_file SSO_RB_PATH()

set :end, false


live_loop :noise do
  use_synth :bnoise
  play :C3, amp: 0.5, release: 0.0, sustain: 5.0
  sleep 5.0
  stop if get :end
end

live_loop :main do
  note = (choose chord :C3, :minor)
  pl note, 0.5, 'Celli stc', (rrand 0.8, 1.0)
  pl note, 0.5, 'Cello', (rrand 0.8, 1.0)
  sleep [0.25,0.25,0.25, 0.5].choose
  stop if get :end
end

live_loop :ambi do
  synth :dark_ambience, note: (choose chord :C4, :minor), sustain: 2.0, amp: 0.5
  synth :growl, note: (choose chord :C4, :minor), sustain: 2.0, amp: 0.5
  sleep 2.5
  stop if get :end
end

sleep 0.5
samp = sample SAMPLE_DIR() + "Killing The Silence.wav", amp: 7.0

sleep 14.65
s1 = SSO_SAMPLES_DIR() + "Percussion/wood_block-lo.wav"
s2 = SSO_SAMPLES_DIR() + "/Percussion/wood_block-hi.wav"
sample s1
sleep 0.3
sample s2

sleep 21.85
sample s1
sleep 0.3
sample s2

sleep 17.1
sample s1
sleep 0.3
sample s2
sleep 0.3

live_loop :main do
  baseNote = (choose [:c2, :c2, :c3, :c3, :c4])
  curScale = (chord baseNote, :minor)
  curScale = curScale.reverse if one_in 2
  amp = tick * 0.05
  at [0.0, 0.2, 0.4], curScale do |note|
    pl note, 10.0, 'Harp', (rrand 0.6, 0.8) + amp
  end
  sleep 0.8
  stop if get :end
end

live_loop :main2 do
  note = (choose chord :c5, :minor)
  pl note, 1.0, '1st Violins stc', (rrand 0.8, 1.0) + tick * 0.05
  sleep [0.25, 0.5].choose
  stop if get :end
end

live_loop :main3 do
  pl (choose chord :c4, :minor, num_octaves: 2), 1.0, '2nd Violins sus', (rrand 0.7, 0.9) + tick * 0.05
  sleep 1.0
  stop if get :end
end

sleep 16.0

set :end, true
stop