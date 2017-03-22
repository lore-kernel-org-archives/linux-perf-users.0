From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: perf software events broken in containers
Date: Wed, 22 Mar 2017 14:35:14 -0700
Message-ID: <CAE40pdcbbU=e6YXTivOW1=w2urucbQknUZc9VzebPgHeiLrKqw@mail.gmail.com>
References: <CAE40pddXy_vJ5Xd4eunsuYbnaqCDV2bJNqfsdLcMY3kvR-hqOg@mail.gmail.com>
 <8c4186d0-bfbf-6f1a-c953-9859bf057856@redhat.com> <CAE40pdd06QXckEMYfU63c=Zvrrn22A-sm-Sh37CymR5rpJZ57Q@mail.gmail.com>
 <4bf76843-d25e-4cda-30ce-0984f8778704@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37743 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751799AbdCVVfq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Mar 2017 17:35:46 -0400
Received: by mail-wm0-f43.google.com with SMTP id n11so48637630wma.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Mar 2017 14:35:45 -0700 (PDT)
In-Reply-To: <4bf76843-d25e-4cda-30ce-0984f8778704@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: William Cohen <wcohen@redhat.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

On Wed, Mar 22, 2017 at 1:29 PM, William Cohen <wcohen@redhat.com> wrote:
> On 03/22/2017 03:59 PM, Brendan Gregg wrote:
>> G'Day Will,
>>
>> On Wed, Mar 22, 2017 at 12:15 PM, William Cohen <wcohen@redhat.com> wrot=
e:
>>> On 03/22/2017 02:24 PM, Brendan Gregg wrote:
>>>> G'Day,
>> [...]
>>>>
>>>> The kernel is returning errno 1 to the sys_perf_event_open() call in
>>>> __perf_evsel__open(). I'm trying to find out which kernel function
>>>> throws the EPERM, but almost nothing is tracable via ftrace/kprobes.
>>>> It's pretty annoying... Thanks for any ideas,
>>>
>>> Hi Brendan,
>>>
>>> Several years ago I had a problem with the perf_event_open not working =
on arm machines.  I looked at the kernel source code and just kept putting =
systemtap one-liners like the following on the various functions used by th=
e perf_event_open to see which function was the one returning the error cod=
e:
>>>
>>> stap -v -e 'probe kernel.function("idr_find").return {printf("%s %s 0x%=
x\n", pn(), $$parms$, $return)}'
>>>
>>
>> Right, I've been doing that with ftrace/kprobes/bcc/BPF... Many of the
>> functions aren't visible, though, I suspect inlined.
>>
>
> Hi Brendan,
>
> Yes, the inlined functions are going to make it hard to get some of the r=
eturn values.  However, you can probably narrow down the boundary between e=
xecuted functions and not executed functions. Would the Intel Processor Tra=
ce (http://halobates.de/blog/) be usable to help track down this problem?
>

I'm in the cloud, so I usually don't even have PMCs. :)

Looks like the issue is a change with docker, I'd guess related to
this syscall whitelisting. Doing a "docker run --cap-add cap_sys_admin
..." results in a container that can run perf (but has sysadmin
privilege always on), although we still need the --privileged for it
to work fully. Previously we could run normal containers and run some
ad hoc privileged shells only with "docker exec -it --privileged ...
bash" for running perf.

Weirdly, the container claims it has cap_sys_admin either way, but one
way it doesn't work and the other it does. I filed
https://github.com/docker/docker/issues/32018

We also found that docker explicitly blocks perf_event_open() by default[1]=
:

"perf_event_open    Tracing/profiling syscall, which could leak a lot
of information on the host."

[1] https://docs.docker.com/engine/security/seccomp/#significant-syscalls-b=
locked-by-the-default-profile

Brendan
