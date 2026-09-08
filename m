Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959524AE8D3;
	Tue,  8 Sep 2026 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862765; cv=none; b=h+MGcOXCR+YBIQsJ5XC8Fo+lrQIUprhqwrqDTfFhDJylfC8lXvXy2VvpJ0jf7rTlM9KCxnd69aBZ7VX3JPIpvNW1AoCNfE5w9FuYCa75JHty/6vExXAusAxI2ikE6GFR+hGx3rFnTbrfaxDMbfQybGUtd3xyXl257h451xBlTd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862765; c=relaxed/simple;
	bh=hEuRbTV6SvjdmFz+0877szScfVcZnzHpJeO28Pd1ZYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ReRt6XKaW/Su7qQT3JgYypi0lJbb8ZtWmvPafpHCpNxlYcQ+zaKyt9+yWwv9DSw/S1ixtvjuCxVqnxFCh6ENstKuTcoclg/6DAIB/E5xJLuBC3LO0d3mrvrxOHp5Fm900AaT5Q0Vvy8h4DL7qxK8H6zuMFMThwtVqudMdGXJlic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XDtlUVdF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XDtlUVdF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=T+kCWxG4P1csfiYeIyXplZqlim9VWnSA/EFfrPlit0w=; b=XDtlUVdFXp3lb33aUhN1at2W3G
	AdAsdDF8xYCOYMfMZ8eLploxV2WwRhcRwbA7fnJ02ruIbAdogbZ4vahqOH1myB1H5tILp5cKN60K8
	v6XA8iFRooI6MUwAuODTJ2L2+H12Q+6SNbGUzyFkD5zAzlPtzB17gvxOtXcXb/tAWWL2MT5tUvf6m
	u6GMD/vrmZNWjplokmesaS0UVWa9tNil8evn5vdUjRwdgkVlsmcjpFgtPJGrI8PWk0Tb6uMZp32kf
	MFZEgKSvNa6k944nFzYq8XRsZmmtrk5pS1BOBUG0X1hwNHRju7xNv3sTevz9w8Pn0WlHJfxLN2jEG
	5RqWqelg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3sv5-000000087VH-0oMK;
	Tue, 08 Sep 2026 10:19:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B2C71300A9A; Tue, 08 Sep 2026 12:19:14 +0200 (CEST)
Date: Tue, 8 Sep 2026 12:19:14 +0200
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
	Xudong Hao <xudong.hao@intel.com>,
	Gennady Kupava <gennady.kupava@gmail.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH 2/2] perf/x86: Disable precise sampling for
 PERF_SAMPLE_STACK_USER
Message-ID: <20260908101914.GQ4121339@noisy.programming.kicks-ass.net>
References: <20260908075102.540715-1-dapeng1.mi@linux.intel.com>
 <20260908075102.540715-2-dapeng1.mi@linux.intel.com>
 <20260908084906.GO4121339@noisy.programming.kicks-ass.net>
 <1691a05c-49a6-4b16-8bad-cb3c004ed07c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1691a05c-49a6-4b16-8bad-cb3c004ed07c@linux.intel.com>

On Tue, Sep 08, 2026 at 04:56:22PM +0800, Mi, Dapeng wrote:
> 
> On 9/8/2026 4:49 PM, Peter Zijlstra wrote:
> > On Tue, Sep 08, 2026 at 03:51:02PM +0800, Dapeng Mi wrote:
> >> PERF_SAMPLE_STACK_USER needs to return the user stack and user registers
> >> to user space when the PMI exits. Since the skid from the PEBS/IBS sample
> >> and PMI delivery, the PEBS/IBS register snapshot (especially IP/SP/BP)
> >> can diverge from the user stack at PMI return. That mismatch breaks DWARF
> >> unwinding.
> >>
> >> Precise sampling provides no benefit in this case, so disable PEBS/IBS
> >> precise sampling and allow only PMI-based sampling when
> >> PERF_SAMPLE_STACK_USER is requested.
> >>
> >> Reported-by: Gennady Kupava <gennady.kupava@gmail.com>
> >> Closes: https://lore.kernel.org/all/CAPu-DQqF0aF6=GS8Z6KKWeeX_V5LiXeKU_rJQZC+uGg8zuTPNw@mail.gmail.com/
> >> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> >> Fixes: c5ebcedb566e ("perf: Add ability to attach user stack dump to sample")
> >> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > This breaks long standing existing behaviour.
> 
> Yeah, but it seems there is no better way to fix this issue.

Breaking things that worked before isn't fixing.. people get upset.

> An alternative way to fix this issue is still to return the PMI
> context register state rather than the PEBS precise registers for user
> stack sampling, but this actually falls back the imprecise PMI-based
> sampling. 

That's what we already do, no? I have distinct memories of making the
stack unwind use the NMI regs rather then the PEBS regs.

> In my opinion, it could even make the thing worse. User
> requires to get precise samplings, but perf silently returns imprecise
> records, this would mislead user. 

Mostly just the unwind might be off a little, the rest is accurate. This
has been the case 'forever'. Performance analysis isn't for silly
people, if they can't deal with a little fuzz then perhaps they're in
the wrong business.
