From: Manuel Selva <selva.manuel@gmail.com>
Subject: Re: Intel PEBS Load Latency Measurement
Date: Fri, 01 Nov 2013 10:02:08 +0100
Message-ID: <52736E10.9080104@gmail.com>
References: <52380863.4090606@insa-lyon.fr> <526E4A46.2060003@insa-lyon.fr>	<87r4b47qgv.fsf@sejong.aot.lge.com>	<CALbiyZy_JE+wai7d_=r-XzE+FdHRitTiAuPmANtRt7Qpet8fTg@mail.gmail.com>	<CALbiyZyOUYL3dKo_OaXK6SMXmMBF3N47gGv0MAjRirsFzyPDMw@mail.gmail.com>	<CALbiyZyimUGh5MfjyBcH4UdvwX=S0V2uKJz3px1CaKg_HrMzeA@mail.gmail.com> <87eh704iq9.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:53747 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892Ab3KAJCL (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 1 Nov 2013 05:02:11 -0400
Received: by mail-ee0-f49.google.com with SMTP id e52so1855557eek.22
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Nov 2013 02:02:09 -0700 (PDT)
In-Reply-To: <87eh704iq9.fsf@sejong.aot.lge.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org

Thanks for this info. It confirms what I finally concluded after looking 
at source code where I saw that pid is used to get a task_struct object.

Manu

On 11/01/2013 09:41 AM, Namhyung Kim wrote:
> On Tue, 29 Oct 2013 14:20:09 +0100, Manuel Selva wrote:
>> One more thing I forgot to ask is clarification about the pid
>> parameter. According to Vince Weaver page: "If pid is 0, measurements
>> happen on the current thread, if pid is greater than 0, the process
>> indicated by pid is measured, and if pid is -1, all processes are
>> counted." and according to perf userland tool wiki page, it's possible
>> to attache to a specific thread with a -i option. As a consequence I
>> wonder how I can use the perf perf_event_sys_call to only count events
>> for a specific thread ?
>
> In the syscall's point of view, pid is actually tid AFAIK - so I works
> on the thread-basis not the process.
>
> Thanks,
> Namhyung
>
