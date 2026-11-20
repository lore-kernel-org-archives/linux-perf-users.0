Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187102;
	b=bwHeNpmK2+QMjrAv6vPTCj/fbz6LyT97hTblw8Y331zEHruzZEYQ4q6m56iz4iAIH2pr
	 i3DXdZG4ovgJsQQBTHmBoqcIr7LlIap2ffGa451V3JhAhfLbCi3PVCOqUYMbpviXAcw+2
	 prwgqsVuktLe9w7Skz+ky4msa5mmNCYOsefT69pNOZXjHFUr+k4ybU+hTJiO/tY5suiNi
	 gyIYk8shFIguVm4AGah0j3HDEvknVPU+P8+oWepfJjBuUi3PhGCoTsr7sR4ODf/SqUPIn
	 dPckb4J6aMGTkn/Kwk/aXl/GoNMDqH20M3SZAHPRBwa0T4+bTV23CjNLu+EnpONdjYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187102;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=l7uEAm+QOmGAfuAmZyD3+ggDCi5vQfxbP4w0OjIGnQY=;
	b=e0c5Iyf+8TiOGibE/8hYnFZHae4W2o1L9vc4VOkctLGRfGlUwdUyATlP1aEqAET/WaOz
	 xOTJOk/4UH61GEUYK8I0o/3QWhuByr5yvppGCaJ5Q3Ix6j6fXLZ0/eLJG3B1Qv4sj9QPy
	 4BcCAFceBXNqQi/WoU5FGHxtABhqFRQOm4yxGBcG1RmxM+kR6x39lZKVi6bLlHRjPBZzQ
	 ncxi8GM2w/CA5VHZ52pJ/+LTNnX/Iw/LFhHT9eH6hyNZqUOxGXX85ikLYisN3dNBRw8Cq
	 j8mYVnYMxYGqVtbQZdwHU1xiX7U9S/+FEI6D0rnXrf/op+ocCMO8uOf4iAVPNWdeCVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=TSGKfYVU;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9524606A326;
	Fri, 20 Nov 2026 15:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9524606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=TSGKfYVU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l7uEAm+QOmGAfuAmZyD3+ggDCi5vQfxbP4w0OjIGnQY=; b=TSGKfYVUvkSowdMgG2pwQ267dm
	BV2HE7ZqiJD48z762M1YfRl300gHELBGgNfKnxZ4QTCEEXUmfM/aOXKIMsReY1UfR2imWAS7qIblj
	u0E0XONWxwVLhGP3Amtki4TCFnYI8yjcpSKYO8y2E48U65m0eIvL2OSeKPLdXoLLT5ZS2JPOLkGDU
	tSU6x5cIDfeA4rT5wyr5Nmm3W2Bg5tv02sgjqP7pi+wFiVm0o8CnVWTCaYx7M+dsogEnCvB0fBS7W
	FSOfPJBk9F1WZZLF9Sn3FL8ZG06xYOkjMVzl2Z7TdcqfBuv6tWaMX24HCuG2ny+ZNolNm0xVO0rkl
	Yn7UsWng==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUQAY-00000000t7a-06W1;
	Fri, 20 Nov 2026 15:04:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2F4BD3008D6; Fri, 20 Nov 2026 16:04:52 +0100 (CET)
Date: Fri, 20 Nov 2026 16:04:52 +0100
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
Message-ID: <20261120150452.GU2668564@noisy.programming.kicks-ass.net>
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <45bd71c976aea1a0e8bf5762dd6b6552e6009439.1795053619.git.wutengda@huaweicloud.com>
 <20261120121436.GT2668564@noisy.programming.kicks-ass.net>
 <20261120141606.zcwyHZ3P@linutronix.de>
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
In-Reply-To: <20261120141606.zcwyHZ3P@linutronix.de>

On Fri, Nov 20, 2026 at 03:16:06PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-11-20 13:14:36 [+0100], Peter Zijlstra wrote:
> > > Also use smp_load_acquire() when checking pending_work in
> > > the exclude_kernel warning path to ensure the read is properly
> > > ordered.
> > 
> > I am confused by the use of smp_*() and cmpxchg() here. Where is the
> > multi-cpu scenario?
> 
> The same event is used in process context and NMI
> |        perf-tc1-7647    [001] d..6.   114.513688: __perf_event_overflow: ffff888100d68540
> |        perf-tc1-7647    [001] d.Z2.   114.513703: __perf_event_overflow: ffff888100d68540
> 
> I don't see how to deal with this without cmpxchg. And the same event is
> also used by other task

You can do CMPXCHG (without the LOCK) prefix; the helper is called
cmpxchg_local().

> |        perf-tc1-7657    [001] d.Z2.   114.598356: __perf_event_overflow: ffff888100d68540
> 
> which makes me thing that it could be pinned to another CPU (unless
> there is something that impossible and it is strictly per-CPU).
> 
> The smp load/store macros is my fault as it looked better to do this
> than plain stores (given that we have the cmpxchg already).

It is confusing as all heck. This is all task-local, and a task can only
ever run on one CPU at the time.
