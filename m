From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: Intel PEBS Load Latency Measurement
Date: Fri, 1 Nov 2013 13:02:49 -0400 (EDT)
Message-ID: <alpine.DEB.2.10.1311011300350.31770@vincent-weaver-1.um.maine.edu>
References: <52380863.4090606@insa-lyon.fr> <526E4A46.2060003@insa-lyon.fr> <87r4b47qgv.fsf@sejong.aot.lge.com> <CALbiyZy_JE+wai7d_=r-XzE+FdHRitTiAuPmANtRt7Qpet8fTg@mail.gmail.com> <CALbiyZyOUYL3dKo_OaXK6SMXmMBF3N47gGv0MAjRirsFzyPDMw@mail.gmail.com>
 <CALbiyZyimUGh5MfjyBcH4UdvwX=S0V2uKJz3px1CaKg_HrMzeA@mail.gmail.com> <87eh704iq9.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:37945 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107Ab3KAQym (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 1 Nov 2013 12:54:42 -0400
Received: by mail-qc0-f175.google.com with SMTP id e16so2572942qcx.6
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Nov 2013 09:54:41 -0700 (PDT)
In-Reply-To: <87eh704iq9.fsf@sejong.aot.lge.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Manuel Selva <selva.manuel@gmail.com>, linux-perf-users@vger.kernel.org

On Fri, 1 Nov 2013, Namhyung Kim wrote:

> On Tue, 29 Oct 2013 14:20:09 +0100, Manuel Selva wrote:
> > One more thing I forgot to ask is clarification about the pid
> > parameter. According to Vince Weaver page: "If pid is 0, measurements
> > happen on the current thread, if pid is greater than 0, the process
> > indicated by pid is measured, and if pid is -1, all processes are
> > counted." and according to perf userland tool wiki page, it's possible
> > to attache to a specific thread with a -i option. As a consequence I
> > wonder how I can use the perf perf_event_sys_call to only count events
> > for a specific thread ?
> 
> In the syscall's point of view, pid is actually tid AFAIK - so I works
> on the thread-basis not the process.

It is true the manpage is a bit confusing here, though that's mostly due 
to the confusing way that Linux interchangably uses pid/tid for process 
and thread ids.  I'll see if I can get the documentation made more clear.

Vince
