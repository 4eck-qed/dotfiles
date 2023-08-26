vim.g.mapleader = ' '

local keymap = vim.keymap

local function unset(key)
   pcall(keymap.del, 'n', key)
   pcall(keymap.del, 'v', key)
   pcall(keymap.del, 'i', key)
end

local function set_xmode_uniform(key, cmd, help)
    keymap.set('i', key, cmd)
    keymap.set('n', key, cmd)
    keymap.set('v', key, cmd)
end

local function set_xmode_cmd(key, cmd, help)
    keymap.set('i', key, string.format('<C-o>%s<CR>', cmd))
    keymap.set('n', key, string.format('%s<CR>', cmd))
    keymap.set('v', key, string.format('%s<CR>', cmd))
end

local function set_xmode_map(key, map, help)
    keymap.set('i', key, string.format('<C-o>%s', map))
    keymap.set('n', key, string.format('%s', map))
    keymap.set('v', key, string.format('%s', map))
end

local function set_xmode_vcmd(key, cmd, help)
    keymap.set('i', key, string.format('<C-o>v%s<CR>', cmd))
    keymap.set('n', key, string.format('v%s<CR>', cmd))
    keymap.set('v', key, string.format('%s<CR>', cmd))
end

local function set_xmode_vmap(key, map, help)
    keymap.set('i', key, string.format('<C-o>v%s', map))
    keymap.set('n', key, string.format('v%s', map))
    keymap.set('v', key, string.format('%s', map))
end

local function set_cmd(key, cmd, help)
    keymap.set('n', key, string.format('%s<CR>', cmd))
    keymap.set('v', key, string.format('%s<CR>', cmd))
end

local function set_normal(key, map, help)
    keymap.set('n', key, map)
end

local function set_visual(key, map, help)
    keymap.set('v', key, map)
end

local function set_nv(key, map, help)
    keymap.set('n', key, map)
    keymap.set('v', key, map)
end

local function set_input(key, map, help)
    keymap.set('i', key, map)
end

local function set_leader_cmd(key, cmd, help)
    keymap.set('n', string.format('<leader>%s', key), string.format('%s<CR>', cmd))
end

local function set_leader_map(key, map, help)
    keymap.set('n', string.format('<leader>%s', key), map)
end

-- unmap
-- unset('CR')
unset('s')
unset('ss')
unset('sss')
unset('<C-S-z>') -- fuck you who ever set this to killing the ide
unset('<C-S-Z>') -- fuck you who ever set this to killing the ide
set_xmode_map('<C-S-z', '')
set_xmode_map('<C-S-Z', '')



set_input(      '<CR>',         '<CR>')
set_input(      '<Esc>',        '<Esc>',                            'enter normal mode')
set_normal(     '<Esc>',        'a',                                'enter insert mode')

--[[
    /////////////////////////////////
    //////////// GLOBAL /////////////
    /////////////////////////////////
]]
set_xmode_cmd(  '<C-q>',        ':q!')
set_xmode_cmd(  '<C-S-q>',      ':qa!')
set_xmode_cmd(  '<C-t>',        ':sp | term')
set_xmode_cmd(  '<C-S-b>',      ':sp | term cargo build',           'build')
set_xmode_map(  '<C-z>',        'u',                                'undo')
set_xmode_map(  '<C-y>',        '<C-r>',                            'redo')
set_xmode_cmd(  '<C-k><C-c>',   ':CommentToggle',                   'comment/uncomment')
-- set_xmode_cmd(  '<C-k><C-d>',   ':RustFmt',                         'format document')
set_xmode_cmd(  '<C-s>',        ':w',                               'save document')

-- Selection
set_xmode_vmap( '<S-Up>',       'k',                                'select up')
set_xmode_vmap( '<S-Down>',     'j',                                'select down')
set_xmode_vmap( '<S-C-Up>',     '<PageUp>',                         'select page up')
set_xmode_vmap( '<S-C-Down>',   '<PageDown>',                       'select page down')
set_xmode_vmap( '<S-Left>',     'h',                                'select to the left')
set_xmode_vmap( '<S-Right>',    'l',                                'select to the right')
set_xmode_vmap( '<S-C-Left>',   '<C-Left>',                         'select to the left with skip')
set_xmode_vmap( '<S-C-Right>',  '<C-Right>',                        'select to the right with skip')

-- Navigation
set_xmode_map(  '<C-a>',        '^',                                'goto line start')
set_xmode_map(  '<C-e>',        '<End>',                            'goto line end')
set_input(      '<C-Left>',     '<Esc>bi',                          'skip word left')
set_normal(     '<C-Left>',     'b')
set_input(      '<C-Right>',    '<Esc>ea',                          'skip word right')
set_normal(     '<C-Right>',    'e')

-- Move line(s) up
set_input(      '<A-Up>',       '<C-o>:move -2<CR>',                'move line(s) up')
set_normal(     '<A-Up>',       ':move -2<CR>')
set_visual(     '<A-Up>',       ':move \'<-2<CR>gv')

-- Move line(s) down
set_input(      '<A-Down>',     '<C-o>:move +1<CR>',                'move line(s) down')
set_normal(     '<A-Down>',     ':move +1<CR>')
set_visual(     '<A-Down>',     ':move \'>+1<CR>gv')

-- Manipulation
set_xmode_map(  '<S-Del>',      'dd',                               'delete line(s)')
set_input(      '<C-BS>',       '<C-w>',                            'delete word to left')
set_nv(         '<C-BS>',       'db',                               'delete word to left')
set_xmode_map(  '<C-Del>',      'dw',                               'delete word to right')
set_xmode_map(  '<C-x>',        'd',                                'cut')
set_xmode_map(  '<C-c>',        'y',                                'copy')
set_nv(         '<C-v>',        'p',                                'paste')
set_input(      '<C-v>',        '<C-r+>',                           'paste')
set_xmode_cmd(  '<C-d>',        ':t.',                              'duplicate line')
set_visual(     '<C-d>',        ':\'<,\'>t.<cr>',                   'duplicate line(s)')

--[[
    /////////////////////////////////
    //////////// NORMAL /////////////
    /////////////////////////////////
]]
-- set_cmd(        '<C-`>',        ':so',                              'shitout')
set_leader_cmd( 'e',            ':NvimTreeToggle',                  'toggle file explorer')
set_leader_cmd( 'b',            ':bprev',                           'prev buffer')
set_leader_map( '+',            '<C-a>',                            'incr number')
set_leader_map( '-',            '<C-x>',                            'decr number')
set_leader_cmd( 'cm',           ':nohl',                            'clear search matches')

-- window splitting
set_leader_map( 'sv',           '<C-w>v',                           'vertical split')
set_leader_map( 'sh',           '<C-w>s',                           'horizontal split')
set_leader_map( 'se',           '<C-w>=',                           'equal split')
set_leader_cmd( 'sx',           ':close',                           'close split')
set_leader_cmd( 'sm',           ':MaximizerToggle',                 'max split')

-- tabs
set_leader_cmd( 'to',           ':tabnew',                          'open new tab')
set_leader_cmd( 'tx',           ':tabclose',                        'close tab')
set_leader_cmd( 'tn',           ':tabn',                            'goto next tab')
set_leader_cmd( 'tp',           ':tabp',                            'goto prev tab')

-- telescope
set_leader_cmd( 'ff',           ':Telescope find_files',            'find files in cwd (respects .gitignore)')
set_leader_cmd( 'fg',           ':Telescope git_files')
set_leader_cmd( 'fs',           ':Telescope live_grep',             'find in cwd as you type')
set_leader_cmd( 'fc',           ':Telescope grep_string',           'find under cursor in cwd')
set_leader_cmd( 'fb',           ':Telescope buffers',               'list open buffers in cur nvim instance')
set_leader_cmd( 'fh',           ':Telescope help_tags',             'list available help tags')

-- telescope git cmds (not on youtube nvim video)
set_leader_cmd( 'gc',           ':Telescope git_commits',           'list all git commits (use <cr> to checkout) [\'gc\' for git commits]')
set_leader_cmd( 'gfc',          ':Telescope git_bcommits',          'list git commits for current file/buffer (use <cr> to checkout) [\'gfc\' for git file commits]') --
set_leader_cmd( 'gb',           ':Telescope git_branches',          'list git branches (use <cr> to checkout) [\'gb\' for git branch]')
set_leader_cmd( 'gs',           ':Telescope git_status',            'list current changes per file with diff preview [\'gs\' for git status]')

--[[
    /////////////////////////////////
    //////////// VISUAL /////////////
    /////////////////////////////////
]]
set_visual(     '<BS>',         '_x',                               'delete backward')

--[[
    /////////////////////////////////
    //////////// INSERT /////////////
    /////////////////////////////////
]]
set_input(      '<Space>',      ' ')
set_input(      '<C-Bslash>',   '<Esc><S-k>')
set_normal(     'x',            '\'_x',                             'delete char no copy')
