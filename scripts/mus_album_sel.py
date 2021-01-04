#!/bin/python

import argparse
import sys
import os
import re
import taglib


def main():

    parser = argparse.ArgumentParser(
        description='Create an album with metadata from given songs.')
    parser.add_argument('files', type=argparse.FileType('r'), nargs='+')
    args = parser.parse_args()

    album_artist = input('Artist: ')
    album_name = input('Album name: ')

    songs = [file.name for file in args.files]
    songs.sort(key=lambda x: os.path.getmtime(x))

    albumdir = f'{os.environ["HOME"]}/Music/{album_artist} - {album_name}/'
    if not os.path.exists(albumdir):
        os.mkdir(albumdir)

    for num, oldfile in enumerate(songs, start=1):
        filename = oldfile.split("/")[-1]
        artist = filename.split(" - ")[0]
        title_ext = " - ".join(filename.split(" - ")[1:])
        title = os.path.splitext(title_ext)[0]
        newfile = f'{albumdir}{num:02d}. {filename}'

        # moving files to a new directory
        os.rename(oldfile, newfile)

        # changing metadata
        song = taglib.File(newfile)
        if "TITLE" not in song.tags:
            song.tags["TITLE"] = title
        if "ARTIST" not in song.tags:
            song.tags["ARTIST"] = artist
        if "TRACKNUMBER" not in song.tags:
            song.tags["TRACKNUMBER"] = f'{num}/{len(sys.argv)-1}'
        song.save()


if __name__ == '__main__':
    main()
