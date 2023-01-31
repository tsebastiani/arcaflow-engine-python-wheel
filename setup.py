from setuptools import setup

setup(
    name='arcaflowengine',
    version='1.0.0',
    license_files = ('LICENSE',),
    package_data={
        'arcaflowengine':['bin/arcaflow*']
    },
    description="Arcaflow engine python wrapper",
    author="Tullio Sebastiani",
    author_email="tsebasti@redhat.com",
    license="Apache",
    packages=['arcaflowengine'],
    url="https://arcalot.io/arcaflow/"
)