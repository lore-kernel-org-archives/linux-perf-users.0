From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf/tools/pmu-events/powerpc: Added nest imc metric
 events
Date: Mon, 6 Jul 2020 09:38:55 -0300
Message-ID: <20200706123855.GI1320@kernel.org>
References: <20200703065658.377467-1-kjain@linux.ibm.com>
 <CAP-5=fUraGwGLC79g51eZpcB9e2P=tOmz7U7G=RAu+Hmjjjxzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP-5=fUraGwGLC79g51eZpcB9e2P=tOmz7U7G=RAu+Hmjjjxzw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Kajol Jain <kjain@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Paul Clarke <pc@us.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, maddy@linux.ibm.com, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, "Liang, Kan" <kan.liang@linux.intel.com>, nasastry@in.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Sun, Jul 05, 2020 at 06:30:30PM -0700, Ian Rogers escreveu:
> On Thu, Jul 2, 2020 at 11:57 PM Kajol Jain <kjain@linux.ibm.com> wrote:
> >
> > Added nest imc metric events.
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo
 
> > Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> > ---
> >  .../arch/powerpc/power9/nest_metrics.json     | 35 +++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >
> > diff --git a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> > index c121e526442a..8383a37647ad 100644
> > --- a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> > +++ b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> > @@ -15,5 +15,40 @@
> >         "MetricExpr": "(hv_24x7@PM_PB_CYC\\,chip\\=?@ )",
> >          "MetricName": "PowerBUS_Frequency",
> >          "ScaleUnit": "2.5e-7GHz"
> > +    },
> > +    {
> > +       "MetricExpr" : "nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT23@",
> > +       "MetricName" : "mcs01-read",
> > +       "MetricGroup" : "memory_bw",
> > +       "ScaleUnit": "6.1e-5MB"
> 
> nit: I'm guessing this is from:
> 64.0/(1024.0*1024.0) = 6.103515625e-05
> and for reference:
> 64.0/(1000.0*1000.0) = 6.3999999999999997e-05
> should the unit be MiB?
> https://en.wikipedia.org/wiki/Kibibyte
> 
> Searching around I only see knightslanding using MiB but it seems to
> be using it in the 1000^2 case which probably means it should be MB:
> knightslanding/uncore-memory.json:        "ScaleUnit": "6.4e-05MiB"
> 
> Given there is some confusion I wonder if it makes sense to just make
> this 0.015625B and then we have a utility function that selects the
> best unit for "bytes" with config options similar to --big-num?
> 
> Thanks,
> Ian
> 
> > +    },
> > +    {
> > +       "MetricExpr" : "nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT23@",
> > +       "MetricName" : "mcs23-read",
> > +       "MetricGroup" : "memory_bw",
> > +       "ScaleUnit": "6.1e-5MB"
> > +    },
> > +    {
> > +       "MetricExpr" : "nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT23@",
> > +       "MetricName" : "mcs01-write",
> > +       "MetricGroup" : "memory_bw",
> > +       "ScaleUnit": "6.1e-5MB"
> > +    },
> > +    {
> > +       "MetricExpr" : "nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT23@",
> > +       "MetricName" : "mcs23-write",
> > +       "MetricGroup" : "memory-bandwidth",
> > +       "ScaleUnit": "6.1e-5MB"
> > +    },
> > +    {
> > +       "MetricExpr" : "nest_powerbus0_imc@PM_PB_CYC@",
> > +       "MetricName" : "powerbus_freq",
> > +       "ScaleUnit": "1e-9GHz"
> > +    },
> > +    {
> > +       "MetricExpr" : "(nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT23@ + nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT23@ + nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT23@ + nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT23@)",
> > +       "MetricName" : "Memory-bandwidth-MCS",
> > +       "MetricGroup" : "memory_bw",
> > +       "ScaleUnit": "6.1e-5MB"
> >      }
> >  ]
> > --
> > 2.17.1
> >

-- 

- Arnaldo
