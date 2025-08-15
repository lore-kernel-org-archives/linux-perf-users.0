Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC30531770C;
	Fri, 15 Aug 2025 20:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755288431; cv=none; b=l051ZfHZYvjK07oELh3i+K1iXUldH57bG6MYd4JvHooysk6dwhHtbmzqCV1E5siXmWUGiLshqW8ETTInEswSuGmauWZCqab/ZEfv/CIGp4rB0VHuPu3N/jve+p4Y/VPDFVWQa9lshzQ/jW4Z6aGChImhPVxf/Sa1LMhO+0iAu3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755288431; c=relaxed/simple;
	bh=LB0I6qgS47+4b3ACqA7gDZLekADLJqAEu/NklHRK1Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpmSwlvxTXd7EWqVDpQD606wypJUkkBhxuQL6toDKUxU1lx7mj0vdoJUIq/MPAcLgf8UO93ooWPRDhX6Zxg6jkDVjaOf3Pwh5cvup6txoQtWcSoEHcMGrKrrMtU0sbkI1UdSObmBfsDuQVEkXX108J2ZJrpBPs6ZqyoHU5T6tYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1TuKXV0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1TuKXV0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2174C4CEF1;
	Fri, 15 Aug 2025 20:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755288429;
	bh=LB0I6qgS47+4b3ACqA7gDZLekADLJqAEu/NklHRK1Lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U1TuKXV0zuuYuQ/xu1AQw/+dHKcdmW2RTSrfktt1nAvi9dPKB3gDkrI2bjYk+cdvO
	 fPLLRmDY2KamWJ2CW9g/dk1ewvK8EDrLnQQ/SCqYd2+Ch7wcetEaQjV6qpaI6A35Lw
	 E2wypstacgBT53z8hx+6Hj+BbTBd6U1vlzQ5/oQa/E0gvWhxdHgAvGn58X8aIDl9GA
	 BOTuBFuQAcEQfinY4VFkQbCEaQ7fvIuy6d532xdpG/EqrltyWqOEnqvu7YWcMcERqj
	 rtX0mqjNTssg8gec0gXC2H6mdBG9XQoE2gdZlMRnN6kJmOQjEFqDYtsGhsfhZeh5V2
	 EtfAHe0za9x7A==
Date: Fri, 15 Aug 2025 13:07:07 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf test: Add test case for event group throttling with
 inactive events
Message-ID: <aJ-Ta0axsWXH2b6p@google.com>
References: <20250813163251.490451-2-ysk@kzalloc.com>
 <aJ5Bt1q3AZFxxz_U@google.com>
 <a40f008e-d552-4ce2-8279-5a25183b7726@kzalloc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a40f008e-d552-4ce2-8279-5a25183b7726@kzalloc.com>

On Fri, Aug 15, 2025 at 05:23:44AM +0900, Yunseong Kim wrote:
> Hi Namhyung,
> 
> Thanks for your reply.
> 
> On 8/15/25 5:06 AM, Namhyung Kim wrote:
> > Hi Yunseong,
> > 
> > On Wed, Aug 13, 2025 at 04:32:52PM +0000, Yunseong Kim wrote:
> >> A recent UBSAN shift-out-of-bounds report was identified when throttling
> >> event groups that included inactive (PERF_EVENT_STATE_OFF) events.
> >> This occurred because pmu->start()/stop() could be called on these events,
> >> potentially leaving event->hw.idx at -1. This leads to undefined behavior
> >> when PMU code later uses this negative index as a shift exponent.
> >>
> >> The issue need to ensuring perf_event_throttle() and
> >> perf_event_unthrottle() skip inactive events entirely.
> >>
> >> Introduce a new perf test suite, "event group throttle", to verify this
> >> fix and prevent regressions.
> > 
> > Thanks for your work!
> > 
> > I'm curious what happens if it runs on unfixed kernels.  I suspect this
> > should be in the selftest so that it can tie with the kernel fix.
> 
> I agree with your point. I believe it's more appropriate for this test to
> be included in "kself test" alongside the kernel fix. I'll modify the
> test case based on Liang's suggestion.
> 
> > By having this in the perf tools test suite, you cannot guarantee if the
> > kernel has the fix.  And it may turn the kernel into an unstable state
> > easily.
> 
> Would it be possible to add this test if it were changed to focus on
> a different aspect?

It depends on how you change it.  Can you please share your idea first?

Thanks,
Namhyung

