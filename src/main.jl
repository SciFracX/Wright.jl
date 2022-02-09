using SpecialFunctions
using QuadGK

"""
K(ρ, β, x, r) computes the integral original function, gives a more convinent way to calculste the cumulative sum of the inner function.
"""
function K(ρ, β, x, r)
    return exp(-r-x*r^(-ρ)cos(ρ*π))r^(-β)sin(-xr^(-ρ)sin(ρ*π)+π*β)
end

"""
wright(ρ, β, z) computes the Wright function of z.

While in the paper, q₁ is a fixed small number which 0<q₁<1 and q₂ is a fixed big number,
Here we set q₁ = 0.5 and q₂ = 100
"""
q₁ = 0.5
q₂ = 100


function wright(ρ, β, z)
    ϵ = 0.2
    if abs(z) ≤ q₁ #HACK: This part is working fine
        if ρ > 0
            k₀ = max(ceil(Int, (1-β)/ρ), ceil(Int, log(ϵ)/log(abs(z))-1))
        elseif -1 < ρ < 0
            med = (1-β)/(1+ρ)
            k₀ = max(ceil(Int, -β/ρ), ceil(Int, med), ceil(Int, log(π*(1+ρ)*ϵ*abs(z)^med)/(log(abs(z))-1-ρ)+med))
        end

        s = zero(z)
        for k=0:k₀
            s += (z^k)/(factorial(k)*gamma(β+ρ*k))#+μz #NOTE: factorial might led to overflow when k is bigger than 21
        end
        return s

    elseif q₁ < abs(z) < q₂ #The most important in applications
            x=-abs(z) 
            #TODO: What is x stand for?? The real part of z or just a defination??
        med1 = 1-z*cos(ρ*π)
        med2 = 1/ρ+1-β/ρ
        if (-1 < ρ <-1/2) & (1+ρ ≤ β)
            return r₀ = max(ceil(Int, med1^(1/(1+ρ))), ceil(Int, (-log(-π*ρ*ϵ))^(-1/ρ)))
        elseif (-1 < ρ < -1/2) & (β<1+ρ)
            B = -1/(ρ*π)*(abs(med2)+2)*(-2*med2)^(-med2)
            return r₀ = max(ceil(Int, (med1)), ceil(Int, (abs(med2)+1)^(-1/ρ)), ceil(Int, (-2log(ϵ/B))^(-1/ρ)))
        elseif (-1/2 <= ρ < 0) & (β ≥ 0)
            return r₀ = -log(ϵ*π)
        elseif (-1 < ρ < -1/2) & (β<0)
            return r₀ = max(ceil(Int, abs(β)+1), ceil(Int, -2log(ϵπ/(4(abs(β)+2)*β²))))
        elseif (ρ > 0) & (β ≥ 0)
            return r₀ = max(ceil(Int, abs(x*cos(ρ*π))^(1/ρ)), ceil(Int, -log(ϵ*π)+1))
        elseif (ρ > 0) & (β ≥ 0)
            return r₀ = max(ceil(Int, abs(x*cos(ϵ*π))^(1/ρ)), ceil(Int, abs(β)+1), ceil(Int, -2log(ϵ*π/(4*(abs(β)+2)*β²))+2))
        end
        return quadgk(K, 0, r₀) # The improper integral require the lower limit ∈ {0, 1} and r₀≥1, we set 0 as the lower limit.
    end
    
    #FIXME: The third part abs(z) > q₂ is not implement yet

end

