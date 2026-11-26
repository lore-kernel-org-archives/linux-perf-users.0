Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713548;
	b=lQWwxmnIaUfFPJki+ZQ5e4gKhOue1c92/xokIxkYtuXbvMluF5uXNgNGAaRjLu6n71eq
	 O0SSQNMPs4Zn9ucePQAVnyOzyl1gaadZKLMWVS83nQgRbylCIUeKKl3t9eIJadZjeCxSq
	 h8wmEhwAlIjRbdGaW/np1SdtJxzE9EvizlsaQ6omeEuCZCwxGXkFL7NZ2DRitWpE0rJpg
	 iclbxQpnw5ZHfKzrZXHO6QZehMsTNYnEVpWM4yNMHL56KwvAv0g5/PVIOJgZljIypoO5W
	 ytt6U2THNW9UrxOHSC1Vi1DEjTaKezz+UPopUDMSpkX+3yq5MrT+5KOQOX/MgvQZt0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713548;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=rhuNE5ZBjPY4tQM9iK0/pMmQ8I5mIIDIxgZDyp0clYQ=;
	b=DCVqQwtJgWZnglvlz9RG/zSK5Ty/Xb032ExlFdu9ieiweDyoh4Q5lGaY2EIbQrRszMFC
	 s6saxOjdEhx2e+7pXwQExKP/5sjjz7GyrBi5xHuH89H4ZgyV2ErsYp0Yq+5lF+6ti9EPr
	 +8x2m9ftOBWl8o+ZbKowIUn2cLuJ3BD8T+vBsvsEE/vDatWTedozyTVjh+9/5I83GrXVO
	 MuQ7q9U6FHfEqxzelhiMuksH6CZYwrfscrKv2mi8hKEDjXjdA898NIidCrvJJcj7eFcbY
	 jTTD+kR3fc3XN12lmYTFXuHyAHovQwB3ZAovNS4Q95v+2JZdWs2zXavjl5XczzhdYAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WQwPnco+;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D73606A31C;
	Thu, 26 Nov 2026 17:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85D73606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WQwPnco+
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 976901BA8;
	Thu, 26 Nov 2026 09:19:03 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FB553F632;
	Thu, 26 Nov 2026 09:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795713546; bh=sZs002yDgzA/dip7O6vSkyyHHDBEqKsTsOooqP68T3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQwPnco+m4E6tas0PwJz5g+dSTh0h6mJYL1KDaMMF7XGQnmhSEeBYfbePNjX/pdfJ
	 vsxH+p786cl9H6eKs3yMNEgCshrcbaIiIirRx8w5NN4hk45Y1SsOdTJIHJpImcA0jZ
	 vM6YrW02LPKHZvLfZk9W2dAqEPcoKEc7sWq1Ln20=
Date: Thu, 26 Nov 2026 17:19:04 +0000
From: Leo Yan <leo.yan@arm.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	bpf@vger.kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Rob Herring <robh@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shuah Khan <shuah@kernel.org>, Breno Leitao <leitao@debian.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Stephane Eranian <eranian@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Usama Arif <usama.arif@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v6 2/3] perf/arm64: Add BRBE support for
 bpf_get_branch_snapshot()
Message-ID: <20261126171904.GA809232@e132581.arm.com>
References: <20260810164622.1829843-1-puranjay@kernel.org>
 <20260810164622.1829843-3-puranjay@kernel.org>
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
In-Reply-To: <20260810164622.1829843-3-puranjay@kernel.org>

On Mon, Aug 10, 2026 at 09:46:19AM -0700, Puranjay Mohan wrote:

[...]

> +int brbe_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
> +{
> +	u64 brbidr, brbfcr, brbcr, pmcr;
> +	int nr_hw, nr_copied = 0;
> +	bool paused_here = false;
> +	unsigned long flags;
> +
> +	/* Called with migration disabled, so this is the CPU read below. */
> +	if (!valid_brbe_version())
> +		return 0;
> +
> +	flags = raw_local_daif_save();
> +
> +	brbcr = read_sysreg_s(SYS_BRBCR_EL1);
> +	brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
> +
> +	/*
> +	 * PAUSED is only ever set behind our back, so finding it set is final.
> +	 * likely() keeps this inline; a taken branch costs a record.
> +	 */
> +	if (likely(brbcr && !(brbfcr & BRBFCR_EL1_PAUSED))) {
> +		/*
> +		 * Stop the counters so a freeze cannot set PAUSED behind the
> +		 * value read below; the D19.3 conditions need a PMOVSCLR_EL0
> +		 * bit, which a stopped counter cannot set.
> +		 */
> +		pmcr = read_pmcr();
> +		write_pmcr(pmcr & ~ARMV8_PMU_PMCR_E);
> +		isb();
> +
> +		brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
> +		paused_here = !(brbfcr & BRBFCR_EL1_PAUSED);
> +
> +		write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
> +		isb();
> +	}

AI pointed out a edge case:

 1) The PMU is enabled (PMCR_EL0.E=1). The first BRBFCR_EL1 read
    observes PAUSED=0.
 2) A counter overflows and hardware freezes BRBE before the helper
    stops the counters. This can happen while interrupt is masked.
 3) The helper saves PMCR_EL0 and clears PMCR_E. Its second BRBFCR_EL1
    read observes PAUSED=1, so paused_here becomes false.
 4) The only write restoring the saved PMCR_EL0 is inside
    "if (paused_here)". The helper therefore returns with PMCR_EL0.E=0.

This can happen with a normal PMU IRQ because hardware can freeze BRBE
while local IRQs are masked.

> +	trace_hardirqs_off();

The irqsoff tracer misses the time between raw_local_daif_save() and
this call. Other callers could introduce similar gaps by using the raw
helper.

I'll reply separately on the pNMI / NMI cases with an approach that
may avoid adding the raw helpers.

Thanks,
Leo
