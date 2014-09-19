From: David Ahern <dsahern@gmail.com>
Subject: Re: Perf event for Wall-time based sampling?
Date: Fri, 19 Sep 2014 09:04:50 -0600
Message-ID: <541C4612.6000301@gmail.com>
References: <2221771.b2oSN5LR6X@milian-kdab2> <541B3DED.1010306@gmail.com> <20140918203625.GM2770@kernel.org> <5770573.p6hpIeRPQV@milian-kdab2> <20140919144747.GC32694@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:46457 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757090AbaISPEx (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 19 Sep 2014 11:04:53 -0400
Received: by mail-pd0-f179.google.com with SMTP id ft15so108816pdb.24
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Sep 2014 08:04:52 -0700 (PDT)
In-Reply-To: <20140919144747.GC32694@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, Milian Wolff <mail@milianw.de>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>, Namhyung Kim <namhyung@gmail.com>, Ingo Molnar <mingo@kernel.org>, Joseph Schuchart <joseph.schuchart@tu-dresden.de>

On 9/19/14, 8:47 AM, Arnaldo Carvalho de Melo wrote:
> Now that the need for getting a backtrace from existing threads, a-la
> using ptrace via gdb to attach to it and then traverse its stack to
> provide that backtrace, I think we need to do something on the perf
> infrastructure in the kernel to do that, i.e. somehow signal the perf
> kernel part that we want a backtrace for some specific thread.
>
> Not at event time, but at some arbitrary time, be it creating an event
> that, as you suggested, will create a timer and then when that timer
> fires will use (parts of the) mechanism used by ptrace.
>
> But in the end we need a mechanism to ask for backtraces for existing,
> sleeping, threads.

But perf already has that information -- stacktraces on a sched_switch. 
We already know where the task is when it is sleeping.

> Ok, we need two mechanisms to get that, one for existing, sleeping
> threads at the time we start monitoring (we don't have that now other
> than freezing the process, looking for threads that were waiting, then
> using ptrace and asking for that backtrace), and another for threads
> that will sleep/wait_after_  we start monitoring.

That's a missing piece -- callchains for sleeping threads when perf starts.


>> >I'm interested in the the other side of the fence. The backtrace could/should
>> >stop at system_call_fastpath.

We talked about this last year - options to control stack depth obtained 
on a record. Most flexibility is to allow controls of user space stack 
and kernel. Here someone could set kstack depth to 0 to get only 
userspace stack.

> Right, adding callchains to 'perf trace' and using it with --duration
> may provide a first approximation for threads that will start waiting
> after 'perf trace' starts, I guess.

Talked about this one too. Integration of perf-script with perf-trace.

So many features, so little time.

David
