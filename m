Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E612A1C5;
	Tue,  6 Aug 2024 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722966427; cv=none; b=tdi73QpPhtU4YwJZkyLWvIu6RFTybJDxFc43lZ3qybmSi78gomSnOIA1hDyBpDLYOBM5WNvHg6l/tk9hukcQs2SuQbAJOswV3jAsaTC0JG7h791J4c+mkez1wGRKHmwgZ6F7mEZYY9KaLIokpH+PsfK5nld/rpCT5+sWKhJJvlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722966427; c=relaxed/simple;
	bh=cAgxLRUonxQ14zEMn94zwCIcLctgqYrtfxpI11Fy8wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCS6DLgjmWKjkh67zc876ClACk8Mr4mYLf85HU1EKuFBId9NSlMfRnUtA1SkbcgEcDSKtWQ8LSUEWRDQeZUg1AkYc3n1TUojXdSu8jrhF38/XwVCRCAbLN6gHeoOm5GJur9vpV5ikkxL8LNCwqcVSxFs8Tjl/5pUj5jOZTu617I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fx5GUAKM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fx5GUAKM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C87C4AF0D;
	Tue,  6 Aug 2024 17:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722966427;
	bh=cAgxLRUonxQ14zEMn94zwCIcLctgqYrtfxpI11Fy8wc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Fx5GUAKMYrw01E2NOQ1E8mDP+Pa2FREQ9xmrdnvI2JRpi70zNRNst9qUE1XYbQ5OS
	 XPI87A12VeS0VVT4UNmPKi37STUZS7hV9suOSoVBhd9YJqSkYsL2V8xHZYl0n+d9DH
	 T0xYjgL+2ev68pfV1bvqczTVO5nh9pzopTZawUilCCbuWUXJ+32HHZp6YV8/A2FbN/
	 E+VUMFFhZt7uTXiYZCtctn8zWetrN08YxonF11rLBlEVPJ01zzse+0skxpZmjpL4G5
	 kd0G1xvmJnPkRtbiI0NCi/1/Wg9SepT9nuEGezK8JPzS+bDZawHomCYoaPVrz3pEyP
	 l9Zch34CqgXOA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DEAE2CE0A72; Tue,  6 Aug 2024 10:47:06 -0700 (PDT)
Date: Tue, 6 Aug 2024 10:47:06 -0700
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
Subject: Re: [PATCH v3] perf/x86/amd: Warn only on new bits set
Message-ID: <3bbb2f65-7305-4e02-942a-484def3a04a3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240806165848.3397232-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806165848.3397232-1-leitao@debian.org>

On Tue, Aug 06, 2024 at 09:58:48AM -0700, Breno Leitao wrote:
> Warning at every leaking bits can cause a flood of message, triggering
> various stall-warning mechanisms to fire, including CSD locks, which
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

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
> Changelog:
> v3:
>  * Avoid potential false reporting when concurrent execution occurs on
>    different CPUs (Paul E. McKenney)
> 
> v2:
>   * Improved the patch description, getting the benefits in words.
>   * https://lore.kernel.org/all/20240731154651.1555511-1-leitao@debian.org/
> 
> v1:
>   * https://lore.kernel.org/all/20240524141021.3889002-1-leitao@debian.org/
> 
> 
>  arch/x86/events/amd/core.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 920e3a640cad..b4a1a2576510 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -943,11 +943,12 @@ static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, u
>  static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	static atomic64_t status_warned = ATOMIC64_INIT(0);
> +	u64 reserved, status, mask, new_bits, prev_bits;
>  	struct perf_sample_data data;
>  	struct hw_perf_event *hwc;
>  	struct perf_event *event;
>  	int handled = 0, idx;
> -	u64 reserved, status, mask;
>  	bool pmu_enabled;
>  
>  	/*
> @@ -1012,7 +1013,12 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
>  	 * the corresponding PMCs are expected to be inactive according to the
>  	 * active_mask
>  	 */
> -	WARN_ON(status > 0);
> +	if (status > 0) {
> +		prev_bits = atomic64_fetch_or(status, &status_warned);
> +		// A new bit was set for the very first time.
> +		new_bits = status & ~prev_bits;
> +		WARN(new_bits, "New overflows for inactive PMCs: %llx\n", new_bits);
> +	}
>  
>  	/* Clear overflow and freeze bits */
>  	amd_pmu_ack_global_status(~status);
> -- 
> 2.43.5
> 
