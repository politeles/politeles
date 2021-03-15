+++ 
draft = false
date = 2021-03-08T00:09:12+02:00
title = "Vim shortcuts"
description = ""
slug = "vim-shortcuts" 
tags = []
categories = []
externalLink = ""
series = []
+++


# Cut/copy and paste using visual selection

Visual selection is a common feature in applications, but Vim's visual selection has several benefits.

To cut-and-paste or copy-and-paste:

    Position the cursor at the beginning of the text you want to cut/copy.
    Press v to begin character-based visual selection, or V to select whole lines, or Ctrl-v or Ctrl-q to select a block.
    Move the cursor to the end of the text to be cut/copied. While selecting text, you can perform searches and other advanced movement.
    Press d (delete) to cut, or y (yank) to copy.
    Move the cursor to the desired paste location.
    Press p to paste after the cursor, or P to paste before.

Visual selection (steps 1-3) can be performed using a mouse.

If you want to change the selected text, press c instead of d or y in step 4. In a visual selection, pressing c performs a change by deleting the selected text and entering insert mode so you can type the new text. 

# Comment and uncomment

Put your cursor on the first # character, press CtrlV (or CtrlQ for gVim), and go down until the last commented line and press x, that will delete all the # characters vertically.

For commenting a block of text is almost the same:

    First, go to the first line you want to comment, press CtrlV. This will put the editor in the VISUAL BLOCK mode.
    Then using the arrow key and select until the last line
    Now press ShiftI, which will put the editor in INSERT mode and then press #. This will add a hash to the first line.
    Then press Esc (give it a second), and it will insert a # character on all other selected lines.

For the stripped-down version of vim shipped with debian/ubuntu by default, type : s/^/# in the third step instead (any remaining highlighting of the first character of each line can be removed with :nohl).

Here are two small screen recordings for visual reference.

# Replace all

The :substitute command searches for a text pattern, and replaces it with a text string. There are many options, but these are what you probably want:

:s/foo/bar/g
    Find each occurrence of 'foo' (in the current line only), and replace it with 'bar'.

:%s/foo/bar/g
    Find each occurrence of 'foo' (in all lines), and replace it with 'bar'.

:%s/foo/bar/gc
    Change each 'foo' to 'bar', but ask for confirmation first.

:%s/\<foo\>/bar/gc
    Change only whole words exactly matching 'foo' to 'bar'; ask for confirmation.

:%s/foo/bar/gci
    Change each 'foo' (case insensitive due to the i flag) to 'bar'; ask for confirmation.
    :%s/foo\c/bar/gc is the same because \c makes the search case insensitive.
    This may be wanted after using :set noignorecase to make searches case sensitive (the default).
	
	
# References
[Visual selection](https://vim.fandom.com/wiki/Cut/copy_and_paste_using_visual_selection)
[Comment and uncomment](
https://stackoverflow.com/questions/1676632/whats-a-quick-way-to-comment-uncomment-lines-in-vim
)

