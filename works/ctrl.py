f = open('./english_demo.tex')
c = f.read()
c = c.replace('[', '$[')
c = c.replace(']', ']$')
f.close()

f = open('./1.tex', 'w')
f.write(c)
f.close()
