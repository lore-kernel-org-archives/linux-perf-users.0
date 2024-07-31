Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F88812B93;
	Wed, 31 Jul 2024 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445175; cv=none; b=GRroKANLPSg9MMzWAiZQK3c+e4uU1utvpll/vs/5OWKbewlphGVPXcbg5CXAmTnl0bSL1Y/GAlzpc7gqTgCXJf7rLPNR3SMHMIyep/AluocGqmHSMycluBEV75VejqHu4Ytxsop3voQsKxQRK47o6VtOgMx6DXO/4+G2JhrBNTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445175; c=relaxed/simple;
	bh=T5X6f1K32kns6RA907bQ7f9UBfa+XyFbsVazMXgTJjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y59iK/Jyc7yqe/NA2kQyrJZ8YISf60Z0bCtzWV0vY5ub8J1/oNe6t51T/uCTXIjthnCQqUuxfTNK29CK8b0AzD8AnRfWI7fujxzvrEpCw9JdYIQna6UB0BJTPcCfnk/+BdxqESfgF+Kuii2Ixa1iN+O8ajZ2V1eY5yroxZichbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ranQsrYo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ranQsrYo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2E1C116B1;
	Wed, 31 Jul 2024 16:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722445174;
	bh=T5X6f1K32kns6RA907bQ7f9UBfa+XyFbsVazMXgTJjs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ranQsrYoiFptE6K5ltsv9xIHf3Fzj2Xdwn2IeZte4tyMx2M7NmlykzZgN404c24Pf
	 guLctRh8JL2GzfRjKmn+Au1ksbHvljOHJ1dC4JlSo0IZCiadoIc+yRL8CGNmtHFbTK
	 vmz8bt2ByO2hh0UcBhH5C0lhB2wqF8BK0zSzJ+PuOGikynxBEKYa29nCNiNTTSakWx
	 8tjBNkYDqzYL8O+N/0Hi+XZFP8qD7+ICHQpcshWGqsJhi3RYKVOBMrz0pfvnAVK1Z+
	 xbQfani5f42Ma1imuCC6MehiZzOIjfs3+1Vhii5wanWA4aX9WWkO1FVELDNccZRfru
	 jHeIEIN8AhPhQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 60170CE0A01; Wed, 31 Jul 2024 09:59:34 -0700 (PDT)
Date: Wed, 31 Jul 2024 09:59:34 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
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
	Sandipan Das <sandipan.das@amd.com>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] perf/x86/amd: Warn only on new bits set
Message-ID: <de55c0e0-0a1b-449a-94f5-56d4ef3fc3b5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240731154651.1555511-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731154651.1555511-1-leitao@debian.org>

On Wed, Jul 31, 2024 at 08:46:51AM -0700, Breno Leitao wrote:
> Warning at every leaking bits can cause a flood of message, triggering
> vairous stall-warning mechanisms to fire, including CSD locks, which
> makes the machine to be unusable.
> 
> Track the bits that are being leaked, and only warn when a new bit is
> set.
> 
> That said, this patch will help with the following issues:
> 
> 1) It will tell us which bits are being set, so, it is easy to
>    communicate it back to vendor, and to do a root-cause analyzes.
> 
> 2) It avoid the machine to be unusable, because, worst case
>    scenario, the user gets less than 60 WARNs (one per unhandled bit).
> 
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Reviewed-by: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Nice!!!

A question about an admittedly unlikely race below.

> ---
> Changelog:
> v2:
>   * Improved the patch description, getting the benefits in words.
> 
> v1:
>   * https://lore.kernel.org/all/20240524141021.3889002-1-leitao@debian.org/
> 
> 
>  arch/x86/events/amd/core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 920e3a640cad..577158d0c324 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -943,11 +943,12 @@ static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, u
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
> @@ -1012,7 +1013,11 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
>  	 * the corresponding PMCs are expected to be inactive according to the
>  	 * active_mask
>  	 */
> -	WARN_ON(status > 0);
> +	if (status > 0) {
> +		new_bits = atomic64_fetch_or(status, &status_warned) ^ atomic64_read(&status_warned);

It is possible that two CPUs could execute the above line concurrently,
correct?  In that case, the reports might be a bit confused.

Why not be exact, perhaps as follows, introducing a "u64 prev_bits"?

		prev_bits = atomic64_fetch_or(status, &status_warned);
		new_bits = status & ~prev_bits;

Or, if you would like to avoid the added variable and to keep this to
a single line:

		new_bits = status & ~atomic64_fetch_or(status, &status_warned);

Or is my boolean arithmetic off this morning?  (Wouldn't be the first
time...)

							Thanx, Paul

> +		// A new bit was set for the very first time.
> +		WARN(new_bits, "New overflows for inactive PMCs: %llx\n", new_bits);
> +	}
>  
>  	/* Clear overflow and freeze bits */
>  	amd_pmu_ack_global_status(~status);
> -- 
> 2.43.0
> 
