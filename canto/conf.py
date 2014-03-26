from canto.extra import *
from os.path import expanduser

opml_path = expanduser("~/.canto/feeds.opml")
source_opml(opml_path)

link_handler("firefox \"%u\"")

reader_keys['j'] = "scroll_down"
reader_keys['k'] = "scroll_up"

