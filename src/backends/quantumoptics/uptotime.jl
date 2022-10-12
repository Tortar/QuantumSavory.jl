export krausops

function uptotime!(state::StateVector, idx::Int, background, Δt)
    state = dm(state)
    uptotime!(state, idx, background, Δt)
end

function uptotime!(state::Operator, idx::Int, background, Δt)
    nstate = zero(state)
    tmpl = zero(state)
    tmpr = zero(state)
    b = basis(state)
    e = isa(b,CompositeBasis) # TODO make this more elegant with multiple dispatch
    for k in krausops(background, Δt)
        k = e ? embed(b,[idx],k) : k # TODO lazy product would be better maybe
        mul!(tmpl,k,state,1,0) # TODO there must be a prettier way to do this
        mul!(tmpr,tmpl,k',1,0)
        nstate.data .+= tmpr.data
    end
    @assert abs(tr(nstate)) ≈ 1. # TODO maybe put under a debug flag
    nstate
end

function krausops(T1::T1Decay, Δt) # TODO checks comparing krausops and lindbladops
    p = exp(-Δt/T1.t1) # TODO check this
    [√(1-p) * _lh, √p * _hh + _ll]
end

function krausops(T2::T2Dephasing, Δt)
    p = 1-exp(-Δt/T2.t2) # TODO check this
    [√(1-p/2) * _id, √(p/2) * _z]
    #[√(1-p) * _id, √(p) * _hh, √(p) * _ll]
end