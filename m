From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Multiple commands in perf 3.2.30 and 3.5.5 on Ubuntu 12 do not work
Date: Thu, 15 Nov 2012 10:25:03 +0900
Message-ID: <878va3mzdc.fsf@sejong.aot.lge.com>
References: <loom.20121113T224335-737@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE1Q.lge.com ([156.147.1.111]:42565 "EHLO
	LGEMRELSE1Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964820Ab2KOBZG (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 14 Nov 2012 20:25:06 -0500
In-Reply-To: <loom.20121113T224335-737@post.gmane.org> (Florin Trofin's
	message of "Tue, 13 Nov 2012 23:01:18 +0000 (UTC)")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Florin Trofin <ftrofin@adobe.com>
Cc: linux-perf-users@vger.kernel.org

Hi Florin,

On Tue, 13 Nov 2012 23:01:18 +0000 (UTC), Florin Trofin wrote:
> I mentioned in a previous post that "perf archive" command is not recognized on
> Ubuntu 12.04 (perf version 3.2.30) although it is  listed in the --help output.
> I wanted to see if the issue was fixed in a later version so I tried
> Ubuntu 12.10 (perf version 3.5.5) and it has the same problems:
> archive is not recognized as a valid command, and other commands fail as well:
>
> $ perf timechart record sleep 2
> invalid or unsupported event: 'power:cpu_frequency'
> Run 'perf list' for a list of valid events
>
> Another command that doesn't work:
>
> $ perf lock record sleep 2
> invalid or unsupported event: 'lock:lock_acquire'
> Run 'perf list' for a list of valid events
>
> This makes me think that either perf is mostly broken in the new versions
> or something is wrong on my machine (although installation went smoothly).
> I installed perf by doing:
>
> $ sudo apt-get install linux-tools-common
> $ sudo apt-get install linux-tools-3.5.0-17
>
> Can somebody shed some light on this please?

It looks like a problem of opening a tracepoint event.  More
specifically there's a problem in accessing debugfs.  Even after
changing /proc/sys/kernel/perf_events_paranoid to -1, I failed to
record tracepoint events.

$ ls /sys/kernel/debug
ls: cannot open directory /sys/kernel/debug: Permission denied

$ sudo ls -la /sys/kernel/debug | head -3
total 0
drwx------. 19 root root 0 Nov  6 10:38 .
drwxr-xr-x.  8 root root 0 Nov  6 10:38 ..

$ perf record -e sched:sched_switch
invalid or unsupported event: 'sched:sched_switch'
Run 'perf list' for a list of valid events

I have no idea when it's changed, I used to be abled to access
tracepoint events as a non-root user with the perf_events_paranoid
setting.

But this is failed on a recent kernel (w/ Fedora 17).

$ uname -a
Linux sejong.aot.lge.com 3.7.0-rc2+ #35 SMP PREEMPT Tue Nov 6 10:33:02 KST 2012 x86_64 x86_64 x86_64 GNU/Linux


Anyways, running as root will solve your problem I guess.

Thanks,
Namhyung
