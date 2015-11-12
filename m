From: Yuanfang Chen <cyfmxc@gmail.com>
Subject: Re: event group without multiplexing
Date: Thu, 12 Nov 2015 13:12:17 -0500
Message-ID: <CAJh9x3oOkwdhT2d=ao6kmzwbwtdKuFxyhVO_yOQ97iYNeicurA@mail.gmail.com>
References: <CAJh9x3q+g4Q4WfZ8XZ9ZOw0BcgYd_hdoUufu2YpRGtZt2tfu5Q@mail.gmail.com>
	<CAJh9x3qCnvz4yWTBxyMp_RZt66L7OXHxbgTcfWaqFBfdZiGkLQ@mail.gmail.com>
	<CAJh9x3q1ZeJ7U2XFpP2PbaeJ4xtjNJ1K13fYQSjnZKiO2LjKWQ@mail.gmail.com>
	<1447350001.15375.95.camel@Rudolf-RHEL-7>
	<alpine.DEB.2.20.1511121248050.7597@vincent-weaver-1.umelst.maine.edu>
	<alpine.DEB.2.20.1511121257380.7597@vincent-weaver-1.umelst.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34048 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbbKLSMS (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 12 Nov 2015 13:12:18 -0500
Received: by wmvv187 with SMTP id v187so46387264wmv.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2015 10:12:17 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1511121257380.7597@vincent-weaver-1.umelst.maine.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-perf-users@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>, Andi Kleen <ak@linux.intel.com>

Seems that 0x248 show up in  https://download.01.org/perfmon/HSW/ but
not in manual. If 0x248 does not exist, then the code should be
correct.

On Thu, Nov 12, 2015 at 1:00 PM, Vince Weaver <vincent.weaver@maine.edu> wrote:
>
> ccing Andi Kleen as he's the one who introduced the Haswell constraint
> code in 3a632cb229bfb18b6d09822cc842451ea46c013e so maybe he knows why
> it is contraining all L1D_PEND_MISS.* events rather than just
> L1D_PEND_MISS.PENDING on IVB and BDW.
>
> On Thu, 12 Nov 2015, Vince Weaver wrote:
>
>> On Thu, 12 Nov 2015, Michael Petlan wrote:
>>
>> > But I can't find any reference about the r1000248 event
>> > in the Intel Manual. Vince, am I missing something?
>> >
>> > Anyway, shouldn't it behave the same on IVB and HSW?
>>
>> I am going off the code in
>>       arch/x86/kernel/cpu/perf_event_intel.c
>> (current git tree)
>>
>> SNB and HSW have as a constraint
>>       INTEL_EVENT_CONSTRAINT(0x48, 0x4), /* L1D_PEND_MISS.* */
>>
>> IVB has as a constraint
>>       INTEL_UEVENT_CONSTRAINT(0x0148, 0x4), /* L1D_PEND_MISS.PENDING */
>>
>> Notice the difference.  Not sure if this is a bug in the kernel or what,
>> but that's what's there and I think it's what's causing the issue.
>>
>> Vince
