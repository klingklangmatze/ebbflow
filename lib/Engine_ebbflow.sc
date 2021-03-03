Engine_ebbflow : Engine_Nv {

*new { arg context, callback;
^super.new(context, callback);
}
synthFunc {^{
        arg peak=0, hz=0, level=0.2,
        
        shape=0.5, slope=0.5, smooth=0.5, shift=0, output_mode=0, output=0, fader=0,
        
        ampAtk=0.01, ampDec=0.1, ampSus=1.0, ampRel=0.3, ampCurve= -3.0;
        
        var snd, aenv, fade;        
        
        snd = MiTides.ar(hz, shape, slope, smooth, shift, output_mode: output_mode);
        aenv = EnvGen.ar(Env.adsr(ampAtk, ampDec, ampSus, ampRel, 1.0, ampCurve),
            peak, doneAction:2);
            
        fade = [snd[0],snd[1],snd[2],snd[3], Splay.ar(snd)];
        snd = snd * aenv;
        snd = SelectX.ar(fader*fade.size, fade);

        Out.ar(context.out_b.index, level * Pan2.ar(snd));
    }}

alloc {
        ^super.alloc()
}

free {
        ^super.free()
}
}
