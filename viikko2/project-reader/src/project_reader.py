from urllib import request
from project import Project
import toml


class ProjectReader:
    def __init__(self, url):
        self._url = url

    def get_project(self):
        # tiedoston merkkijonomuotoinen sisältö
        content = request.urlopen(self._url).read().decode("utf-8")

        # deserialisoi TOML-formaatissa oleva merkkijono ja muodosta Project-olio sen tietojen perusteella
        content_dict = toml.loads(content)
        name = content_dict["tool"]["poetry"]["name"]
        description = content_dict["tool"]["poetry"]["description"]
        dependencies = content_dict["tool"]["poetry"]["dependencies"].keys()
        dev_dependencies = content_dict["tool"]["poetry"]["group"]["dev"]["dependencies"]
        license = content_dict["tool"]["poetry"]["license"]
        authors = content_dict["tool"]["poetry"]["authors"]
        
        return Project(name, description, license, authors, dependencies, dev_dependencies)
