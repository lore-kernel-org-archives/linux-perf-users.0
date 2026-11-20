Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795184170;
	b=YViu4RociDF9rwvxBotPVGT2zrolwNkweANJ6+U0Le5SxkOYgvtYRNPx8z57wG3MSm5W
	 JEN1/AZgFS6fTOBlI9w+HK8HmnHewHFhbwm3PWgWhuOijcWLQ2m+YrMzb8nNyDVUT0Py4
	 BMdvc5AKp00quHQfEV78IRA6SoSsx1U3hiHh1vS1JBR3YvKwB9kcJpuYjmoWspT4RzOmj
	 JwLq4YB3eTk5bE+XSUGgiPlvTXh5lkxM+i/kSS4rnVzUIjIBCt6byfHmdmgcLSLIHm8NN
	 u7HqedLNSsoTcXxrNLQ4xt+Ihp8Ltj/LjVhCjo+HrRPck+On9zw6TtVP8x7Opmg6UvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184170;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=RS6E0aCrGfHttoJoLg3wAvtdViYdywflW1zClO3xhHU=;
	b=Pl6DXjDINbuAGtClmj9TVkRdbWaYA1idBEphpuukwV5GL5pjdkVobVOI3kAvy7xdmRuB
	 m2ZSYnpR4LnuXJrjBCFLmmiZSdXv/0rrQpyPPn/LDMSxeraQIUEDIDHtEQK0yh3sRvf0L
	 1ruAFZEO1sac0kKorLEry31Aag8OrEeNNwQSoHWDRUWxsy5/XfEeaqwdSBHIEQ1ZcYdsO
	 zRBI3n/bwp3tmtcoTdRNrxgwm1TdTzMIW8yIo03KedWOdWVLYLELh4jrtMj7YnB0rqXSu
	 gTRt9ARYaV/sHGq0ZNn2tnLc6kBOW0CMCmHXqGJHuC/xAUsSVUXCuzaM6x3bEnN67qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=vqY2SizF;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=+Dq8tZ5d;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2B3606A33D;
	Fri, 20 Nov 2026 14:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E2B3606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=vqY2SizF;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=+Dq8tZ5d
Date: Fri, 20 Nov 2026 15:16:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795184168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RS6E0aCrGfHttoJoLg3wAvtdViYdywflW1zClO3xhHU=;
	b=vqY2SizFoIEUCCa098XYAAv3YNeSt4AZm705itlAKiagcD1S6b3ONMTnJbV2n+YhTcfkm1
	GGgjjYxmKAcGT618g1YJJCD71cKiTVak5mvkWhzyfcRpuHEKbVHy9luJTRtOjJecBfqWQq
	JuLw6Dzi31l0v1cOIv0Cuemc25HmkAxw/BO/LTlkOV2ojeMvvnDWDQ5o1D2WJ8rI2JTOlV
	Aj+HwFMGbuDcjhgD9DAgHZ7dHYizz0QbZj/klDqC2rzzWm7Nuho34dg9u9Sj7hc7qefbqD
	6JX56FTzG6Q0tf/spltrwHDPSgSzj3gl4KL3lVF2RiAAKJ9JClZ6cFd//9Yjzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795184168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RS6E0aCrGfHttoJoLg3wAvtdViYdywflW1zClO3xhHU=;
	b=+Dq8tZ5dyt4Wnm5ctlcJpvCmR5gW0XTGHXCOpzBJ5weC1A76NpVe1BaEFM8d53sSSUIg6n
	bu1Btrf06Y4xxACA==
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
Message-ID: <20261120141606.zcwyHZ3P@linutronix.de>
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <45bd71c976aea1a0e8bf5762dd6b6552e6009439.1795053619.git.wutengda@huaweicloud.com>
 <20261120121436.GT2668564@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20261120121436.GT2668564@noisy.programming.kicks-ass.net>

On 2026-11-20 13:14:36 [+0100], Peter Zijlstra wrote:
> > Also use smp_load_acquire() when checking pending_work in
> > the exclude_kernel warning path to ensure the read is properly
> > ordered.
> 
> I am confused by the use of smp_*() and cmpxchg() here. Where is the
> multi-cpu scenario?

The same event is used in process context and NMI
|        perf-tc1-7647    [001] d..6.   114.513688: __perf_event_overflow: ffff888100d68540
|        perf-tc1-7647    [001] d.Z2.   114.513703: __perf_event_overflow: ffff888100d68540

I don't see how to deal with this without cmpxchg. And the same event is
also used by other task

|        perf-tc1-7657    [001] d.Z2.   114.598356: __perf_event_overflow: ffff888100d68540

which makes me thing that it could be pinned to another CPU (unless
there is something that impossible and it is strictly per-CPU).

The smp load/store macros is my fault as it looked better to do this
than plain stores (given that we have the cmpxchg already).

Sebastian
