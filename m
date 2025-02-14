Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0F47081C;
	Fri, 14 Feb 2025 01:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739496442; cv=none; b=Re66qGMFQUYWNtGggblLfQ3Oic8OKfivog47oQOI8K0kWAjacfhx9pDZNxYIeSB4i36+BUwIH0Mt+hMzJFr6mVc71Yuk9HHGCyKJy8427s5rSj4KQPWyKebzaZ3Gx32xOtWX6K6yYVk9et7RIEopGpEYoCsTGPuEKXInFu4W9Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739496442; c=relaxed/simple;
	bh=Tw2ys3ocF6gdBGnWzCtn8X1+JhzVVjWEPt15oDLoFP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tj4xKk+4SatWJy9BFfUTautGLnyHfLTe1oZ/Cc5kU6bckEqx5KdsCD+nhD7F0jOT42ITtoO5j9tPg3dnOhoJlR4G0cwl5U3ach3IBCuID0Q2cmGKIKBzyiFHbXNYnEQcecQqGGHKT/kDI6QI31yC5c8U9mubPfzvyK22UBHBuT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLsqYtMC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLsqYtMC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5EAC4CED1;
	Fri, 14 Feb 2025 01:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739496442;
	bh=Tw2ys3ocF6gdBGnWzCtn8X1+JhzVVjWEPt15oDLoFP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QLsqYtMCOieuWF8B+QYNWaHVU3taYQhMjlw0lytp54H0k6xcYIP53+mQPq1rm2J+O
	 eT8iDoLi6LYKxcbtakEcwDk1SGJ4/E9750y/I7ygt3SuYbj9sxkHkjmWpJwVUzg9b8
	 hTOKDCbzR5mO4fxQGk7ikJfxLEuInq2dXwDWvaG0F4imjecd39YlEOcnZ6bGltY+zq
	 gA2wCpFLP8AA5vklKx32ocCJrM8zyMbvEMbmmE//acTZBLuwDUFoTZymcNPc+i6SOq
	 5nDuV2MrIqI84BDhG5tRT/AKO4QiJ+ZT1KAXizeEd/xv3smcPjJkGXxEIMZsMSaQxC
	 xL6Zp8kH16/IA==
Date: Thu, 13 Feb 2025 17:27:19 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>, Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, Robin.Murphy@arm.com,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf stat: Fix non-uniquified hybrid legacy events
Message-ID: <Z66b9-I_MkmX7pg5@google.com>
References: <20250212122413.1184503-1-james.clark@linaro.org>
 <CAP-5=fWywDB40-RgV8LaPqsoffOLdDcYkUB_LHoPvV=R8yas4w@mail.gmail.com>
 <CAP-5=fV0rWEL-ewGpoDwaJ3rvbTPXSx0YTuF5p9=6+h5oUhsfg@mail.gmail.com>
 <c672c3a3-64e3-495a-ae61-ae098d30c6b9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c672c3a3-64e3-495a-ae61-ae098d30c6b9@linaro.org>

Hello,

On Thu, Feb 13, 2025 at 12:15:30PM +0000, James Clark wrote:
> 
> 
> On 12/02/2025 9:38 pm, Ian Rogers wrote:
> > On Wed, Feb 12, 2025 at 9:48 AM Ian Rogers <irogers@google.com> wrote:
> > > 
> > > On Wed, Feb 12, 2025 at 4:24 AM James Clark <james.clark@linaro.org> wrote:
> > > > 
> > > > Legacy hybrid events have attr.type == PERF_TYPE_HARDWARE, so they look
> > > > like plain legacy events if we only look at attr.type. But legacy events
> > > > should still be uniquified if they were opened on a non-legacy PMU.
> > > > Previously we looked at the PMU type to determine legacy vs hybrid
> > > > events here so revert this particular check to how it was before the
> > > > linked fixes commit.
> > > > 
> > > > counter->pmu doesn't need to be null checked twice, in fact it is
> > > > required for any kind of uniquification so make that a separate check.
> > > > 
> > > > This restores PMU names on hybrid systems and also changes "perf stat
> > > > metrics (shadow stat) test" from a FAIL back to a SKIP (on hybrid). The
> > > > test was gated on "cycles" appearing alone which doesn't happen on
> > > > here.
> > > > 
> > > > Before:
> > > > 
> > > >    $ perf stat -- true
> > > >    ...
> > > >       <not counted>      instructions:u                           (0.00%)
> > > >             162,536      instructions:u            # 0.58  insn per cycle
> > > >    ...
> > > > 
> > > > After:
> > > > 
> > > >   $ perf stat -- true
> > > >   ...
> > > >       <not counted>      cpu_atom/instructions/u                  (0.00%)
> > > >             162,541      cpu_core/instructions/u   # 0.62  insn per cycle
> > > >   ...
> > > > 
> > > > Fixes: 357b965deba9 ("perf stat: Changes to event name uniquification")
> > > > Signed-off-by: James Clark <james.clark@linaro.org>
> > > > ---
> > > >   tools/perf/util/stat-display.c | 9 +++++++--
> > > >   1 file changed, 7 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > > > index e65c7e9f15d1..eae34ba95f59 100644
> > > > --- a/tools/perf/util/stat-display.c
> > > > +++ b/tools/perf/util/stat-display.c
> > > > @@ -1688,12 +1688,17 @@ static void evsel__set_needs_uniquify(struct evsel *counter, const struct perf_s
> > > >                  return;
> > > >          }
> > > > 
> > > > -       if  (counter->core.attr.type < PERF_TYPE_MAX && counter->core.attr.type != PERF_TYPE_RAW) {
> > > > +       if (!counter->pmu) {
> > > 
> > > Thanks James, I wish I had a hybrid laptop so I didn't keep breaking
> > > things like this. I'm uncomfortable using an evsel having/not-having a
> > > PMU as an indication of whether uniquification is necessary. It is
> > > kind of a side-effect of parsing whether the PMU variable is non-NULL,
> > > it'd kind of be nice to stop things using `evsel->pmu` directly and
> > > switch them to `evsel__find_pmu(evsel)`, in the future maybe legacy
> > > events will get the core PMU, a tracepoint PMU, etc. so we'd never
> > > expect this variable to be NULL.
> 
> As it stands evsel__uniquify_counter() unconditionally dereferences
> evsel->pmu which is why I thought it made sense to check that first. But if
> that might change then fair enough.
> 
> > > 
> > > Your commit message gives me enough to think about what the issue is,
> > > so let me give it some thought.
> > 
> > I wonder we should just hoist the hybrid test earlier:
> > ```
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > index e65c7e9f15d1..e852ac0d9847 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -1688,6 +1688,12 @@ static void evsel__set_needs_uniquify(struct
> > evsel *counter, const struct per
> > f_s
> >                 return;
> >         }
> > 
> > +       if (!config->hybrid_merge && evsel__is_hybrid(counter)) {
> > +               /* Unique hybrid counters necessary. */
> > +               counter->needs_uniquify = true;
> > +               return;
> > +       }
> > +
> >         if  (counter->core.attr.type < PERF_TYPE_MAX &&
> > counter->core.attr.type != PERF_TYPE_RAW) {
> >                 /* Legacy event, don't uniquify. */
> >                 return;
> > @@ -1705,12 +1711,6 @@ static void evsel__set_needs_uniquify(struct
> > evsel *counter, const struct per
> > f_s
> >                 return;
> >         }
> > 
> > -       if (!config->hybrid_merge && evsel__is_hybrid(counter)) {
> > -               /* Unique hybrid counters necessary. */
> > -               counter->needs_uniquify = true;
> > -               return;
> > -       }
> > -
> >         /*
> >          * Do other non-merged events in the evlist have the same name? If so
> >          * uniquify is necessary.
> > 
> > ```
> > 
> > The hybrid test is unfortunately expensive at it needs to search for
> > > 1 core PMU, which means loading all sysfs PMUs. I think we're already
> > paying the cost though.
> > 
> > Could you check this works James?
> > 
> > Thanks,
> > Ian
> > 
> 
> Yep that works too.

James, can I take it as your Tested-by?

Ian, can you please send a formal patch with that?

Thanks,
Namhyung

