Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793266851;
	b=psmBqS/l+BwzgwaEEL0fzuIR38NYGmGb0sikd3GFGrq4iLqRpHrCcAxOd6w5LxUPBewo
	 g9SXLwSldSjrdH4tlTCX7Qmtm9VAtsLHeMbqWqqZzKyEN1zYYpg/X5P0S7qF3O6l3x+WZ
	 Cbtf5tr0ERTTJJkE2XpsKtymXeRtykmbKcL1kzdZsD1tB925VDYJB5OiSAe/5Lt7pgp+A
	 sZmLxYlUFSj6nlveiIBz3TawpbC5+RN59o1wvW5R9V2NMlDi/tPdOJoNcCQ7wL2Fec+nA
	 dAxqnpkJopqmk9yBOIadnz3n3llSuGmZyV+x2Vrn7j0XHKEu56wCUm0LOPtHeHihS5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266851;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=WehD4D0lGL1tjwM58dul7G6t9gPl0FSp8uFA/ummXEA=;
	b=RZIldATyf2tbdBsqewXQ+gm/l5aUU8kjalvuf259nqiJXjyJ5qhVTd/hgPpKncWgfLUF
	 /WLBurNn2YHN7tX0uFLqCmOIbNZAIIm/oniYS2R1jAETGXuZHoKYig8hF9+8aiwSYaf37
	 a8ciaj696ET2rFFjLumEPIOl2EXo2B71pw0+BYjgUgrh/nVA9xtuu+c6Hg1px3Qrq1BQc
	 1k17PFLesl38e3TcLIrgCClKKrhJDdS9EfJIQHI88V0d4zPmM9x2g9eWunHqvsAhYTzrY
	 6D3S3huI4Rk6ERzHZJyY6HjnDNPstO2krACW88VA8oWM1WFHYVKC0lW+8T0LoGg/Qkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b="aInJ9L/z";
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFED606A31A;
	Thu, 29 Oct 2026 09:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EFED606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=aInJ9L/z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WehD4D0lGL1tjwM58dul7G6t9gPl0FSp8uFA/ummXEA=; b=aInJ9L/zPb64UJ/IoafbEV5KW7
	lot0wOO6r9+2jrB696VTye43kCdEo9WgInWtx7aQao1sNwon74fggE7QyRtCzWQ53v35BZ7hLkDhD
	A9mmTzdRa4wm5xUW9Yq1rDWO7taqIzr0mUAxK40rCafDvZ6++CvalJbTNBf7JuOzEQ4oqLTLYKkpM
	+dPJDXV6+dm1fSJtB6Nl9ZgZhAUUTam+HG7mmnAiEnzoo+h4gekcMXIWQJeykUOdY4du0oQLWIcB0
	EiaSA9qfkZFYNcFc42Qm2GWOHG6dTD6o5f4nG5vc4yLGkiIGvWHyivFOnqnZ8BYyRwQhbHI55cL8e
	DUYT6cLw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMMcn-0000000E9Bu-0fK0;
	Thu, 29 Oct 2026 09:40:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A238B300312; Thu, 29 Oct 2026 10:40:44 +0100 (CET)
Date: Thu, 29 Oct 2026 10:40:44 +0100
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
Subject: Re: [Patch v5 02/18] perf/x86/intel: Validate LBR XSAVE state before
 updating LBR stack
Message-ID: <20261029094044.GJ1779021@noisy.programming.kicks-ass.net>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-3-dapeng1.mi@linux.intel.com>
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
In-Reply-To: <20261029043914.1395147-3-dapeng1.mi@linux.intel.com>

On Thu, Oct 29, 2026 at 12:38:58PM +0800, Dapeng Mi wrote:
> intel_pmu_arch_lbr_read_xsave() doesn't check if the LBR data is present
> in the xsave area. If LBR data is in the INIT state, the LBR data may not
> be really written into the xsave area.
> 
> Add an explicit LBR XSAVE state presence check before updating the cached
> LBR stack. Also clear the cached LBR stack when intel_pmu_lbr_reset() is
> called, in addition to resetting the hardware LBR register file, to prevent
> stale LBR data from being reused after a context switch or similar
> transition.
> 
> Fixes: c085fb877467 ("perf/x86/intel/lbr: Support XSAVES for arch LBR read")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/lbr.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 0b446d8912e4..a2e4ba7e1a4f 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -193,6 +193,8 @@ void intel_pmu_lbr_reset(void)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  
> +	cpuc->lbr_stack.nr = 0;
> +
>  	if (!x86_pmu.lbr_nr)
>  		return;
>  

This also clears the stack if there is no LBR; was that on purpose? The
Changelog is silent on this point.

> @@ -1010,9 +1012,15 @@ static void intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc)
>  		intel_pmu_store_lbr(cpuc, NULL);
>  		return;
>  	}
> +	xsave->header.xfeatures = 0;
>  	xsaves(&xsave->xsave, XFEATURE_MASK_LBR);
>  
> -	intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
> +	if (xsave->header.xfeatures & XFEATURE_MASK_LBR) {
> +		intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
> +	} else {
> +		/* Clear the LBR stack to avoid leaking stale entries. */
> +		cpuc->lbr_stack.nr = 0;
> +	}
>  }
>  
>  void intel_pmu_lbr_read(void)
> -- 
> 2.34.1
> 
