eval_file SSO_RB_PATH()
load_synthdefs SCL_ORK_SYNTHS_DIR() + "bass"

set :pause, true
set :end, false

set :scale, :A2
set :bpm, 60

define :playBass do |len|
  note = (choose chord (get :scale), :minor)
  
  use_synth 'subBass1'
  play freq: (midi_to_hz note), amp: 0.5, rel: len * 2
  
  use_synth 'subBass2'
  play freq: (midi_to_hz note), amp: 0.5, rel: len * 2
  
  use_synth 'fmBass'
  play freq: (midi_to_hz note), amp: 0.2, rel: len * 2
  
  pl note, len, 'Cello', (rrand 0.2, 0.3)
end

live_loop :main_bass do
  use_bpm (get :bpm)
  len = choose [0.5, 0.5, 1.0]
  
  times = [0.0]
  noteLen = len
  
  if len == 0.5 and one_in 2
    times = [0.0, 0.25]
    noteLen = 0.25
  end
  
  at times do
    playBass noteLen
  end
  
  sleep len
  stop if get :end
end

define :playMain do |len|
  note = (choose chord (get :scale), :minor7, num_octaves: 3)
  
  use_synth 'rubberBand'
  play freq: (midi_to_hz note), amp: 0.5, rel: 1.0
  use_synth 'subBass1'
  play freq: (midi_to_hz note), amp: 0.5, rel: len * 2
  use_synth 'subBass2'
  play freq: (midi_to_hz note), amp: 0.5, rel: len * 2
end

live_loop :main_guitar do
  sleep 1.0 while get :pause
  
  use_bpm (get :bpm)
  
  times = [0.0]
  noteLen = 0.5
  
  if !one_in 4
    if one_in 7
      times = [0.0, 0.125, 0.25, 0.375]
      noteLen = 0.125
    elsif one_in 4
      times = [0.0, 0.125, 0.25]
      noteLen = 0.125
    else
      times = [0.0, 0.25]
      noteLen = 0.25
    end
  end
  
  at times do
    playMain noteLen
  end
  
  sleep 0.5
  stop if get :end
end

voice = sample SAMPLE_DIR() + "Christianity’s most glamorous product.wav", amp: 7.0

sleep 24.0
set :pause, false
sleep 9.0
set :pause, true

set :scale, :A2
set :bpm, 70

sleep 15.0
set :pause, false
sleep 9.0
set :pause, true

set :scale, :C3
set :bpm, 80

sleep 25.0
set :pause, false
sleep 9.0
set :pause, true

set :scale, :A2
set :bpm, 80

sleep 14
set :pause, false
sleep 9.0
set :pause, true

control voice, amp: 9.0
set :scale, :A3
set :bpm, 80

sleep 24.0
set :pause, false
sleep 9.0
set :pause, true

control voice, amp: 7.0
set :scale, :A2
set :bpm, 100

sleep 27.0
set :pause, false
sleep 10.0
set :bpm, 60
sleep 10.0
set :bpm, 30
sleep 10.0
set :end, true

with_fx :level, amp_slide: 1 do |l|
  playMain 1
  playBass 1
  control l, amp: 0.0
end