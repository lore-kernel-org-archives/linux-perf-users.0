Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793900105;
	b=2WpmfIIXUPt3QDHh0mh98YMHKFFY9C2PBCn8BR9/mEPq6RcJnY9bRx8C4Pf05MZYPrLm
	 MOqGwXrive3C0DtC88e6FBZFMnbtx4uvHBfzGLLlq8FjdqrDu+rheOxeNcOMZshoL++bK
	 wqtpwuH+UcSVUOzZDgfhauF10OwZdavq7QEB666JcR8uj4Cy2eZbnx+1Kx9RG3ynFw9dL
	 M4hyhh/lAaKrJxLOgUfvQZWUQ06pDW9MoVZPISFdvWIWNGMB0JIsOsrg2oZTU9ccwHIVp
	 HZKdywzLKEEbZhfV1CcOz3ZDUMSxlVTicyzjuBMAedJ2EUrL7ymUNtVnLtEDJCZ/tag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900105;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=t9fXrsO0O2af3z3/kWMiEISte9PuUvmoDvuTu4maoQU=;
	b=YcMUW1K6Fg79T6DzeE3/BjNWJ8eHR6QvIDY5DL0UTkq9/tZ0DwTAE42l2Ukb18WeL7zg
	 +yAjwcd82k2vPXhBk1VjT7wZ/gO6jBJmPbnov8yOjqNrwIAMAeaax/4RnhrT4gsYj6Tje
	 DIHEp20yyEoyZIhaFY12/Stbgk5X4IdhmFYaDiqZutBOdXPSLu9xFuhSog8JQaAoUkufH
	 v3Ngbx3O+3jaMCDJJ3SlG6EJX685hm8KkjNVFk6L9gS6q+sDxKLWziFm6dotbbCnKxvbH
	 1o4g5gtJBSIakFkKqexEjwjV5pCJpVy23vmk8Ml8+t0PW0kWgEGQKN+DOs51YFOBihw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=CigfXg3H;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0160C606A328;
	Thu,  5 Nov 2026 17:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0160C606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=CigfXg3H
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C283168F;
	Thu,  5 Nov 2026 09:35:01 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8CDE3F628;
	Thu,  5 Nov 2026 09:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793900104; bh=1kdTInzv5avQC44NY6UkCIy3jwAJ0WWvZ6Hq0Mp6/Z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CigfXg3HjPp56Isr9XGD0NM81d6kV4jL7gMyL+LqukWH9Lez/STa6w1aenTrOl7cD
	 yWBs/d8EDxRkirRXKTdJ0v2JLV97O03cgMICD4sHuaxQ2S0468DKeUFwYtHktKIIzE
	 VPEKEJrZD4sTj+eX27hY6gWL/dUEuG7LJ9p2xKQk=
Date: Thu, 5 Nov 2026 17:35:01 +0000
From: Leo Yan <leo.yan@arm.com>
To: Yabin Cui <yabinc@google.com>
Cc: Dev Jain <dev.jain@arm.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Tamas Petz <tamas.petz@arm.com>,
	Tamas Zsoldos <tamas.zsoldos@arm.com>,
	Michiel van Tol <michiel.vantol@arm.com>,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "perf/aux: Allocate non-contiguous AUX pages by
 default"
Message-ID: <20261105173501.GV9176@e132581.arm.com>
References: <20261025-perf_revert_prefer_large_alloc-v1-1-5fb431bbd624@arm.com>
 <57c34e26-3048-474d-8e74-f65799e32ff4@arm.com>
 <CALJ9ZPNWcDtajO+Luhxe1K3af64mPRFQSjvfvNornyFFkam-+g@mail.gmail.com>
 <CALJ9ZPO9XxF-kz5K67Jg8RtpiEmK7XFU3e+xDak6LyV_We7yBQ@mail.gmail.com>
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
In-Reply-To: <CALJ9ZPO9XxF-kz5K67Jg8RtpiEmK7XFU3e+xDak6LyV_We7yBQ@mail.gmail.com>

On Tue, Nov 03, 2026 at 12:46:24PM -0800, Yabin Cui wrote:

...

> In field telemetry and local ftrace on Pixel devices (prior to
> 18049c8cff9c, so __GFP_NORETRY was already in place), we observed heavy
> rb_alloc_aux() -> __alloc_pages_direct_compact() stalls alongside
> kcompactd0 pinned on big cores scanning order-9, and this accounted for
> >20% of all perceptible app kills (via lmkd) across dogfood devices
> until we stopped high-order AUX allocations.

Thanks for the detailed explanation. My understanding is that repeated
reclaim/compaction during AUX allocation raises memory PSI and can lead
to lmkd killing applications. The problem to address is therefore the
cost of obtaining higher-order pages under memory fragmentation.

> Initially we worked around this in userspace (simpleperf) by setting
> perf_event_attr::aux_watermark = 4096 so get_order(watermark) == 0. That
> was fine for CoreSight ETR (which uses its own separate scatter-gather
> buffer and only copies into AUX on flush/stop), but when enabling TRBE
> (and SPE) it caused hardware maintenance interrupts every 4 KiB instead
> of every 2 MiB. Also, in overwrite/snapshot mode rb_alloc_aux() ignores
> aux_watermark and uses ilog2(nr_pages). That is why I sent 18049c8cff9c.

Agreed. Reducing watermark to 4096 also increases maintenance interrupt
frequency for SPE/TRBE. We should refine buffer allocation rather than
using watermark as a workaround.

> ### Possible solutions
> 
> For PMUs without PERF_PMU_CAP_AUX_NO_SG (such as SPE, TRBE, and modern
> Intel PT), higher-order AUX pages are an opportunistic optimization
> rather than a functional requirement -- very similar to THP allocations
> on fault (GFP_TRANSHUGE_LIGHT) or opportunistic high-order slabs in SLUB
> (allocate_slab()).
> 
> Instead of reverting to GFP_KERNEL reclaim/compaction for all high-order
> attempts, could we do the following?
> 
> 1. Make opportunistic high-order AUX allocations no-reclaim:
>    When !(event->pmu->capabilities & PERF_PMU_CAP_AUX_NO_SG) and
>    order > 0, clear __GFP_RECLAIM (and add __GFP_NOMEMALLOC, matching
>    SLUB's allocate_slab() and GFP_TRANSHUGE_LIGHT):
> 
>      gfp_t gfp = PERF_AUX_GFP;
> 
>      if (order && !has_no_sg)
>              gfp = (PERF_AUX_GFP | __GFP_NOMEMALLOC) & ~__GFP_RECLAIM;
> 
>    When order falls back to 0 (or when PERF_PMU_CAP_AUX_NO_SG is set),
>    keep PERF_AUX_GFP so single-page allocations still reclaim normally
>    under memory pressure.
> 
>    That way, when free order-9 / order-4 blocks exist, SPE and TRBE get
>    them immediately for PMD / contiguous-PTE vmap() mappings (and pages
>    stay grouped together); when memory is fragmented on a long-running
>    device, high-order probes fail fast on the freelist without waking
>    kcompactd/kswapd or triggering direct compaction and reclaim.

This looks reasonable for me: try to obtain larger blocks cheaply, then
then retain the PERF_AUX_GFP policy for order-0 allocations. I also
agree with preserving the allocation policy for PERF_PMU_CAP_AUX_NO_SG
case.

Could you compare the memory PSI stall deltas before and after applying
this option? I think measurements from your production devices would be
convinced evidence for benefits.

> 2. Clamp max_order in rb_alloc_aux() after fallback:
>    If rb_alloc_aux_page() requested `order` and had to fall back to a
>    smaller order, update `max_order = page_private(page)` in
>    rb_alloc_aux() so subsequent iterations for the rest of the buffer do
>    not keep re-probing higher orders that just failed.

This also can avoid reclaim repeatedly, but the side effect is subsequent
iterations would no longer try high order, which have no chance to
benefit from large mapping.

I would prefer to evaluate option 1 first.

> (Optionally, if server/benchmark workloads ever want synchronous
> compaction to form huge AUX mappings even on fragmented hosts, that could
> be gated behind an opt-in attr/sysfs knob similar to THP defrag modes,
> with light/no-reclaim as the default.)

I will follow up with Will separately about the userspace interface.

> Would this approach work for your SPE/TRBE use cases? Happy to help test
> on our side.

If option 1 works, we can confidently revert 18049c8cff9c, as it would
restore higher-order allocations for TRBE/SPE without introducing the
regression you mentioned.

Thanks,
Leo
