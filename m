Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEBC372EC0;
	Mon, 12 Oct 2026 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819025; cv=none; b=VJXDB8ziFxDYOYMTcq9hVjc/Qt3cIMeKKc1sKHraML78Qrm9JuQ/KVxZLFOQGKemEL9Gt/iY3P4/b0dNTdNEodSz0zg92hkj802qHLIeu+CK+KsoBYtGH69RoEKw9eJayZyo9uxjEMT6jhcSkubuYoaPlKJRXTdXY+hk//tC0XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819025; c=relaxed/simple;
	bh=dNylLoKi8RBSUwXF/JjHMpiUkq5fTCS1c9Ln8jRG7+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Epd7y4NcJImumThX19AUV+kGhzpvYxxgqfi3SmzNdhiiRyVMRrWgf3cQCo6AcCyTSHwGxp0WUANXrnYlM0p/JszYOyJi5jKRAU5IhggkmL9RSdkjfN9P+22zYknORJFmhYZgcBEx5xXFwzG72/bqV877C0B2oPDmeBR07C8Y8yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HTcLs3Sd; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HTcLs3Sd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e7vnY38Ok46IN7dLJiR4A9dOlKWJTcpeT6vTfLbFeYA=; b=HTcLs3Sda32VW2HZSIi79a9j4u
	wEkDHaykiaIIGma0cUValLNCOTaqZLu2Fc1MVgu47Q5fmH61ii2VHTWTHGn0w7Iu4yHefb91M6R00
	GILYCg/nZzsRt+54DceKPHW+NKOghSrDZPYfG+TI76Yk8OFxW0YfZbCcZuyHMyMcAOCHmpUuJSp16
	5EmvhF9BeOomBlA1HIJJZSjOsI0KU9tTpxdRaHibVVrg1GowIqwMz6neMo/gkgdZXxCoDPPuDdykb
	TaS2GE8YPtCQnDFAvbNkhb2XpLTvkWD7Rn5adSKgMUXjOtG80S/gU2ZA/geHQD768YlxIkbpMw+NZ
	Jbw69p3Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGHyh-0000000Ea1I-13Cb;
	Mon, 12 Oct 2026 15:30:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1B9CF30045A; Mon, 12 Oct 2026 17:30:14 +0200 (CEST)
Date: Mon, 12 Oct 2026 17:30:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Subject: Re: [PATCH] perf/x86/amd/lbr: Limit branch snapshots to valid entries
Message-ID: <20261012153014.GU4121339@noisy.programming.kicks-ass.net>
References: <20261007181002.4005262-1-sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007181002.4005262-1-sandipan.das@amd.com>

On Wed, Oct 07, 2026 at 11:40:02PM +0530, Sandipan Das wrote:
> The branch snapshot callback used by bpf_get_branch_snapshot() copies
> up to x86_pmu.lbr_nr entries from cpuc->lbr_entries[], even when the
> last LBR read kept fewer branches. The entries past lbr_stack.nr are
> invalid, but they end up reaching BPF programs.
> 
> Limit copying to lbr_stack.nr entries and also reset lbr_stack.nr when
> amd_pmu_lbr_read() skips reading the registers, so that a stale count
> is never reused.
> 
> Fixes: a4d18112e531 ("perf/x86/amd: Support capturing LBR from software events")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-163130@kernel.org/
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> ---
>  arch/x86/events/amd/core.c | 2 +-
>  arch/x86/events/amd/lbr.c  | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 49b6b8fce566..bf631f60757c 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -944,7 +944,7 @@ static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, u
>  	cpuc = this_cpu_ptr(&cpu_hw_events);
>  
>  	amd_pmu_lbr_read();
> -	cnt = min(cnt, x86_pmu.lbr_nr);
> +	cnt = min(cnt, cpuc->lbr_stack.nr);
>  	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
>  
>  	amd_pmu_v2_enable_all(0);
> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
> index 1e1b2f08cb51..a00d3850c4a8 100644
> --- a/arch/x86/events/amd/lbr.c
> +++ b/arch/x86/events/amd/lbr.c
> @@ -165,8 +165,10 @@ void amd_pmu_lbr_read(void)
>  	struct branch_entry entry;
>  	int out = 0, idx, i;
>  
> -	if (!cpuc->lbr_users)
> +	if (!cpuc->lbr_users) {
> +		cpuc->lbr_stack.nr = 0;
>  		return;
> +	}
>  
>  	for (i = 0; i < x86_pmu.lbr_nr; i++) {
>  		entry.from.full	= amd_pmu_lbr_get_from(i);

You now seem to deviate from what the Intel code does. Please clarify.
