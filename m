From: Michael Edwards <michael@tensyr.com>
Subject: perf/x86/intel: Collecting CPU-local performance counters from all
 cores in parallel
Date: Mon, 22 May 2017 22:42:29 -0700
Message-ID: <CACFdaOz-ox4XSu-q8S-Op8xPTDwoT6FAN-yhi0988NJiazpm0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35142 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933266AbdEWFmv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 May 2017 01:42:51 -0400
Received: by mail-wm0-f43.google.com with SMTP id b84so12344889wmh.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 May 2017 22:42:50 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-kernel@vger.kernel.org, peterz@infradead.org, linux-perf-users@vger.kernel.org

I'm working on a system-wide profiling tool that uses perf_event to
gather CPU-local performance counters (L2/L3 cache misses, etc.)
across all CPUs (hyperthreads) of a multi-socket system.  We'd like
for the monitoring process to run on a single core, and to be able to
sample at frequent, regular intervals (sub-millisecond), with minimal
impact on the tasks running on other CPUs.  I've prototyped this using
perf_events (with one event group per CPU), and on a two-socket,
32-(logical)-CPU system the prototype reaches about 2,700 samples per
second per CPU, at which point it's spending about 30% of its time
inside the read() syscall.  Optimizing the other 70% (the prototype
userland) looks fairly routine, so I'm looking at what it would take
to get beyond 10K samples per second.

I'm aware of the mmap()/RDPMC path to sampling counters from userland,
but I'd prefer not to go down that road; it involves mmap()ing all the
individual perf_event fds and reading them from userland tasks on the
relevant core, which is needlessly intrusive on the actual workload.
The measured overheads of the IPI-dispatched __perf_event_read() are
acceptable, if we could just dispatch it in parallel to all CPUs from
a single read() syscall.

I've dug through the perf_event code and think I have a fair idea of
what it would take to implement a sort of "event meta-group" file.
Its read() handler would be equivalent to concatenating the read()
output of its member fds (per-CPU event group leaders), except that it
would only take the syscall / VFS indirection / locking / copy_to_user
overhead once, and would dispatch one IPI (with a per-cpu array of
cache-line-aligned struct perf_read_data arguments) via
on_each_cpu_mask() (thus effectively waiting in parallel on all the
responses).  Implementing that is a bit tedious but it's just plumbing
-- except for the small matter of taking all the perf_event_ctx::mutex
locks in the right order.  There is a logical sequence (by mutex
address; see mutex_lock_double()), but acquiring several dozen mutexes
in every read() call may be problematic.

One could add a per-meta-group mutex, and add code to
perf_event_ctx_lock() (and other callers / variants of
perf_event_ctx_lock_nested()) that checks for meta-group membership
and takes the per-meta-group mutex before taking the ctx mutex.  Then
the meta-group read() path only has to take this one mutex.  That
means an event group can only be attached to one meta-group, but
that's probably okay.  Still, it's fiddly code, what with the lock
nesting - though I think it helps that we're dealing exclusively with
the group leaders for hardware events, so the move_group code path in
perf_event_open() isn't relevant.

Am I going about this wrong?  Is there some better way to pursue the
high-level goal of gathering PMC-based statistics frequently and
efficiently from all cores, without breaking everything else that uses
perf_events?
