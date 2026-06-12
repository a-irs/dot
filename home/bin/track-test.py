#!/usr/bin/env python3

import track

import unittest
import os
import argparse
from pathlib import Path
import tempfile


class TestCli(unittest.TestCase):
    def setUp(self):
        tmp = tempfile.NamedTemporaryFile("w")
        track.DATA_FILE = Path(tmp.name)

        self.c = track.Cli()
        self.c.args = argparse.Namespace()

    def test_same_times_fail(self):
        with self.assertRaises(track.TimeLogException):
            self.c.args.additional = ["tag1", "tag2", "11:00", "-", "13:00"]
            self.c.start()
            self.c.args.additional = ["tag1", "tag2", "11:00", "-", "13:00"]
            self.c.start()

        all = list(track.TimeLogs.get_all())
        assert len(all) == 1 and all[0].serialize() == "2026-05-26 11:00 - 13:00  tag1 tag2"

    def test_same_times_fail_2(self):
        with self.assertRaises(track.TimeLogException):
            self.c.args.additional = ["tag1", "tag2", "12:00", "-", "13:00"]
            self.c.start()
            self.c.args.additional = ["tag1", "tag2", "12:30", "-", "12:35"]
            self.c.start()

        all = list(track.TimeLogs.get_all())
        assert len(all) == 1 and all[0].serialize() == "2026-05-26 12:00 - 13:00  tag1 tag2"

    def test_ok_1(self):
        self.c.args.additional = ["tag1", "tag2"]
        self.c.start()

        # FIXME track.TimeLogParseException: start 17:04 is identical to end 17:04
        self.c.report()


if __name__ == "__main__":
    unittest.main()
    # unittest.main(verbosity=2)
