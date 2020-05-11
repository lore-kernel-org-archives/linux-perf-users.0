From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 2/2] perf: Add missing metrics to POWER9 'cpi_breakdown'
Date: Mon, 11 May 2020 12:29:15 -0300
Message-ID: <20200511152915.GC28888@kernel.org>
References: <1588868938-21933-1-git-send-email-pc@us.ibm.com>
 <1588868938-21933-3-git-send-email-pc@us.ibm.com>
 <0b276c65-9c54-c6eb-0381-f56c4ccf5ec2@linux.ibm.com>
 <CAP-5=fV4-m-x6hNLvVGcBHHrL_Z67+4tM=ruxbZJpjn5V6Eqtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP-5=fV4-m-x6hNLvVGcBHHrL_Z67+4tM=ruxbZJpjn5V6Eqtg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: kajoljain <kjain@linux.ibm.com>, "Paul A. Clarke" <pc@us.ibm.com>, linux-perf-users <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, ananth@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.ibm.com, mpe@ellerman.id.au
List-Id: linux-perf-users.vger.kernel.org

Em Sat, May 09, 2020 at 11:26:56PM -0700, Ian Rogers escreveu:
> On Fri, May 8, 2020 at 12:05 AM kajoljain <kjain@linux.ibm.com> wrote:
> > On 5/7/20 9:58 PM, Paul A. Clarke wrote:
> > > From: "Paul A. Clarke" <pc@us.ibm.com>
> > >
> > > Add the following metrics to the POWER9 'cpi_breakdown' metricgroup:
> > > - ict_noslot_br_mpred_cpi
> > > - ict_noslot_br_mpred_icmiss_cpi
> > > - ict_noslot_cyc_other_cpi
> > > - ict_noslot_disp_held_cpi
> > > - ict_noslot_disp_held_hb_full_cpi
> > > - ict_noslot_disp_held_issq_cpi
> > > - ict_noslot_disp_held_other_cpi
> > > - ict_noslot_disp_held_sync_cpi
> > > - ict_noslot_disp_held_tbegin_cpi
> > > - ict_noslot_ic_l2_cpi
> > > - ict_noslot_ic_l3_cpi
> > > - ict_noslot_ic_l3miss_cpi
> > > - ict_noslot_ic_miss_cpi
> > >
> > > Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> >
> > Reviewed-by: Kajol Jain <kjain@linux.ibm.com>
> 
> Tested with:
> https://lore.kernel.org/lkml/20200508053629.210324-3-irogers@google.com/
> Tested-by: Ian Rogers <irogers@google.com>

Thanks, looking up that series now,

- Arnaldo
 
> Thanks,
> Ian
> 
> > Thanks,
> > Kajol Jain
> > > ---
> > >  .../arch/powerpc/power9/metrics.json          | 143 ++++++++++--------
> > >  1 file changed, 78 insertions(+), 65 deletions(-)
> > >
> > > diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> > > index 811c2a8c1c9e..6169351a72c8 100644
> > > --- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> > > +++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> > > @@ -207,6 +207,84 @@
> > >          "MetricGroup": "cpi_breakdown",
> > >          "MetricName": "fxu_stall_cpi"
> > >      },
> > > +    {
> > > +        "BriefDescription": "Ict empty for this thread due to branch mispred",
> > > +        "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED/PM_RUN_INST_CMPL",
> > > +        "MetricGroup": "cpi_breakdown",
> > > +        "MetricName": "ict_noslot_br_mpred_cpi"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Ict empty for this thread due to Icache Miss and branch mispred",
> > > +        "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED_ICMISS/PM_RUN_INST_CMPL",
> > > +        "MetricGroup": "cpi_breakdown",
> > > +        "MetricName": "ict_noslot_br_mpred_icmiss_cpi"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "ICT other stalls",
> > > +        "MetricExpr": "(PM_ICT_NOSLOT_CYC - PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_BR_MPRED_ICMISS - PM_ICT_NOSLOT_BR_MPRED - PM_ICT_NOSLOT_DISP_HELD)/PM_RUN_INST_CMPL",
> > > +        "MetricGroup": "cpi_breakdown",
> > > +        "MetricName": "ict_noslot_cyc_other_cpi"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Cycles in which the NTC instruciton is held at dispatch for any reason",
> > > +        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD/PM_RUN_INST_CMPL",
> > > +        "MetricGroup": "cpi_breakdown",
> > > +        "MetricName": "ict_noslot_disp_held_cpi"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Ict empty for this thread due to dispatch holds because the History Buffer was full. Could be GPR/VSR/VMR/FPR/CR/XVF",
> > > +        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_HB_FULL/PM_RUN_INST_CMPL",
> > > +        "MetricGroup": "cpi_breakdown",
> > > +        "MetricName": "ict_noslot_disp_held_hb_full_cpi"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Ict empty for this thread due to dispatch hold on this thread due to Issue q full, BRQ full, XVCF Full, Count cache, Link, Tar full",
> > > +        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_ISSQ/PM_RUN_INST_CMPL",
> > > +        "MetricGroup": "cpi_breakdown",
> > > +        "MetricName": "ict_noslot_disp_held_issq_cpi"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "ICT_NOSLOT_DISP_HELD_OTHER_CPI",
> > > +        "MetricExpr": "(PM_ICT_NOSLOT_DISP_HELD - PM_ICT_NOSLOT_DISP_HELD_HB_FULL - PM_ICT_NOSLOT_DISP_HELD_SYNC - PM_ICT_NOSLOT_DISP_HELD_TBEGIN - PM_ICT_NOSLOT_DISP_HELD_ISSQ)/PM_RUN_INST_CMPL",
> > > +        "MetricGroup": "cpi_breakdown",
> > > +        "MetricName": "ict_noslot_disp_held_other_cpi"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Dispatch held due to a synchronizing instruction at dispatch",
> > > +        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_SYNC/PM_RUN_INST_CMPL",
> > > +        "MetricGroup": "cpi_breakdown",
> > > +        "MetricName": "ict_noslot_disp_held_sync_cpi"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "the NTC instruction is being held at dispatch because it is a tbegin instruction and there is an older tbegin in the pipeline that must complete before the younger tbegin can dispatch",
> > > +        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_TBEGIN/PM_RUN_INST_CMPL",
> > > +        "MetricGroup": "cpi_breakdown",
> > > +        "MetricName": "ict_noslot_disp_held_tbegin_cpi"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "ICT_NOSLOT_IC_L2_CPI",
> > > +        "MetricExpr": "(PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_IC_L3 - PM_ICT_NOSLOT_IC_L3MISS)/PM_RUN_INST_CMPL",
> > > +        "MetricGroup": "cpi_breakdown",
> > > +        "MetricName": "ict_noslot_ic_l2_cpi"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from the local L3",
> > > +        "MetricExpr": "PM_ICT_NOSLOT_IC_L3/PM_RUN_INST_CMPL",
> > > +        "MetricGroup": "cpi_breakdown",
> > > +        "MetricName": "ict_noslot_ic_l3_cpi"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from beyond the local L3. The source could be local/remote/distant memory or another core's cache",
> > > +        "MetricExpr": "PM_ICT_NOSLOT_IC_L3MISS/PM_RUN_INST_CMPL",
> > > +        "MetricGroup": "cpi_breakdown",
> > > +        "MetricName": "ict_noslot_ic_l3miss_cpi"
> > > +    },
> > > +    {
> > > +        "BriefDescription": "Ict empty for this thread due to Icache Miss",
> > > +        "MetricExpr": "PM_ICT_NOSLOT_IC_MISS/PM_RUN_INST_CMPL",
> > > +        "MetricGroup": "cpi_breakdown",
> > > +        "MetricName": "ict_noslot_ic_miss_cpi"
> > > +    },
> > >      {
> > >          "MetricExpr": "(PM_NTC_ISSUE_HELD_DARQ_FULL + PM_NTC_ISSUE_HELD_ARB + PM_NTC_ISSUE_HELD_OTHER)/PM_RUN_INST_CMPL",
> > >          "MetricGroup": "cpi_breakdown",
> > > @@ -1819,71 +1897,6 @@
> > >          "MetricExpr": "PM_FXU_IDLE / PM_CYC",
> > >          "MetricName": "fxu_all_idle"
> > >      },
> > > -    {
> > > -        "BriefDescription": "Ict empty for this thread due to branch mispred",
> > > -        "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED/PM_RUN_INST_CMPL",
> > > -        "MetricName": "ict_noslot_br_mpred_cpi"
> > > -    },
> > > -    {
> > > -        "BriefDescription": "Ict empty for this thread due to Icache Miss and branch mispred",
> > > -        "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED_ICMISS/PM_RUN_INST_CMPL",
> > > -        "MetricName": "ict_noslot_br_mpred_icmiss_cpi"
> > > -    },
> > > -    {
> > > -        "BriefDescription": "ICT other stalls",
> > > -        "MetricExpr": "(PM_ICT_NOSLOT_CYC - PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_BR_MPRED_ICMISS - PM_ICT_NOSLOT_BR_MPRED - PM_ICT_NOSLOT_DISP_HELD)/PM_RUN_INST_CMPL",
> > > -        "MetricName": "ict_noslot_cyc_other_cpi"
> > > -    },
> > > -    {
> > > -        "BriefDescription": "Cycles in which the NTC instruciton is held at dispatch for any reason",
> > > -        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD/PM_RUN_INST_CMPL",
> > > -        "MetricName": "ict_noslot_disp_held_cpi"
> > > -    },
> > > -    {
> > > -        "BriefDescription": "Ict empty for this thread due to dispatch holds because the History Buffer was full. Could be GPR/VSR/VMR/FPR/CR/XVF",
> > > -        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_HB_FULL/PM_RUN_INST_CMPL",
> > > -        "MetricName": "ict_noslot_disp_held_hb_full_cpi"
> > > -    },
> > > -    {
> > > -        "BriefDescription": "Ict empty for this thread due to dispatch hold on this thread due to Issue q full, BRQ full, XVCF Full, Count cache, Link, Tar full",
> > > -        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_ISSQ/PM_RUN_INST_CMPL",
> > > -        "MetricName": "ict_noslot_disp_held_issq_cpi"
> > > -    },
> > > -    {
> > > -        "BriefDescription": "ICT_NOSLOT_DISP_HELD_OTHER_CPI",
> > > -        "MetricExpr": "(PM_ICT_NOSLOT_DISP_HELD - PM_ICT_NOSLOT_DISP_HELD_HB_FULL - PM_ICT_NOSLOT_DISP_HELD_SYNC - PM_ICT_NOSLOT_DISP_HELD_TBEGIN - PM_ICT_NOSLOT_DISP_HELD_ISSQ)/PM_RUN_INST_CMPL",
> > > -        "MetricName": "ict_noslot_disp_held_other_cpi"
> > > -    },
> > > -    {
> > > -        "BriefDescription": "Dispatch held due to a synchronizing instruction at dispatch",
> > > -        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_SYNC/PM_RUN_INST_CMPL",
> > > -        "MetricName": "ict_noslot_disp_held_sync_cpi"
> > > -    },
> > > -    {
> > > -        "BriefDescription": "the NTC instruction is being held at dispatch because it is a tbegin instruction and there is an older tbegin in the pipeline that must complete before the younger tbegin can dispatch",
> > > -        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_TBEGIN/PM_RUN_INST_CMPL",
> > > -        "MetricName": "ict_noslot_disp_held_tbegin_cpi"
> > > -    },
> > > -    {
> > > -        "BriefDescription": "ICT_NOSLOT_IC_L2_CPI",
> > > -        "MetricExpr": "(PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_IC_L3 - PM_ICT_NOSLOT_IC_L3MISS)/PM_RUN_INST_CMPL",
> > > -        "MetricName": "ict_noslot_ic_l2_cpi"
> > > -    },
> > > -    {
> > > -        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from the local L3",
> > > -        "MetricExpr": "PM_ICT_NOSLOT_IC_L3/PM_RUN_INST_CMPL",
> > > -        "MetricName": "ict_noslot_ic_l3_cpi"
> > > -    },
> > > -    {
> > > -        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from beyond the local L3. The source could be local/remote/distant memory or another core's cache",
> > > -        "MetricExpr": "PM_ICT_NOSLOT_IC_L3MISS/PM_RUN_INST_CMPL",
> > > -        "MetricName": "ict_noslot_ic_l3miss_cpi"
> > > -    },
> > > -    {
> > > -        "BriefDescription": "Ict empty for this thread due to Icache Miss",
> > > -        "MetricExpr": "PM_ICT_NOSLOT_IC_MISS/PM_RUN_INST_CMPL",
> > > -        "MetricName": "ict_noslot_ic_miss_cpi"
> > > -    },
> > >      {
> > >          "BriefDescription": "Rate of IERAT reloads from L2",
> > >          "MetricExpr": "PM_IPTEG_FROM_L2 * 100 / PM_RUN_INST_CMPL",
> > >

-- 

- Arnaldo
