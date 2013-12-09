From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Measuring worst case interrupt processing time
Date: Sun, 08 Dec 2013 19:49:44 -0800
Message-ID: <87ob4qvg2v.fsf@tassilo.jf.intel.com>
References: <CAL7o8itUf0wOj-f7LEF=EfydzimOkpi1VrTZXVE0VvECNP0VPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63864 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760353Ab3LIDtp (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 8 Dec 2013 22:49:45 -0500
In-Reply-To: <CAL7o8itUf0wOj-f7LEF=EfydzimOkpi1VrTZXVE0VvECNP0VPQ@mail.gmail.com>
	(Mohammed Riyaz's message of "Sun, 8 Dec 2013 05:18:06 -0800")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mohammed Riyaz <riyaz.list@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Mohammed Riyaz <riyaz.list@gmail.com> writes:

> Hi,
>
> I am working on trying to measure the worst case processing time for
> hard IRQ and soft IRQ. Well, I understand that we could use time
> stamps at entry and exit to measure this. Just wanted to know if there
> were other standard ways of measuring this. Any suggestions?

If your goal is to identify worst case latencies of interrupted code --
ftrace has special tracers for this: CONFIG_{IRQSOFF,PREEMPT,SCHED}_TRACER

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
