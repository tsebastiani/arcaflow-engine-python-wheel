from setuptools import setup

setup(
    name='arcaflowengine',
    version='1.0.0',
    license_files = ('LICENSE',),
    package_data={
        'arcaflowengine':['bin/arcaflowengine']
    },
    packages=['arcaflowengine']
)