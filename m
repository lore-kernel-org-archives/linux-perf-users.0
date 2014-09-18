From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Perf event for Wall-time based sampling?
Date: Thu, 18 Sep 2014 17:36:25 -0300
Message-ID: <20140918203625.GM2770@kernel.org>
References: <2221771.b2oSN5LR6X@milian-kdab2>
 <2297882.Vc1x1zOfA6@milian-kdab2>
 <20140918155745.GH2770@kernel.org>
 <45528931.El8SOGvs6Z@milian-kdab2>
 <20140918191713.GK2770@kernel.org>
 <541B3DED.1010306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:49332 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757227AbaIRUga (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 18 Sep 2014 16:36:30 -0400
Content-Disposition: inline
In-Reply-To: <541B3DED.1010306@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Milian Wolff <mail@milianw.de>, linux-perf-users <linux-perf-users@vger.kernel.org>, Namhyung Kim <namhyung@gmail.com>, Ingo Molnar <mingo@kernel.org>, Joseph Schuchart <joseph.schuchart@tu-dresden.de>

Em Thu, Sep 18, 2014 at 02:17:49PM -0600, David Ahern escreveu:
> On 9/18/14, 1:17 PM, Arnaldo Carvalho de Melo wrote:
> >>This was also why I asked my initial question, which I want to repeat once
> >>>more: Is there a technical reason to not offer a "timer" software event to
> >>>perf? I'm a complete layman when it comes to Kernel internals, but from a user
> >>>point of view this would be awesome:

> >>>perf record --call-graph dwarf -e sw-timer -F 100 someapplication

> >>>This command would then create a timer in the kernel with a 100Hz frequency.
> >>>Whenever it fires, the callgraphs of all threads in $someapplication are
> >>>sampled and written to perf.data. Is this technically not feasible? Or is it
> >>>simply not implemented?
> >>>I'm experimenting with a libunwind based profiler, and with some ugly signal
> >>>hackery I can now grab backtraces by sending my application SIGUSR1. Based on
> >Humm, can't you do the same thing with perf? I.e. you send SIGUSR1 to
> >your app with the frequency you want, and then hook a 'perf probe' into
> >your signal... /me tries some stuff, will get back with results...
 
> Current profiling options with perf require the process to be running. What

Ok, so you want to see what is the wait channel and unwind the stack
from there? Is that the case? I.e. again, a sysrq-t equivalent?

> Milian want is to grab samples every timer expiration even if process is not
> running.

What for? And by "grab samples" you want to know where it is waiting for
something, together with its callchain?
 
> Any limitations that would prevent doing this with a sw event? e.g, mimic
> task-clock just don't disable the timer when the task is scheduled out.

I'm just trying to figure out if what people want is a complete
backtrace of all threads in a process, no matter what they are doing, at
some given time, i.e. at "sysrq-t" time, is that the case?

- Arnaldo
