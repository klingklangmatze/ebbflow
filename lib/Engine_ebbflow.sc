Engine_ebbflow : Engine_Nv {

*new { arg context, callback;
^super.new(context, callback);
}
synthFunc {^{
        arg peak=0, hz=0, level=0.2, // the basics
        shape=0.0, // base waveshape selection
        // amplitude envelope params
        ampAtk=0.01, ampDec=0.1, ampSus=1.0, ampRel=0.3, ampCurve= -3.0;
        
        var osc1, osc2, snd, freq, del, aenv, fenv;

        
        
        snd = MiTides.ar(hz, shape);
        aenv = EnvGen.ar(
            Env.adsr(ampAtk, ampDec, ampSus, ampRel, 1.0, ampCurve),
            peak, doneAction:2);


                snd = snd * aenv;

        Out.ar(context.out_b.index, Pan2.ar(snd));
    }}

alloc {
        ^super.alloc()
}

free {
        ^super.free()
}
}
