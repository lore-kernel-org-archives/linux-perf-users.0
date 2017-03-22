From: William Cohen <wcohen@redhat.com>
Subject: Re: perf software events broken in containers
Date: Wed, 22 Mar 2017 15:15:15 -0400
Message-ID: <8c4186d0-bfbf-6f1a-c953-9859bf057856@redhat.com>
References: <CAE40pddXy_vJ5Xd4eunsuYbnaqCDV2bJNqfsdLcMY3kvR-hqOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751539AbdCVTPQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Mar 2017 15:15:16 -0400
In-Reply-To: <CAE40pddXy_vJ5Xd4eunsuYbnaqCDV2bJNqfsdLcMY3kvR-hqOg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Brendan Gregg <brendan.d.gregg@gmail.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

On 03/22/2017 02:24 PM, Brendan Gregg wrote:
> G'Day,
> 
> I think something broke recently with using perf from within a docker
> container. We used to be able to run "docker exec -it --privileged
> UUID bash", and then run perf from it for CPU sampling. But we just
> noticed on recent kernels (4.10 and updated 4.4) that it no longer
> works. Anyone else see this?
> 
> perf's error message is contradictory:
> 
> # /perf record -F 99 -a -- sleep 1
> perf_event_open(..., PERF_FLAG_FD_CLOEXEC) failed with unexpected
> error 1 (Operation not permitted)
> perf_event_open(..., 0) failed unexpectedly with error 1 (Operation
> not permitted)
> Error:
> You may not have permission to collect system-wide stats.
> 
> Consider tweaking /proc/sys/kernel/perf_event_paranoid,
> which controls use of the performance events system by
> unprivileged users (without CAP_SYS_ADMIN).
> 
> The current value is -1:
> 
>   -1: Allow use of (almost) all events by all users
>> = 0: Disallow raw tracepoint access by users without CAP_IOC_LOCK
>> = 1: Disallow CPU event access by users without CAP_SYS_ADMIN
>> = 2: Disallow kernel profiling by users without CAP_SYS_ADMIN
> 
> With -v, I can see that it tries the PMC based cycles, then gives up.
> What normally happens is it then switches to the cpu-clock software
> event, but it's not trying that anymore. Those software events are
> also no longer visible:
> 
> # /perf list sw
> 
> List of pre-defined events (to be used in -e):
> 
> (no output)
> 
> The kernel is returning errno 1 to the sys_perf_event_open() call in
> __perf_evsel__open(). I'm trying to find out which kernel function
> throws the EPERM, but almost nothing is tracable via ftrace/kprobes.
> It's pretty annoying... Thanks for any ideas,

Hi Brendan,

Several years ago I had a problem with the perf_event_open not working on arm machines.  I looked at the kernel source code and just kept putting systemtap one-liners like the following on the various functions used by the perf_event_open to see which function was the one returning the error code:

stap -v -e 'probe kernel.function("idr_find").return {printf("%s %s 0x%x\n", pn(), $$parms$, $return)}'


Could the docker container not have the perf_event_open syscall on the whitelist of allowed syscalls?

Would bcc's capable.py tool give some insight into whether there are some other capabilities that the perf_event_open might be needing?

-Will
> 
> Brendan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
