From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Intel PEBS Load Latency Measurement
Date: Fri, 01 Nov 2013 17:41:18 +0900
Message-ID: <87eh704iq9.fsf@sejong.aot.lge.com>
References: <52380863.4090606@insa-lyon.fr> <526E4A46.2060003@insa-lyon.fr>
	<87r4b47qgv.fsf@sejong.aot.lge.com>
	<CALbiyZy_JE+wai7d_=r-XzE+FdHRitTiAuPmANtRt7Qpet8fTg@mail.gmail.com>
	<CALbiyZyOUYL3dKo_OaXK6SMXmMBF3N47gGv0MAjRirsFzyPDMw@mail.gmail.com>
	<CALbiyZyimUGh5MfjyBcH4UdvwX=S0V2uKJz3px1CaKg_HrMzeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE1Q.lge.com ([156.147.1.111]:42288 "EHLO
	LGEMRELSE1Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707Ab3KAIlT (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 1 Nov 2013 04:41:19 -0400
In-Reply-To: <CALbiyZyimUGh5MfjyBcH4UdvwX=S0V2uKJz3px1CaKg_HrMzeA@mail.gmail.com>
	(Manuel Selva's message of "Tue, 29 Oct 2013 14:20:09 +0100")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Manuel Selva <selva.manuel@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Tue, 29 Oct 2013 14:20:09 +0100, Manuel Selva wrote:
> One more thing I forgot to ask is clarification about the pid
> parameter. According to Vince Weaver page: "If pid is 0, measurements
> happen on the current thread, if pid is greater than 0, the process
> indicated by pid is measured, and if pid is -1, all processes are
> counted." and according to perf userland tool wiki page, it's possible
> to attache to a specific thread with a -i option. As a consequence I
> wonder how I can use the perf perf_event_sys_call to only count events
> for a specific thread ?

In the syscall's point of view, pid is actually tid AFAIK - so I works
on the thread-basis not the process.

Thanks,
Namhyung
