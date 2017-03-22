From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: perf software events broken in containers
Date: Wed, 22 Mar 2017 12:59:22 -0700
Message-ID: <CAE40pdd06QXckEMYfU63c=Zvrrn22A-sm-Sh37CymR5rpJZ57Q@mail.gmail.com>
References: <CAE40pddXy_vJ5Xd4eunsuYbnaqCDV2bJNqfsdLcMY3kvR-hqOg@mail.gmail.com>
 <8c4186d0-bfbf-6f1a-c953-9859bf057856@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:33431 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750867AbdCVT7y (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Mar 2017 15:59:54 -0400
Received: by mail-wr0-f170.google.com with SMTP id y90so17496506wrb.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Mar 2017 12:59:53 -0700 (PDT)
In-Reply-To: <8c4186d0-bfbf-6f1a-c953-9859bf057856@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: William Cohen <wcohen@redhat.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

G'Day Will,

On Wed, Mar 22, 2017 at 12:15 PM, William Cohen <wcohen@redhat.com> wrote:
> On 03/22/2017 02:24 PM, Brendan Gregg wrote:
>> G'Day,
[...]
>>
>> The kernel is returning errno 1 to the sys_perf_event_open() call in
>> __perf_evsel__open(). I'm trying to find out which kernel function
>> throws the EPERM, but almost nothing is tracable via ftrace/kprobes.
>> It's pretty annoying... Thanks for any ideas,
>
> Hi Brendan,
>
> Several years ago I had a problem with the perf_event_open not working on=
 arm machines.  I looked at the kernel source code and just kept putting sy=
stemtap one-liners like the following on the various functions used by the =
perf_event_open to see which function was the one returning the error code:
>
> stap -v -e 'probe kernel.function("idr_find").return {printf("%s %s 0x%x\=
n", pn(), $$parms$, $return)}'
>

Right, I've been doing that with ftrace/kprobes/bcc/BPF... Many of the
functions aren't visible, though, I suspect inlined.

>
> Could the docker container not have the perf_event_open syscall on the wh=
itelist of allowed syscalls?
>

Good thought. I do have a __secure_computing() call returning a -1,
and docker recently changed their blacklist to a whitelist:

https://github.com/docker/docker/pull/18979

I'm digging on this...

> Would bcc's capable.py tool give some insight into whether there are some=
 other capabilities that the perf_event_open might be needing?
>

It should do (and I should enhance it to show the result of the
capability lookups, it was first written to just show what was being
asked), but it doesn't say anything new in this case. CAP_SYS_ADMIN,
which perf already has...

Thanks,

Brendan

> -Will
>>
>> Brendan
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-perf-use=
rs" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
