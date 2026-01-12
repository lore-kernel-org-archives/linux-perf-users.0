Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A00B2BEC34;
	Mon, 12 Jan 2026 10:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768213641; cv=none; b=qk5+Uc1wIg+LuGNoxlmhxl5rk6h6A5khbnjt8kPUr/En13Ojl05+n4vPDOY0OJOuj+gYNrvZ59B2tvIpTkyifjW8YxRj84riQzO8nb2Lx+kq/lfy+4GwvRc16fwe7dkgs5vGaYE7tiy88vkfKGBZfbjX6LMpAm17aD+nphfpBpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768213641; c=relaxed/simple;
	bh=kAQtztJnlRWpAZf1+RwaQbCo3hIx7GAy5JkPCCztsv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VppWDb/BLW+PFIwGkiH4LyBXlK1b6W1ZvqIAlY9hgBZ/KpnbN61heuXbLUkWFHmxkUkNWoGs37leBbXkl/XmQiQkda93Twmou+gS79Gy0MnGK4eWNRs9P/H+byRM3voEtP1EqWWfZ4AoKjDzDDMv/KH3JxV8f+HDre98H0ZSy3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ErTD1jPJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ErTD1jPJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Exaj7ywlZ52Y7D+AZFKn4qBEeJ3su3z41jY4quHcAUw=; b=ErTD1jPJBIs6VW3tjYV7umHlA5
	+XRMqglCI3zVuoiz62qqQQ/WRNX49LTVVxK1vibbh9zz6WTqTZop+FhCjTc1gBW3Oh3Splje9VvWl
	Tw6ZxKask0kSPHrw6b8GiWxknN4OqzGGP6geVR9zKK46rDzM2KFwPfin8v+93AH/5EhsCLaa2DW9H
	WNrc8J1hMB6KsxHZM53dIHgPc3Pnqt3lnePNIQaLYjhoR/ZdG8ZpiTtiOAGvRHWAuEb2tdPuSbyl2
	Pwh3Zg4YDxe21m4Ldlnl70kzEGjqphrRuj7se+2YFUXHEKbfRwgsEWlw6Sn2mu2sTFvZ6e9zukHKL
	S+DRPYEA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfF8h-000000035iG-1x1d;
	Mon, 12 Jan 2026 10:27:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0519430057E; Mon, 12 Jan 2026 11:27:11 +0100 (CET)
Date: Mon, 12 Jan 2026 11:27:10 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: Re: [Patch v2 1/7] perf/x86/intel: Support the 4 new OMR MSRs
 introduced in DMR and NVL
Message-ID: <20260112102710.GE830755@noisy.programming.kicks-ass.net>
References: <20260112051649.1113435-1-dapeng1.mi@linux.intel.com>
 <20260112051649.1113435-2-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112051649.1113435-2-dapeng1.mi@linux.intel.com>

On Mon, Jan 12, 2026 at 01:16:43PM +0800, Dapeng Mi wrote:

> ISE link: https://www.intel.com/content/www/us/en/content-details/869288/intel-architecture-instruction-set-extensions-programming-reference.html

Does intel guarantee this link is stable? If not, it is not appropriate
to stick in a changelog that will live 'forever'.


> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 1840ca1918d1..6ea3260f6422 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3532,17 +3532,28 @@ static int intel_alt_er(struct cpu_hw_events *cpuc,
>  	struct extra_reg *extra_regs = hybrid(cpuc->pmu, extra_regs);
>  	int alt_idx = idx;
>  
> -	if (!(x86_pmu.flags & PMU_FL_HAS_RSP_1))
> -		return idx;
> -
> -	if (idx == EXTRA_REG_RSP_0)
> -		alt_idx = EXTRA_REG_RSP_1;
> -
> -	if (idx == EXTRA_REG_RSP_1)
> -		alt_idx = EXTRA_REG_RSP_0;
> +	if (idx == EXTRA_REG_RSP_0 || idx == EXTRA_REG_RSP_1) {
> +		if (!(x86_pmu.flags & PMU_FL_HAS_RSP_1))
> +			return idx;
> +		if (++alt_idx > EXTRA_REG_RSP_1)
> +			alt_idx = EXTRA_REG_RSP_0;
> +		if (config & ~extra_regs[alt_idx].valid_mask)
> +			return idx;
> +	}
>  
> -	if (config & ~extra_regs[alt_idx].valid_mask)
> -		return idx;
> +	if (idx >= EXTRA_REG_OMR_0 && idx <= EXTRA_REG_OMR_3) {
> +		if (!(x86_pmu.flags & PMU_FL_HAS_OMR))
> +			return idx;
> +		if (++alt_idx > EXTRA_REG_OMR_3)
> +			alt_idx = EXTRA_REG_OMR_0;
> +		/*
> +		 * Subtracting EXTRA_REG_OMR_0 ensures to get correct
> +		 * OMR extra_reg entries which start from 0.
> +		 */
> +		if (config &
> +		    ~extra_regs[alt_idx - EXTRA_REG_OMR_0].valid_mask)
> +			return idx;
> +	}
>  
>  	return alt_idx;
>  }
> @@ -3550,16 +3561,24 @@ static int intel_alt_er(struct cpu_hw_events *cpuc,
>  static void intel_fixup_er(struct perf_event *event, int idx)
>  {
>  	struct extra_reg *extra_regs = hybrid(event->pmu, extra_regs);
> -	event->hw.extra_reg.idx = idx;
> +	int er_idx;
>  
> -	if (idx == EXTRA_REG_RSP_0) {
> -		event->hw.config &= ~INTEL_ARCH_EVENT_MASK;
> -		event->hw.config |= extra_regs[EXTRA_REG_RSP_0].event;
> -		event->hw.extra_reg.reg = MSR_OFFCORE_RSP_0;
> -	} else if (idx == EXTRA_REG_RSP_1) {
> +	event->hw.extra_reg.idx = idx;
> +	switch (idx) {
> +	case EXTRA_REG_RSP_0 ... EXTRA_REG_RSP_1:
> +		er_idx = idx - EXTRA_REG_RSP_0;
>  		event->hw.config &= ~INTEL_ARCH_EVENT_MASK;
> -		event->hw.config |= extra_regs[EXTRA_REG_RSP_1].event;
> -		event->hw.extra_reg.reg = MSR_OFFCORE_RSP_1;
> +		event->hw.config |= extra_regs[er_idx].event;
> +		event->hw.extra_reg.reg = MSR_OFFCORE_RSP_0 + er_idx;
> +		break;
> +	case EXTRA_REG_OMR_0 ... EXTRA_REG_OMR_3:
> +		er_idx = idx - EXTRA_REG_OMR_0;
> +		event->hw.config &= ~ARCH_PERFMON_EVENTSEL_UMASK;
> +		event->hw.config |= 1ULL << (8 + er_idx);
> +		event->hw.extra_reg.reg = MSR_OMR_0 + er_idx;
> +		break;
> +	default:
> +		pr_warn("The extra reg idx %d is not supported.\n", idx);
>  	}
>  }

I found it jarring to have these two functions so dissimilar; I've
changed both to be a switch statement.

---
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3532,16 +3532,17 @@ static int intel_alt_er(struct cpu_hw_ev
 	struct extra_reg *extra_regs = hybrid(cpuc->pmu, extra_regs);
 	int alt_idx = idx;
 
-	if (idx == EXTRA_REG_RSP_0 || idx == EXTRA_REG_RSP_1) {
+	switch (idx) {
+	case EXTRA_REG_RSP_0 ... EXTRA_REG_RSP_1:
 		if (!(x86_pmu.flags & PMU_FL_HAS_RSP_1))
 			return idx;
 		if (++alt_idx > EXTRA_REG_RSP_1)
 			alt_idx = EXTRA_REG_RSP_0;
 		if (config & ~extra_regs[alt_idx].valid_mask)
 			return idx;
-	}
+		break;
 
-	if (idx >= EXTRA_REG_OMR_0 && idx <= EXTRA_REG_OMR_3) {
+	case EXTRA_REG_OMR_0 ... EXTRA_REG_OMR_3:
 		if (!(x86_pmu.flags & PMU_FL_HAS_OMR))
 			return idx;
 		if (++alt_idx > EXTRA_REG_OMR_3)
@@ -3550,9 +3551,12 @@ static int intel_alt_er(struct cpu_hw_ev
 		 * Subtracting EXTRA_REG_OMR_0 ensures to get correct
 		 * OMR extra_reg entries which start from 0.
 		 */
-		if (config &
-		    ~extra_regs[alt_idx - EXTRA_REG_OMR_0].valid_mask)
+		if (config & ~extra_regs[alt_idx - EXTRA_REG_OMR_0].valid_mask)
 			return idx;
+		break;
+
+	default:
+		break;
 	}
 
 	return alt_idx;
@@ -3571,12 +3575,14 @@ static void intel_fixup_er(struct perf_e
 		event->hw.config |= extra_regs[er_idx].event;
 		event->hw.extra_reg.reg = MSR_OFFCORE_RSP_0 + er_idx;
 		break;
+
 	case EXTRA_REG_OMR_0 ... EXTRA_REG_OMR_3:
 		er_idx = idx - EXTRA_REG_OMR_0;
 		event->hw.config &= ~ARCH_PERFMON_EVENTSEL_UMASK;
 		event->hw.config |= 1ULL << (8 + er_idx);
 		event->hw.extra_reg.reg = MSR_OMR_0 + er_idx;
 		break;
+
 	default:
 		pr_warn("The extra reg idx %d is not supported.\n", idx);
 	}
