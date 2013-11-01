From: Manuel Selva <selva.manuel@gmail.com>
Subject: Re: Intel PEBS Load Latency Measurement
Date: Fri, 01 Nov 2013 19:08:29 +0100
Message-ID: <5273EE1D.2010803@gmail.com>
References: <52380863.4090606@insa-lyon.fr> <526E4A46.2060003@insa-lyon.fr> <87r4b47qgv.fsf@sejong.aot.lge.com> <CALbiyZy_JE+wai7d_=r-XzE+FdHRitTiAuPmANtRt7Qpet8fTg@mail.gmail.com> <CALbiyZyOUYL3dKo_OaXK6SMXmMBF3N47gGv0MAjRirsFzyPDMw@mail.gmail.com> <CALbiyZyimUGh5MfjyBcH4UdvwX=S0V2uKJz3px1CaKg_HrMzeA@mail.gmail.com> <87eh704iq9.fsf@sejong.aot.lge.com> <alpine.DEB.2.10.1311011300350.31770@vincent-weaver-1.um.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:44562 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310Ab3KASId (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 1 Nov 2013 14:08:33 -0400
Received: by mail-we0-f177.google.com with SMTP id x55so4182173wes.8
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Nov 2013 11:08:32 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.10.1311011300350.31770@vincent-weaver-1.um.maine.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org

I agree about the confusing way that Linux uses pid and tid. I guess 
this comes from the (old) time where processes only had one thread. 
Anyway, threads are just processes sharing some part of their memory, 
and processes are just threads that don't share anything.

Your man page (the online version, I have to check why I don't have it 
on my Linux workstation) was really helpful for me to build what I 
needed upon the perf_event_open system call without having to start from 
scratch with my own kernel module  or the msr module and the Intel 
documentation. I listed from my side some complementary information that 
maybe useful for others, if you plan to update the man page I can 
provide you these notes.

Thanks again to all here on the list for your help !

Manu

On 11/01/2013 06:02 PM, Vince Weaver wrote:
> On Fri, 1 Nov 2013, Namhyung Kim wrote:
>
>> On Tue, 29 Oct 2013 14:20:09 +0100, Manuel Selva wrote:
>>> One more thing I forgot to ask is clarification about the pid
>>> parameter. According to Vince Weaver page: "If pid is 0, measurements
>>> happen on the current thread, if pid is greater than 0, the process
>>> indicated by pid is measured, and if pid is -1, all processes are
>>> counted." and according to perf userland tool wiki page, it's possible
>>> to attache to a specific thread with a -i option. As a consequence I
>>> wonder how I can use the perf perf_event_sys_call to only count events
>>> for a specific thread ?
>>
>> In the syscall's point of view, pid is actually tid AFAIK - so I works
>> on the thread-basis not the process.
>
> It is true the manpage is a bit confusing here, though that's mostly due
> to the confusing way that Linux interchangably uses pid/tid for process
> and thread ids.  I'll see if I can get the documentation made more clear.
>
> Vince
>
