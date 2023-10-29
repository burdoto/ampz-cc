file='oredata.json'
data={}

function save()
    h=fs.open(file,'w')
    buf=textutils.serialize(data)
    h.writeLine(buf)
    h.flush()
    h.close()
end

function load()
    h=fs.open(file,'r')
    buf=h.readAll()
    data=textutils.unserialize(buf)
    h.close()
end

load()
