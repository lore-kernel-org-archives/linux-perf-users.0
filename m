Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47F93B7B84;
	Tue, 13 Oct 2026 07:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877605; cv=none; b=cDcJjdrBhNOsZ+cFPpO0RufaQg5Fmq5/QGkGjv47Rc/ihiEgIVM3bAJGUE+H1mOUgf1ffkMpdw6SQ8rhCcMxhMthscO6D2f2CeB4jCSeJbHrEf9RetF0Ogexrru7patjVN6ljONCH9pXJhFuknj7+rW3dgrqWvsTGofzv4ylJvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877605; c=relaxed/simple;
	bh=kqh5UWkz+aPn66PWCf11QsrGKC2RTfd46/Fypr8xPVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCiWuSQc7+y7b8shAaDhf9tPNxuuVNtEe4SdkSQJ+L63Kr0OX/NqycWOO+lDB2cW7gv0pZY+e2aArrDJ5JwX3bTFB2Bbs0VYrG0gtcmO1qspFzizL9FcKZiql/pDWTML3SdfofWsGEWS1mDsxmQld3RTxEIEcoA+4ptPB2PhGbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IyoaCRer; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IyoaCRer"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5ZEZzELnvolUpIyeLg3RxehH4NULQswA+ln1L1k4RHc=; b=IyoaCRerLeEfiuhfSoY65l6DFt
	Mq//JqhMgq3kLLt8B7JlDsgQYPhuC77JDFtsliGBjyOp6hq48KEjh2kmyeeBOUp2iotWvdOY5JU+c
	KDBxIQeOJxviQFAWI8oF3+sU+DH/MyF+jJAbmc9jLWp0gfwEKly3G05GQelJQGvZG5qa4S8amIc7l
	TMcEK2MYNedqkesnoOAiOnnfhHBWKXKa7nxBil6ZiKO8X9gvUFDkwuQ2iis8x6kpAvktaayoLt0mj
	bxgalyDd4nOkb7ccIEnska9KY684HRxsbpsXDByNCsemFr158/yC2ij+37Tph66nlmxgGz5Vzo+lr
	VKMTNsog==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGXDP-0000000FDQO-1ttG;
	Tue, 13 Oct 2026 07:46:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 939DC30063F; Tue, 13 Oct 2026 09:46:25 +0200 (CEST)
Date: Tue, 13 Oct 2026 09:46:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sandipan Das <sandipan.das@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
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
Message-ID: <20261013074625.GC2009045@noisy.programming.kicks-ass.net>
References: <20261007181002.4005262-1-sandipan.das@amd.com>
 <20261012153014.GU4121339@noisy.programming.kicks-ass.net>
 <94d387f2-ff07-4895-a722-e8ded4203309@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94d387f2-ff07-4895-a722-e8ded4203309@amd.com>

On Tue, Oct 13, 2026 at 12:14:58PM +0530, Sandipan Das wrote:
> On 12-10-2026 21:00, Peter Zijlstra wrote:
> > On Wed, Oct 07, 2026 at 11:40:02PM +0530, Sandipan Das wrote:
> >> The branch snapshot callback used by bpf_get_branch_snapshot() copies
> >> up to x86_pmu.lbr_nr entries from cpuc->lbr_entries[], even when the
> >> last LBR read kept fewer branches. The entries past lbr_stack.nr are
> >> invalid, but they end up reaching BPF programs.
> >>
> >> Limit copying to lbr_stack.nr entries and also reset lbr_stack.nr when
> >> amd_pmu_lbr_read() skips reading the registers, so that a stale count
> >> is never reused.
> >>
> >> Fixes: a4d18112e531 ("perf/x86/amd: Support capturing LBR from software events")
> >> Reported-by: Sashiko <sashiko-bot@kernel.org>
> >> Closes: https://lore.kernel.org/all/sashiko-outbox-163130@kernel.org/
> >> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> >> ---
> >>  arch/x86/events/amd/core.c | 2 +-
> >>  arch/x86/events/amd/lbr.c  | 4 +++-
> >>  2 files changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> >> index 49b6b8fce566..bf631f60757c 100644
> >> --- a/arch/x86/events/amd/core.c
> >> +++ b/arch/x86/events/amd/core.c
> >> @@ -944,7 +944,7 @@ static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, u
> >>  	cpuc = this_cpu_ptr(&cpu_hw_events);
> >>  
> >>  	amd_pmu_lbr_read();
> >> -	cnt = min(cnt, x86_pmu.lbr_nr);
> >> +	cnt = min(cnt, cpuc->lbr_stack.nr);
> >>  	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
> >>  
> >>  	amd_pmu_v2_enable_all(0);
> >> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
> >> index 1e1b2f08cb51..a00d3850c4a8 100644
> >> --- a/arch/x86/events/amd/lbr.c
> >> +++ b/arch/x86/events/amd/lbr.c
> >> @@ -165,8 +165,10 @@ void amd_pmu_lbr_read(void)
> >>  	struct branch_entry entry;
> >>  	int out = 0, idx, i;
> >>  
> >> -	if (!cpuc->lbr_users)
> >> +	if (!cpuc->lbr_users) {
> >> +		cpuc->lbr_stack.nr = 0;
> >>  		return;
> >> +	}
> >>  
> >>  	for (i = 0; i < x86_pmu.lbr_nr; i++) {
> >>  		entry.from.full	= amd_pmu_lbr_get_from(i);
> > 
> > You now seem to deviate from what the Intel code does. Please clarify.
> 
> Yes, it is a deviation. I thought of proposing the following but didn't
> proceed because I was not sure about the if condition in the second hunk
> which considers things other than cpuc->lbr_users for an early return.

Dapeng, can you look into this? I would really like to keep behaviour
consistent where possible.

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 0a34d674df59..5dfb9e9156e8 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2822,7 +2822,7 @@ __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
>         struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> 
>         intel_pmu_lbr_read();
> -       cnt = min_t(unsigned int, cnt, x86_pmu.lbr_nr);
> +       cnt = min_t(unsigned int, cnt, cpuc->lbr_stack.nr);
> 
>         memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
>         intel_pmu_enable_all(0);
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 0b446d8912e4..6b070490f461 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -1026,8 +1026,10 @@ void intel_pmu_lbr_read(void)
>          * but this simple approach seems to work for now.
>          */
>         if (!cpuc->lbr_users || vlbr_exclude_host() ||
> -           cpuc->lbr_users == cpuc->lbr_pebs_users)
> +           cpuc->lbr_users == cpuc->lbr_pebs_users) {
> +               cpuc->lbr_stack.nr = 0;
>                 return;
> +       }
> 
>         x86_pmu.lbr_read(cpuc);
> 
