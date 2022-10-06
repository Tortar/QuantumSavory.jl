if get(ENV,"QUANTUMSAVORY_GL_TEST","")=="true"
    include("../examples/firstgenrepeater/1_entangler_example.jl")
    include("../examples/firstgenrepeater/2_swapper_example.jl")
    include("../examples/firstgenrepeater/3_purifier_example.jl")
    include("../examples/firstgenrepeater/4_visualization.jl")
    include("../examples/firstgenrepeater/5_clifford_full_example.jl")
end
include("../examples/firstgenrepeater/6_compare_formalisms.jl")
include("../examples/firstgenrepeater/6.1_compare_formalisms_noplot.jl")

include("../examples/colorcentermodularcluster/1_time_to_connected.jl")
