Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793271389;
	b=G4cdIqWXFCJ6SFNp+Bune9Ju5NEPW2sEEMV8SbQDah25C8r07u5NbSJw1taKfzt6h08B
	 HsJ3e5xrPsa2C7Qin+6XRVbj8iAFO1Jk6wU4OAP2CPHyR32t9yBIU//u0lmAY20+GzGqm
	 zDux64Db+Abr0lKs9HXuCTqTwOPKBiXd098VuoLMduknpHilW1VAwDZlY6LHuOJAmec8R
	 kWT3YcFlM7wYu3G+dmm8gomOshxqZce2+bVhbZGXqO0okCWf63V9Z+zHitGTbaAzgF0p4
	 Mf0Xw1w3BkQfx1dkBGrVxxl0LyaqZO5R89jmKKKWUPJozE3jREJDHrLvsFG1HauW1KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271389;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=NSH1x3BBzRaE3Cv0AWjNvraojxbNU18l90OOGfS9A2Y=;
	b=1NWZ8oGr4MNTsw//ty7YKfPJZ1o9Vdl0KAqgxH65Ek3XCjcAu5NIpTKFfsKSlW+wxt4p
	 9BiMcZQhKAaaKGjJT1B+1Erm6K/jFEdzTMPiianAiJvS5UQ11IdsiXQync5YT5iwWF8VT
	 1QZkmK79LJWOEh992D6iI7g/CiSq9Qh+tiyawdIIkVlz7xoOCp85seJzbFZBfaEqooXQD
	 aPyUv/nRlqf91bzz900zRa6Fp0oVeoz2aKXId1hHUKnshslXXHJzuCpyryc5I+8lpu7q3
	 G/UKHmXgsoOaB9T0OqJfme1+NrcS+rrtda7fseKtfW2KQTKer2icownmjeKziq9YC0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=ZtHFyEA3;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D37B606A31C;
	Thu, 29 Oct 2026 10:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D37B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=ZtHFyEA3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NSH1x3BBzRaE3Cv0AWjNvraojxbNU18l90OOGfS9A2Y=; b=ZtHFyEA3C/+nbaEYKk5V6u5/sL
	lusa/FqrGhQT1DM+5uAYDsypSDZ4s0jtNfd8Awwk/n7KulUH563jE6UichpR33E6RjoADmBRGBpVR
	0+f7D3WxikPIws1AXFfYTcyKgAVmE0mG5fDsx7OXIw7wri8SzDQDEJBlV6HX1MgpIiePbCBAwooQ6
	Y9YJbAcSksVVVtAZUq+qF6Kxc03uezib/14nWta4ChLq7UHaG7AK3fBjAKUnDRmq6etqjs3TeqfuC
	+aMyk8/oibWF1BdP6QLo+0jUBSPMZqydB49ED7Zao75uKaYStuLzvS70XRDRQk+/AlBv5SLxv76r8
	d/XfEJRA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMNo0-0000000GtOk-0Sam;
	Thu, 29 Oct 2026 10:56:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F22413011E4; Thu, 29 Oct 2026 11:56:22 +0100 (CET)
Date: Thu, 29 Oct 2026 11:56:22 +0100
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
	Xudong Hao <xudong.hao@intel.com>
Subject: Re: [Patch v5 12/18] perf/x86/intel: Always snapshot live hardware
 LBR state for BPF
Message-ID: <20261029105622.GN1779021@noisy.programming.kicks-ass.net>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-13-dapeng1.mi@linux.intel.com>
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
In-Reply-To: <20261029043914.1395147-13-dapeng1.mi@linux.intel.com>

On Thu, Oct 29, 2026 at 12:39:08PM +0800, Dapeng Mi wrote:
> __intel_pmu_snapshot_branch_stack() is intended to capture the current
> live hardware LBR state for the BPF path. However, that snapshot is
> currently skipped when all LBR users are PEBS events.
> 
> BPF LBR snapshotting now uses its own dedicated LBR stack, so there is
> no longer a risk of clobbering the shared default LBR stack. As a
> result, always snapshot the live hardware LBR state for the BPF path.
> 
> Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c | 10 ++++++++--
>  arch/x86/events/intel/lbr.c  |  9 ---------
>  2 files changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 482a148916bf..110fff65bd50 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4069,8 +4069,14 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
>  
>  	loops = 0;
>  again:
> -	intel_pmu_lbr_read(&cpuc->lbr_stack,
> -			   cpuc->lbr_entries, cpuc->lbr_counters);
> +	/*
> +	 * No need to read the LBR stack when all LBR users are PEBS events,
> +	 * since the PEBS handler updates it.
> +	 */
> +	if (cpuc->lbr_users != cpuc->lbr_pebs_users) {
> +		intel_pmu_lbr_read(&cpuc->lbr_stack,
> +				   cpuc->lbr_entries, cpuc->lbr_counters);
> +	}
>  
>  	/*
>  	 * Do not clear the LBR frozen status here; keep LBR frozen
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 63f0504f9d2a..790580f96040 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -1050,15 +1050,6 @@ void intel_pmu_lbr_read(struct perf_branch_stack *lbr_stack,
>  		return;
>  	}
>  
> -	/*
> -	 * Don't read when all LBRs users are using adaptive PEBS.
> -	 *
> -	 * This could be smarter and actually check the event,
> -	 * but this simple approach seems to work for now.
> -	 */
> -	if (cpuc->lbr_users == cpuc->lbr_pebs_users)
> -		return;
> -
>  	x86_pmu.lbr_read(cpuc, lbr_stack, lbr_entries);
>  
>  	intel_pmu_lbr_filter(cpuc, lbr_stack, lbr_entries, lbr_counters);

AFAICT AMD could be similarly modified, it currently unconditionally
reads the LBR stack, irrespective of lbr_users.
