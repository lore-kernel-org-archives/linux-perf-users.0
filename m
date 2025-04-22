Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC132BB13;
	Tue, 22 Apr 2025 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745326200; cv=none; b=HYbhtJw6eA5zb2r3PRk1UWXGGHHR59i14GkKgULgDLhp2LDWsnC5fk6XT4/Q/v1GUOmWn4UGwRyHB3G/YpLvoUde2xQirAFYW9x+QD0j9xH9wzxV2haKUyVWPP0xzSZPs+s/7FJGFKGRMDe5rC7sJeLhc6gnA4vfw+pMwdLXuPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745326200; c=relaxed/simple;
	bh=zGK1SYvl1R3qX4Muyg2URTmK/fEOJmlqm6dSjkPeR90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkYahQYGMIiOib11c4ZbQu8WlUNzQ6oFZnQGyinJwzIQBFbgmjZt9RLTVtl/aOgIqSJ0NuxSOLCA112qxmvBkvB+1wKVLozv89aVe/i04JYFHSRRAl9+/BJcJo/wYSRbM+1u36At+54qMGLlbQOaIJNzUdaC94S1qbdkBU9nNgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwA3/5J9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwA3/5J9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FAC9C4CEE9;
	Tue, 22 Apr 2025 12:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745326199;
	bh=zGK1SYvl1R3qX4Muyg2URTmK/fEOJmlqm6dSjkPeR90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NwA3/5J9Ha5NdSIjddtSk2H5ta118ishcIEEwQOH3/kIAelihtsb9UcFAYQxemhHS
	 bi+jk1ryXPj4T1zPSC4Ck44ocqOrd+tm9IRodQAjwzwpt8y48u/W/fqFIPJvgibOF0
	 acROZXRvsitp3oBYOazJIhGaVwTui2wAFREzWwaIRbWRtDA1y2XXm5SPOb8eBI/Ari
	 6Wh1x5rIqZTQNeP9Sjw31E/8oXvN4/zvrEEIhYhy1P84pmIsTqcYRNO9Z6n7QVDnsg
	 YSO+CdirFjG/zdr60H9LjYMbNkroUBoBpKB6VsUzUQcsH8NiyADbDJ+v33L4BFwRwt
	 F1RPuaLlSCh3A==
Date: Tue, 22 Apr 2025 14:49:54 +0200
From: Ingo Molnar <mingo@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Yabin Cui <yabinc@google.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>
Subject: Re: [PATCH 1/2] perf: Allow non-contiguous AUX buffer pages via PMU
 capability
Message-ID: <aAeQcgmL-iqGbG_g@gmail.com>
References: <20250421215818.3800081-1-yabinc@google.com>
 <20250421215818.3800081-2-yabinc@google.com>
 <48640298-effa-42d4-9137-a18a51637f03@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48640298-effa-42d4-9137-a18a51637f03@linaro.org>


* James Clark <james.clark@linaro.org> wrote:

> 
> 
> On 21/04/2025 10:58 pm, Yabin Cui wrote:
> > For PMUs like ARM ETM/ETE, contiguous AUX buffers are unnecessary
> > and increase memory fragmentation.
> > 
> > This patch introduces PERF_PMU_CAP_AUX_NON_CONTIGUOUS_PAGES, allowing
> > PMUs to request non-contiguous pages for their AUX buffers.
> > 
> > Signed-off-by: Yabin Cui <yabinc@google.com>
> > ---
> >   include/linux/perf_event.h  | 1 +
> >   kernel/events/ring_buffer.c | 6 ++++++
> >   2 files changed, 7 insertions(+)
> > 
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index 0069ba6866a4..26ca35d6a9f2 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -301,6 +301,7 @@ struct perf_event_pmu_context;
> >   #define PERF_PMU_CAP_AUX_OUTPUT			0x0080
> >   #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
> >   #define PERF_PMU_CAP_AUX_PAUSE			0x0200
> > +#define PERF_PMU_CAP_AUX_NON_CONTIGUOUS_PAGES	0x0400
> >   /**
> >    * pmu::scope
> > diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> > index 5130b119d0ae..87f42f4e8edc 100644
> > --- a/kernel/events/ring_buffer.c
> > +++ b/kernel/events/ring_buffer.c
> > @@ -710,6 +710,12 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
> >   		max_order = ilog2(nr_pages);
> >   		watermark = 0;
> >   	}
> > +	/*
> > +	 * When the PMU doesn't prefer contiguous AUX buffer pages, favor
> > +	 * low-order allocations to reduce memory fragmentation.
> > +	 */
> > +	if (event->pmu->capabilities & PERF_PMU_CAP_AUX_NON_CONTIGUOUS_PAGES)
> > +		max_order = 0;
> >   	/*
> >   	 * kcalloc_node() is unable to allocate buffer if the size is larger
> 
> Hi Yabin,
> 
> I was wondering if this is just the opposite of 
> PERF_PMU_CAP_AUX_NO_SG, and that order 0 should be used by default 
> for all devices to solve the issue you describe. Because we already 
> have PERF_PMU_CAP_AUX_NO_SG for devices that need contiguous pages. 
> Then I found commit 5768402fd9c6 ("perf/ring_buffer: Use high order 
> allocations for AUX buffers optimistically") that explains that the 
> current allocation strategy is an optimization.
> 
> Your change seems to decide that for certain devices we want to 
> optimize for fragmentation rather than performance. If these are 
> rarely used features specifically when looking at performance should 
> we not continue to optimize for performance? Or at least make it user 
> configurable?

So there seems to be 3 categories:

 - 1) Must have physically contiguous AUX buffers, it's a hardware ABI. 
      (PERF_PMU_CAP_AUX_NO_SG for Intel BTS and PT.)

 - 2) Would be nice to have continguous AUX buffers, for a bit more 
      performance.

 - 3) Doesn't really care.

So we do have #1, and it appears Yabin's usecase is #3?

I strongly suspect that #2 and #3 are mostly the same in practice, and 
that we don't really need a lot of differentiation and complexity here, 
just the AUX_NO_SG flag that must have a max-order allocation - all 
other cases should allocate the AUX buffer in a default-nice, 
MM-friendly way.

Thanks,

	Ingo
