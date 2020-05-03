From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v4 12/12] perf test: improve pmu event metric testing
Date: Sun, 3 May 2020 19:06:08 +0200
Message-ID: <20200503170608.GA1915271@krava>
References: <20200501173333.227162-1-irogers@google.com>
 <20200501173333.227162-13-irogers@google.com>
 <20200503145553.GA1865281@krava>
 <CAP-5=fXrwcz+MMF0Dqd_UnoXoTo1iO7T3-ENX0fzytPmJWmtoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP-5=fXrwcz+MMF0Dqd_UnoXoTo1iO7T3-ENX0fzytPmJWmtoA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Haiyan Song <haiyanx.song@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Song Liu <songliubraving@fb.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, John Garry <john.garry@huawei.com>, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Paul Clarke <pc@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, kajoljain <kjain@linux.ibm.com>, linux-perf-users <linux-perf-users@vger.kernel.org>, Stephane
List-Id: linux-perf-users.vger.kernel.org

On Sun, May 03, 2020 at 08:26:22AM -0700, Ian Rogers wrote:
> On Sun, May 3, 2020 at 7:56 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Fri, May 01, 2020 at 10:33:33AM -0700, Ian Rogers wrote:
> > > Add a basic floating point number test to expr.
> > > Break pmu-events test into 2 and add a test to verify that all pmu metric
> > > expressions simply parse. Try to parse all metric ids/events, failing if
> > > metrics for the current architecture fail to parse.
> > >
> > > Tested on skylakex with the patch set in place. May fail on other
> > > architectures if metrics are invalid.
> >
> > yep, failing for me (-vvv output below).. could you plz
> > detect that and skip the test ?
> 
> Thanks, filtering the verbose output we have just 1 parse event failure:
> 
> Parse event failed: id 'arb/event=0x80,umask=0x2,thresh=1/' metric
> 'DRAM_Parallel_Reads' expr 'arb@event\=0x80\,umask\=0x2@ /
> arb@event\=0x80\,umask\=0x2\,thresh\=1@'
> Error string 'unknown term 'thresh' for pmu 'uncore_arb'' help 'valid
> terms: event,edge,inv,umask,cmask,config,config1,config2,name,period,freq,branch_type,time,call-graph,stack-size,no-inherit,inherit,max-stack,nr,no-overwrite,overwrite,driver-config,percore,aux-output,aux-sample-size'
> 
> This looks like a bug in skl-metrics.json:
> 
>    {
>         "BriefDescription": "Average number of parallel data read
> requests to external memory. Accounts for demand loads and L1/L2
> prefetches",
>         "MetricExpr": "arb@event\\=0x80\\,umask\\=0x2@ /
> arb@event\\=0x80\\,umask\\=0x2\\,thresh\\=1@",
>         "MetricGroup": "Memory_BW",
>         "MetricName": "DRAM_Parallel_Reads"
>     },
> 
> which can be fixed by removing "\\,thresh\\=1" but looking at the
> expression this will just make the expression yield a value of 1. As
> this is an Intel json file could they comment? Jiri, could you be
> missing a patch on the kernel side? We could lower this failure to
> just a diagnostic message to land this set of patches, let me know
> what you'd like me to do.

I applied this on current Arnaldo's perf/core.. not sure there's
more pending changes out there

I'd like not to delay this patchset too long.. could we push the
first 10 patches and solve the rest in separate change?

thanks,
jirka
