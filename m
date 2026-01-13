Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17F233F8A3;
	Tue, 13 Jan 2026 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301499; cv=none; b=MNiwCeuoDK9RZ8+TjDy0s5fAZ1PzaCQJxHrpSaOSMrQx/sPA/hiZvq8i4mcf5TyNRWCJvp4ijx1uFa6Vgiumgmbv3mRAJup2MaHnIXHiA9dIqCrC+tSBPGRZxUoDmxFbo/InKvNyrU8ev+rxE11swPP20NMrQGofMfV8nncdZC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301499; c=relaxed/simple;
	bh=aqxjaU2m9mjQx0tQLyP7rvp0vQJAZs8ZLarzwBT1X/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3UvvSKXUbj3c0Xsp0fRthQ5vx4u23YFo6jBvA5mtsygf5DMEIoniknfEnrEvdin2/YxZ4MLm+TA06eE3isaRICPpHmd9XA0VVIarGHsOacpL2q4nDXKgRCuUqhpv1KIyUd25WJuZkwRfXe8EwX/h4sH4I7aRwd9jE/6jdNQQis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k8IZ5sHl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k8IZ5sHl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ufe8XBNPUy1yGKDMVlcndcgcQzd1ulvCzV+HMuWpKKA=; b=k8IZ5sHldqsuiOFtDWzwa4ozXW
	s1rDaRlh1NAowSiiKgN7R4/8KGtk47bIu0vAgEFOG22qhwUViIEMsJusune98P0JZLX4LInJCHEwG
	xvo5LnNLWiCm8Jtyd53YqAeyn+jtdKDuv+AfeL8dErVPTlyVpVBjyc+eBZ1dPCzKFNrfyDhplHbSY
	Thlaoc/XkrgDLuamvoRMx1D0fmoinFU33cgpJYJQxJUqrkxifvQPgshsX7RwyWd1CgLTzF1jtzePE
	kQ47PR5mxe5+i54UE69/gjzTw3RWxepCjCBuziREyI2kfoyGaYmmS+aWbbDN8jfd4pUPqtCwiXZbM
	mUAj1Kaw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfbzn-00000004bV7-0H36;
	Tue, 13 Jan 2026 10:51:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8CFB93005AF; Tue, 13 Jan 2026 11:51:30 +0100 (CET)
Date: Tue, 13 Jan 2026 11:51:30 +0100
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
Subject: Re: [Patch v2 7/7] perf/x86/intel: Add support for rdpmc user
 disable feature
Message-ID: <20260113105130.GW830755@noisy.programming.kicks-ass.net>
References: <20260112051649.1113435-1-dapeng1.mi@linux.intel.com>
 <20260112051649.1113435-8-dapeng1.mi@linux.intel.com>
 <20260112105738.GG830755@noisy.programming.kicks-ass.net>
 <35123882-b909-43b7-879d-f3802dca2da1@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35123882-b909-43b7-879d-f3802dca2da1@linux.intel.com>

On Tue, Jan 13, 2026 at 10:29:38AM +0800, Mi, Dapeng wrote:
> 
> On 1/12/2026 6:57 PM, Peter Zijlstra wrote:
> > On Mon, Jan 12, 2026 at 01:16:49PM +0800, Dapeng Mi wrote:
> >
> >> +static void intel_pmu_update_rdpmc_user_disable(struct perf_event *event)
> >> +{
> >> +	/*
> >> +	 * Counter scope's user-space rdpmc is disabled by default
> >> +	 * except two cases.
> >> +	 * a. rdpmc = 2 (user space rdpmc enabled unconditionally)
> >> +	 * b. rdpmc = 1 and the event is not a system-wide event.
> >> +	 *    The count of non-system-wide events would be cleared when
> >> +	 *    context switches, so no count data is leaked.
> >> +	 */
> >> +	if (x86_pmu_has_rdpmc_user_disable(event->pmu)) {
> >> +		if (x86_pmu.attr_rdpmc == X86_USER_RDPMC_ALWAYS_ENABLE ||
> >> +		    (x86_pmu.attr_rdpmc == X86_USER_RDPMC_CONDITIONAL_ENABLE &&
> >> +		     event->ctx->task))
> >> +			event->hw.config &= ~ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE;
> >> +		else
> >> +			event->hw.config |= ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE;
> >> +	}
> >> +}
> > Is it not simpler to invert that condition?
> >
> > 	if (x86_pmu.attr_rdpmc == X86_USER_RDPMC_ALWAYS_NEVER ||
> > 	    !event->ctx->task)
> > 		event->hw.config |= ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE;
> > 	else
> > 		event->hw.config &= ~ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE;
> 
> Hmm, it seems the logic changes along with the code change. The system-wide
> event should be allowed to read with rdpmc from user space when attr_rdpmc
> == X86_USER_RDPMC_ALWAYS_ENABLE, but it doesn't with the new code.

Bah, indeed. Oh well.
