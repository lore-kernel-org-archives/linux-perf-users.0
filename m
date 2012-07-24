From: Kant <fnord.hammer@gmail.com>
Subject: perf 3.5: Lots of SIGSEGV - annotate_browser__draw_current_jump
Date: Tue, 24 Jul 2012 14:35:19 +0200
Message-ID: <CAEmqk_z-E1W6kHqDVhpxgAHS3aqgHQ58s+whRpMrbJWYzW_y8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:43215 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780Ab2GXMfU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 24 Jul 2012 08:35:20 -0400
Received: by wibhr14 with SMTP id hr14so4015849wib.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Jul 2012 05:35:19 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I'm getting a lot of these when scrolling trough annotated code:

Program received signal SIGSEGV, Segmentation fault.
annotate_browser__draw_current_jump (browser=0x76ae7b8ae750) at
ui/browsers/annotate.c:207
207	ui/browsers/annotate.c: No such file or directory.
(gdb) bt
#0  annotate_browser__draw_current_jump (browser=0x76ae7b8ae750) at
ui/browsers/annotate.c:207
#1  annotate_browser__refresh (browser=0x76ae7b8ae750) at
ui/browsers/annotate.c:219
#2  0x00000000004765f2 in __ui_browser__refresh
(browser=0x76ae7b8ae750) at ui/browser.c:306
#3  ui_browser__run (browser=browser@entry=0x76ae7b8ae750,
delay_secs=delay_secs@entry=0) at ui/browser.c:361
#4  0x0000000000477ddc in annotate_browser__run (delay_secs=0,
arg=0x0, timer=0, evidx=0, browser=0x76ae7b8ae750) at
ui/browsers/annotate.c:626
#5  symbol__tui_annotate (sym=0x3125080, map=<optimized out>, evidx=0,
timer=timer@entry=0, arg=arg@entry=0x0, delay_secs=delay_secs@entry=0)
at ui/browsers/annotate.c:893
#6  0x0000000000478faa in hist_entry__tui_annotate (he=<optimized
out>, evidx=<optimized out>, timer=timer@entry=0, arg=arg@entry=0x0,
delay_secs=delay_secs@entry=0)
    at ui/browsers/annotate.c:761
#7  0x000000000047bb2f in perf_evsel__hists_browse
(evsel=evsel@entry=0x2939590, nr_events=1,
    helpline=helpline@entry=0x4a5198 "For a higher level overview,
try: perf report --sort comm,dso", ev_name=0x7ad960 "cycles",
left_exits=left_exits@entry=false,
    timer=timer@entry=0, arg=arg@entry=0x0,
delay_secs=delay_secs@entry=0) at ui/browsers/hists.c:1097
#8  0x000000000047c4e5 in perf_evlist__tui_browse_hists
(evlist=evlist@entry=0x2937d00, help=help@entry=0x4a5198 "For a higher
level overview, try: perf report --sort comm,dso",
    timer=0, timer@entry=0x7417, arg=0x0, arg@entry=0x7417,
delay_secs=0, delay_secs@entry=29719) at ui/browsers/hists.c:1338
#9  0x000000000041fe1b in __cmd_report (rep=0x76ae7b8aecf0) at
builtin-report.c:427
#10 cmd_report (argc=<optimized out>, argv=<optimized out>,
prefix=<optimized out>) at builtin-report.c:756
#11 0x0000000000414088 in run_builtin (p=p@entry=0x6d00e8,
argc=argc@entry=5, argv=argv@entry=0x76ae7b8af9e0) at perf.c:273
#12 0x000000000041396c in handle_internal_command
(argv=0x76ae7b8af9e0, argc=5) at perf.c:345
#13 run_argv (argv=0x76ae7b8af7e0, argcp=0x76ae7b8af7ec) at perf.c:389
#14 main (argc=5, argv=0x76ae7b8af9e0) at perf.c:487

Is this a known issue or do you need more details?

Thanks
