/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int swallowfloating    = 1;        /* 1 means swallow floating windows by default */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft = 0;   	/* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;        /* 0 means no systray */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const Bool viewontag         = True;     /* Switch view on tag switch */
static const char *fonts[]          = { "Hasklig:size=16" };
static const char dmenufont[]       = "Hasklig:size=16";
static const char col_dgray[]       = "#191D24";
static const char col_gray1[]       = "#2E3440";
static const char col_gray2[]       = "#3B4252";
static const char col_gray3[]       = "#434C5E";
static const char col_dwhite[]      = "#D8DEE9";
static const char col_white[]       = "#ECEFF4";
static const char col_magenta[]     = "#C800FF";
/* #define OPAQUE 0xffU */
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_dwhite, col_gray1, col_gray2 },
	[SchemeSel]  = { col_white, col_gray3, col_magenta  },
};

/* suckless */
/* static const unsigned int gappx     = 15;       /1* gaps between windows *1/ */
/* static const int splitstatus        = 1;        /1* 1 for split status items *1/ */
/* static const char *splitdelim        = ";";     /1* Character used for separating status *1/ */
/* static const unsigned int baralpha = 140; */
/* static const unsigned int borderalpha = 140; */


/* static const unsigned int alphas[][3]      = { */
/* 	/1*               fg      bg        border     *1/ */
/* 	[SchemeNorm] = { OPAQUE, baralpha, borderalpha }, */
/* 	[SchemeSel]  = { OPAQUE, baralpha, borderalpha }, */
/* }; */

// ##########################################################################################
// #                                        AUTOSTART                                       #
// ##########################################################################################
static const char *const autostart[] = {
    "xsetroot", "-cursor_name", "left_ptr", NULL,
    "kitty", NULL,
    "flameshot", NULL,
    "lxpolkit", NULL,
    "dunst", NULL,
    "picom", NULL,
    "sh", "-c", "/home/shared/.config/dwm/scripts/status", NULL,
    "sh", "-c", "/home/shared/.config/dwm/scripts/dbus", NULL,
    "sh", "-c", "/home/shared/.xinitrc", "&", NULL,
    "ulauncher", "&", NULL,
    NULL /* terminate */
};

// ##########################################################################################
// #                                        WORKSPACES (TAGS)                               #
// ##########################################################################################
static const char *tags[] = { 
    "☕",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "🌈",
    "♿",
    "💀"
};

static const char ptagf[] = "[%s %s]";	/* format of a tag label */
static const char etagf[] = "[%s]";	    /* format of an empty tag */
static const int lcaselbl = 0;		    /* 1 means make tag label lowercase */	

// ##########################################################################################
// #                                        WINDOWRULES                                     #
// ##########################################################################################
static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
    // NOTE: 
    //  due to count starting at 0 -> 0 = Workspace 1 => n = Workspace n+1
    //  to assign a window to a workspace set `tags mask` to: `1 << n`
    //  where 0 means unassigned
	/* class                            instance  title           tags mask     isfloating  isterminal     noswallow   monitor */
	{ "St",                             NULL,     NULL,           0,            0,          1,             0,          -1 },
	{ "kitty",                          NULL,     NULL,           0,            0,          1,             0,          -1 },
	{ "Picture-in-Picture",             NULL,     NULL,           0,            1,          0,             0,          -1 },
	{ "Gimp",                           NULL,     NULL,           0,            1,          0,             0,          -1 },
	{ "Pinta",                          NULL,     NULL,           0,            1,          0,             0,          -1 },
	{ "Notes-up",                       NULL,     NULL,           0,            1,          0,             0,          -1 },
	{ "vlc",                            NULL,     NULL,           0,            1,          0,             0,          -1 },
	{ "mpv",                            NULL,     NULL,           0,            1,          0,             0,          -1 },
	{ "Thunar",                         NULL,     NULL,           0,            1,          0,             0,          -1 },
	{ "thunar",                         NULL,     NULL,           0,            1,          0,             0,          -1 },
	{ "dolphin",                        NULL,     NULL,           0,            1,          0,             0,          -1 },
	{ "jetbrains-rider",                NULL,     NULL,           1 << 0,       0,          0,             0,           0 },
	{ "discord",                        NULL,     NULL,           1 << 3,       0,          0,             0,           0 },
	{ "WebCord",                        NULL,     NULL,           1 << 3,       0,          0,             0,           0 },
	{ "de.shorsh.discord-screenaudio",  NULL,     NULL,           1 << 3,       0,          0,             0,           0 },
  	{ "steam",                          NULL,     NULL,           1 << 7,       0,          0,             0,	        0 },
  	{ "lutris",                         NULL,     NULL,           1 << 8,       0,          0,             0,	        0 },
  	{ "Lutris",                         NULL,     NULL,           1 << 8,       0,          0,             0,	        0 },
  	{ "gamescope",                      NULL,     NULL,           1 << 9,       0,          0,             0,	        0 },
  	{ "leagueclient.exe",               NULL,     NULL,           1 << 9,       1,          0,             0,	        0 },
  	{ "league of legends.exe",          NULL,     NULL,           1 << 9,       0,          0,             0,	        0 },
  	{ "masterduel",                     NULL,     NULL,           1 << 9,       1,          0,             0,	        0 },
	{ "xivlauncher",                    NULL,     NULL,           1 << 9,       1,          0,             0,           0 },
	{ "steam_app_319510",               NULL,     NULL,           1 << 11,      1,          0,             1,           0 },
	{ "Firefox",                        NULL,     NULL,           1 << 0,       0,          0,            -1,           1 },
	{ "firefoxdeveloperedition",        NULL,     NULL,           1 << 0,       0,          0,            -1,           1 },
	{ "Google-chrome",                  NULL,     NULL,           1 << 1,       0,          0,            -1,           1 },
	{ NULL,                             NULL,     "Event Tester", 0,            0,          0,             1,          -1 }, /* xev */
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int attachbelow = 1;    /* 1 means attach after the currently active window */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[T]",      tile },    /* first entry is default */
	{ "[F]",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, 
    "-nb", col_dgray,   // normal background
    "-nf", col_dwhite,  // normal foreground
    "-sb", col_gray3,   // selected background
    "-sf", col_white,   // selected foreground
    NULL
};
static const char *termcmd[]  = { "kitty", NULL };

// ##########################################################################################
// #                                        KEYBINDS                                        #
// ##########################################################################################
static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_r,       spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_x,       spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_Return,  spawn,          SHCMD ("kitty")},
	{ MODKEY,                       XK_t,       spawn,          SHCMD ("kitty -e btop")},
	{ MODKEY,                       XK_e,       spawn,          SHCMD ("thunar")},
	{ MODKEY,                       XK_b,       spawn,          SHCMD ("firefox-developer-edition")},
	{ MODKEY,                       XK_p,       spawn,          SHCMD ("flameshot full -p $HOME/Pictures/Screenshots/")},
	{ MODKEY|ShiftMask,             XK_p,       spawn,          SHCMD ("flameshot gui -p $HOME/Pictures/Screenshots/")},
	{ MODKEY|ShiftMask,             XK_s,       spawn,          SHCMD ("flameshot gui")},
	{ MODKEY|ShiftMask,             XK_b,       togglebar,      {0} },
  	{ MODKEY,                       XK_m,       fullscreen,     {0} },
	{ MODKEY,                       XK_comma,   focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period,  focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,   tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period,  tagmon,         {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_f,       togglefloating, {0} },
	{ 0,                            0x1008ff02, spawn,          SHCMD ("xbacklight -inc 10")},
	{ 0,                            0x1008ff03, spawn,          SHCMD ("xbacklight -dec 10")},
	{ 0,                            0x1008ff11, spawn,          SHCMD ("amixer sset Master 5%- unmute")},
	{ 0,                            0x1008ff12, spawn,          SHCMD ("amixer sset Master $(amixer get Master | grep -q '\\[on\\]' && echo 'mute' || echo 'unmute')")},
	{ 0,                            0x1008ff13, spawn,          SHCMD ("amixer sset Master 5%+ unmute")},
	{ MODKEY,                       XK_j,       focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,       focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,       incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,       incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,       setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,       setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_z,       zoom,           {0} },
	{ MODKEY,                       XK_Tab,     view,           {0} },
	/* { MODKEY,                       XK_t,       setlayout,      {.v = &layouts[0]} }, */
	{ MODKEY,                       XK_f,       setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_space,   setlayout,      {0} },
	/* { MODKEY,                       XK_0,       view,           {.ui = ~0 } }, */
	/* { MODKEY|ShiftMask,             XK_0,       tag,            {.ui = ~0 } }, */
	TAGKEYS(                        XK_1,                       0)
	TAGKEYS(                        XK_2,                       1)
	TAGKEYS(                        XK_3,                       2)
	TAGKEYS(                        XK_4,                       3)
	TAGKEYS(                        XK_5,                       4)
	TAGKEYS(                        XK_6,                       5)
	TAGKEYS(                        XK_7,                       6)
	TAGKEYS(                        XK_8,                       7)
	TAGKEYS(                        XK_9,                       8)
	TAGKEYS(                        XK_0,                       9)
	TAGKEYS(                        XK_minus,                   10)
	TAGKEYS(                        XK_equal,                   11)
	{ MODKEY|ShiftMask,             XK_q,       killclient,     {0} },
	{ MODKEY|ControlMask|ShiftMask, XK_q,       quit,           {0} },
	{ MODKEY|ControlMask|ShiftMask, XK_r,       spawn,          SHCMD("reboot")},
	{ MODKEY|ControlMask|ShiftMask, XK_p,       spawn,          SHCMD("shutdown now")},
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	/* placemouse options, choose which feels more natural:
	 *    0 - tiled position is relative to mouse cursor
	 *    1 - tiled postiion is relative to window center
	 *    2 - mouse pointer warps to window center
	 *
	 * The moveorplace uses movemouse or placemouse depending on the floating state
	 * of the selected client. Set up individual keybindings for the two if you want
	 * to control these separately (i.e. to retain the feature to move a tiled window
	 * into a floating position).
	 */
	{ ClkClientWin,         MODKEY,         Button1,        moveorplace,    {.i = 2} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

