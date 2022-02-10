using SpecialFunctions
using QuadGK

function ourquadgk(f, a, b)
    (value, _) = quadgk(f, a, b, )
    return value
end

"""
K(ρ, β, x, r) computes the integral original function, gives a more convinent way to calculste the cumulative sum of the inner function.
"""


"""
wright(ρ, β, z) computes the Wright function of z.

While in the paper, q₁ is a fixed small number which 0<q₁<1 and q₂ is a fixed big number,
Here we set q₁ = 0.5 and q₂ = 100
"""
q₁ = 2
q₂ = 100


function wright(ρ, β, z)
    ϵ = 0.2
    x=abs(z) 
    if abs(z) ≤ q₁ #HACK: This part is working fine
        if ρ > 0
            k₀ = max((1-β)/ρ, log(ϵ)/log(abs(z))-1)
        elseif -1 < ρ < 0
            med = (1-β)/(1+ρ)
            k₀ = max(-β/ρ, med, log(π*(1+ρ)*ϵ*abs(z)^(-med))/(log(abs(z))-1-ρ)+med)
        end
        s = zero(z)
        k₀ = ceil(k₀)
        for k=0:k₀
            s += (z^k)/(factorial(k)*gamma(β + ρ*k))#+μz #NOTE: factorial might led to overflow when k is bigger than 21
        end
        return s

    elseif q₁ < abs(z) < q₂ #The most important in applications

        
        #TODO: What is x stand for?? The real part of z or just a defination??
        med1 = 1-z*cos(ρ*π)
        med2 = 1/ρ+1-β/ρ
        r₀=0
        if (-1 < ρ < -1/2) && (1+ρ ≤ β)
            r₀ = max(med1^(1/(1+ρ)), (-log(-π*ρ*ϵ))^(-1/ρ))
        elseif (-1 < ρ < -1/2) && (β<1+ρ)
            B = -1/(ρ*π)*(abs(med2)+2)*(-2*med2)^(-med2)
            r₀ = max((med1), (abs(med2)+1)^(-1/ρ), (-2*log(ϵ/B))^(-1/ρ))
        elseif (-1/2 <= ρ < 0) & (β ≥ 0)
            r₀ = -log(ϵ*π)
        elseif (-1 < ρ < -1/2) & (β<0)
            r₀ = max(abs(β)+1, -2*log(ϵ*π/(4(abs(β)+2)*β^2)))
        elseif (ρ > 0) & (β ≥ 0)
            r₀ = max(abs(x*cos(ρ*π))^(1/ρ), -log(ϵ*π)+1)
        elseif (ρ > 0) & (β < 0)
            r₀ = max(abs(x*cos(ϵ*π))^(1/ρ), abs(β)+1, -2*log(ϵ*π/(4*(abs(β)+2)*β^2))+2)
        end
        function K(r)
            return exp(-r-x*r^(-ρ)*cos(ρ*π))*r^(-β)*sin(-x*r^(-ρ)*sin(ρ*π)+π*β)
        end
        return ourquadgk(K, 1, r₀) # The improper integral require the lower limit ∈ {0, 1} and r₀≥1, we set 0 as the lower limit.

    elseif abs(z)>q₂
    end
    
    #FIXME: The third part abs(z) > q₂ is not implement yet

end

