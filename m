Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01522010F2;
	Thu, 23 Jan 2025 09:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737623657; cv=none; b=GlzGZem9zoro/y6p+V5p+qzF/fgmvNG4Gsq8F1PnMGFMKSCbgnL088ye9Xm1ibw8ihQWBK0Jx0yOm2FZNweWObWwQxhWLWNo+VEhNvtMyGk8LAMYafo5yP8OArZHyKU/Cf2nyjrqWKQxdzcfYKax5m6X6qs5MrLMJFQk6xeWoIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737623657; c=relaxed/simple;
	bh=UhEgZubK54fEPqXm/asIEOwWn/TImv/6W1gP46DzVEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkMzH2JNpx1w0Pg6ll77P0q6d+JwF6iNnNMMuMRW7IdJBYmF2R7yGyqrX6qS/nUzoiEz9JEsgOOqhF2jbezOg4ElOd4JHz8XmJR+9PS1TdZV8sXric18WGZNxEZ/ixIYfV8RBrl5K84ttg02QAnM4aXo5r/TbK0hluwq/mzSOcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ewmgdo4m; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ewmgdo4m"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4gk8VcCUdUgjoW54ObMOvOEf7lv/rECHs3E4nbb1c1c=; b=ewmgdo4mIuMQyPFe+ikPGSyFap
	12z3vfgeItTMwCuQvfv4OuqrtSZgdL97hOj0GNu4+sz1AYx5ChBdKQvbAgP/qS6hXsw6J89v9+Pbj
	q7VeOu3DUVlrlWOdlyirElF9oevtdNwY3xxxBNjidSP3VOe9uvtMJMa3CXk/BeYnz7Nv/M/qdtOiA
	I1/6HxQPP5JxozQDP/EQUHUoJWRXfl8bNc9Wzl+3jRevxWg+G6LV5sL7WZ+XNS2Qn0DCT0reXhZ6x
	1JkBRUQBrF1CWIevIcn0k8+KwdYXJ97NnAfMjWKnumYLd90uSLPxZuK/x6xbwg8iYCuKApxzvpFed
	ctM10M0Q==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tatHt-0000000DlLD-12uQ;
	Thu, 23 Jan 2025 09:14:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1BF983006E6; Thu, 23 Jan 2025 10:14:08 +0100 (CET)
Date: Thu, 23 Jan 2025 10:14:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	ak@linux.intel.com, eranian@google.com, dapeng1.mi@linux.intel.com
Subject: Re: [PATCH V9 3/3] perf/x86/intel: Support PEBS counters snapshotting
Message-ID: <20250123091407.GJ3808@noisy.programming.kicks-ass.net>
References: <20250115184318.2854459-1-kan.liang@linux.intel.com>
 <20250115184318.2854459-3-kan.liang@linux.intel.com>
 <20250116114751.GJ8362@noisy.programming.kicks-ass.net>
 <be90e73b-eedf-4ff0-a832-b579e003cac9@linux.intel.com>
 <20250116204225.GA7232@noisy.programming.kicks-ass.net>
 <20250116205659.GA15641@noisy.programming.kicks-ass.net>
 <7f0ed750-b4b3-4adc-98d2-1e9cccd3bf02@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f0ed750-b4b3-4adc-98d2-1e9cccd3bf02@linux.intel.com>

On Thu, Jan 16, 2025 at 04:50:01PM -0500, Liang, Kan wrote:
> 
> 
> On 2025-01-16 3:56 p.m., Peter Zijlstra wrote:
> > On Thu, Jan 16, 2025 at 09:42:25PM +0100, Peter Zijlstra wrote:
> >> On Thu, Jan 16, 2025 at 10:55:46AM -0500, Liang, Kan wrote:
> >>
> >>>> Also, I think I found you another bug... Consider what happens to the
> >>>> counter value when we reschedule a HES_STOPPED counter, then we skip
> >>>> x86_pmu_start(RELOAD) on step2, which leave the counter value with
> >>>> 'random' crap from whatever was there last.
> >>>>
> >>>> But meanwhile you do program PEBS to sample it. That will happily sample
> >>>> this garbage.
> >>>>
> >>>> Hmm?
> >>>
> >>> I'm not quite sure I understand the issue.
> >>>
> >>> The HES_STOPPED counter should be a pre-existing counter. Just for some
> >>> reason, it's stopped, right? So perf doesn't need to re-configure the
> >>> PEBS__DATA_CFG, since the idx is not changed.
> >>
> >> Suppose you have your group {A, B, C} and lets suppose A is the PEBS
> >> event, further suppose that B is also a sampling event. Lets say they
> >> get hardware counters 1,2 and 3 respectively.
> >>
> >> Then lets say B gets throttled.
> >>
> >> While it is throttled, we get a new event D scheduled, and D gets placed
> >> on counter 2 -- where B lives, which gets moved over to counter 4.
> >>
> >> Then our loops will update and remove B from 2, but because
> >> throttled/HES_STOPPED it will not start it on counter 4.
> >>>> Meanwhile, we do have the PEBS_DATA_CFG thing updated to sample counter
> >> 1,3 and 4.
> >>
> >> PEBS assist happens, and samples the uninitialized counter 4.
> > > Also, by skipping x86_pmu_start() we miss the assignment of
> > cpuc->events[] so PEBS buffer decode can't even find the dodgy event.
> > 
> 
> Yes, counter 4 includes garbage before the B is started again.
> But the cpuc->events[counter 4] is NULL either.
> 
> The current implementation ignores the NULL cpuc->events[]. The stopped
> B should not be mistakenly updated.

Ah, indeed. I was so close.

One question though -- is this value ever exposed otherwise? I had a
quick look and I don't think we support PERF_SAMPLE_RAW for PEBS, but
what about PEBS-to-PT ? 

Anywya, let me go find this v10 thing :-)
