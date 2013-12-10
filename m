From: Mohammed Riyaz <riyaz.list@gmail.com>
Subject: Re: Measuring worst case interrupt processing time
Date: Tue, 10 Dec 2013 01:14:34 -0800
Message-ID: <CAL7o8ivP97rHo1LD3o_KhKF_9MH=F6HZ216S-HTPJyuNiKi94A@mail.gmail.com>
References: <CAL7o8itUf0wOj-f7LEF=EfydzimOkpi1VrTZXVE0VvECNP0VPQ@mail.gmail.com>
	<87ob4qvg2v.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:33448 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371Ab3LJJOf (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 10 Dec 2013 04:14:35 -0500
Received: by mail-qc0-f171.google.com with SMTP id c9so3745470qcz.30
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Dec 2013 01:14:34 -0800 (PST)
In-Reply-To: <87ob4qvg2v.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

Hi Andi,

>
> If your goal is to identify worst case latencies of interrupted code --
> ftrace has special tracers for this: CONFIG_{IRQSOFF,PREEMPT,SCHED}_TRACER
>

ok, that got me thinking.. but it turns out that, the need is to
measure the processing time per IRQ. And of course, to then identify
the offenders using this.

Thanks
Riyaz
