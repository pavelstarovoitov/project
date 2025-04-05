# Python script must generate index.html file with greetings

import argparse  # for parsing incoming arguments

# for generating index.html from template.html
from jinja2 import Environment, FileSystemLoader

parser = argparse.ArgumentParser()  # create parser

# get undefined number of people names
parser.add_argument("names", help="people names", nargs="+")
args = parser.parse_args()

# set current folder as working enviroment
environment = Environment(loader=FileSystemLoader('./'))
template = environment.get_template("template.html")  # get template.html file
image = 'image.png'  # set name for picture
context = {                # set data for generating content from template.html
    "names": args.names,
    "image": image
}

content = template.render(context)  # create content from template file
with open('index.html', mode="w", encoding="utf-8") as page:
    page.write(content)  # create index.html file and write content in it
