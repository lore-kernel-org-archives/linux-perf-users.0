Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE401CD3F;
	Tue, 28 Jan 2025 11:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738063333; cv=none; b=I6FcVnppA3lRCZu/aPRTJ1ZevxeLY4n5nPcQ1TLA1+yD4j2/ghbO56rH47Du+88VTjWkuC5DPJQsmjsD16eOah6kZSWKXnMlcd3fTRBGHJVT851aBnojg5lfciZbs+OkfJqZDY75FmMzrvd3W2pgpuqB8i4xiAReD3BXSQYpGkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738063333; c=relaxed/simple;
	bh=Qz5GHf1dJZb+VFFjhcFvqY91drX8kVQ4WuTicvqgm5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4oKaGRuzpQchqD3yPUDFfXd8vnrS/WeCNi+YN0l3rfXSrhz/4W0Rnk4w26ZlNbDhp20/gFcplTBHS96+jwMK3G/8eu4u4ENYUjuI4TUAkmtRCo/ygiexMtoQR+gAyOyPiQxV7xvDhFyPM7xbQkxU/pkimcd/HfSWNrRUjuYyw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gaBwAJ64; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gaBwAJ64"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9F2rOXV5rzpbOZhu1LAwlvj6RbrDMa9WlnEnmJdBLCE=; b=gaBwAJ64ichzGbahqZ5GBl9azS
	eAqxmtuMttir6AfqNwhOwnBGNde4WoTdij8WsEXxzdBHEbZUMe1z9B0L7nfL2cPRQW1CYNASERtoT
	ZDYyNrv1rqEsV51IeUANQdlvWw8icMX9q6XKoszm4DJ1QYmQKZ0O8FxRnARU9+qNcqIJKvX55QGxf
	a4FczBuLmSvxTSbiricPVrdiQNNCj6CF12qReDWNyMmWLvJS2vF0tgZ2F8ADHhbjfeuH9rxPHF+9f
	y+KwqEErPagTHX/JdzCtfywcW5dAQgy/R+7SE4xURBVDZQClvR5mczSFRRPe+6WYEL0DnfU5WoYaz
	sn90gY4A==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tcjfP-0000000AWdg-0Zjx;
	Tue, 28 Jan 2025 11:22:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6E65A30050D; Tue, 28 Jan 2025 12:22:02 +0100 (CET)
Date: Tue, 28 Jan 2025 12:22:02 +0100
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
Subject: Re: [PATCH 06/20] perf/x86/intel: Initialize architectural PEBS
Message-ID: <20250128112202.GA7145@noisy.programming.kicks-ass.net>
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
 <20250123140721.2496639-7-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123140721.2496639-7-dapeng1.mi@linux.intel.com>

On Thu, Jan 23, 2025 at 02:07:07PM +0000, Dapeng Mi wrote:


> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index e8a06c8486af..1b33a6a60584 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1537,6 +1537,9 @@ void intel_pmu_pebs_enable(struct perf_event *event)
>  
>  	cpuc->pebs_enabled |= 1ULL << hwc->idx;
>  
> +	if (x86_pmu.arch_pebs)
> +		return;
> +
>  	if ((event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT) && (x86_pmu.version < 5))
>  		cpuc->pebs_enabled |= 1ULL << (hwc->idx + 32);
>  	else if (event->hw.flags & PERF_X86_EVENT_PEBS_ST)
> @@ -1606,6 +1609,11 @@ void intel_pmu_pebs_disable(struct perf_event *event)
>  
>  	cpuc->pebs_enabled &= ~(1ULL << hwc->idx);
>  
> +	hwc->config |= ARCH_PERFMON_EVENTSEL_INT;
> +
> +	if (x86_pmu.arch_pebs)
> +		return;
> +
>  	if ((event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT) &&
>  	    (x86_pmu.version < 5))
>  		cpuc->pebs_enabled &= ~(1ULL << (hwc->idx + 32));
> @@ -1616,15 +1624,13 @@ void intel_pmu_pebs_disable(struct perf_event *event)
>  
>  	if (cpuc->enabled)
>  		wrmsrl(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
> -
> -	hwc->config |= ARCH_PERFMON_EVENTSEL_INT;
>  }
>  
>  void intel_pmu_pebs_enable_all(void)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  
> -	if (cpuc->pebs_enabled)
> +	if (!x86_pmu.arch_pebs && cpuc->pebs_enabled)
>  		wrmsrl(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
>  }
>  
> @@ -1632,7 +1638,7 @@ void intel_pmu_pebs_disable_all(void)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  
> -	if (cpuc->pebs_enabled)
> +	if (!x86_pmu.arch_pebs && cpuc->pebs_enabled)
>  		__intel_pmu_pebs_disable_all();
>  }

So there's a ton of if (arch_pebs) sprinkled around. Can't we avoid that
by using a few static_call()s ?
