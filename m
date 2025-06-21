Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5CE1A5B99;
	Sat, 21 Jun 2025 09:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750497618; cv=none; b=ChtxjIyeZ5BEgmD9qMCO7zDpLi8Q1hqJnUmtLzIkOZL3HSJsMWCrAKUQJjvi5AEGxRGEK9KTZnQs8AAAaR/vUaceODwMXui58Xgv8eTBXD732GWNwKhq25BSiIqH3H7a1DKkznVUB13unpzZ36b+7jymC4z7qwsPQKRj4ZB2+cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750497618; c=relaxed/simple;
	bh=toupD9+AQbYUeU5Tc+TD0Yk8NrBjlSM4Q+eiJFhhiEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2OKXBsqbSLeHxUSw5LMuZx0zsKlcjos2Dd0k5Q7iCuCyISipqBeuE2r6M4C0G6KVpO51UjknnfHkP9++3WrqpgVdKUWMdqPCpQevHlzFN80CGI3VKo/tINsSW2hZiesTMWBw8MV9WR6wb7QxDPKKUt9IxR87rmkp0MhC5eU48g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uLIfli8Z; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uLIfli8Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FyfL9prHLKhHbqgEe+wwi0u4/Cr2AD00/3GDODY/t8M=; b=uLIfli8Z/LRRwFGc5OR0bOhwOO
	qqca39KikuN6TmQ1SA5qATe7tuqA5OIxHg6u7Mpsyd2GU2TSm2oPic/sjVphVnm7tYI9nxRRU4RdK
	sD/2X5vn7heLHAMk2MnQqhgvm3KswvxaUhrykKV0IDMmAApxqnOw7EaFtnkIecj+eL1OSuBDrfvD1
	jFLlJNAK0gAAeIe6oxnH6B+e5vZqQeMI1LHPmT8tK9wN8tfSmcLWhvKyfe4xsVvea/5mBnT+yzkQl
	tZV4RKreYONiWZiaopf/uhjVR8PTKrcRDW8nt0jtGP3XKnUzQCYi9b5SZMaIA5lr9WxJqy6TuU2T9
	I5Yl+CsA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSuOI-0000000EujU-0zr0;
	Sat, 21 Jun 2025 09:20:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2C4C03087E7; Sat, 21 Jun 2025 11:20:01 +0200 (CEST)
Date: Sat, 21 Jun 2025 11:20:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v4 07/13] perf/x86/intel: Allocate arch-PEBS buffer and
 initialize PEBS_BASE MSR
Message-ID: <20250621092001.GT1613376@noisy.programming.kicks-ass.net>
References: <20250620103909.1586595-1-dapeng1.mi@linux.intel.com>
 <20250620103909.1586595-8-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620103909.1586595-8-dapeng1.mi@linux.intel.com>

On Fri, Jun 20, 2025 at 10:39:03AM +0000, Dapeng Mi wrote:

> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index b6eface4dccd..72b925b8c482 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -625,13 +625,22 @@ static int alloc_pebs_buffer(int cpu)
>  	int max, node = cpu_to_node(cpu);
>  	void *buffer, *insn_buff, *cea;
>  
> -	if (!x86_pmu.ds_pebs)
> +	if (!intel_pmu_has_pebs())
>  		return 0;
>  
> -	buffer = dsalloc_pages(bsiz, GFP_KERNEL, cpu);
> +	/*
> +	 * alloc_pebs_buffer() could be called by init_arch_pebs_buf_on_cpu()
> +	 * which is in atomic context.
> +	 */
> +	buffer = dsalloc_pages(bsiz, preemptible() ? GFP_KERNEL : GFP_ATOMIC, cpu);
>  	if (unlikely(!buffer))
>  		return -ENOMEM;

Here we go again.. that is CPU_STARTING context, that has IRQs disabled
and as such no allocation is allowed. Not even GFP_ATOMIC -- this will
break PREEMPT_RT.
