From: William Cohen <wcohen@redhat.com>
Subject: Re: perf software events broken in containers
Date: Wed, 22 Mar 2017 16:29:54 -0400
Message-ID: <4bf76843-d25e-4cda-30ce-0984f8778704@redhat.com>
References: <CAE40pddXy_vJ5Xd4eunsuYbnaqCDV2bJNqfsdLcMY3kvR-hqOg@mail.gmail.com>
 <8c4186d0-bfbf-6f1a-c953-9859bf057856@redhat.com>
 <CAE40pdd06QXckEMYfU63c=Zvrrn22A-sm-Sh37CymR5rpJZ57Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753841AbdCVU3z (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Mar 2017 16:29:55 -0400
In-Reply-To: <CAE40pdd06QXckEMYfU63c=Zvrrn22A-sm-Sh37CymR5rpJZ57Q@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

On 03/22/2017 03:59 PM, Brendan Gregg wrote:
> G'Day Will,
> 
> On Wed, Mar 22, 2017 at 12:15 PM, William Cohen <wcohen@redhat.com> wrote:
>> On 03/22/2017 02:24 PM, Brendan Gregg wrote:
>>> G'Day,
> [...]
>>>
>>> The kernel is returning errno 1 to the sys_perf_event_open() call in
>>> __perf_evsel__open(). I'm trying to find out which kernel function
>>> throws the EPERM, but almost nothing is tracable via ftrace/kprobes.
>>> It's pretty annoying... Thanks for any ideas,
>>
>> Hi Brendan,
>>
>> Several years ago I had a problem with the perf_event_open not working on arm machines.  I looked at the kernel source code and just kept putting systemtap one-liners like the following on the various functions used by the perf_event_open to see which function was the one returning the error code:
>>
>> stap -v -e 'probe kernel.function("idr_find").return {printf("%s %s 0x%x\n", pn(), $$parms$, $return)}'
>>
> 
> Right, I've been doing that with ftrace/kprobes/bcc/BPF... Many of the
> functions aren't visible, though, I suspect inlined.
> 

Hi Brendan,

Yes, the inlined functions are going to make it hard to get some of the return values.  However, you can probably narrow down the boundary between executed functions and not executed functions. Would the Intel Processor Trace (http://halobates.de/blog/) be usable to help track down this problem?

-Will
