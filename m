Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1F218C011;
	Sat, 21 Jun 2025 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750498606; cv=none; b=K3TAFx7fmx5BWakqyjAeieyS+Zf7pKsuFSCku8PHozQdFXNC785mGUOEbGek16JWzSgzxYFz6w7SsC5n9amI0qSPiayH3iMGRipwTl0IS68ebZG1kDZgyVtBXXQsGwDs1t6pvkvcDwgqicHpljIl6CD7y4gzcN2EJCl9M18RNWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750498606; c=relaxed/simple;
	bh=AWYmgXwDVGYTbpVaOepPzbV3pc6zDZL69oKZSuw8gyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDiG7Uf4xMAYjsObPj/FEsb/iUQr7ix6C7sYe6gJ57Q2mDIBJcXwDyGARU/+K/BWc3StA/WJWCZbk7N+rOxjqmEHCzMhM206mKMnPvu1fUuX86fES76u3nQYKsig+Wzm5yc+31bsr1E+h0UGyu/KFCf8o0D9VdHyYbz88HSfRLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XCKLvqUv; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XCKLvqUv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wnsVG699CovqjDa4s0DOHxRpy7laDgGw4DHwMEUDvMA=; b=XCKLvqUvDFEWIZCX/8vmjPtHMr
	L0rLSK5O6DPN0hjKHdObGW5cRSh3lr17QORshKMm38bJYl0wOgzy691zsuWBEr9ZGpD3s5zoWIu5G
	r5deO58uulRTZfMgp889vA2CjxRIivFeGuaB5Nt9p3ZhvgeU6o5zJxCEY9/nc13IW9dNH+wAHGNRM
	Gai9V9h77wTvEz1/Cx8q1lpnwd2usljbibCt8wI+LPDln8DKersvKEir+u0bjjro+VWc7AVTl6SvS
	8e2WIYGwf8iK1lQdcg5061J3MWjewZzvHnjZ4XcQIC+KIFbKM+eC3CT8xuAqx8+lljdgd1TWC2Xea
	5MktZ90g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSueO-00000004t8x-007p;
	Sat, 21 Jun 2025 09:36:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DE1343087E7; Sat, 21 Jun 2025 11:36:38 +0200 (CEST)
Date: Sat, 21 Jun 2025 11:36:38 +0200
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
Message-ID: <20250621093638.GW1613376@noisy.programming.kicks-ass.net>
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
> +static inline void __intel_update_large_pebs_flags(struct pmu *pmu)
> +{
> +	u64 caps = hybrid(pmu, arch_pebs_cap).caps;
> +
> +	x86_pmu.large_pebs_flags |= PERF_SAMPLE_TIME;
> +	if (caps & ARCH_PEBS_LBR)
> +		x86_pmu.large_pebs_flags |= PERF_SAMPLE_BRANCH_STACK;
> +
> +	if (!(caps & ARCH_PEBS_AUX))
> +		x86_pmu.large_pebs_flags &= ~PERF_SAMPLE_DATA_SRC;

> +	if (!(caps & ARCH_PEBS_GPR))
> +		x86_pmu.large_pebs_flags &=
> +			~(PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER);

Coding style wants { } on this, because multi-line.

> +}
