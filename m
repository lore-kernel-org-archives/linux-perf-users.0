Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FA41F4291;
	Thu, 17 Oct 2024 23:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729206656; cv=none; b=OnXSMqdwrXDOPjjgrl7NES42kQyrd4dxQ4rrwhG4AOx9WLj/yKl7QOfThsSgaL34WzGgfr/gaYrNfN6LMj8EptNJr46oAlKGBdAtZs8S3RYtU66dxnCY5r1AXw1EXGADtE4ufisGeOdUnVVJalZhvcuKTyUdbWNbT5LFjdGNgJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729206656; c=relaxed/simple;
	bh=y3OGkvcrQ61QHk72F/iBT4MxYu9S1hYlJTm2WOze0Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhPunPzaA4kTvePM0hJ39N+kk8cMh0+tGDf9nxW8mmrESdE4Kz1MZ4t4xWOnyzuErVJnhKfBFwS4f79feiw5gf6822Uoq1trlOGl7GfbpXZlPO1HGC3zO9BjQzFvcGwwkJcQswY9eM/OoeO6cNkzpyVoXnF939WXfAH/9wEAMXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmBoWySJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmBoWySJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EA8C4CEC3;
	Thu, 17 Oct 2024 23:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729206655;
	bh=y3OGkvcrQ61QHk72F/iBT4MxYu9S1hYlJTm2WOze0Bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qmBoWySJQPa7X7C+UMLw//JmJUyzeuIyt7mT4V/5rqdqlTPCuNomD3YfBlIyODdsk
	 6/iBMbUTOP61DIQ+lZ9hqp7CKv9BzfMzfgfjQtdCYVWJmTyAP1sIXM4z3AhDCSaRUp
	 tMpIJNQM0Hq20WusuiLvJilsFqVkFjITCsnQUqBVHlWXOFBPvz/lrYG5uTx0vVq0Fa
	 1ntuNj6nOxA8pxJ158kUK6frFxhaIrvG+m4iX2EClLKi4l8Vzr7Z4Wj/Ut0szYSje4
	 rU6pIKRtIaZe2QAxPwekU0yrP+CJT5VFx5VWLzuwomjSTHNWhATxpZTgno5OvXfutV
	 ZL3TEzW4QnFNg==
Date: Thu, 17 Oct 2024 16:10:54 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
	acme@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] libperf: evlist: Fix --cpu argument on hybrid
 platform
Message-ID: <ZxGZfoH6pMZwANou@google.com>
References: <20241015145416.583690-1-james.clark@linaro.org>
 <20241015145416.583690-2-james.clark@linaro.org>
 <CAP-5=fW7aERe3KHtAoYX9UWsVWrhU95RcCgabgP+DNHi1whjsQ@mail.gmail.com>
 <d9a4bebe-dde1-438f-bcf7-70b7a5e21848@linaro.org>
 <CAP-5=fUi-Y408hZmPosfejOW=SkXZZTTvRm326fBz-9zrHk8ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUi-Y408hZmPosfejOW=SkXZZTTvRm326fBz-9zrHk8ew@mail.gmail.com>

On Wed, Oct 16, 2024 at 08:01:21AM -0700, Ian Rogers wrote:
> On Wed, Oct 16, 2024 at 1:29 AM James Clark <james.clark@linaro.org> wrote:
> >
> > On 15/10/2024 4:14 pm, Ian Rogers wrote:
> > > On Tue, Oct 15, 2024 at 7:54 AM James Clark <james.clark@linaro.org> wrote:
> > >>
> > >> Since the linked fixes: commit, specifying a CPU on hybrid platforms
> > >> results in an error because Perf tries to open an extended type event
> > >> on "any" CPU which isn't valid. Extended type events can only be opened
> > >> on CPUs that match the type.
> > >>
> > >> Before (working):
> > >>
> > >>    $ perf record --cpu 1 -- true
> > >>    [ perf record: Woken up 1 times to write data ]
> > >>    [ perf record: Captured and wrote 2.385 MB perf.data (7 samples) ]
> > >>
> > >> After (not working):
> > >>
> > >>    $ perf record -C 1 -- true
> > >>    WARNING: A requested CPU in '1' is not supported by PMU 'cpu_atom' (CPUs 16-27) for event 'cycles:P'
> > >>    Error:
> > >>    The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cpu_atom/cycles:P/).
> > >>    /bin/dmesg | grep -i perf may provide additional information.
> > >>
> > >> (Ignore the warning message, that's expected and not particularly
> > >> relevant to this issue).
> > >>
> > >> This is because perf_cpu_map__intersect() of the user specified CPU (1)
> > >> and one of the PMU's CPUs (16-27) correctly results in an empty (NULL)
> > >> CPU map. However for the purposes of opening an event, libperf converts
> > >> empty CPU maps into an any CPU (-1) which the kernel rejects.
> > >
> > > Ugh. The cpumap API tries its best to confuse NULL == empty but empty
> > > can give you dummy, dummy is also known as 'any' or -1, 'any' sounds a
> > > lot like 'all' but sometimes 'all' is only online CPUs. I tried to
> > > tidy up the naming a while ago, but there is still a mess.
> > >
> >
> > I don't know if you think this is a good opportunity for me to have a go
> > at finishing separating those? Or is it a dead end?
> 
> So cpumap (and threadmap) underpin a lot of things, we also used to
> routinely confuse CPU numbers with cpumap indices that are used to
> densely index xyarrays with file descriptors, etc. My thought was that
> we may end up doing a proper Rust libperf that can be under a more
> permissive license like libbpf - currently libperf is a source of GPL
> infection. The rewrite would be a good time to clear these things up.
> I believe someone at RedHat has looked at doing a Rust libperf.

I really want to rewrite CPU/thread map related code but didn't have
time to work on it. :(

It'd be great if we can rewrite it in Rust!  But current libperf API is
pretty bad and it's not clearly separated from the tools code.  For
example, accessing internals like evsel->core.xxx should be changed
first.

> 
> > >> Fix it by deleting evsels with empty CPU maps in the specific case where
> > >> user requested CPU maps are evaluated.
> > >
> > > If we delete evsels than the indices can be broken for certain things.
> > > I'm guessing asan testing is clean but the large number of side data
> > > structures that are indexed by things in another data structure makes
> > > the whole code base brittle and I am nervous around this change.
> > >
> > >> Fixes: 251aa040244a ("perf parse-events: Wildcard most "numeric" events")
> > >> Signed-off-by: James Clark <james.clark@linaro.org>
> > >
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> > >
> > > Thanks,
> > > Ian
> > >
> >
> > Ok if we're not completely opposed to doing it this way I will dig a bit
> > more and double check everything is working.
> 
> I think it is okay to do it this way (hence the reviewed-by tag) as
> propagate maps should happen before the xyarrays are set up, it'd be
> nice if these things were checked at runtime, or by the compiler...

Right, evsel index is used some places probably we need to update it
too.

Thanks,
Namhyung

> 
> > >> ---
> > >>   tools/lib/perf/evlist.c | 11 +++++++++--
> > >>   1 file changed, 9 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> > >> index c6d67fc9e57e..8fae9a157a91 100644
> > >> --- a/tools/lib/perf/evlist.c
> > >> +++ b/tools/lib/perf/evlist.c
> > >> @@ -47,6 +47,13 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
> > >>                   */
> > >>                  perf_cpu_map__put(evsel->cpus);
> > >>                  evsel->cpus = perf_cpu_map__intersect(evlist->user_requested_cpus, evsel->own_cpus);
> > >> +
> > >> +               /*
> > >> +                * Empty cpu lists would eventually get opened as "any" so remove
> > >> +                * genuinely empty ones before they're opened in the wrong place.
> > >> +                */
> > >> +               if (perf_cpu_map__is_empty(evsel->cpus))
> > >> +                       perf_evlist__remove(evlist, evsel);
> > >>          } else if (!evsel->own_cpus || evlist->has_user_cpus ||
> > >>                  (!evsel->requires_cpu && perf_cpu_map__has_any_cpu(evlist->user_requested_cpus))) {
> > >>                  /*
> > >> @@ -80,11 +87,11 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
> > >>
> > >>   static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
> > >>   {
> > >> -       struct perf_evsel *evsel;
> > >> +       struct perf_evsel *evsel, *n;
> > >>
> > >>          evlist->needs_map_propagation = true;
> > >>
> > >> -       perf_evlist__for_each_evsel(evlist, evsel)
> > >> +       list_for_each_entry_safe(evsel, n, &evlist->entries, node)
> > >>                  __perf_evlist__propagate_maps(evlist, evsel);
> > >>   }
> > >>
> > >> --
> > >> 2.34.1
> > >>
> >
