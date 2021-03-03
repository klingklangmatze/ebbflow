-- ebbflow polysynths

nv = include "lib/Nv"
controlspec = require 'controlspec'
musicutil = require "musicutil"

nv.name 'ebbflow'

keyboardz = midi.connect()

function init()
    nv.init(8) -- 8 voice polyphony

    params:add {id="shape", type='control', controlspec = controlspec.new(0, 1, "lin", 0.01, 0.5, ''), action = function(v) nv.all.shape(v) end}
    params:add {id="slope", type='control', controlspec = controlspec.new(0, 1, "lin", 0.01, 0.5, ''), action = function(v) nv.all.slope(v) end}
    params:add {id="smooth", type='control', controlspec = controlspec.new(0, 1, "lin", 0.01, 0.5, ''), action = function(v) nv.all.smooth(v) end}
    params:add {id="shift", type='control', controlspec = controlspec.new(0, 1, "lin", 0.01, 0, ''), action = function(v) nv.all.shift(v) end}
    params:add {id="output_mode", type='control', controlspec = controlspec.new(0, 3, "lin", 1, 0, ''), action = function(v) nv.all.output_mode(v) end}
    params:add {id="fade", type='control', controlspec = controlspec.new(0, 1, "lin", 0.01, 0, ''), action = function(v) nv.all.fader(v) end}
    params:add {id="ampAtk", type='control', controlspec = controlspec.new(0, 1, "lin", 0.01, 0.01, ''), action = function(v) nv.all.ampAtk(v) end}
    params:add {id="ampDec", type='control', controlspec = controlspec.new(0, 1, "lin", 0.01, 0.1, ''), action = function(v) nv.all.ampDec(v) end}
    params:add {id="ampSus", type='control', controlspec = controlspec.new(0, 1, "lin", 0.01, 1.0, ''), action = function(v) nv.all.ampSus(v) end}
    params:add {id="ampRel", type='control', controlspec = controlspec.new(0, 1, "lin", 0.01, 1.0, ''), action = function(v) nv.all.ampRel(v) end}
    params:add {id="ampCurve", type='control', controlspec = controlspec.new(-8, 5, "lin", 0.01, -3.0, ''), action = function(v) nv.all.ampCurve(v) end}
    params:add {id="level", type='control', controlspec = controlspec.new(0, 1, "lin", 0.01, 0.2, ''), action = function(v) nv.all.lvel(v) end}
        
    
       
end

keyboardz.event = function(data)
    local msg = midi.to_msg(data)
    if msg.type == "note_on" then
        nv.id(msg.note).hz(musicutil.note_num_to_freq(msg.note)) -- actual hz is vc.hz * all.hz
        nv.id(msg.note).peak((msg.vel / 127 /4 ) + 0.75)
    elseif msg.type == "note_off" then
        nv.id(msg.note).peak(0)
    end
end


function key(n,z)
  if n==3 and z==1 then
    nv.all.peak(0)
  end
end
