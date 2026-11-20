Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795188303;
	b=KTC0gl4jiOWouEaB2DwYNU3NhTYHkuainGlufHK8BFKM+MqijksTkD31WIyAu0eSTSvA
	 fQnr9jUYgBzyzAfblcadaRa9BWKWH9y0+iyNn/plG464USi6ab5K3OxRsU5jMASm5q7bO
	 +vVtRe915FE2t7G0a1Bx8aFkkQwmtHs5ZND89poNgWWzEQO2+Qjbc9PO2rl3ypeAX+R43
	 ttmVV/WM92k102n51qwGyDA3LGEsGtvYASHs+QJ8Guzz853Su5Cd8ds9qcdJW7E4odkIH
	 zhNhQ0uxPbjXnnYP0k8C8PoC3ES7Dvk5fAP6BmrWYudBT65RjHVq5pofG2y4tqjLIIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188303;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=+RAiifQP1e5nLcxfyf/nJlEgVnCv8MvUh0IXv0jqyag=;
	b=OPxC4RS49kk6VyMRttucptMvbGb7TAheXLJ311Rw/lgxSZJhQau0yciqRoSm5LI6TUDa
	 TzKHphGqN/LlF6tR7T64dAG76KYUyByp7v8cc1suQnBggye8KW5gFsnVqsWxb3EX4DAxI
	 bOtSiV+ukvMSzTcZoWYzd+oRv6KWwqUgXnkL2Aw4pD4ydBG7VrHmYQHlOMhMBzyuUvSvq
	 NfJm5bWWCYt9c8Z8pga+qYT2ZED4+UC50jLbg7txnfNnbsViZs9u1VuI0sNVu9VlUAITR
	 RT9nrXUx2reqBshDPhtZOAYloDXtDXSlWIWj7dqPaBVqt6B2OXyLAMjcFodzuvJtX7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=SgJ8gPFe;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16172606A326;
	Fri, 20 Nov 2026 15:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16172606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=SgJ8gPFe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+RAiifQP1e5nLcxfyf/nJlEgVnCv8MvUh0IXv0jqyag=; b=SgJ8gPFeNaP3DSN7NtmlqLi/iN
	iV9r/oQSlpXbAF34ej4NQK2Fo5NSbvBNdCmCqIlbVmfxeGbaqXrWus3M7g3qBNCok+Quqn8AffD2u
	XBGgr8Shholi2aNldd0PEF/KScopR86DXpqUzpKctgoJZzEej/t3EftyB3705sAgqYc05GEtwpA+U
	6wspwqR14TZmWuowNPZFBulZa3wjPX3h8F2mZtwfsoscCOtOMVwFBvMFL27YOn/kx7xUzgPUiHpwH
	HDMAUUYI7v1Ws9dZf+pmm6JA9DrFId9d7frQP4ho+gM5hU75ufHF6TwzyNHH61GZDPG4lOq33adXo
	tWlgSySQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUQTw-00000006tZA-0jgH;
	Fri, 20 Nov 2026 15:24:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 855EA301185; Fri, 20 Nov 2026 16:24:55 +0100 (CET)
Date: Fri, 20 Nov 2026 16:24:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tengda Wu <wutengda@huaweicloud.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] perf/core: Prevent duplicate sigtrap task work
 enqueue
Message-ID: <20261120152455.GV2668564@noisy.programming.kicks-ass.net>
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <45bd71c976aea1a0e8bf5762dd6b6552e6009439.1795053619.git.wutengda@huaweicloud.com>
 <20261120121436.GT2668564@noisy.programming.kicks-ass.net>
 <20261120141606.zcwyHZ3P@linutronix.de>
 <20261120150452.GU2668564@noisy.programming.kicks-ass.net>
 <20261120151017.mKJ_Y_u0@linutronix.de>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120151017.mKJ_Y_u0@linutronix.de>

On Fri, Nov 20, 2026 at 04:10:17PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-11-20 16:04:52 [+0100], Peter Zijlstra wrote:
> > On Fri, Nov 20, 2026 at 03:16:06PM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2026-11-20 13:14:36 [+0100], Peter Zijlstra wrote:
> > > > > Also use smp_load_acquire() when checking pending_work in
> > > > > the exclude_kernel warning path to ensure the read is properly
> > > > > ordered.
> > > > 
> > > > I am confused by the use of smp_*() and cmpxchg() here. Where is the
> > > > multi-cpu scenario?
> > > 
> > > The same event is used in process context and NMI
> > > |        perf-tc1-7647    [001] d..6.   114.513688: __perf_event_overflow: ffff888100d68540
> > > |        perf-tc1-7647    [001] d.Z2.   114.513703: __perf_event_overflow: ffff888100d68540
> > > 
> > > I don't see how to deal with this without cmpxchg. And the same event is
> > > also used by other task
> > 
> > You can do CMPXCHG (without the LOCK) prefix; the helper is called
> > cmpxchg_local().
> > 
> > > |        perf-tc1-7657    [001] d.Z2.   114.598356: __perf_event_overflow: ffff888100d68540
> > > 
> > > which makes me thing that it could be pinned to another CPU (unless
> > > there is something that impossible and it is strictly per-CPU).
> > > 
> > > The smp load/store macros is my fault as it looked better to do this
> > > than plain stores (given that we have the cmpxchg already).
> > 
> > It is confusing as all heck. This is all task-local, and a task can only
> > ever run on one CPU at the time.
> 
> Given the two pids I was assuming (!knowing) that two CPUs could be
> involved.
> 
> So you are saying cmpxchg_local() and a plain assign/WRITE_ONCE rather
> than the smp.* given that this is all task local.

Well, from what I can remember, only task bound self-monitoring events
can signal, and the whole task_work is per necessity task local. Which
makes it all local.

It is indeed {READ,WRITE}_ONCE() combined with barrier() if you really
need to beat the compiler into submission.

But let me go try and read this Changelog in more detail.
