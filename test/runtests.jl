using Wright
using Test

@testset "Wright function" begin
    @test isapprox(wright(1, 2, -1), 0.57672)
    @test isapprox(wright(1, 1/2, -1), -0.23479)
    @test isapprox(wright(1, 2, -9/16), 0.74392)
    @test isapprox(wright(1, 1/2, -9/16), 0.03991)
    @test isapprox(wright(1, 3/2, -121/100), -0.14475)
    @test isapprox(wright(-1/2, 1/2, -5/2), 0.11826)
    @test isapprox(wright(-1/2, 1/2, -1/2), 0.53001)
    @test isapprox(wright(-1/3, 2/3, -5/2), 0.10772)
    @test isapprox(wright(-1/3, 2/3, -1/2), 0.55633)
    @test isapprox(wright(1, 2, -2500), -0.002)
end