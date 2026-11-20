Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187421;
	b=3FmVB/LoPcfBE0qHS2vCExDInz96LqeaVUiFX6LyVhMcY2r8d1b0UMMamALoPiHHFx0g
	 x1yAk6ReCAGnXIOWJYMtAWfTqbvAJvoN6XpIDvfxktitvVLiUDRXOzy0CXayVNY9jzAwt
	 gUBVdF7kXLfpTZgb3jz2SRwjQIGI/2U9h6KRhnJyFPhqvnAK12IviuPR2ITSWfpLE+qJ8
	 C9WDc9z+mjsujl5ED9RUfxGvVkCIHKsm+jbque+bX/UiVZxc6+jOeaOVni7En5IwhuDYv
	 RGUQwBOh3gLUjfvHF5rpjtwpSZ0dCqlzVMVlmLzN+H5eXSukh1hf1rY9Zi1hsFmaTZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187421;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=1Uf2w3C6VLG0GW6+V2bXKgNIiaxX6Iz2cPxMgQETrHM=;
	b=m6FPNs1rVQlih5rI87SmBHf04eNhqxrVjcNLhKlhX0jRdeYg+zRaBV+0T94Iliiap0ch
	 InLLKGbMiX39JfUKzsdlQnxIUIcFjyY6tqgp26J6oN3kQrVh9rPr0MK5myX6kaBOQx1FZ
	 KyEte8U8HPlo3JqvkomHtAO4AHVa7r9y+fTywbOZjGHTO1TPwexAwrrl6XdXhWZcpAeo1
	 glppQ/rwiD2Jp3US/K8CLEQrOnM0j0yZ9OhGTCG/vFxnoSnJHJEADi1ieRJoUU4zLZCku
	 aymJftGAi9yg97OeRz3aHHFTvocdMLaTwt6ISB7jM2hPjTd1+PekgxCa8QAe49ddu7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="OUX/lrvJ";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=IAoGx9P4;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15449606A338;
	Fri, 20 Nov 2026 15:10:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15449606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=OUX/lrvJ;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=IAoGx9P4
Date: Fri, 20 Nov 2026 16:10:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795187419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Uf2w3C6VLG0GW6+V2bXKgNIiaxX6Iz2cPxMgQETrHM=;
	b=OUX/lrvJURJO8B/bRcp1KZOhz1W0eXw6NIP2IBMY8qkuYXGlUs6iMbipujxmPkzsIOFQ3W
	3VBh7otPD7vX1rf7drGmNjmvpndwa//iyUGtx46uMCgy3LVI/2BsUndZqchz+25I36nAcK
	DKlnshuEHGOVFdnQxChEOlf+gKCLGz9RlFOHxcI0C+OwPTiVnjbGwmYTBeYC1PEbBEUjtq
	J9M1bw3ECuKpYBN+NA7VgWHPuvAonecMFp26Mxf3sucAxDJSkTGzBAgd9mcozfau4MjJXU
	FSODWpAWAtny0C/gsBZ8PrSOOVeLk0DxTOwOdiK8TV9/jNApOidq6NuSryhPZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795187419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1Uf2w3C6VLG0GW6+V2bXKgNIiaxX6Iz2cPxMgQETrHM=;
	b=IAoGx9P4ncOm9hSQfXJorUUR2w+oqVmjqkKbhoJG+hMFDa45LVImFg3VwXkZh0xQYaL2jJ
	pH4W6J/Uvnz8v3Dg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20261120151017.mKJ_Y_u0@linutronix.de>
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <45bd71c976aea1a0e8bf5762dd6b6552e6009439.1795053619.git.wutengda@huaweicloud.com>
 <20261120121436.GT2668564@noisy.programming.kicks-ass.net>
 <20261120141606.zcwyHZ3P@linutronix.de>
 <20261120150452.GU2668564@noisy.programming.kicks-ass.net>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261120150452.GU2668564@noisy.programming.kicks-ass.net>

On 2026-11-20 16:04:52 [+0100], Peter Zijlstra wrote:
> On Fri, Nov 20, 2026 at 03:16:06PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2026-11-20 13:14:36 [+0100], Peter Zijlstra wrote:
> > > > Also use smp_load_acquire() when checking pending_work in
> > > > the exclude_kernel warning path to ensure the read is properly
> > > > ordered.
> > > 
> > > I am confused by the use of smp_*() and cmpxchg() here. Where is the
> > > multi-cpu scenario?
> > 
> > The same event is used in process context and NMI
> > |        perf-tc1-7647    [001] d..6.   114.513688: __perf_event_overflow: ffff888100d68540
> > |        perf-tc1-7647    [001] d.Z2.   114.513703: __perf_event_overflow: ffff888100d68540
> > 
> > I don't see how to deal with this without cmpxchg. And the same event is
> > also used by other task
> 
> You can do CMPXCHG (without the LOCK) prefix; the helper is called
> cmpxchg_local().
> 
> > |        perf-tc1-7657    [001] d.Z2.   114.598356: __perf_event_overflow: ffff888100d68540
> > 
> > which makes me thing that it could be pinned to another CPU (unless
> > there is something that impossible and it is strictly per-CPU).
> > 
> > The smp load/store macros is my fault as it looked better to do this
> > than plain stores (given that we have the cmpxchg already).
> 
> It is confusing as all heck. This is all task-local, and a task can only
> ever run on one CPU at the time.

Given the two pids I was assuming (!knowing) that two CPUs could be
involved.

So you are saying cmpxchg_local() and a plain assign/WRITE_ONCE rather
than the smp.* given that this is all task local.

Sebastian
