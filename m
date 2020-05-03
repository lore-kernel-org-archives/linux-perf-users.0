From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v4 12/12] perf test: improve pmu event metric testing
Date: Mon, 4 May 2020 00:16:50 +0200
Message-ID: <20200503221650.GA1916255@krava>
References: <20200501173333.227162-1-irogers@google.com>
 <20200501173333.227162-13-irogers@google.com>
 <20200503145553.GA1865281@krava>
 <CAP-5=fXrwcz+MMF0Dqd_UnoXoTo1iO7T3-ENX0fzytPmJWmtoA@mail.gmail.com>
 <20200503170608.GA1915271@krava>
 <CAP-5=fVaLWVyxweesWYCj1=FFubM3t6OsF1Jd46d=FtsQUQVmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP-5=fVaLWVyxweesWYCj1=FFubM3t6OsF1Jd46d=FtsQUQVmQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Haiyan Song <haiyanx.song@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Song Liu <songliubraving@fb.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, John Garry <john.garry@huawei.com>, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Paul Clarke <pc@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, kajoljain <kjain@linux.ibm.com>, linux-perf-users <linux-perf-users@vger.kernel.org>, Stephane
List-Id: linux-perf-users.vger.kernel.org

On Sun, May 03, 2020 at 10:31:37AM -0700, Ian Rogers wrote:

SNIP

> > >
> > > This looks like a bug in skl-metrics.json:
> > >
> > >    {
> > >         "BriefDescription": "Average number of parallel data read
> > > requests to external memory. Accounts for demand loads and L1/L2
> > > prefetches",
> > >         "MetricExpr": "arb@event\\=0x80\\,umask\\=0x2@ /
> > > arb@event\\=0x80\\,umask\\=0x2\\,thresh\\=1@",
> > >         "MetricGroup": "Memory_BW",
> > >         "MetricName": "DRAM_Parallel_Reads"
> > >     },
> > >
> > > which can be fixed by removing "\\,thresh\\=1" but looking at the
> > > expression this will just make the expression yield a value of 1. As
> > > this is an Intel json file could they comment? Jiri, could you be
> > > missing a patch on the kernel side? We could lower this failure to
> > > just a diagnostic message to land this set of patches, let me know
> > > what you'd like me to do.
> >
> > I applied this on current Arnaldo's perf/core.. not sure there's
> > more pending changes out there
> >
> > I'd like not to delay this patchset too long.. could we push the
> > first 10 patches and solve the rest in separate change?
> 
> Thanks, I've attached a patch that can be squashed into 12 to make the
> error non-fatal. Patch 11 is trying to make the diagnostics around
> adding a PMU event clearer and aside warning messages, and removal of,
> has no functional effect. I don't mind the first 10 being merged and
> these coming later. I don't mind just patch 11 coming later as it'd be
> nice to have the test so metrics can get fixed.

sounds good, for patches 1 - 10:

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka
