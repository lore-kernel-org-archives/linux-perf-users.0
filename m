Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021026;
	b=rLsTr8SmpdXKi3dWj4l/PxxB5NoevVSE2haVl6Xv8VyOWCNZUcC733e6IjNhuiYzWNEq
	 ycIdPiGPNgy0YobJbe4RQbcjDP4r7ZBAdBqO80r0vGnwVoaLIFklI6ZPSee7uipO21edn
	 pwCD1cremgKd658MPpJvcP7gW6ie8v+NwzyE2PFPPNxmUb5+3MhHYU+h2KlDXrGd1UNDC
	 SpX4t3OEzBMzfx5n7phID0c9Qf7kRA/9bPMf50WEADMCCurf0GNXhy1btJEYtfCztP6FO
	 mtfFVMpULN+wa7eDWxDAHDK7SHypLvUzKwEhqamo4ezwdYc84k1mIhwYx71pA/QUQ6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021026;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=gDbQgltaqPt13f80+rohZ9O+aZWS2o93rLNs1Qzegh4=;
	b=g837Mq645yOlnW2XcRXmdleFD59x2/JZBhnch7P5AtVPSBBYUrl5wqfvV5WbvIG2lXPp
	 A4j4FnfHNPnB/4DdLRcG7tZqnaHsHbt+KtKi4AdhVzhmoz6JtnHisVYj1xxxZGDS/ck6R
	 D7GLrZug68YexrE1qF8zi61CmQPxq53+C83WtsZqB38J5KvSG5TYTKHl8vPJPLWphoVW7
	 M+KUzlio1zNiQ9Bw45vcvYhRkdTD5EbUh86dMHhvTnFis2ji4JlJBsw8dYvYVF2LMfuWG
	 LA4I/ujeakgD1ZOwogx/wW5jndZAXbUQvZGrXa31wP7qUxN0eXT7LNpIB+CeI7Dt5fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=J1QoBo4V;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAAE606A325;
	Wed, 18 Nov 2026 16:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAAAE606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=J1QoBo4V
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EC1D1477;
	Wed, 18 Nov 2026 08:57:02 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDBEF3F673;
	Wed, 18 Nov 2026 08:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795021025; bh=VJzwyz3x5Pbv7fER/187sZZoDznAD2Da8ucRUDzZjcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J1QoBo4V2OnY4fsMLoH8jwS4KdLzvja6kqMwSutIl+WJNZqLArcpL/ObosFwraWq/
	 SGKDmA8dUo+Yoi/t5rkFvkOIUwN12eqbwRXFUc76WNghmECPnX0nc9xj+1Pm+AYJsg
	 QvxF3QZdD04w6BvjGxDsZGLcFrrp1ctMH8skfZ2g=
Date: Wed, 18 Nov 2026 16:57:02 +0000
From: Leo Yan <leo.yan@arm.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Yabin Cui <yabinc@google.com>, Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20261118165702.GX9176@e132581.arm.com>
References: <20261025-perf_revert_prefer_large_alloc-v1-1-5fb431bbd624@arm.com>
 <57c34e26-3048-474d-8e74-f65799e32ff4@arm.com>
 <CALJ9ZPNWcDtajO+Luhxe1K3af64mPRFQSjvfvNornyFFkam-+g@mail.gmail.com>
 <CALJ9ZPO9XxF-kz5K67Jg8RtpiEmK7XFU3e+xDak6LyV_We7yBQ@mail.gmail.com>
 <307b4d48-00f2-40dc-bf3f-ffa0f2f58d33@arm.com>
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
In-Reply-To: <307b4d48-00f2-40dc-bf3f-ffa0f2f58d33@arm.com>

On Sun, Nov 15, 2026 at 08:32:16PM +0530, Dev Jain wrote:

[...]

> > 1. Make opportunistic high-order AUX allocations no-reclaim:
> >    When !(event->pmu->capabilities & PERF_PMU_CAP_AUX_NO_SG) and
> >    order > 0, clear __GFP_RECLAIM (and add __GFP_NOMEMALLOC, matching
> >    SLUB's allocate_slab() and GFP_TRANSHUGE_LIGHT):
> > 
> >      gfp_t gfp = PERF_AUX_GFP;
> > 
> >      if (order && !has_no_sg)
> >              gfp = (PERF_AUX_GFP | __GFP_NOMEMALLOC) & ~__GFP_RECLAIM;
> 
> Thanks for your reply.
> 
> This looks like the correct solution. Note commit 0e05a469c294
> ("mm/page_alloc: avoid direct reclaim and compaction for costly __GFP_NORETRY allocations")
> post which the regression you report should reduce drastically. It only
> removes GFP_DIRECT_RECLAIM flag, I assume you are seeing latency even
> due to reclaim/compaction daemon wakeups.
> 
> So instead of enhancing this commit even more by making a page-allocator
> change, I would rather make your proposed change on the perf side to
> keep it simple. This should completely solve the problem.

Thanks a lot, Dev!

The revert (526d945ad9c0) and 0e05a469c294 are now in mainline. My tests
show significantly lower PSI on v7.4-rc3, consistent with the expected
benefit of 0e05a469c294.

The following PSI some values are totals in milliseconds across runs
2-10 (nine runs), excluding the first run of each case to avoid
glitches caused by its proximity to lauching the pressure workload:

  Memory usage    v7.4-rc1    v7.4-rc3    rc3 + perf patch [1]
  90%                0.000       0.000               0.000
  95%               21.781       0.000               2.061
  100%              27.946       0.000               0.000

My perf patch [1] reduces pageoutrun and compact_daemon_wake, but
increases pgscan_kswapd at 95%. The following totals compare v7.4-rc3
and v7.4-rc + my patch, also across runs 2-10:

  Usage    pageoutrun    compact_daemon_wake    pgscan_kswapd
  90%        58 -> 0               57 -> 0       1,932 -> 0
  95%         3 -> 2                2 -> 1       9,664 -> 148,079
  100%       40 -> 1               40 -> 0      11,616 -> 1,918

I would wait for Yabin's testing before deciding whether to proceed
with the additional perf changes. In my patch, changing order 0 to
__GFP_RETRY_MAYFAIL needs care: it may reduce allocation failures when
free memory is scarce, at the cost of longer reclaim stalls and
higher PSI.

Yabin, could you test the current mainline (or backport
526d945ad9c0/0e05a469c294) and confirm whether it resolves the PSI issue
on Android? If still see the reclaim pressure or observe AUX allocation
failures, it may also be worth testing patch [1].

Thanks,
Leo

[1] https://lore.kernel.org/lkml/20261109-perf_aux_alloc_optimize_psi-v1-1-d56ac4bf3ef5@arm.com/
