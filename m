Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D816E18E1A;
	Tue, 15 Apr 2025 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744726071; cv=none; b=GjhoraHF05I7ygxqBgnXP1Em5NFyg1hpsOXVwKqdevM3/k7RhUPwvdGD5rtF2d0BwQbFoGSX0oGZ8QHfZsnR+rTfs04LL9+WkLl5shpyYB1WPs6xgLKo8Sm4YikAlX49auVm5IxN4dE+Wgu4t3jDe+agBD86NNvhXKkT/vDF8b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744726071; c=relaxed/simple;
	bh=D5XakogxV37TAHJXYCgHLmI6mETHhT7YD6oacyBbVgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxFl1Ue1tRWCqX6OHJWBXpAaO6vnnPXm5jgCEhsqMLhdszZ6A4nfAGlG9jYFkoC91bh98jn82Lry/c4MReBnndGSKrYLBmjcyB+K0SEGOWXqzlA9meMLCZzvreU00IDinyDqHeSFaFzkgXkADSPV1gOxxh+gth2bPM+CqEaZ/ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NtWr2gf2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NtWr2gf2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EOzlHo3nOGWAuEjEI2KtHNOFWKa2sq/OO1E6O8ecYn4=; b=NtWr2gf2w3MmBJX5ZeWhAd2jwT
	OQJarIJihKqXFbfv3cF9p+Llc8Me1yAfdCpQka7Jv4ETGIZtT9SbDeZuDONo1eF8brI9fyzpqq4g9
	Dkp02eg+IXZkW6lrbDYOgNYp7cRoTRK9nmaVNrswohzqbWS6oV+pse64LxMBimvoEu3m08PaF/L4D
	102Gp4KPDJdkOVmk98YnV2WGCKMOo3wLmkiFPV2KK5XnitnOW6LT6wDXpbihb9s5K4krMvQX2ydof
	OryGrL7DaVBrU+yXylWeQqKEIOIw0qQ14Cl3+dxJtTsCbhEnjnJoXrVazhfmJppqigGCl90bV44mZ
	WmD9dyDQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4gwo-00000008exI-3JwL;
	Tue, 15 Apr 2025 14:07:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A3ED0300619; Tue, 15 Apr 2025 16:07:34 +0200 (CEST)
Date: Tue, 15 Apr 2025 16:07:34 +0200
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
Subject: Re: [Patch v3 15/22] perf/x86/intel: Support SSP register capturing
 for arch-PEBS
Message-ID: <20250415140734.GE4031@noisy.programming.kicks-ass.net>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
 <20250415114428.341182-16-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415114428.341182-16-dapeng1.mi@linux.intel.com>

On Tue, Apr 15, 2025 at 11:44:21AM +0000, Dapeng Mi wrote:
> Arch-PEBS supports to capture shadow stack pointer (SSP) register in GPR
> group. This patch supports to capture and output SSP register at
> interrupt or user space, but capturing SSP at user space requires
> 'exclude_kernel' attribute must be set. That avoids kernel space SSP
> register is captured unintentionally.
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/core.c                | 15 +++++++++++++++
>  arch/x86/events/intel/core.c          |  3 ++-
>  arch/x86/events/intel/ds.c            |  9 +++++++--
>  arch/x86/events/perf_event.h          |  4 ++++
>  arch/x86/include/asm/perf_event.h     |  1 +
>  arch/x86/include/uapi/asm/perf_regs.h |  4 +++-
>  arch/x86/kernel/perf_regs.c           |  7 +++++++
>  7 files changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 9c205a8a4fa6..0ccbe8385c7f 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -650,6 +650,21 @@ int x86_pmu_hw_config(struct perf_event *event)
>  			return -EINVAL;
>  	}
>  
> +	if (unlikely(event->attr.sample_regs_user & BIT_ULL(PERF_REG_X86_SSP))) {
> +		/* Only arch-PEBS supports to capture SSP register. */
> +		if (!x86_pmu.arch_pebs || !event->attr.precise_ip)
> +			return -EINVAL;
> +		/* Only user space is allowed to capture. */
> +		if (!event->attr.exclude_kernel)
> +			return -EINVAL;
> +	}

We should be able to support this for !PEBS samples by reading the MSR
just fine, no?

ISTR making a similar comment last time.
