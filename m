From: Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2 08/11] perf metrics: fix parse errors in power8 metrics
Date: Wed, 22 Apr 2020 15:46:32 -0700
Message-ID: <CAP-5=fVOPdFjthXuh1MZWuNzJbEATg0EnL946HBYo+vzdbiwVw@mail.gmail.com>
References: <20200422220430.254014-1-irogers@google.com> <20200422220430.254014-9-irogers@google.com>
 <70bb1987-c8cd-ecc1-a6d8-61569a83494c@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <70bb1987-c8cd-ecc1-a6d8-61569a83494c@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Clarke <pc@us.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Haiyan Song <haiyanx.song@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Song Liu <songliubraving@fb.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, John Garry <john.garry@huawei.com>, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Apr 22, 2020 at 3:31 PM Paul Clarke <pc@us.ibm.com> wrote:
>
> On 4/22/20 5:04 PM, Ian Rogers wrote:
> > Mismatched parentheses.
> >
> > Fixes: dd81eafacc52 (perf vendor events power8: Cpi_breakdown & estimated_dcache_miss_cpi metrics)
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/pmu-events/arch/powerpc/power8/metrics.json | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/arch/powerpc/power8/metrics.json b/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
> > index bffb2d4a6420..ad71486a38e3 100644
> > --- a/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
> > +++ b/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
> > @@ -169,7 +169,7 @@
> >      },
> >      {
> >          "BriefDescription": "Cycles GCT empty where dispatch was held",
> > -        "MetricExpr": "(PM_GCT_NOSLOT_DISP_HELD_MAP + PM_GCT_NOSLOT_DISP_HELD_SRQ + PM_GCT_NOSLOT_DISP_HELD_ISSQ + PM_GCT_NOSLOT_DISP_HELD_OTHER) / PM_RUN_INST_CMPL)",
> > +        "MetricExpr": "(PM_GCT_NOSLOT_DISP_HELD_MAP + PM_GCT_NOSLOT_DISP_HELD_SRQ + PM_GCT_NOSLOT_DISP_HELD_ISSQ + PM_GCT_NOSLOT_DISP_HELD_OTHER) / PM_RUN_INST_CMPL",
>
> OK. (Thank you!)
>
> >          "MetricGroup": "cpi_breakdown",
> >          "MetricName": "gct_empty_disp_held_cpi"
> >      },
> > @@ -886,7 +886,7 @@
> >      },
> >      {
> >          "BriefDescription": "GCT slot utilization (11 to 14) as a % of cycles this thread had atleast 1 slot valid",
> > -        "MetricExpr": "PM_GCT_UTIL_11_14_ENTRIES / ( PM_RUN_CYC - PM_GCT_NOSLOT_CYC) * 100",
> > +        "MetricExpr": "PM_GCT_UTIL_11_14_ENTRIES / ( PM_RUN_CYC - PM_GCT_NOSLOT_CYC ) * 100",
>
> I think this is just a whitespace change?  Is it necessary?
> Curiosity, more than complaint.

Sorry about that, the space isn't necessary and this doesn't need to
change. For the curious, originally the parse test would make all
metrics equal to 1.0 and this metric would trigger a divide by zero
because of this. This motivated adding a debug print for this case.

Thanks,
Ian

> >          "MetricGroup": "general",
> >          "MetricName": "gct_util_11to14_slots_percent"
> >      },
>
> Reviewed-by: Paul A. Clarke <pc@us.ibm.com>
>
> PC
