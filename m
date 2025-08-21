Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AF02EC553;
	Thu, 21 Aug 2025 13:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783564; cv=none; b=DiBX+jGMg2eETWP1GUlw6UFXUTrfPGIrX+VEIFsMmURjNg3vf1Y1vGkunTWtQaeFRNZoPVEq7fnRjHGTVd3jOq3/WIW83hNBm7Qjr+jYsXM8B6hk7qOJXNlSUiM3BeRiPQA6j+t0bCLb6ANKAOcBpuXGaT17ofTyXcXcfNec5ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783564; c=relaxed/simple;
	bh=fQSqm+AxUdok9N34ho8i6HvT7kUIuAl8hQZyJ4p33+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrRZhqsTJ1bf5A7+LquH2dbOkdbPXpmLllicuXUd2hY/VkbL77f2XsvlflDj3r82ARyVHyveihIVEMqownV4BW7aE22pBweFnq4b2zM3nVDCoOKluSUNLSDpfeZejY4FX3jK+wAetJSfw8W/Q7FqhF0fGXIhbg+3Y7FEO5xbvHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oZbdMPG3; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oZbdMPG3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1y8eLWiWOOgAAfOTf8ZMD7lCrmB7LYfroYNuOLtPwdI=; b=oZbdMPG3ELUJ98D7TNN8htEp1o
	4SNEynlyzwyfBT48z6FHM1fw/ny0agbTmhxcIt2Q4lhSM52v2kKCX7yz3tbbBeEDUu2gq4kAWdwnd
	96UU8o1WdsieTrWCjJnA/iFpBjz7wwQhM9o/AzWSmeegaQc9Gkuu9V3vLJ5NS178yK/k9z+Jtv1cl
	vYdMQnTYgl0xaYgJs9I/8/mUYkGDLnWIjEjZaI6rAqp/6Hjtg2Mf8r1x3/4hrR2HAxKWixW5UqWey
	rYS8WXch1iRIOlbcWkMZft05/Hqu7vvul5Es0e7MP0nSlltLO20ueXSUNL7P0tTrYSXByWup/JQUy
	oj+qs+WQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up5Vc-00000000Zg0-1e0N;
	Thu, 21 Aug 2025 13:39:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EB6243002ED; Thu, 21 Aug 2025 15:39:15 +0200 (CEST)
Date: Thu, 21 Aug 2025 15:39:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v3 0/7] x86 perf bug fixes and optimization
Message-ID: <20250821133915.GQ4067720@noisy.programming.kicks-ass.net>
References: <20250820023032.17128-1-dapeng1.mi@linux.intel.com>
 <75fbe025-214f-4b2c-8077-a8dbfa34a5c2@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75fbe025-214f-4b2c-8077-a8dbfa34a5c2@linux.intel.com>

On Wed, Aug 20, 2025 at 08:55:24AM -0700, Liang, Kan wrote:

> > Dapeng Mi (7):
> >   perf/x86/intel: Use early_initcall() to hook bts_init()
> >   perf/x86/intel: Fix IA32_PMC_x_CFG_B MSRs access error
> >   perf/x86: Check if cpuc->events[*] pointer exists before accessing it
> >   perf/x86: Add PERF_CAP_PEBS_TIMING_INFO flag
> >   perf/x86/intel: Change macro GLOBAL_CTRL_EN_PERF_METRICS to
> >     BIT_ULL(48)
> >   perf/x86/intel: Add ICL_FIXED_0_ADAPTIVE bit into
> >     INTEL_FIXED_BITS_MASK
> >   perf/x86: Print PMU counters bitmap in x86_pmu_show_pmu_cap()
> >
> 
> The series looks good to me.
> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

I've picked up all but patch 3 -- I really don't think that does the
right thing.
