Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B1A30E85B;
	Sat, 21 Jun 2025 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750498901; cv=none; b=dvReR/yx3pP249+gwUOJqr2g1JPf76hQgRUhew+vCpbncl6qECQqegu5XfGJByb8R3ANrS72+IE3EGc5Hb24wDsGyMvaxR9Nmt/9vbzmXNLAOJMvVjuoDpVi16Pj2rycwzUkPKyiiF7BdCgLriQ5pINmch3NfEgSa5zzkopRAIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750498901; c=relaxed/simple;
	bh=m7TJTsHJa6TY4PrTqVO0kYjSdkPRDBut4S3vVyW0uWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxsiXTqTlr5quUAUWNKP+i+cW9MqYFkvxvyUzpy3VS33t8qrosZttYF9wSviw3bCyslV3Ku+NSNlkjhrW9nJzQQYoNte9twJpkunA6zkeSFsEgnKC6C8vO6ZkqHKv9BUKqyqssyNmNeQTEn8Pqv1UBOIyapVUTAaNK7N29ixwwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WRD9COay; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WRD9COay"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4zMCTLG4kJDerA+w9GW+UhDLBS5IcHFJTTe8BRiVuPI=; b=WRD9COaye/In2P/qqwHo6+wXXp
	NNtVnX/0EK3usiitUDi8Z/1DnzuZxNj76BVu0ZfNj5yFlUFEKVvfE2iHXuSuKjs8Qsts+xy/0Q+cw
	PJfCT6LneGZ1jZ58tZggeKUXVPDsxR3HTCWY4hKTD7DiLFVC5oy45n9KdZjpYOh8acECTNVHsDbPQ
	aBZ3rRRg5+/B5BUf/R6BoxJY9brGg2JHk0sxwvqdmTGB/Lncs3BSAxMXMcttW8jlYHWIFMUc/X7gd
	UBk+Ww37KwpNKbevzFPaQdSLKzddRCMn9tuZgwxRR9D1I+WnZKS5b6+Ut9mwInLNySv9u7zDG2fxJ
	bDYnqunA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSuj9-00000004tB4-0oaN;
	Sat, 21 Jun 2025 09:41:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4578B3087E7; Sat, 21 Jun 2025 11:41:34 +0200 (CEST)
Date: Sat, 21 Jun 2025 11:41:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v4 09/13] perf/x86/intel: Setup PEBS data configuration
 and enable legacy groups
Message-ID: <20250621094134.GX1613376@noisy.programming.kicks-ass.net>
References: <20250620103909.1586595-1-dapeng1.mi@linux.intel.com>
 <20250620103909.1586595-10-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620103909.1586595-10-dapeng1.mi@linux.intel.com>

On Fri, Jun 20, 2025 at 10:39:05AM +0000, Dapeng Mi wrote:

> +static inline void __intel_pmu_update_event_ext(int idx, u64 ext)
> +{
> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	u32 msr = idx < INTEL_PMC_IDX_FIXED ?
> +		  x86_pmu_cfg_c_addr(idx, true) :
> +		  x86_pmu_cfg_c_addr(idx - INTEL_PMC_IDX_FIXED, false);
> +
> +	cpuc->cfg_c_val[idx] = ext;
> +	wrmsrq(msr, ext);
> +}

> +static inline unsigned int x86_pmu_cfg_c_addr(int index, bool gp)
> +{
> +	u32 base = gp ? MSR_IA32_PMC_V6_GP0_CFG_C : MSR_IA32_PMC_V6_FX0_CFG_C;
> +
> +	return base + (x86_pmu.addr_offset ? x86_pmu.addr_offset(index, false) :
> +					     index * MSR_IA32_PMC_V6_STEP);
> +}

This seems like an aweful lot of conditions just to get an ddress.

Also, IIRC we have intel_pmu_v6_addr_offset() and that does: index *
MSR_IA32_PMC_V6_STEP, so something is very redundant here.


