From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: kprobe string
Date: Sun, 20 Jul 2014 18:20:20 -0700
Message-ID: <CAE40pdeyZkYeKC4DQdw2QCqQ+HtMxWZz_pGj09Z8WGr8AtVX_w@mail.gmail.com>
References: <CAE40pdfJpksb-LJghF+w4XZBagKo7wg6fh3irGPha5F9Uknb=A@mail.gmail.com>
	<53C753DE.6080306@gmail.com>
	<CAE40pdefmx7trDyWnix1tPXNQBeO-cE8-6-p68tojuXry-LGXQ@mail.gmail.com>
	<8761iw30sv.fsf@sejong.aot.lge.com>
	<CAE40pdfdrUOdkrV6WWZ-0PjwzVoWYo3cSe3SysKwN+PtVtV45w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:58283 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbaGUBUV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 20 Jul 2014 21:20:21 -0400
Received: by mail-qa0-f51.google.com with SMTP id k15so4606283qaq.24
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Jul 2014 18:20:20 -0700 (PDT)
In-Reply-To: <CAE40pdfdrUOdkrV6WWZ-0PjwzVoWYo3cSe3SysKwN+PtVtV45w@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: David Ahern <dsahern@gmail.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

On Thu, Jul 17, 2014 at 1:23 AM, Brendan Gregg
<brendan.d.gregg@gmail.com> wrote:
> G'Day Namhyung,
[...]
> Wow... So now I know perf can do this, and, I have working examples of
> kprobes via ftrace if needed (I am trying to use perf first, due to
> the way it buffers, error handling, and concurrent usage).
>

To follow up: I ended up using kprobes, as I wanted to match on the
calling function (the "(xxx <- yyy)" part), which wasn't showing
symbols for perf_events, but was for ftrace.

The outcome is a (hacky) Linux port of my popular opensnoop tool,
based on Linux ftrace:

# ./opensnoop
Tracing open()s. Ctrl-C to end.
COMM             PID      FD FILE
opensnoop        5881    0x3
<...>            5900    0x3 /etc/ld.so.cache
opensnoop        5899    0x3 /etc/ld.so.cache
opensnoop        5899    0x3 /lib/x86_64-linux-gnu/libm.so.6
<...>            5900    0x3 /lib/x86_64-linux-gnu/libc.so.6
opensnoop        5899    0x3 /lib/x86_64-linux-gnu/libc.so.6
<...>            5900    0x3 /usr/lib/locale/locale-archive
<...>            5900    0x3 trace_pipe
ls               5915    0x3 /etc/ld.so.cache
ls               5915    0x3 /lib/x86_64-linux-gnu/libselinux.so.1
ls               5915    0x3 /lib/x86_64-linux-gnu/librt.so.1
ls               5915    0x3 /lib/x86_64-linux-gnu/libacl.so.1
ls               5915    0x3 /lib/x86_64-linux-gnu/libc.so.6
ls               5915    0x3 /lib/x86_64-linux-gnu/libdl.so.2
ls               5915    0x3 /lib/x86_64-linux-gnu/libpthread.so.0
ls               5915    0x3 /lib/x86_64-linux-gnu/libattr.so.1
ls               5915    0x3 /proc/filesystems
ls               5915    0x3 /usr/lib/locale/locale-archive
supervise        1690    0x9 supervise/status.new
supervise        1681    0x9 supervise/status.new
supervise        1690    0x9 supervise/status.new
supervise        1681    0x9 supervise/status.new
[...]

This works by caching the getname() result, and reading it for
sys_exit_open. It works in my large environment of 3.2 servers,
without debuginfo, since I'm just using $retval:string.

If debuginfo is available I can improve opensnoop a bit by using just
the syscall tracepoints, and tracing filenames using "filename:string"
on sys_enter_open, but this adds a lot of lag to wait for a debuginfo
install when wanting to debug an issue (and having debuginfo installed
on all our servers isn't really practical). I couldn't find entry
argument versions of $retval, eg, $arg1, $arg2, etc. Such a thing
would let me use the syscall open tracepoint with $arg2:string,
without debuginfo, so I could avoid dynamic tracing of getname(), and
therefore improving stability a bit. I was trying to hack this up
using %ax, %bx, etc, but I think that's also brittle...

opensnoop supports various options:

# ./opensnoop -h
USAGE: opensnoop [-htx] [-d secs] [-f file] [-p PID] [-n name]
                 -d seconds      # trace duration, and use buffers
                 -f file         # match filename (partials ok)
                 -n name         # process name to match on I/O issue
                 -p PID          # PID to match on I/O issue
                 -t              # include time (seconds)
                 -x              # only show failed opens
                 -h              # this usage message
  eg,
        opensnoop                # watch open()s live (unbuffered)
        opensnoop -d 1           # trace 1 sec (buffered)
        opensnoop -f conf        # trace filenames containing "conf"
        opensnoop -p 181         # trace I/O issued by PID 181 only

It's on github: https://github.com/brendangregg/perf-tools

Brendan

-- 
http://www.brendangregg.com
