from sUTLHaxePython2.sUTL import sUTL

def main():
    decl = {"transform-t": {"&": "@", "head": True}}
    z = {
        "transform-t": {"x": {"x": {"x": {"s": "^@"}}}, "y": {"x": {"x": {"s": "^@"}}}}
    }
     
    source = {
      "y": 3
    }
       
    s = sUTL()

    def compilelib():
        libs = [[
          {
              "name": "six",
              "transform-t": {
                  "x": 6
              }
          }
        ]]
     
        libr = s.compilelib([decl], libs)
        lib = libr["lib"]
        
        return lib

    def run(shx, thx, lhx, bhx, hhx):
        return s.evaluatehx(shx, thx, lhx, bhx, hhx)

    lib = compilelib()
    
    import cProfile

    p = cProfile.Profile()
    
    shx = s._toHx(source)
    thx = s._toHx(decl["transform-t"])
    lhx = s._toHx(lib)
    hhx = s._toHx(0)
    bhx = s.builtinshx()
    
    p.enable()
    rhx = p.runcall(run, shx, thx, lhx, bhx, hhx)
    p.disable()

    r = s._fromHx(rhx)

    p.print_stats()
 
    print r

main()