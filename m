Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270483;
	b=wXweS8PbqAf7KfWVD+EVh7UoVX4FXjxpIVM029pEe1mTmNrFWzo22ERHIAeh5rZFLpTs
	 d26Q6tSJTSjAdY9dP7L+ueJd7HUyj0TdrUle0WiBUPytXNNHtSGWJITmgyA0VK5IonI3I
	 GTdsFPNWfTFwsW8n8MxBNyd+3x9RPrl4ew/3rTeW7mD9qJKV290bxtRGOesddi3DDWW5v
	 4pN3eyvchIv1n6aYrD2nnOnFsYExgX55vEe1NVHPvvgiyHnFMtw+Y/2IsP0L4fxFOj2Y8
	 nkamn7sGukr/OD8B/oYZLhoGxQ4/emy5vBqG+3HcGn8cRv6hsTCqS0MpLVNmvOaHgEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270483;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=0g/u21OUt5SLkwjv097E9H3comvNgIEWHceOCbcl/kw=;
	b=NyH+d3HJjIl8JAer3mtM9I2xSebJmXLs84C1aarcTtS5u7ai0hbLSZVArASq4cJ7nzPH
	 u0M3RtwzmoCGtK40QDlbIKXvFVp2sZthCLCO9xYSYrcz1UqTyDla3lpaZ4EzLajKl0qmE
	 G2SBF8+ciGOHnSf+/wfYPkKSrCYVJ4Z8HhSkvjsFr583HrhHA55DDx1J83+QOCTTrIgcl
	 TyOkrahIzj/TN5q48fk52wxhMAwy8Z9wUBQv+0hZEvlXqRlRS7PnsKOZhuYulge9HlAug
	 BvnYFu/bdHPpTqIOMYmvFBViozI5SX7C+3lhk+ooTrkao/g4pBj1OC5qchMjh3alYUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=RGE6E1ED;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D025E606A31E;
	Thu, 29 Oct 2026 10:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D025E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=RGE6E1ED
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0g/u21OUt5SLkwjv097E9H3comvNgIEWHceOCbcl/kw=; b=RGE6E1ED1zakrjY++Y985kDUii
	nIYUy/m7RdHL/TgeyEqzOAzswyupxEIRaXvSPX6UfNGXU4rZIAYkfL7w3IBqFRmj/3J0GV/c33fw+
	0FvWAnl+NPfiat0fyNoYuYDpRoHeHq5tsqpJBBCrDhdFUBZsUdyo7UY+a1gcW1C3yF9ZooUhZd4vN
	AjJEXUXLS16TvPWgLr4rztdyeD2q+SogZcqibG37DmAn/SbzYhhutQq3yL4o89A0cHLDKB9rJjDCF
	j98oj7f4vSVT3ohh5+zGJAE92KZygkM67DY/gj8lTbcExVsp69FBM0UYIO31QGHWDSGbmouYel2pI
	49aK/Q7Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMNZM-0000000Gsep-3int;
	Thu, 29 Oct 2026 10:41:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B12BF300312; Thu, 29 Oct 2026 11:41:15 +0100 (CET)
Date: Thu, 29 Oct 2026 11:41:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [Patch v5 11/18] perf/x86/intel: Use a dedicated LBR stack for
 BPF snapshotting
Message-ID: <20261029104115.GM1779021@noisy.programming.kicks-ass.net>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-12-dapeng1.mi@linux.intel.com>
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
In-Reply-To: <20261029043914.1395147-12-dapeng1.mi@linux.intel.com>

On Thu, Oct 29, 2026 at 12:39:07PM +0800, Dapeng Mi wrote:
> BPF LBR snapshotting currently reuses the default LBR stack
> (cpuc->lbr_stack) when storing sampled data. This is unsafe when the
> BPF helper runs in PMI context via bpf_overflow_handler(): it can
> overwrite the cached LBR state for active PEBS LBR events, causing
> incorrect LBR data to be reported to userspace. When the PEBS and BPF
> stacks have different depths, this can also lead to out-of-bounds reads
> when the LBR stack is later exported.
> 
> Use a dedicated LBR stack for BPF snapshotting so the BPF path no
> longer clobbers the shared LBR state used by other perf events.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: 425507fa5f32 ("perf/x86/intel/lbr: Optimize v4 LBR unfreezing")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

AMD has the same problem, no?

> ---
>  arch/x86/events/intel/core.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 5eda551cc9f2..482a148916bf 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2819,18 +2819,24 @@ static void intel_pmu_enable_all(int added)
>  	__intel_pmu_enable_all(false);
>  }
>  
> +struct lbr_snapshot {
> +	struct perf_branch_stack stack;
> +	struct perf_branch_entry entries[MAX_LBR_ENTRIES];
> +	u64 counters[MAX_LBR_ENTRIES];
> +};
> +static DEFINE_PER_CPU(struct lbr_snapshot, lbr_snapshot);
> +
>  static noinline int
>  __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
>  				  unsigned int cnt, unsigned long flags,
>  				  int pmu_enabled, int lbr_enabled)
>  {
> -	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	struct lbr_snapshot *bpf = this_cpu_ptr(&lbr_snapshot);
>  
> -	intel_pmu_lbr_read(&cpuc->lbr_stack,
> -			   cpuc->lbr_entries, cpuc->lbr_counters);
> -	cnt = min_t(unsigned int, cnt, cpuc->lbr_stack.nr);
> +	intel_pmu_lbr_read(&bpf->stack, bpf->entries, bpf->counters);
> +	cnt = min_t(unsigned int, cnt, bpf->stack.nr);
>  
> -	memcpy(entries, cpuc->lbr_entries,
> +	memcpy(entries, bpf->entries,
>  	       sizeof(struct perf_branch_entry) * cnt);
>  
>  	/*
> -- 
> 2.34.1
> 
