Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ECA149DF4;
	Tue, 25 Jun 2024 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719316751; cv=none; b=pL7E8BywpwaGx1XjIUY3Q3/37CMdS/MNdipWSh4qN7VAb6cIGN1v7q4sk6hbhoI9NOp9SUt0Njvv8w1mX39PWTF7I0L/ylkxX73YETgoMExSmlGibK5S9h6bhvhLuUdJYfW9X5q+KRvKKTnh8jFkfViOejaqOodIsMuiI3xiyMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719316751; c=relaxed/simple;
	bh=Hrfq+maSEj3WxB6vB3cQGQLr956uhgW13951p1ffbds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6lu9G5+uEU8Gj8ElEb0JQyDUZytQ8pYjUf3TGuBdXkFoVrGXV8IvpM55J6lUQfO2bUuf1f7owo8YK+PPgu9DAU7nGi4BNnWFFD9iB5Pa5JXUMW4S0jXSaUTmMmwjzX0BXQJl2sIbtpgaKzJkwbGPT0nRxwaOSsyMOSwdchRBUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HRMqsVsK; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HRMqsVsK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+gy/BrN3plSDRuoejybnMPbKrZg1ii0jthWvzT4Keuk=; b=HRMqsVsK6KtfIJ+AhJTGPBu8WD
	FkIKIbX8KH/L1dUAXOTOGgncK2CAGq2KF3rnzfMgo0rgOIuP7RTel+hBMlfl0fMv5GTIzhzo0HSDq
	/I+yWPDn992eHHrayab0mD8Ndk8sODlSgZ7j+45IhBzfJxjm6GDZTtQvF4bBcrLhpQZtJprOot/4O
	LcCHlcHJZP9eXLp44UZsbXZrWzs0UpHn/ygNPGyUNqVhr4l3uNJreI4a07Ko8EITs2ahxK4/FdKrn
	4HdMY+RPdWzfcYKExj9dJzCs2RlmdaK8qvBTliCdwWh97ZTby7zQ1xh4HWzLhQOYaDuUYMuEh6O2G
	dCvqkI4A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM4ns-00000008P5z-14sL;
	Tue, 25 Jun 2024 11:58:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0387730036F; Tue, 25 Jun 2024 13:57:35 +0200 (CEST)
Date: Tue, 25 Jun 2024 13:57:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Breno Leitao <leitao@debian.org>
Cc: sandipan.das@amd.com, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, leit@meta.com,
	"Paul E . McKenney" <paulmck@kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf/x86/amd: Warn only on new bits set
Message-ID: <20240625115734.GX31592@noisy.programming.kicks-ass.net>
References: <20240524141021.3889002-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524141021.3889002-1-leitao@debian.org>

On Fri, May 24, 2024 at 07:10:20AM -0700, Breno Leitao wrote:
> Warning at every leaking bits can cause a flood of message, triggering
> vairous stall-warning mechanisms to fire, including CSD locks, which
> makes the machine to be unusable.
> 
> Track the bits that are being leaked, and only warn when a new bit is
> set.
> 
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/x86/events/amd/core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 1fc4ce44e743..df0ba2382d13 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -941,11 +941,12 @@ static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, u
>  static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	static atomic64_t status_warned = ATOMIC64_INIT(0);
> +	u64 reserved, status, mask, new_bits;
>  	struct perf_sample_data data;
>  	struct hw_perf_event *hwc;
>  	struct perf_event *event;
>  	int handled = 0, idx;
> -	u64 reserved, status, mask;
>  	bool pmu_enabled;
>  
>  	/*
> @@ -1010,7 +1011,11 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
>  	 * the corresponding PMCs are expected to be inactive according to the
>  	 * active_mask
>  	 */
> -	WARN_ON(status > 0);
> +	if (status > 0) {
> +		new_bits = atomic64_fetch_or(status, &status_warned) ^ atomic64_read(&status_warned);
> +		// A new bit was set for the very first time.
> +		WARN(new_bits, "New overflows for inactive PMCs: %llx\n", new_bits);
> +	}

Why not just a WARN_ON_ONCE() instead? This really shouldn't be
happening in the first place.

