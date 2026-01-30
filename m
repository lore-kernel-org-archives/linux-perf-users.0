Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1FE3346A0;
	Fri, 30 Jan 2026 10:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769767660; cv=none; b=bxqVjanAVOln6dvUAo8IA2yQhDK1uyNtlompp547eQThlF5/PFRVAV6Dc5DpQPG9ie2v2v20NLBv1dZlor8E1S4/4rJoSltVeS9mzh8REoDmi3Yl0MCycWKejAIoeFY24XYmfBgPtw1NhnRamcpQJog+xBTrBZYaGy8KDqAGB50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769767660; c=relaxed/simple;
	bh=jmg7OlniGbH+jhn28my8TAMmKVX6efXZiryi23GtK8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxVcaUQhJ1LnDRTG4PgUr6cUtASdWaBucxddMkP+KPxJ5bh75TVVplraVeUeQoL+rLtypOlAQ7jyWXVbY6HKQaz0gK3wDQCudbV7cCrR9xZMBUEvortOTnjD6PCVEgmB1rQwJqajRKF1PSg1JCpN0uLG/lBxK9hJ1hM1MiJg9rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q9tLVBPA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q9tLVBPA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=v4UZzjjr4zqEky9B7UEmne/JqH8DoiM8MsNNh9lofv0=; b=q9tLVBPAxdGPLxr2i5m6ddCiZR
	RZ7i10get27Dzw9cNV46F9hyC0/zB0xqNtmJ73+IE5RlCOiP5HbV1tt5+Q7/sHorCBJ40khMuQW2i
	jQMLTiu6b/TdckLabvM2squ+PeekC2wI+9vRarqxosjJ0bN7m1IyL57+CJ306MZYISacFPu1w16EI
	h1Nq2Pqsvc9UCtSOqtB0cautTbz4pHukW6LJ1xfM7SxaHA59yt2NJpFoD4xnZfst/C90QqDUtHVTd
	buFEMpM3HHTaAYSiHl+mHs3S4qi3R7apF7hLB7+eFIDQdrH/Bnd5wN8MYhKgt+iowPz5cMqdls3i7
	T9jInVOg==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vllPa-0000000C0oW-13WV;
	Fri, 30 Jan 2026 10:07:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C459A3006CD; Fri, 30 Jan 2026 11:07:33 +0100 (CET)
Date: Fri, 30 Jan 2026 11:07:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Qing Wang <wangqing7171@gmail.com>
Cc: henryzhangjcle@gmail.com, acme@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	syzbot+2a077cb788749964cf68@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, zeri@umich.edu
Subject: Re: [PATCH] perf: Fix data race in perf_event_set_bpf_handler()
Message-ID: <20260130100733.GZ171111@noisy.programming.kicks-ass.net>
References: <20260127023618.1469937-1-zeri@umich.edu>
 <20260127083719.1347209-1-wangqing7171@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127083719.1347209-1-wangqing7171@gmail.com>

On Tue, Jan 27, 2026 at 04:37:19PM +0800, Qing Wang wrote:
> On Tue, 27 Jan 2026 at 10:36, Henry Zhang <henryzhangjcle@gmail.com> wrote:
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index a0fa488bce84..1f3ed9e87507 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -10349,7 +10349,7 @@ static inline int perf_event_set_bpf_handler(struct perf_event *event,
> >  		return -EPROTO;
> >  	}
> >  
> > -	event->prog = prog;
> > +	WRITE_ONCE(event->prog, prog);
> >  	event->bpf_cookie = bpf_cookie;
> >  	return 0;
> >  }
> > @@ -10407,7 +10407,9 @@ static int __perf_event_overflow(struct perf_event *event,
> >  	if (event->attr.aux_pause)
> >  		perf_event_aux_pause(event->aux_event, true);
> >  
> > -	if (event->prog && event->prog->type == BPF_PROG_TYPE_PERF_EVENT &&
> > +	struct bpf_prog *prog = READ_ONCE(event->prog);
> > +
> > +	if (prog && prog->type == BPF_PROG_TYPE_PERF_EVENT &&
> >  	    !bpf_overflow_handler(event, data, regs))
> >  		goto out;
> 
> Looking at this code, I guess there may be an serious issue: a potential
> use-after-free (UAF) risk when accessing event->prog in __perf_event_overflow.
> 
> CPU 0 (interrupt context)               CPU 1 (process context)
> read event->prog
>                                         perf_event_free_bpf_handler()
>                                             put(prog)
>                                                 free(prog)
> access memory pointed to by prog
> 
> This scenario need to be more analysis.

This can only happen if the event can overlap with removal, which it
typically cannot -- but I'll have to audit the software events.

Specifically, events happen in IRQ/NMI context, and event removal
involves an IPI to that very CPU, which by necessity will then have to
wait for event completion.
