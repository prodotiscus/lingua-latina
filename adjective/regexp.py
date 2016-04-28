import re
class r(str):
    def s(self, rs, rm):
        return r(re.sub(rs, rm, self))
    def m(self, s):
        return re.findall(s, self)
    def c(self, s):
        return re.search(s, self)
    def split(self, s):
        return re.split(s, self)
def indexOf(lst, rx):
    srgx = re.compile(rx).search
    return [l for l in lst for m in (srgx(l),) if m]
