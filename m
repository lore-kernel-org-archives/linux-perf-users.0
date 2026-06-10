Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA664CA6F;
	Wed, 10 Jun 2026 08:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079660; cv=none; b=azYC3KmAXoew7wiPB/3C1M3xTbKx7xpjBGKrcFvUSFBAXjuTW49utQ+d/5HcqulPsqTuAffnY1KTv6JGHzWWQCb3iRpuw/XwnfGpXMWel+ob5+zEYm+BtUHRF53ax7OOQoeyhPowrhjkMcBvA0LUfXdSBG0l17uPZcjOBRVkyvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079660; c=relaxed/simple;
	bh=L4+J3zxZHBaqUA/PNVwiNAigpifjSqXEUm1W0yGeLbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThwXTP/QnMXny5BVCCEQlqClVqPHuWxB+NdesPhTRJDcJFjhUz2lvbaqZl6U6nJECsCIhG1eTHQq2Ui8jdfLMXbqdvx4X8dYvr00XIcGNLnhyy3tNsHUonqQChhIob8v7bPMYcBvbzseXouQpBn6TFAaCUNQkXr1Or3A3ilmTj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pcQtR7ao; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pcQtR7ao"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+4sapeTaX1R/iiNa0YT6d7A8P2ZqGEEdBlz7Gx4AxPs=; b=pcQtR7aoSVbegqF6pno+R1pIzs
	FbY1aYOxr5ZunLnJyOz39+/aTHYZ98UvENTwzjzhx+GNWtfXSw/Uy5wkaPyLfyKHU+Ud/RCmILvQd
	t1vZ7FNKTXnCrG5oo3RARnuooM1sWij64im5kNXJdb0wAVXegJhg5AHu8wIKv5QBJUrpav89eo8yi
	QViNNMM1reec5PAsRU1bgd9e5P+nwK2dJA5cqSTo1FOCNWgIQekfolB1R4MXgSNeICmrHup0FDMXG
	PsJPHK8HHBytKqWbzS8mhk0ZCNmxch9Ryquxxo2wEQAN0F2GnLsZ/ePnDrQ9A4X8FIw+r2SI4zP64
	/AdgzDVQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wXEBA-00000003bxt-3P00;
	Wed, 10 Jun 2026 08:20:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AA962302F8E; Wed, 10 Jun 2026 10:20:51 +0200 (CEST)
Date: Wed, 10 Jun 2026 10:20:51 +0200
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
	Xudong Hao <xudong.hao@intel.com>, Yi Lai <yi1.lai@intel.com>
Subject: Re: [Patch v2 7/9] perf/x86/intel: Drop fixed-counter PEBS
 constraints for baseline PEBS
Message-ID: <20260610082051.GF49951@noisy.programming.kicks-ass.net>
References: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
 <20260609050222.2458129-8-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609050222.2458129-8-dapeng1.mi@linux.intel.com>

On Tue, Jun 09, 2026 at 01:02:20PM +0800, Dapeng Mi wrote:
> On SPR guests where pebs_baseline is not advertised, running:
> 
> $ ./perf record -e cpu/event=0x00,umask=0x01,i\
> 	 name=INST_RETIRED.PREC_DIST/p -c 10000 sleep 1
> 
> can trigger:
> 
> unchecked MSR access error: WRMSR to 0x3f1 ... in\
> 	 intel_pmu_pebs_enable_all()
> 
> Root cause:
> SPR-specific PEBS constraints allow fixed-counter scheduling,
> for example INST_RETIRED.PREC_DIST on fixed counter 0. In guests without
> pebs_baseline, KVM does not support PEBS sampling on fixed counters,
> so enabling such events reaches an invalid MSR programming path.
> 
> Fix:
> Drop fixed-counter entries from the PEBS constraint table. Without
> pebs_baseline, those fixed-counter PEBS events now resolve to empty
> constraints and are not scheduled/enabled, avoiding the warning and the
> broken guest PEBS path.
> 
> This is safe because, in pebs_baseline-capable cases, PEBS constraint
> lookup already falls back to non-PEBS constraints when needed, and
> fixed-counter constraints are effectively shared there.

I am confused, this works outside of KVM? (It appears to work fine on my
spr).. so removing this to fix some guest only issue seems wrong.


> Reported-by: Yi Lai <yi1.lai@intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/ds.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index cb72af9b61ce..5db15a92017a 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1447,10 +1447,6 @@ struct event_constraint intel_skl_pebs_event_constraints[] = {
>  };
>  
>  struct event_constraint intel_icl_pebs_event_constraints[] = {
> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x01c0, 0x100000000ULL),	/* old INST_RETIRED.PREC_DIST */
> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),	/* SLOTS */
> -
>  	INTEL_PLD_CONSTRAINT(0x1cd, 0xff),			/* MEM_TRANS_RETIRED.LOAD_LATENCY */
>  	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_LOADS */
>  	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x12d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_STORES */
> @@ -1473,9 +1469,6 @@ struct event_constraint intel_icl_pebs_event_constraints[] = {
>  };
>  
>  struct event_constraint intel_glc_pebs_event_constraints[] = {
> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
> -
>  	INTEL_FLAGS_EVENT_CONSTRAINT(0xc0, 0xfe),
>  	INTEL_PLD_CONSTRAINT(0x1cd, 0xfe),
>  	INTEL_PSD_CONSTRAINT(0x2cd, 0x1),
> @@ -1500,9 +1493,6 @@ struct event_constraint intel_glc_pebs_event_constraints[] = {
>  };
>  
>  struct event_constraint intel_lnc_pebs_event_constraints[] = {
> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
> -
>  	INTEL_FLAGS_UEVENT_CONSTRAINT(0x012a, 0x1),		/* OCR.* events */
>  	INTEL_FLAGS_UEVENT_CONSTRAINT(0x012b, 0x1),		/* OCR.* events */
>  
> @@ -1534,9 +1524,6 @@ struct event_constraint intel_lnc_pebs_event_constraints[] = {
>  };
>  
>  struct event_constraint intel_pnc_pebs_event_constraints[] = {
> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
> -
>  	INTEL_HYBRID_LDLAT_CONSTRAINT(0x1cd, 0xfc),
>  	INTEL_HYBRID_STLAT_CONSTRAINT(0x2cd, 0x3),
>  	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_LOADS */
> -- 
> 2.34.1
> 
