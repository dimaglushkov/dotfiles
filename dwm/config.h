/* See LICENSE file for copyright and license details. */
#include <X11/XF86keysym.h>

static const unsigned int borderpx  		= 2;/* border pixel of windows */
static const Gap default_gap        		= {.isgap = 1, .realgap = 5, .gappx = 5};
static const unsigned int snap      		= 32;	/* snap pixel */
static const unsigned int systraypinning 	= 0;	/* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft		= 0;	/* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing 	= 2;	/* systray spacing */
static const int systraypinningfailfirst 	= 1;	/* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        		= 1;	/* 0 means no systray */
//#define ICONSIZE 16   /* icon size */
//#define ICONSPACING 5 /* space between icon and title */
static const int ICONSIZE                   = 16;   /* icon size */
static const int ICONSPACING                = 5; /* space between icon and title */
static const int showbar            		= 1;	/* 0 means no bar */
static const int topbar             		= 1;	/* 0 means bottom bar */
static const char font[]            		= "Noto Mono, Font Awesome 5 Free, 12";
static const char dmenufont[]       		= "monospace:size=12";
static const char col_gray1[]       		= "#222222";
static const char col_gray2[]       		= "#444444";
static const char col_gray3[]       		= "#bbbbbb";
static const char col_gray4[]       		= "#eeeeee";
static const char col_cyan[]        		= "#005577";
static const char *colors[][3]      		= {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

static const char *const autostart[] = {
	"nm-applet", NULL,
	"picom", "-b", NULL,
	".fehbg", NULL,
	"set_mouse_configuration.sh", NULL,
	"set_touchpad_configuration.sh", NULL,
	"xset", "-dpms", "s", "off", NULL,
	"numlockx", "on", NULL,
	"gxkb", NULL,
	"indicator-keylock", NULL,
	"libinput-gestures", NULL,
	"dwmblocks", NULL,
	"blueman-applet", NULL,
	"thunderbird", NULL,
	"telegram-desktop", NULL,
	NULL
};


static const char *tags[] = {
	"1",
	"2",
	"3",
	"4",
	"5",
	"&#xf095;",
	"&#xf1bc;",
	"&#xf198;",
	"&#xf0e0;",
	"&#xf2c6;"
	};

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      			instance    title       tags mask   isfloating  monitor */
	{ "Gimp",     			NULL,       NULL,       0,          1,          -1 },
	{ "firefox",  			NULL,       NULL,       1 << 0,     0,          -1 },
	{ "discord",			NULL, 		NULL, 		1 << 5,		0,		  	-1 },
	{ "zoom",				NULL,		NULL,		1 << 5, 	0,			-1 },
	{ "spotify", 			NULL,		NULL,		1 << 6, 	0,			-1 },
	{ "Slack",				NULL,		NULL,		1 << 7,		0,			-1 },
	{ "thunderbird",		NULL,		NULL,		1 << 8,		0,			-1 },
	{ "TelegramDesktop", 	NULL,		NULL,		1 << 9, 	0, 			-1 },
	{ NULL,					NULL,		"win0",		0,			1,			-1 },
	{ NULL,					NULL,		"splash",	0,			1,			-1 }
};

/* layout(s) */
static const float mfact     = 0.6; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	// { "><>",      NULL },    /* no layout function means floating behavior */
	// { "[M]",      monocle },
	{ "|M|",      centeredmaster },
	{ ">M>",      centeredfloatingmaster },
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

#define STATUSBAR "dwmblocks"

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char terminal[] = "alacritty";
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { terminal, NULL };
static const char scratchpadname[] = "scratchpad";

static const char *scratchpadcmd[] = { terminal, "-t", scratchpadname, "-o", "window.dimensions.columns=120", "-o", "window.dimensions.lines=34", NULL };
static const char *rangercmd[] = { terminal, "-e", "ranger", NULL };
static const char *firefoxcmd[] = { "firefox", NULL };
static const char *telegramcmd[] = { "telegram-desktop", NULL} ;


static Key keys[] = {
	/* modifier                     key        				function       		argument */
	{ MODKEY,                       XK_d,     				spawn,          	{.v = dmenucmd } },
	{ MODKEY,			            XK_t, 	   				spawn,          	{.v = termcmd } },
	{ MODKEY,                       XK_grave,  				togglescratch,  	{.v = scratchpadcmd } },

	{ MODKEY,                       XK_b,      				sigstatusbar,      	{.i = 10} },
	{ MODKEY|ShiftMask,				XK_b,      				togglebar,      	{0} },
	{ MODKEY,						XK_f, 	   				spawn,		   		{.v = firefoxcmd } },
	{ MODKEY,                       XK_f,      				view,           	{.ui = 1 << 0 } },
	{ MODKEY,						XK_i, 	   				spawn,		   		{.v = telegramcmd } },
	TAGKEYS(                        XK_i,                      					9)
	{ MODKEY,						XK_r, 	   				spawn,		   		{.v = rangercmd } },
	{ MODKEY|ShiftMask,             XK_q,      				killclient,     	{0} },
	{ MODKEY,                       XK_minus,  				setgaps,        	{.i = -5 } },
	{ MODKEY,                       XK_equal,  				setgaps,        	{.i = +5 } },
	{ MODKEY|ShiftMask,             XK_minus,  				setgaps,        	{.i = GAP_RESET } },
	{ MODKEY|ShiftMask,             XK_equal,  				setgaps,        	{.i = GAP_TOGGLE} },
	{ MODKEY|ShiftMask,             XK_space,  				togglefloating, 	{0} },
	{ MODKEY|ShiftMask,             XK_f,      				togglefullscr,  	{0} },

	{ MODKEY,                       XK_Tab,    				shiftviewclientscycled,   { .i = +1 } },
	{ MODKEY|ShiftMask,             XK_Tab,    				shiftviewclientscycled,   { .i = -1 } },
	TAGKEYS(                        XK_1,                      					0)
	TAGKEYS(                        XK_2,                      					1)
	TAGKEYS(                        XK_3,                      					2)
	TAGKEYS(                        XK_4,                      					3)
	TAGKEYS(                        XK_5,                      					4)
	TAGKEYS(                        XK_6,                      					5)
	TAGKEYS(                        XK_7,                      					6)
	TAGKEYS(                        XK_8,                      					7)
	TAGKEYS(                        XK_9,                     					8)
	TAGKEYS(						XK_0,					   					9)
	{ MODKEY|ShiftMask,             XK_e,      				quit,           	{0} },
	{ MODKEY,                       XK_Down,   				focusstack,     	{.i = +1 } },
	{ MODKEY,                       XK_Up,     				focusstack,     	{.i = -1 } },
	{ MODKEY, 						XK_Left,				focusmaster,		{0} },
	{ MODKEY, 						XK_Right,				focusmaster,		{0} },
	{ MODKEY|ShiftMask,				XK_Left,   				setmfact,       	{.f = -0.05} },
	{ MODKEY|ShiftMask,				XK_Right,  				setmfact,       	{.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_Return, 				zoom,           	{0} },
	{ 0, 							XF86XK_MonBrightnessUp,	spawn,				SHCMD("xbacklight -inc 5 && pkill -RTMIN+16 dwmblocks && notify-brightness-change.sh") },
	{ 0, 							XF86XK_MonBrightnessDown,spawn,				SHCMD("xbacklight -dec 5 && pkill -RTMIN+16 dwmblocks && notify-brightness-change.sh") },
	{ 0, 							XF86XK_AudioRaiseVolume,spawn,				SHCMD("pactl set-sink-volume 0 +5% && pkill -RTMIN+15 dwmblocks && notify-volume-change.sh")},
	{ 0, 							XF86XK_AudioLowerVolume,spawn,				SHCMD("pactl set-sink-volume 0 -5% && pkill -RTMIN+15 dwmblocks && notify-volume-change.sh")},
	{ 0, 							XF86XK_AudioMute,		spawn,				SHCMD("pactl set-sink-mute 0 toggle && pkill -RTMIN+15 dwmblocks && notify-volume-change.sh ")},
	{ 0, 							XF86XK_AudioPlay,		spawn,				SHCMD("playerctl play-pause")},
	{ 0, 							XF86XK_AudioNext,		spawn,				SHCMD("playerctl next")},
	{ 0, 							XF86XK_AudioPrev,		spawn,				SHCMD("playerctl previous")},

	{ 0,							XK_Print,				spawn,				SHCMD("screenshot-make.sh && screenshot-to-clipboard.sh && notify-send \"Screenshot saved\" && mplayer $HOME/Music/Notifications/screenshot-notification.mp3")},
	{ ControlMask,					XK_Print,				spawn,				SHCMD("screenshot-make.sh -s && screenshot-to-clipboard.sh && notify-send \"Screenshot saved\" && mplayer $HOME/Music/Notifications/screenshot-notification.mp3")},
	{ ControlMask,		        	XK_space,      			spawn,				SHCMD("dunstctl close") },
	{ MODKEY,						XK_Escape,				spawn,				SHCMD("rofi-exit.sh") },
	{ MODKEY, 						XK_F1,					spawn,				SHCMD("rofi-app-launcher.sh")},
	{ MODKEY, 						XK_F2,					spawn,				SHCMD("rofi-vpn.sh")},
	{ MODKEY, 						XK_F3,					spawn,				SHCMD("rofi-monitors-manager.sh")},
	{ MODKEY, 						XK_F4,					spawn,				SHCMD("rofi-disks.sh")},
	{ MODKEY,						XK_l,					spawn,				SHCMD("screen-saver.sh")},
	{ MODKEY|ShiftMask,				XK_v,					spawn,				SHCMD("toggle_vpn.sh wg0")},

	{ MODKEY,                       XK_s,      				togglesticky,   	{0} },
	{ MODKEY,                       XK_comma,  				focusmon,       	{.i = -1 } },
	{ MODKEY,                       XK_period, 				focusmon,      		{.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  				tagmon,         	{.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, 				tagmon,         	{.i = +1 } },
	{ MODKEY|ShiftMask,		        XK_l,      				layoutscroll,   	{.i = +1 } },


	// { MODKEY,                       XK_Tab,    view,           {0} },
	// { MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	// { MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	// { MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	// { MODKEY,                       XK_space,  setlayout,      {0} },
	//
	// { MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	// { MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	// { MODKEY,                       XK_u,      setlayout,      {.v = &layouts[3]} },
	// { MODKEY,                       XK_o,      setlayout,      {.v = &layouts[4]} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      	{0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      	{.v = &layouts[2]} },
	{ ClkStatusText,        0,              Button1,        sigstatusblocks,   	{.i = 1} },
	{ ClkStatusText,        0,              Button2,        sigstatusblocks,   	{.i = 2} },
	{ ClkStatusText,        0,              Button3,        sigstatusblocks,   	{.i = 3} },
	{ ClkStatusText,        0,              Button4,        sigstatusblocks,   	{.i = 4} },
	{ ClkStatusText,        0,              Button5,        sigstatusblocks,   	{.i = 5} },
	{ ClkStatusText,        ControlMask,    Button1,        sigstatusblocks,   	{.i = 6} },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      	{0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, 	{0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    	{0} },
	{ ClkTagBar,            0,              Button1,        view,           	{0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     	{0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            	{0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      	{0} },
	{ ClkTagBar, 			0,				Button4, 		shiftviewclients,	{ .i = -1 } },
	{ ClkTagBar, 			0,				Button5, 		shiftviewclients,   { .i = +1 } },
};
