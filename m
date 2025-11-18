Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825A0311C3C;
	Tue, 18 Nov 2025 11:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763465058; cv=none; b=H4/fx0AX9XYUkXtUW/nCh5whj1c2tO7YhApP2FBuzdN5FHqzrIfULEOLfEu0Be+FgACZvsA+I5TVcawcsfcI1xazYVwcS9CH3wKiV2eRPgSVg/L5RXRCHQt0wvRDFaQEoqv2uessi48ks8wEF/2QZ/YW6b2cy5GhHR4omi4WPdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763465058; c=relaxed/simple;
	bh=j0LWnCH1Js04qK7IbjmxTqss8IAlir1T+L/85yUXYdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJKTDGM5I8XAuHQ/cBkUqfPNoIiFX4TIFuX5yxkRYSodKwB8DvD69bK2+lj41YbPUt6vcxGSh9WaXzgPwU7ShAwPyEW2r7GChOSGtdC1HjrM4+Sehko7bWi5fbn9JE58FxBvOPgsVYAsg2Stm5pFFkBkRom3Pd6eo7ztZNlXHxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ur8zwFbG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ur8zwFbG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ot4gedOVOy6eh5KcNB2yZlNlynmhbNk3sgHm+aTawiY=; b=Ur8zwFbGDiNxHST7GUhU4oXv/n
	r6RnesJzyR1LwWkGlR0uwk+8qZpO2/I+9985IPbJcSj9TShfTsDXtLssVB0ozTh2GlDKhF2GFFK/A
	FFMUhfD0gURiGhCx5bSn+bHhJxm1U24k0V00jOnQkCgTcc+DwgDusTZrDesASSGWi+mbUyIV509X/
	4lgBHut/GDQvHq6lWBqLDvxa9ngewK3JSNyszfDbtDd3PFHc+fXzKivWG07hdBIWYB664K1SSC7lk
	iitUx/lDGGibEyXFwu59Jv0Hf7HVuvRYpETGb/cH2CmU+5oZZaLBfdBpLMNLUcK0yTh00iuvE8DJk
	wQuSqfCw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLJod-0000000FOH9-0ciY;
	Tue, 18 Nov 2025 11:24:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 273DC30029E; Tue, 18 Nov 2025 12:24:06 +0100 (CET)
Date: Tue, 18 Nov 2025 12:24:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
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
	Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH] perf: Fix 0 count issue of cpu-clock
Message-ID: <20251118112406.GH4067720@noisy.programming.kicks-ass.net>
References: <20251112080526.3971392-1-dapeng1.mi@linux.intel.com>
 <20251118110309.GP3245006@noisy.programming.kicks-ass.net>
 <20251118110417.GI4068168@noisy.programming.kicks-ass.net>
 <baf8aceb-5caa-4c3b-80f0-43a4a1449a23@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baf8aceb-5caa-4c3b-80f0-43a4a1449a23@linux.intel.com>

On Tue, Nov 18, 2025 at 07:22:24PM +0800, Mi, Dapeng wrote:
> 
> On 11/18/2025 7:04 PM, Peter Zijlstra wrote:
> > On Tue, Nov 18, 2025 at 12:03:09PM +0100, Peter Zijlstra wrote:
> >> On Wed, Nov 12, 2025 at 04:05:26PM +0800, Dapeng Mi wrote:
> >>
> >>> diff --git a/kernel/events/core.c b/kernel/events/core.c
> >>> index f6a08c73f783..77d3af5959c1 100644
> >>> --- a/kernel/events/core.c
> >>> +++ b/kernel/events/core.c
> >>> @@ -11964,7 +11964,7 @@ static int cpu_clock_event_add(struct perf_event *event, int flags)
> >>>  
> >>>  static void cpu_clock_event_del(struct perf_event *event, int flags)
> >>>  {
> >>> -	cpu_clock_event_stop(event, flags);
> >>> +	cpu_clock_event_stop(event, flags | PERF_EF_UPDATE);
> >>>  }
> >>>  
> >>>  static void cpu_clock_event_read(struct perf_event *event)
> >>> @@ -12043,7 +12043,7 @@ static int task_clock_event_add(struct perf_event *event, int flags)
> >>>  
> >>>  static void task_clock_event_del(struct perf_event *event, int flags)
> >>>  {
> >>> -	task_clock_event_stop(event, PERF_EF_UPDATE);
> >>> +	task_clock_event_stop(event, flags | PERF_EF_UPDATE);
> >>>  }
> >> I think it can both just be: PERF_EF_UPDATE. The only pmu::del() caller
> >> hands in flags=0, but if there were to be flags added, we'd have to
> >> audit all del methods anyway.
> >>
> >> Also, the few comments we do have already note that ->del() must do
> >> ->stop(EF_UPDATE).
> > Updated patch now sits in queue/perf/urgent.
> 
> Hi Peter,
> 
> Thanks for merging. If we decide not to or the "flags", then the last
> sentence "Besides, or flags with PERF_EF_UPDATE for task-clock although
> currently the flags argument would always be 0." in the commit message
> should be dropped as well. :)

Should be fixed now. Thanks!
