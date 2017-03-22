From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: perf software events broken in containers
Date: Wed, 22 Mar 2017 11:24:21 -0700
Message-ID: <CAE40pddXy_vJ5Xd4eunsuYbnaqCDV2bJNqfsdLcMY3kvR-hqOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:36709 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965271AbdCVSYy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Mar 2017 14:24:54 -0400
Received: by mail-wr0-f172.google.com with SMTP id u108so133982406wrb.3
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Mar 2017 11:24:52 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>

G'Day,

I think something broke recently with using perf from within a docker
container. We used to be able to run "docker exec -it --privileged
UUID bash", and then run perf from it for CPU sampling. But we just
noticed on recent kernels (4.10 and updated 4.4) that it no longer
works. Anyone else see this?

perf's error message is contradictory:

# /perf record -F 99 -a -- sleep 1
perf_event_open(..., PERF_FLAG_FD_CLOEXEC) failed with unexpected
error 1 (Operation not permitted)
perf_event_open(..., 0) failed unexpectedly with error 1 (Operation
not permitted)
Error:
You may not have permission to collect system-wide stats.

Consider tweaking /proc/sys/kernel/perf_event_paranoid,
which controls use of the performance events system by
unprivileged users (without CAP_SYS_ADMIN).

The current value is -1:

  -1: Allow use of (almost) all events by all users
>= 0: Disallow raw tracepoint access by users without CAP_IOC_LOCK
>= 1: Disallow CPU event access by users without CAP_SYS_ADMIN
>= 2: Disallow kernel profiling by users without CAP_SYS_ADMIN

With -v, I can see that it tries the PMC based cycles, then gives up.
What normally happens is it then switches to the cpu-clock software
event, but it's not trying that anymore. Those software events are
also no longer visible:

# /perf list sw

List of pre-defined events (to be used in -e):

(no output)

The kernel is returning errno 1 to the sys_perf_event_open() call in
__perf_evsel__open(). I'm trying to find out which kernel function
throws the EPERM, but almost nothing is tracable via ftrace/kprobes.
It's pretty annoying... Thanks for any ideas,

Brendan
