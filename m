Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D845361650;
	Fri, 13 Feb 2026 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770991943; cv=none; b=h3G373VIy0GSHWasP+NuDdtUdWknPYAyE+xIQggAmeIYZVQ7t+unweGdSBHi+R04XOyp/ngtJ+/9bRvC43wjerSH5xZycPIYTBAW3AlHsb3WRAiFtdao6iezmaH8jcpZ07B4wrUj7MbrbzO2YeNLbSVKFfedCez/ppXTiIw6sFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770991943; c=relaxed/simple;
	bh=Z72NaM4FgfTjr30sXLvfCwA/fXsgX8qu8Bt/BDf21Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ce7NsgXOvit35vOGrqSvcOytB/VTknxDpxsYllEBO7K7AvmvIC+dWM76rTzJtcS8Od6wlTpSOXvovSxB8D76xd73ZJJlmT0KWwVsmUtcZaX1MXgQw1VIVk453f+AbOeURkbj/NN6XPt7xFRXOZiy0DVeS34inChyvLCzpD13kuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kvPJw6NU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kvPJw6NU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=htTsucVwnrnc/dGy2CUv7tg1FWCDtHE1VykVCgHknrk=; b=kvPJw6NUVoYSnNG8Q9OtkmK+r+
	HRVUM4Outmx17K95H84VI4MJnd531IOtiT6j5Gq5slWMbivdcRW3kqXo/o4GlqVmIYZeuVsRGx9qy
	oUsYWXe6Eg326KNZlnj5EjyjFdXPuUwJj5bjzi9r0Yxbi1xi6OvGwh/cg7IuYR0yS8LnFINt0kLkV
	xmTV5ELL1sAxSoMsUjLpfa0cEhl7RyDdIDMrQ48jBa3FFnKIDIEt/Qoo3JnDnXj1Tr3KNRvdo4gu5
	v60HQ2WgWf1QXkKwCUZF0nW8DAf3rCaKGCWmzFNExgIH5pj9myT2y23kpLbGVdJuJ+CwRe3xSl7Ur
	OfPwkm5A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqtu2-0000000Fors-0U8L;
	Fri, 13 Feb 2026 14:12:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F2AB1300B40; Fri, 13 Feb 2026 15:12:12 +0100 (CET)
Date: Fri, 13 Feb 2026 15:12:12 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Zw Tang <shicenci@gmail.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	mingo@redhat.com, boqun.feng@gmail.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	namhyung@kernel.org, will@kernel.org, juri.lelli@redhat.com
Subject: Re: [BUG] PREEMPT_RT: sleeping function called from invalid context
 in perf_event_wakeup()
Message-ID: <20260213141212.GU2995752@noisy.programming.kicks-ass.net>
References: <CAPHJ_VK1t=pRw9zct9CNRET1=uH-efB9grAJ-kGJEN=PDk7z0w@mail.gmail.com>
 <20260205110855.GJ232055@noisy.programming.kicks-ass.net>
 <20260213124705.hpxaabypmuj4pfwg@hu-mojha-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260213124705.hpxaabypmuj4pfwg@hu-mojha-hyd.qualcomm.com>

On Fri, Feb 13, 2026 at 06:17:05PM +0530, Mukesh Ojha wrote:
> On Thu, Feb 05, 2026 at 12:08:55PM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 05, 2026 at 06:42:05PM +0800, Zw Tang wrote:
> > > Hi,
> > > 
> > > I am reporting a PREEMPT_RT “sleeping function called from invalid
> > > context” bug triggered by a syzkaller reproducer on Linux 6.19.0-rc7.
> > > 
> > > The kernel reports:
> > > 
> > > BUG: sleeping function called from invalid context at
> > > kernel/locking/spinlock_rt.c:48
> > > in_atomic(): 1, irqs_disabled(): 1, preempt_count: 4
> > > 
> > > The splat points to perf’s wakeup path taking an RT spinlock while
> > > running in an atomic/IRQs-disabled context:
> > > 
> > > merge_sched_in()
> > > -> perf_event_wakeup()
> > > -> __wake_up_common_lock()
> G> > -> rt_spin_lock()
> > > -> __might_resched() (complains about sleeping in invalid context)
> > > 
> > > This suggests a locking semantic mismatch on PREEMPT_RT:
> > > perf_event_wakeup() (via __wake_up_common_lock()) ends up taking a
> > > lock that maps to rt_spin_lock(), which may sleep on RT kernels, but
> > > the current context is explicitly atomic with IRQs disabled.
> > 
> > Fixes: f4b07fd62d4d ("perf/core: Use POLLHUP for pinned events in error")
> > 
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index dad0d3d2e85f..216cf6ae1c7d 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -4017,7 +4017,8 @@ static int merge_sched_in(struct perf_event *event, void *data)
> >  			if (*perf_event_fasync(event))
> >  				event->pending_kill = POLL_ERR;
> >  
> > -			perf_event_wakeup(event);
> > +			event->pending_wakeup = 1;
> > +			irq_work_queue(&event->pending_irq);
> >  		} else {
> >  			struct perf_cpu_pmu_context *cpc = this_cpc(event->pmu_ctx->pmu);
> 
> 
> Looks like this https://lore.kernel.org/lkml/20250603045105.1731451-1-namhyung@kernel.org/
> got unnoticed.

Indeed, -ETOODAMNMUCHEMAIL :/

Let me go grab that one.
