From: Albert Strasheim <albert@cloudflare.com>
Subject: perf crash at util/symbol-elf.c:154
Date: Wed, 26 Feb 2014 12:24:07 -0800
Message-ID: <CAAvaZB0fFuD=Lb3R9eu4F=riedZS0JtQ_Z6zOtw8RYBNTsWqnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ve0-f182.google.com ([209.85.128.182]:50290 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbaBZUY2 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 26 Feb 2014 15:24:28 -0500
Received: by mail-ve0-f182.google.com with SMTP id jy13so2761043veb.41
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2014 12:24:27 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello all

We are having a problem with a perf crash that seems to be due to some
weird ELF stuff in a custom-built Python binary.

I have reproduced the crash on Fedora 20 with
perf-3.13.4-200.fc20.x86_64 and with a custom-built perf 3.10.27.

With 3.13.4, the crash happens at:

0x000000000046c15d in elf_section_by_name (ep=0x7fffffff9290, idx=0x0,
name=0x57928c ".gnu_debuglink", shp=0x7fffffff9250, elf=0xf71f50) at
util/symbol-elf.c:154
154 if (!strcmp(name, str)) {

Here's the full backtrace:

#0  0x000000000046c15d in elf_section_by_name (ep=0x7fffffff9290,
idx=0x0, name=0x57928c ".gnu_debuglink", shp=0x7fffffff9250,
elf=0xf71f50) at util/symbol-elf.c:154
#1  filename__read_debuglink (filename=<optimized out>,
debuglink=0xf70f5d "python", size=size@entry=4067) at
util/symbol-elf.c:497
#2  0x0000000000465c3e in dso__binary_type_file
(dso=dso@entry=0x988b50, type=type@entry=DSO_BINARY_TYPE__DEBUGLINK,
root_dir=root_dir@entry=0x591ec2 "",
    file=file@entry=0xf70f40 "/home/albert/perf/python/bin/python",
size=size@entry=4096) at util/dso.c:47
#3  0x000000000046a482 in dso__load (dso=0x988b50,
map=map@entry=0x988ad0, filter=filter@entry=0x431230 <symbol_filter>)
at util/symbol.c:1298
#4  0x000000000047eb4f in map__load (filter=0x431230 <symbol_filter>,
map=<optimized out>) at util/map.c:159
#5  map__find_symbol (map=0x988ad0, addr=700025, filter=0x431230
<symbol_filter>) at util/map.c:198
#6  0x0000000000450821 in perf_event__preprocess_sample
(event=event@entry=0x7ffff1a1c0a0, machine=machine@entry=0x96f788,
al=al@entry=0x7fffffffa870, sample=sample@entry=0x7fffffffa8a0) at
util/event.c:770
#7  0x0000000000431506 in perf_event__process_sample
(machine=0x96f788, sample=0x7fffffffa8a0, evsel=0x96f2d0,
event=0x7ffff1a1c0a0, tool=0x7fffffffab50) at builtin-top.c:719
#8  perf_top__mmap_read_idx (top=top@entry=0x7fffffffab50,
idx=idx@entry=0) at builtin-top.c:856
#9  0x00000000004336ff in perf_top__mmap_read (top=<optimized out>) at
builtin-top.c:873
#10 __cmd_top (top=0x7fffffffab50) at builtin-top.c:976
#11 cmd_top (argc=<optimized out>, argv=<optimized out>,
prefix=<optimized out>) at builtin-top.c:1231
#12 0x0000000000419995 in run_builtin (p=p@entry=0x7dde08
<commands+264>, argc=argc@entry=3, argv=argv@entry=0x7fffffffdce0) at
perf.c:319
#13 0x0000000000419230 in handle_internal_command
(argv=0x7fffffffdce0, argc=3) at perf.c:376
#14 run_argv (argv=0x7fffffffdae0, argcp=0x7fffffffdaec) at perf.c:420
#15 main (argc=3, argv=0x7fffffffdce0) at perf.c:529

The Python build is available here:

https://docs.google.com/file/d/0B0b-iwt-kSG2Z2dOYWVDYVEyZ2c/edit

To reproduce the crash, all you need is

./python -c 'while True: continue'

perf top -p `pidof python`

Any help would be appreciated. Thanks in advance.

Regards

Albert
