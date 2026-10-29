Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793266733;
	b=ZIoTKBH2Zlwjz5SzG7QQrYkLI3qM7LhQ6Yh/tVIBuyqxN0ucmsimZ0v8S3iikBMU8jqF
	 kKPaQuF6/7Z8VJqq40UqyrbAiAlm6Y9LW14Y99IkT0ygJVcn9p/tuZH+kF5kZ/UIMi2aX
	 yk2Wlc6+oCfD9tq6hHLTUIbxKRvLKD0hxwfOra0MBYlDoo26koQ9bpwViFIV4Uhm69OWa
	 jgITa2jmUN5hldjYmpjMlHXkoYlfyNeFYM0bQ1Pm2xKPXFm2t2iSsgP/dzpAkOTGaH2ry
	 0XUgQ7QkEjtkCNQ0GOn9Z9PO5Fgbldkc1++MuraDMDT4UREz+NjQ3Oyi6rBC83b4fYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266733;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=O6fMYNtC9RTyLNGcKh+OsCLCtLPr6yKMhTz4SqrIi94=;
	b=WFKCwhBprZun95yisLgdew3PPpoWGOICv0Qp8StyIVXHsJcj7MqnhI+zjwf8I4l4qoD1
	 QCEALVj10zrXSmgdHEnQh3TX4xV3ZbR59CVrhmZJIrW4fiaOQGAuL49QjnF33JTQQBbjF
	 7PW926G4l5iSuJZFTinQHIJjf7ryvau+t1KDiaL/Vnx/7fZzlndjsklWIK2sJ+I/067U0
	 2+q/4CZGnDZCCfpCTj2lHVyW1F28452QvfqaEEzIaGd+st/SfRXGGsCMZuJqSlKRgh9yc
	 U4WlUoSBzj7SEdgWIg7rS3l7enj7UD9uJNQu+KWm70w01sQMdWpPkfWISGESMSBx44Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=qeF5aB+b;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3071E606A31A;
	Thu, 29 Oct 2026 09:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3071E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=qeF5aB+b
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O6fMYNtC9RTyLNGcKh+OsCLCtLPr6yKMhTz4SqrIi94=; b=qeF5aB+bkd0o57rvCaHQwkWE9N
	RMVf0GZCBfef0UVq6/YpoeokqY38SjV/wsdbhSYakF2ELsOOpIeULAsYA82T4Bl7xxlzUf+Woo+lB
	JHZmvo1y/NB+3OUqsd9fWOPQZ3qEiIxuIKJkpdOYf3zeLdnUqc0uUitgHr4AaiVb3swrPQB2dYPbi
	v8Zlq0atfT6YPUv8psUG8GBZ89gLXh9XUfIYZpo+HsbOMz62goC/tge6sz9yRGs9RuLMcEOsywsDU
	pFnh5xXyqlUbgLoLm08YgVhaU/dhc5SnXPHUXTsLcpmicLhqnh1S7tG94Ou9iTBw2cQZtE2Oy1dg2
	CuPnQCug==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMMas-0000000Gpb8-38Ju;
	Thu, 29 Oct 2026 09:38:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AA74A300312; Thu, 29 Oct 2026 10:38:45 +0100 (CET)
Date: Thu, 29 Oct 2026 10:38:45 +0100
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
Subject: Re: [Patch v5 01/18] perf/x86: Disable LBR if x86_pmu.lbr_nr exceeds
 MAX_LBR_ENTRIES
Message-ID: <20261029093845.GI1779021@noisy.programming.kicks-ass.net>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-2-dapeng1.mi@linux.intel.com>
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
In-Reply-To: <20261029043914.1395147-2-dapeng1.mi@linux.intel.com>

On Thu, Oct 29, 2026 at 12:38:57PM +0800, Dapeng Mi wrote:
> Add a sanity check for x86_pmu.lbr_nr. If the hardware reports more LBR
> entries than MAX_LBR_ENTRIES, disable LBR to avoid out-of-bounds access
> in the cached LBR stack handling path.

Cute, can this actually happen?

> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/amd/lbr.c    | 8 +++++++-
>  arch/x86/events/intel/core.c | 7 +++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
> index a55646fcb846..96c5b5e56053 100644
> --- a/arch/x86/events/amd/lbr.c
> +++ b/arch/x86/events/amd/lbr.c
> @@ -433,7 +433,13 @@ __init int amd_pmu_lbr_init(void)
>  	ebx.full = cpuid_ebx(EXT_PERFMON_DEBUG_FEATURES);
>  	x86_pmu.lbr_nr = ebx.split.lbr_v2_stack_sz;
>  
> -	pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
> +	if (x86_pmu.lbr_nr > MAX_LBR_ENTRIES) {
> +		pr_warn("LBR entries %d exceeds max %d, disable LBR.\n",
> +			x86_pmu.lbr_nr, MAX_LBR_ENTRIES);
> +		x86_pmu.lbr_nr = 0;
> +	} else {
> +		pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
> +	}
>  
>  	return 0;
>  }
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 0a34d674df59..10c694db85ea 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -9023,6 +9023,13 @@ __init int intel_pmu_init(void)
>  	 */
>  	if (x86_pmu.lbr_tos && !check_msr(x86_pmu.lbr_tos, 0x3UL))
>  		x86_pmu.lbr_nr = 0;
> +
> +	if (x86_pmu.lbr_nr > MAX_LBR_ENTRIES) {
> +		pr_warn("LBR entries %d exceeds max %d, disable LBR.\n",
> +			x86_pmu.lbr_nr, MAX_LBR_ENTRIES);
> +		x86_pmu.lbr_nr = 0;
> +	}
> +
>  	for (i = 0; i < x86_pmu.lbr_nr; i++) {
>  		if (!(check_msr(x86_pmu.lbr_from + i, 0xffffUL) &&
>  		      check_msr(x86_pmu.lbr_to + i, 0xffffUL)))

Would it make sense to have but one copy of this check in
init_hw_perf_events(), after calling into the micro-arch code?
