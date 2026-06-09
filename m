Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FFC48A2A1;
	Tue,  9 Jun 2026 15:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020115; cv=none; b=q2jF6ixRR38bEXbEtcNg8rdWDzqEovlvgVcdHAZAe7bjp3j58EQl/WY4+wGgSor5O1uQk9e+RByQbvK1VSKRe3IgIcMQMQLdgCLly5r0nKmOstC3piSEfEw2qv/55tsGqcIpMhvo7U7K0d0Wu0J9xlYc0nF3fLexdUDA6DOU5Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020115; c=relaxed/simple;
	bh=ImnIoee5onDHjrcTFYmtQJvmJotODJPtHB+sKhkNym0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBVLKXCPaX6VF3+byPVJDVcyXJCMZvA0kiXLVPCZEMWhGxG5A6aYn+A5wrRMMCTz8g2aC2/bLxRiQwDdtbaYg6IhzfqaN9+M0DDn5bQSB7sxbejDtQTeT8OWjjzYdLh2iZBSdfVrVbW/9TT6h5r1EV94jzNR1VwigQ4MOTgYHzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZbQwY9r9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZbQwY9r9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=89kaOsICHrLAJhB1g6xne0LAEm5RZWANfXlE1A7ejgY=; b=ZbQwY9r9XhTTWb4wW3PAOMCTf7
	mQNmO3+jZEuefsY7Op1XuSPVHgT8lfUDlNccfgZcoCPOtxxtJFeu2dy0eZ4sJz15WbYM9zILFV/EO
	PRGnT4exa+Q9gf2jTDEmz3iLJUGT/IooUGjgPDND0RBKwbjuYwY/W7jZhCTZyvoSueZuAScloHByP
	2asRINfQ7M21OHJAwTw1YkeJ9MgOz38tiTPOqpdy2zmj+Ei1/f3G1KuvJALQJqXBDRxeJM46P66UY
	Jkjf/N3d49l8ZfGi4XvUUBR5Y8E376MPc8ODcX8iceQ9IuzM3VYyR5ojF2EBQSqK1SjIrqok5+yUD
	k7aU6wUQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wWxkT-00000002g5N-3qko;
	Tue, 09 Jun 2026 14:48:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 516E2302F12; Tue, 09 Jun 2026 16:48:12 +0200 (CEST)
Date: Tue, 9 Jun 2026 16:48:12 +0200
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
	Xudong Hao <xudong.hao@intel.com>
Subject: Re: [Patch v2 3/9] perf/x86: Update cap_user_rdpmc base on rdpmc
 user disable state
Message-ID: <20260609144812.GB49951@noisy.programming.kicks-ass.net>
References: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
 <20260609050222.2458129-4-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609050222.2458129-4-dapeng1.mi@linux.intel.com>

On Tue, Jun 09, 2026 at 01:02:16PM +0800, Dapeng Mi wrote:

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 3bd0522afe6d..6cd95b8e31cb 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2797,6 +2797,9 @@ void arch_perf_update_userpage(struct perf_event *event,
>  	userpg->cap_user_time_zero = 0;
>  	userpg->cap_user_rdpmc =
>  		!!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT);
> +	if (x86_pmu_has_rdpmc_user_disable(event->pmu) &&
> +	    event->hw.config & ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE)
> +		userpg->cap_user_rdpmc = 0;
>  	userpg->pmc_width = x86_pmu.cntval_bits;
>  
>  	if (!using_native_sched_clock() || !sched_clock_stable())

Remember, this is evaluated very very often. So it makes more sense to
ensure the hw.flags state is correct such that this remains a simple
expression.
