Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600C326A0DB;
	Wed, 26 Nov 2025 11:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764155975; cv=none; b=P3y2jMlhPkW1DkEwLYUqpwG4dgPxtQH/XUzeZ9zmlZkmKDdxUYFK5FWvTiLR+H4a5OJ2Sv3Inuej2vOizMxjCYcmiQ0s/9JyHH9+RnByLWdeYbgHnNc3abXtDssDAjWl7YtAIjlMvm1Vaqk+4a0smbbFqJGyS5Ut2TK1xxvNkYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764155975; c=relaxed/simple;
	bh=Jrynlb2YauEhL5Oo+0bXgS4GGTSvPw/4Tp2MZ26ouCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTS1wJYoLKeYEhbb6cni5nXHsl+bu+80WWLWalTeua1X0l5ocuHSNptDQmoLrG4SJyitiDYOtFNWOvjhI7qLuf51FP2Ppy7nWWqX7ZGUyFdsoDGv4vwAVIHJ0Wx+KHVEI8VYc1Na06rcebS1FR/So3ZCN6uTjTr1DVA2DBgxreU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PYh8Cm+A; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PYh8Cm+A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2tTKYzeAKmskwEPJDRmck9uGQFR/WVms+j+qZKExltA=; b=PYh8Cm+AKY2HDhGNqmTBb+P628
	lyPzPGWODdXXmy6U/BH6q7HVErfsldyWJOSRNKrAh/BqAKBlMdSolR1ypFm08JzNP5i/HH1cpjpTm
	9YH6RvMwTjWrFdzPhtdU0JIPeLOqE5yEWRGug3zudo8gkdzXNQZc1I8IRJZGq58hagsm24Tm2fSS6
	WNsONjHKzKX07FKo5WXjmkWa656cPIDjsk9LyDCvn39sXH/SoHxxRyf4j+aADXUjUigzTThIetH6E
	nfakfO7YAa+CmXi9/U7Obv+UiET4nLpWI4GZDCH6nra3MgM+fcsKs7pwG4Ml5uS5B4ZXSBtP4SA7y
	rUv8lcww==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vODYR-0000000A0Jm-09VP;
	Wed, 26 Nov 2025 11:19:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EB17A30036B; Wed, 26 Nov 2025 12:19:21 +0100 (CET)
Date: Wed, 26 Nov 2025 12:19:21 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Xianying Wang <wangxianying546@gmail.com>, akpm@linux-foundation.org,
	surenb@google.com, mhocko@suse.com, jackmanb@google.com,
	hannes@cmpxchg.org, ziy@nvidia.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [BUG] WARNING in __alloc_frozen_pages_noprof
Message-ID: <20251126111921.GU4067720@noisy.programming.kicks-ass.net>
References: <CAOU40uAHO9-59HB2VmCBfC5OiNg3BZBd-32jphtRd-nkvhD6Dg@mail.gmail.com>
 <4cb9f727-734b-43fa-92d2-80559df76c84@suse.cz>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cb9f727-734b-43fa-92d2-80559df76c84@suse.cz>

On Wed, Nov 26, 2025 at 10:46:38AM +0100, Vlastimil Babka wrote:
> +CC perf people as AFAIU the problem originates there. Should the limit
> be lowered, or the allocations e.g. switched to kvmalloc, to avoid
> requesting impossibly high order allocations?
> 
>         /*
>          * There are several places where we assume that the order value is sane
>          * so bail out early if the request is out of bound.
>          */
>         if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp))
>                 return NULL;
> 
> 
> 
> On 11/19/25 10:07 AM, Xianying Wang wrote:
> > Hi,
> > 
> > I hit the following warning in the page allocator when opening a perf
> > event with callchain sampling after increasing
> > kernel.perf_event_max_stack.This warning can be triggered by first
> > writing a large value into kernel.perf_event_max_stack and then
> > opening a perf event with callchain sampling enabled.
> > 
> > The reproducer does two things:
> > 
> > 1) It writes a large (but still accepted) value to the sysctl:
> > 
> > echo 0x40132 > /proc/sys/kernel/perf_event_max_stack
> > 

Yeah, that is far too large. I suppose the actual max is somewhere near
8k, which would give 64k data for just the callchain -- given that a
single perf buffer entry is limited to 64k (IIRC) and all that.
