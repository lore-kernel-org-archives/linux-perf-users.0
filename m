Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA2A143895;
	Tue, 13 May 2025 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747169440; cv=none; b=QpaCIC5QZjYezGO1EWllsQ36R+AkT+6F3Pw0x0IDqVO91lzmRUDDtDO0ECdzEM3fijKDhjekkHnAUMgWDEkAAsPm2Zuyi14AzHAgJbnjLkh5ZsLIHeSgfUWCUoIGcfRZIeWnaId56AYBWbuAcg3DoW1j3Qga7IlHDAEJyugwEPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747169440; c=relaxed/simple;
	bh=k24S/q0mljfkMX65LqmfPHCdtiBSQ90MpBoOiBvQ1gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJf5CmwFRr5eU4WaS5tfgM74SdRDm/BcTmkGE1ZT+JbjRN01cfrlpcEIIQ/c7IozC+tQ4p0+KlPwBWcF1g5+629imC/Q3cQvDPHb+tjZE2UQweEN/971Po4ru7aiUiVWPmjR60sx/PfHsC3BogcbLhEoEdO9tjoFI/+KpZ9yjYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jV7KEtcD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jV7KEtcD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C76C4CEE4;
	Tue, 13 May 2025 20:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747169440;
	bh=k24S/q0mljfkMX65LqmfPHCdtiBSQ90MpBoOiBvQ1gU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jV7KEtcDUD8pAG+ZEpDgUU/G24NIcHzb3Omk1Po2t2JvLNSHX4EqurmTaLzY9APMF
	 uYYHzE2ZeHQHabbwKMwCubMc81ZHwKS4N0+wLzq06sG0RHb5BpmOdhKJU8G93nPxex
	 fZLk9F7if9gTaY78lbbjRU3oPd4H38h7j4qGS5LpDkLTsY61eAHB9yM4099O/e3QG0
	 +3l8P51W+GfsJG944oYAyjbLThST9fZl4nJplQo/JcwTIbG32OtC2twsLkEU7Iq7/s
	 uUh+E5fFQ+hCGdD6GgCa9Fyqve4E7Lqra5alEWhnfic8lmo7EjLNX6s/bglEP1SPdm
	 Vxd+uSISHocCA==
Date: Tue, 13 May 2025 17:50:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Gautam Menghani <gautam@linux.ibm.com>, namhyung@kernel.org,
	peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	maddy@linux.ibm.com
Subject: Re: [PATCH v2 4/4] perf python: Add counting.py as example for
 counting perf events
Message-ID: <aCOwnUUVKx798Uza@x1>
References: <20250512055748.479786-1-gautam@linux.ibm.com>
 <20250512055748.479786-5-gautam@linux.ibm.com>
 <CAP-5=fWb-=hCYmpg7U5N9C94EucQGTOS7YwR2-fo4ptOexzxyg@mail.gmail.com>
 <aCI0oDBSz86S9fz-@x1>
 <CAP-5=fVYXRzQjRzcDX0aJv5yg3bwDO+PWHfP-Laig0s3cnzcaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVYXRzQjRzcDX0aJv5yg3bwDO+PWHfP-Laig0s3cnzcaQ@mail.gmail.com>

On Mon, May 12, 2025 at 12:38:23PM -0700, Ian Rogers wrote:
> On Mon, May 12, 2025 at 10:49 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Mon, May 12, 2025 at 10:23:39AM -0700, Ian Rogers wrote:
> > > On Sun, May 11, 2025 at 10:58 PM Gautam Menghani <gautam@linux.ibm.com> wrote:
> > > > Add counting.py - a python version of counting.c to demonstrate
> > > > measuring and reading of counts for given perf events.
> >
> > > > Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> > > > ---
> > > > v1 -> v2:
> > > > 1. Use existing iteration support instead of next
> > > > 2. Read the counters on all cpus
> > > > 3. Use existing helper functions
> > > >
> > > >  tools/perf/python/counting.py | 34 ++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 34 insertions(+)
> > > >  create mode 100755 tools/perf/python/counting.py
> >
> > > > diff --git a/tools/perf/python/counting.py b/tools/perf/python/counting.py
> > > > new file mode 100755
> > > > index 000000000000..e535e3ae8bdf
> > > > --- /dev/null
> > > > +++ b/tools/perf/python/counting.py
> > > > @@ -0,0 +1,34 @@
> > > > +#!/usr/bin/env python3
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +# -*- python -*-
> > > > +# -*- coding: utf-8 -*-
> > > > +
> > > > +import perf
> > > > +
> > > > +def main():
> > > > +        cpus = perf.cpu_map()
> > > > +        thread_map = perf.thread_map(-1)
> > > > +        evlist = perf.parse_events("cpu-clock,task-clock", cpus, thread_map)
> >
> > > Thanks Gautam! I think this is really good. Perhaps the events could
> > > be a command line option, but I can see why you want to keep this
> > > similar to counting.c.
> >
> > > > +
> > > > +        for ev in evlist:
> > > > +            ev.read_format = perf.FORMAT_TOTAL_TIME_ENABLED | perf.FORMAT_TOTAL_TIME_RUNNING
> > > > +
> > > > +        evlist.open()
> > > > +        evlist.enable()
> > > > +
> > > > +        count = 100000
> > > > +        while count > 0:
> > > > +            count -= 1
> > > > +
> > > > +        evlist.disable()
> > > > +
> > > > +        for evsel in evlist:
> > > > +            for cpu in cpus:
> > > > +                for thread in range(len(thread_map)):
> >
> > > I kind of wish, for the reason of being intention revealing, this could just be:
> >
> > > for thread in thread_map:
> >
> > > I can see the problem though, the counts lack the thread_map and the
> > > thread_map is needed to turn a thread back into an index. Perhaps when
> > > the python counts is created we hold onto the evsel so that this is
> > > possible. I also suspect that in the code:
> >
> > > for cpu in cpus:
> >
> > > The CPU number is being used rather than its index, which is a similar
> > > story/problem.
> >
> > Lemme see the rest of this code...
> >
> > +static PyObject *pyrf_evsel__read(struct pyrf_evsel *pevsel,
> > +                                 PyObject *args, PyObject *kwargs)
> > +{
> > +       struct evsel *evsel = &pevsel->evsel;
> > +       int cpu_map_idx = 0, thread = 0;
> > +       struct perf_counts_values counts;
> > +       struct pyrf_counts_values *count_values = PyObject_New(struct pyrf_counts_values,
> > +                                                              &pyrf_counts_values__type);
> > +
> > +       if (!PyArg_ParseTuple(args, "ii", &cpu_map_idx, &thread))
> > +               return NULL;
> > +
> > +       perf_evsel__read(&(evsel->core), cpu_map_idx, thread, &counts);
> > +       count_values->values = counts;
> > +       return (PyObject *)count_values;
> > +}
> >
> > Yeah, it is expecting the cpu_map_idx but the cpu number is being used,
> > that is a bug.
> >
> > The way perf_evsel__read() is implemented:
> >
> > int perf_evsel__read(struct perf_evsel *evsel, int cpu_map_idx, int thread,
> >                      struct perf_counts_values *count)
> >
> > It expects a cpu_map index, not a cpu and then a thread that in its
> > prototype seems to imply its not an index? But it is an index as it ends
> > up being the 'y' for:
> >
> >   xyarray__entry(_evsel->mmap, _cpu_map_idx, _thread))
> >
> > :-/
> 
> Yeah. In the C code we've pretty much committed to notions of cpu map
> index and CPU. We're more ambiguous with threads, but generally thread
> is actually thread index into the thread map. As you say it is for the
> xyarray so that we can densely pack things by index rather than having
> huge gaps, say between PIDs. For the python we don't have to have a
> 1:1 mapping with the C code, so I was wondering if we could just
> remove the notions of index and have them be implementation details?

Agreed, even in the C case I find it confusing to sometimes deal with
indexes and sometimes with real thread/cpu numbers, but if we try and
at least keep the variables/parameter naming reflecting that, then it
should be bearable.

> This would lead to an unfortunate O(log n) translation between
> thread/CPU and index (perf_cpu_map__idx) at the API boundary in
> python.c.

Maybe with some more thinking we can get something better? But I don't
have the bw now to think about it.
 
> > So probably its best to do it using indexes and when needing to know the
> > pid or cpu number then use some helper to get the entry at the given
> > entry? At least for the perf_evsel__read() API that seems to be the
> > case, right?

> > > Arnaldo, could you give some input on what to do wrt indices, threads
> > > and CPUs at the API level? Perhaps we need a refactor and objects for
> > > perf CPU and perf thread, similar to the use of struct perf_cpu in the
> > > C code. The original API all pre-dates that change. The issue is that
> > > changing the API could break existing scripts and we can only fix
> > > those that ship with perf.
> > So it was more for catching new/dead threads without having to process /proc.

<SNIP>
 
> Yeah. I think the sampling API is okay. The nice thing with Gautum's
> patches is adding support for counters for use-cases like perf stat.

Right, I like the effort he is making into having perf more usable in
python, and I encourage him to think about the issues you raised so that
we can come to some good abstractions.

- Arnaldo
