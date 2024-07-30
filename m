Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C3B1AA3C5
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Jul 2024 19:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722367731; cv=none; b=sUitYigelCpHZ9rhEWSG9TF5+RCjUQEOYblCUpbtVDGPZtNhyyBNZrChUHmt1Df8gaGSxhJkj/eLos73XkbuD/UUmFZols4jRz9mpzmUaUXOHkv9fXeH9zVVCjvKTsVyAIhSLY2vfkdqswfNgY44lA/IfBUY3sYQm+Eqmt1H0SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722367731; c=relaxed/simple;
	bh=FrnjJAUe++DPW3rNUH9s80QPCeqSyCMElIaO/EUTRmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzP7g4gy1eFY6znQBgTvib85L+MNtwr2X9oHmop3Bs7XP1DcdNHwJk9ElbLwlurhrboKf5/fehhwtbOzqZBESKgkZq/jB3pRF+gmzfs5zlfRSH1QPqUbg8D5Ze+PiNYvjvFMp0lndWXcZkThaN3ASUyod5M8q0HJugLGlr3LNts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q21vgwB+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q21vgwB+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E3DC32782;
	Tue, 30 Jul 2024 19:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722367731;
	bh=FrnjJAUe++DPW3rNUH9s80QPCeqSyCMElIaO/EUTRmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q21vgwB+/SJWf4SZovIRuZOe0jO70UaDqzDCwNTRb+/2VjH8bRnb6I+g5puDTYrxH
	 yqTCwVA7YZUyzIWK9wW5p3zl9BzePjZSK7I6rE/2HKzcSRtMMuOc8+xTjcWzzWLMym
	 tB/mnW6jx/qYM9/l+ZKsz8Iw/o3TNofRsXd6neywjAxmgvHKDAvULV+7dfAmoYOAME
	 FxNqlbhIcpehLkZ+jERsJIoWh59DH+qjqe2xi6CoiMKwRAw9GIOEeVbTyst8Rs15Fm
	 O+pLmm0HjBFCPNKR33fShJP5K4oB1oETrk1ZCX3nUQWMgvx3KrxgpWMbwAycMZUG4m
	 7K6M1CyFiiFzg==
Date: Tue, 30 Jul 2024 16:28:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/4] perf auxtrace: Iterate all AUX events when finish
 reading
Message-ID: <Zqk-7mmQ1UoiqK-X@x1>
References: <20240725064620.1651819-1-leo.yan@arm.com>
 <20240725064620.1651819-2-leo.yan@arm.com>
 <bb8e5202-bffa-4cd6-b49c-6372d51b405b@intel.com>
 <20d8889f-fed1-4642-9baa-c86228d394f7@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20d8889f-fed1-4642-9baa-c86228d394f7@arm.com>

On Mon, Jul 29, 2024 at 09:48:57AM +0100, Leo Yan wrote:
> On 7/25/2024 4:40 PM, Adrian Hunter wrote:
> > On 25/07/24 09:46, Leo Yan wrote:
> >> When finished to read AUX trace data from mmaped buffer, based on the
> > 
> > Here and elsewhere 'mmapped' is more common than 'mmaped' so maybe:
> > 
> >         mmaped -> mmapped
> 
> Will fix.
> 
> >> AUX buffer index the core layer needs to search the corresponding PMU
> >> event and re-enable it to continue tracing.
> >>
> >> However, current code only searches the first AUX event. It misses to
> >> search other enabled AUX events, thus, it returns failure if the buffer
> >> index does not belong to the first AUX event.
> >>
> >> This patch extends the auxtrace_record__read_finish() function to
> >> search for every enabled AUX events, so all the mmaped buffer indexes
> >> can be covered.
> > 
> > Looking at this again, a couple more things came to mind - see below.
> > 
> >>
> >> Signed-off-by: Leo Yan <leo.yan@arm.com>
> >> ---
> >>  tools/perf/util/auxtrace.c | 25 ++++++++++++++++++++-----
> >>  1 file changed, 20 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> >> index b99e72f7da88..61835a6a9ea3 100644
> >> --- a/tools/perf/util/auxtrace.c
> >> +++ b/tools/perf/util/auxtrace.c
> >> @@ -670,18 +670,33 @@ static int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel,
> >>  int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
> >>  {
> >>       struct evsel *evsel;
> >> +     int ret = -EINVAL;
> >>
> >> -     if (!itr->evlist || !itr->pmu)
> >> +     if (!itr->evlist)
> >>               return -EINVAL;
> >>
> >>       evlist__for_each_entry(itr->evlist, evsel) {
> >> -             if (evsel->core.attr.type == itr->pmu->type) {
> >> +             if (evsel__is_aux_event(evsel)) {
> >>                       if (evsel->disabled)
> >> -                             return 0;
> >> -                     return evlist__enable_event_idx(itr->evlist, evsel, idx);
> >> +                             continue;
> > 
> > That will make the evsel->disabled case an error, which
> > might be a problem. Possibly the event can be disabled
> > (e.g. via control fifo) but still have data to read out.
> 
> If so, we need to extend evlist__enable_event_idx() or create a new function
> to check if the memory index is belonged to an evsel. If the idx is found for
> an evsel, then we can check the evsel->disabled flag.
> 
> >> +                     /*
> >> +                      * Multiple AUX events might be opened in a session.
> >> +                      * Bail out for success case as the AUX event has been
> >> +                      * found and enabled, otherwise, continue to check if
> >> +                      * the next AUX event can cover the mmaped buffer with
> >> +                      * 'idx'.
> >> +                      */
> > 
> > Thinking about this some more, raised some questions:
> > 
> > How do we know there is only one AUX event per mmap?
> 
> On my test platform, there have two Arm SPE events, the first one's cpumask is
> 2-5 and the second SPE's cpumask is 6-7. The AUX events do not intersect CPU
> maps. Therefore, a mmapped AUX buffer only binds to a AUX event.
> 
> I think we can add a checking in the function record__auxtrace_init(). After
> it calls auxtrace_record__init(), we can report failure if the AUX events have
> the overlapped cpumask.
> 
> > They would have to be on different CPUs for that to be true?
> 
> Yes.
> 
> > And wouldn't --per-thread have all AUX events in every mmap?
> 
> Before I roughly tested '--per-thread' mode and did not see issue. But this
> time I tested '--per-thread' mode and found the failure by the kernel checking
> [1] - it does not allow the different AUX events to bind to the same FD.
> 
> Here I need to dig a bit for two options, either we need to fix the perf
> tool to open multiple AUX events for '--per-thread' mode, or remove the
> kernel's checking to allow different AUX events to bind to same FD.
> 
> Thanks a lot for review!

Ok, the two patches from Adrian are in, I'll now wait for you to refresh
this series,

Thanks,

- Arnaldo
