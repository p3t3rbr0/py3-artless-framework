import unittest

from artless import __version__


class TestModule(unittest.TestCase):
    def test_version(self):
        self.assertEqual(__version__, "0.0.1")
