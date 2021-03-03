-- ebbflow polysynths

nv = include "lib/Nv"
controlspec = require 'controlspec'
musicutil = require "musicutil"

nv.name 'ebbflow'

keyboardz = midi.connect()

function init()
    nv.init(8) -- 8 voice polyphony

    params:add {id="shape", type='control', controlspec = controlspec.new(0, 1, "lin", 0, 0.5, ''), action = function(v) nv.all.shape(v) end}
  
    
end

keyboardz.event = function(data)
    local msg = midi.to_msg(data)
    if msg.type == "note_on" then
        nv.id(msg.note).hz(musicutil.note_num_to_freq(msg.note)) -- actual hz is vc.hz * all.hz
        nv.id(msg.note).peak((msg.vel / 127) + 0.75)
    elseif msg.type == "note_off" then
        nv.id(msg.note).peak(0)
    end
end


function key(n,z)
  if n==3 and z==1 then
    nv.all.peak(0)
  end
end
