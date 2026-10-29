Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269778;
	b=JTPH0UlmS5yUFJ9E9RCtkjxfGd/OgERKlsV7nbKEYzM+AU4Go6JEiyDZve+12UGL1cWk
	 BMjo4ke6nWyWVz9JsXtwRheIa/7BRpId0y/jMyfxNaE8tBiU+3Rqs+at0FRrkX03293XR
	 JkeEphEAr7ieJyJ2Cczatp/qHBT80ExENpJOd8/GpeYOse44HYUKkWWdW6PsafgzwW+db
	 3rxON53rNlE7s/XZWTiZCJ9pu4fnXcEaBJOysvFiNz/XzkM1+nalmD7aobkNEmx8o6TVR
	 v7HT82MF5JsWasQZkef1zCZ69KppGJS77CDK6kHWHkAfO17cZO/TFQWY78nPUDyFHRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269778;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=R/lMsusE19estJ9V38aj7rBdTRNza2SkNgqdcGvspKE=;
	b=szqZbV2glKv61gDiAMsRub2Qd8AswsFy61aPLXsECBvP6BmAvANvdWZCnyPINnnIF8YZ
	 V9zvDDPoFYByqR6bIz6Yllmgr3m1g7aQZPcXYjojGAqQT8zY8IHwpihY8ZbeHDLfD2LWg
	 quTtC2XHKaaAf2qDWMEmtBFs27tdfho93mMgmRZ1efV9tV26386bXWdJqfuVMGvT6gIM/
	 s4r7qpiLw/gpnF1QO+y9KtIJiu9b+h9m/DBXvsTCzNv/JY38xNhmPJi91eoMDPftw5L9c
	 9Cz2LCYXiAf94qPMhoWVE4+catOHrokzagohla6W6rfdURVZ9C7Ueznk52zQN+IrR3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=CEuiE4wh;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7A7606A327;
	Thu, 29 Oct 2026 10:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB7A7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=CEuiE4wh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R/lMsusE19estJ9V38aj7rBdTRNza2SkNgqdcGvspKE=; b=CEuiE4whPwRJOvlJT1/4ISkmaH
	yFu7mttcfqMvdF39rwvFEeePWC1/MV/Hc5CAz37LE3dpCCJaw1km5sC7VvA17QDpN6gqlY7r9DS3a
	h80CwUyehGohUljql3sUWCu0pVBe2E4cXnO4Vk20R9WTpOpQttX7EiAOIy4wTfjj50nS37nTGqq0l
	ZZeWkC9h+3vigME7XBUZ+Dj6xkA+00c+ycavd3XEAk3+SIG6G3EeRVonj/tjxtt+ViI7NWf1hkbAs
	D5ypbwrxxBPyVQVKyQNhM7GaUl9zI/u2k8hiYAA5hcBUM09GcowjtQZlrapvHz+30qs4n/gBrHQjs
	dEUyweEQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMNNz-0000000GsBu-3dyu;
	Thu, 29 Oct 2026 10:29:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 80967300329; Thu, 29 Oct 2026 11:29:30 +0100 (CET)
Date: Thu, 29 Oct 2026 11:29:30 +0100
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
Subject: Re: [Patch v5 09/18] perf/x86/intel: Keep LBR frozen throughout PMI
 handling
Message-ID: <20261029102930.GK1779021@noisy.programming.kicks-ass.net>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-10-dapeng1.mi@linux.intel.com>
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
In-Reply-To: <20261029043914.1395147-10-dapeng1.mi@linux.intel.com>

On Thu, Oct 29, 2026 at 12:39:05PM +0800, Dapeng Mi wrote:
> For the platforms which has 4+ PMU version, streamline LBR freeze is
> supported. The PERF_GLOBAL_STATUS.LBR_FRZ bit is set to freeze LBR once
> a PMU counter overflow. However, the current PMI handler clears the LBR
> freeze bit too early, allowing branch operations that occur during PMI
> handling to be recorded into the LBR stack.
> 
> This can pollute or overwrite the intended branch snapshot, especially
> when bpf_get_branch_snapshot() is invoked from bpf_overflow_handler().
> In that case, branches recorded while processing the PMI are mixed into
> the original LBR data.
> 
> Defer unfreezing until after PMI handling completes so the LBR remains
> frozen for the entire PMI path and no branch activity from the handler
> is recorded.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-179823@kernel.org/
> Fixes: 425507fa5f32 ("perf/x86/intel/lbr: Optimize v4 LBR unfreezing")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 15dcf8b78de9..a67297148bb6 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4062,7 +4062,13 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
>  	loops = 0;
>  again:
>  	intel_pmu_lbr_read();
> -	intel_pmu_ack_status(status);
> +
> +	/*
> +	 * Do not clear the LBR frozen status here; keep LBR frozen
> +	 * throughout PMI handling.
> +	 */
> +	intel_pmu_ack_status(status & ~GLOBAL_STATUS_LBRS_FROZEN);
> +
>  	if (++loops > 100) {
>  		static bool warned;
>  
> @@ -4081,10 +4087,13 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
>  	 * Repeat if there is more work to be done:
>  	 */
>  	status = intel_pmu_get_status();
> -	if (status)
> +	if (status & ~GLOBAL_STATUS_LBRS_FROZEN)
>  		goto again;
>  
>  done:
> +	if (status & GLOBAL_STATUS_LBRS_FROZEN)
> +		intel_pmu_ack_status(status & GLOBAL_STATUS_LBRS_FROZEN);
> +
>  	if (mid_ack)
>  		apic_write(APIC_LVTPC, APIC_DM_NMI);
>  	/* Only restore PMU state when it's active. See x86_pmu_disable(). */

Given the whole PMU is disabled per __intel_pmu_disable_all(), all that
can really happen is for more bits to be set, right? I mean, any counter
cleared on the first ack_status, will never be re-set, it already fired
and its disabled. All that can happen is that the disable is 'delayed'
and a counter can maybe fire a little bit after the disable; getting
missed on the first go.

Can we really get more than 1 extra loop there?

I'm sure this code has changed lots since we added that loop thing
there.

Anyway, if we can never get more than 1 extra loop, we can probably move
the ack to the end, without having to do a second.

I suppose this isn't something you have to do now, but keep it on the
todo list or something?
