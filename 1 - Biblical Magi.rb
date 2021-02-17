eval_file SSO_RB_PATH()

set :end, false

live_loop :main do
  pl (choose chord :A3, :major), 1.0, 'Horn', (rrand 0.6, 0.8)
  pl (choose chord :A3, :major), 1.0, 'Horns stc', (rrand 0.6, 0.8)
  sleep 0.5
  stop if get :end
end

6.times do |i|
  pl (scale :c1, :major).tick, 1.0, 'Timpani roll', 2.0 + i * 0.2
  sleep 1.0
end

pl :c2, 1.0, 'Timpani f lh', 5.0
samp = sample SAMPLE_DIR() + "Biblical Magi.wav", amp: 5.0

live_loop :main2 do
  pl (choose chord :A3, :major), 2.0, '1st Violins stc', (rrand 0.6, 0.8)
  pl (choose chord :A3, :major), 2.0, '2nd Violins sus', (rrand 0.4, 0.5)
  sleep 1.0
  stop if get :end
end

sleep 24.5
control samp, amp: 8.0

live_loop :main3 do
  pl (choose chord :A3, :major), 1.0, 'Oboe', (rrand 0.6, 0.8)
  pl (choose chord :A3, :major), 1.0, 'Xylophone', (rrand 0.4, 0.5)
  sleep [0.25, 0.5].choose
  stop if get :end
end

sleep 36.5
control samp, amp: 10.0

live_loop :main4 do
  pl (choose chord :A4, :major, num_octaves: 2), 1.0, 'Grand Piano f', (rrand 0.6, 0.8)
  pl (choose chord :A4, :major), 1.0, 'Glockenspiel', (rrand 0.3, 0.4) if one_in(3)
  sleep [0.125,0.125,0.125, 0.25].choose
  stop if get :end
end

sleep 27.0
set :end, true
stop