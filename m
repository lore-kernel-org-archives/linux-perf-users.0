Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB3D1C173C;
	Mon, 12 May 2025 17:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072163; cv=none; b=BxqW0EiZqFcB/CuTN7sUfoGFqAeyf+TuWa7evy+19UxrmOyIU4xmH87wyXAG8qMLrbfZ0MJNXU1H0O6mb/0rDW3ePm8iXlP9xRNiZrLcAfutZ6j0I37a0Nr0JkknyrWjC429Wm3ZxLyXHplWL4BNlO/n2H6ZNxl2SA/LD9g//C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072163; c=relaxed/simple;
	bh=gDNi1AwVmSropyIfvPJSBu00uCfJB3w5KotarpDlRLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlOdn/i0Ti1wxWmDjvchfhm10rp5I6wcJcT50Y0SKxlQjzhBmAaASfQyXbsMKZpaL4EjB7a1ewh2H247hKAjEO33gm7V2CqoMVy6BYixmVeUpFmXXtEwxrKUE0qBwZq6XhAn5qFisuDGKt9NJikPgysw48W9YkN+IR854XUA5zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxVJNpGl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxVJNpGl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE786C4CEE7;
	Mon, 12 May 2025 17:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747072163;
	bh=gDNi1AwVmSropyIfvPJSBu00uCfJB3w5KotarpDlRLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FxVJNpGlhpqS5jnseF5ovxmqTrlBoR95bMjs2lR0/3McT0MDaDRvPKVC/tSQr0i52
	 TktRS077h/cDfA8isM9Yqn4AOmSSTOn67CjIEdgBI/6GSdKeOee5nIJjgMKMY4OIbL
	 crQGG1ZEfQmjtso2EGSRkPGW5B2vRUvnXfkDbYntGcXhV67TS8JaJ/zaU0dtm+ix3r
	 8+6lq6h2goFpgc6n1dcJVKs+zLflc6WQhRR/fZzPOAZZT4RO7tqPxN0lvf12tZrgEM
	 m0jF55dEM0cKcD3ESfYnha4KTNxKTK9Lpo7KjCjGKmC9zvnyD5I7lwEXcyT0Jjzzb1
	 DEkRI+o88ThCg==
Date: Mon, 12 May 2025 14:49:20 -0300
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
Message-ID: <aCI0oDBSz86S9fz-@x1>
References: <20250512055748.479786-1-gautam@linux.ibm.com>
 <20250512055748.479786-5-gautam@linux.ibm.com>
 <CAP-5=fWb-=hCYmpg7U5N9C94EucQGTOS7YwR2-fo4ptOexzxyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWb-=hCYmpg7U5N9C94EucQGTOS7YwR2-fo4ptOexzxyg@mail.gmail.com>

On Mon, May 12, 2025 at 10:23:39AM -0700, Ian Rogers wrote:
> On Sun, May 11, 2025 at 10:58 PM Gautam Menghani <gautam@linux.ibm.com> wrote:
> > Add counting.py - a python version of counting.c to demonstrate
> > measuring and reading of counts for given perf events.

> > Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> > ---
> > v1 -> v2:
> > 1. Use existing iteration support instead of next
> > 2. Read the counters on all cpus
> > 3. Use existing helper functions
> >
> >  tools/perf/python/counting.py | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >  create mode 100755 tools/perf/python/counting.py

> > diff --git a/tools/perf/python/counting.py b/tools/perf/python/counting.py
> > new file mode 100755
> > index 000000000000..e535e3ae8bdf
> > --- /dev/null
> > +++ b/tools/perf/python/counting.py
> > @@ -0,0 +1,34 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: GPL-2.0
> > +# -*- python -*-
> > +# -*- coding: utf-8 -*-
> > +
> > +import perf
> > +
> > +def main():
> > +        cpus = perf.cpu_map()
> > +        thread_map = perf.thread_map(-1)
> > +        evlist = perf.parse_events("cpu-clock,task-clock", cpus, thread_map)
 
> Thanks Gautam! I think this is really good. Perhaps the events could
> be a command line option, but I can see why you want to keep this
> similar to counting.c.
 
> > +
> > +        for ev in evlist:
> > +            ev.read_format = perf.FORMAT_TOTAL_TIME_ENABLED | perf.FORMAT_TOTAL_TIME_RUNNING
> > +
> > +        evlist.open()
> > +        evlist.enable()
> > +
> > +        count = 100000
> > +        while count > 0:
> > +            count -= 1
> > +
> > +        evlist.disable()
> > +
> > +        for evsel in evlist:
> > +            for cpu in cpus:
> > +                for thread in range(len(thread_map)):

> I kind of wish, for the reason of being intention revealing, this could just be:
 
> for thread in thread_map:

> I can see the problem though, the counts lack the thread_map and the
> thread_map is needed to turn a thread back into an index. Perhaps when
> the python counts is created we hold onto the evsel so that this is
> possible. I also suspect that in the code:
 
> for cpu in cpus:
 
> The CPU number is being used rather than its index, which is a similar
> story/problem.

Lemme see the rest of this code...

+static PyObject *pyrf_evsel__read(struct pyrf_evsel *pevsel,
+                                 PyObject *args, PyObject *kwargs)
+{
+       struct evsel *evsel = &pevsel->evsel;
+       int cpu_map_idx = 0, thread = 0;
+       struct perf_counts_values counts;
+       struct pyrf_counts_values *count_values = PyObject_New(struct pyrf_counts_values,
+                                                              &pyrf_counts_values__type);
+
+       if (!PyArg_ParseTuple(args, "ii", &cpu_map_idx, &thread))
+               return NULL;
+
+       perf_evsel__read(&(evsel->core), cpu_map_idx, thread, &counts);
+       count_values->values = counts;
+       return (PyObject *)count_values;
+}

Yeah, it is expecting the cpu_map_idx but the cpu number is being used,
that is a bug.

The way perf_evsel__read() is implemented:

int perf_evsel__read(struct perf_evsel *evsel, int cpu_map_idx, int thread,
                     struct perf_counts_values *count)

It expects a cpu_map index, not a cpu and then a thread that in its
prototype seems to imply its not an index? But it is an index as it ends
up being the 'y' for:

  xyarray__entry(_evsel->mmap, _cpu_map_idx, _thread))

:-/

So probably its best to do it using indexes and when needing to know the
pid or cpu number then use some helper to get the entry at the given
entry? At least for the perf_evsel__read() API that seems to be the
case, right?
 
> Arnaldo, could you give some input on what to do wrt indices, threads
> and CPUs at the API level? Perhaps we need a refactor and objects for
> perf CPU and perf thread, similar to the use of struct perf_cpu in the
> C code. The original API all pre-dates that change. The issue is that
> changing the API could break existing scripts and we can only fix
> those that ship with perf.

So the original user of the perf python binding was:

https://git.kernel.org/pub/scm/utils/tuna/tuna.git/tree/tuna/gui/procview.py

That does basically what the above example does:

    def perf_init(self):
        self.cpu_map = perf.cpu_map()
        self.thread_map = perf.thread_map()
        self.evsel_cycles = perf.evsel(task=1, comm=1, wakeup_events=1, \
            watermark=1, sample_type=perf.SAMPLE_CPU | perf.SAMPLE_TID)
        self.evsel_cycles.open(cpus=self.cpu_map, threads=self.thread_map)
        self.evlist = perf.evlist(self.cpu_map, self.thread_map)
        self.evlist.add(self.evsel_cycles)
        self.evlist.mmap()
        self.pollfd = self.evlist.get_pollfd()
        for f in self.pollfd:
            GObject.io_add_watch(f, GObject.IO_IN, self.perf_process_events)
        self.perf_counter = {}

Then:

    def perf_process_events(self, source, condition):
        had_events = True
        while had_events: 
            had_events = False
            for cpu in self.cpu_map:
                event = self.evlist.read_on_cpu(cpu)
                if event:
                    had_events = True
                    if event.type == perf.RECORD_FORK:
                        if event.pid == event.tid:
                            try:
                                self.ps.processes[event.pid] = procfs.process(event.pid)
                            except: # short lived thread
                                pass
                        else: 
                            if event.pid in self.ps.processes:
                                try:
                                    self.ps.processes[event.pid].threads.processes[event.tid] = procfs.process(event.tid)
                                except (AttributeError, KeyError):
                                    try:
                                        self.ps.processes[event.pid].threads = procfs.pidstats("/proc/%d/task/" % event.pid)
                                    except:
                                        pass
                    elif event.type == perf.RECORD_EXIT:
                        del self.ps[int(event.tid)]
                    elif event.type == perf.RECORD_SAMPLE:
                        tid = event.sample_tid
                        if tid in self.perf_counter:
                            self.perf_counter[tid] += event.sample_period
                        else:
                            self.perf_counter[tid] = event.sample_period

        self.evlist_added = True  # Mark that event arrived, so next periodic show() will refresh GUI
        return True


So it was more for catching new/dead threads without having to process /proc.

- Arnaldo
