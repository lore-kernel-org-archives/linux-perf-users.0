From: Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf stat: update POWER9 metrics to utilize other metrics
Date: Wed, 26 Aug 2020 09:26:40 -0700
Message-ID: <CAP-5=fWw-W3wfy_WeirM_jbEmsbQCC8L_AGo2zsMvv2MW1x04A@mail.gmail.com>
References: <20200813222155.268183-1-pc@us.ibm.com> <CAP-5=fU4P7o1TwVz+PzcrJsBKnrHW4yrNx3R165i9d3BwgP2RQ@mail.gmail.com>
 <cfa27e83-ac2c-7495-b453-ceeaf2412311@linux.ibm.com> <20200814124307.GF13995@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200814124307.GF13995@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Clarke <pc@us.ibm.com>
Cc: kajoljain <kjain@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>, maddy@linux.ibm.com, Arnaldo Carvalho de Melo <acme@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Fri, Aug 14, 2020 at 5:43 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Aug 14, 2020 at 11:20:42AM +0530, kajoljain escreveu:
> >
> >
> > On 8/14/20 9:13 AM, Ian Rogers wrote:
> > > On Thu, Aug 13, 2020 at 3:21 PM Paul A. Clarke <pc@us.ibm.com> wrote:
> > >>
> > >> These changes take advantage of the new capability added in
> > >> merge commit 00e4db51259a5f936fec1424b884f029479d3981
> > >> "Allow using computed metrics in calculating other metrics".
> > >>
> > >> The net is a simplification of the expressions for a handful
> > >> of metrics, but no functional change.
> > >>
> > >> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> > >
> >
> > Hi Paul,
> >   The patch looks good to me.
> >
> > Reviewed-by: Kajol Jain<kjain@linux.ibm.com>
>
> Thanks, applied. Added Ian's Acked-by as well.
>
> - Arnaldo

Hi Paul,

I've synced perf and testing on a remote machine (not easy for me to
log into) I see failures in perf test "10.3: Parsing of PMU event
table metrics" like:
...
parsing metric: dfu_stall_cpi - dflong_stall_cpi
Parse event failed metric 'dfu_other_stall_cpi' id 'dflong_stall_cpi'
expr 'dfu_stall_cpi - dflong_stall_cpi'
Error string 'parser error' help '(null)'
Parse event failed metric 'dfu_other_stall_cpi' id 'dfu_stall_cpi'
expr 'dfu_stall_cpi - dflong_stall_cpi'
Error string 'parser error' help '(null)'
...
This may be that the test doesn't handle the metric in terms of metric
addition and so I'll look for a fix. I thought I'd send a heads up in
case you had already seen/addressed this. Is perf test on PowerPC
clean for you at the moment?

Thanks,
Ian


> > Thanks,
> > Kajol Jain
> >
> > > Acked-by: Ian Rogers <irogers@google.com>
> > > (Re-sent with plain text enabled to avoid lkml bounce)
> > >
> > > Thanks,
> > > Ian
> > >
> > >
> > >>
> > >> ---
> > >>  .../arch/powerpc/power9/metrics.json          | 48 +++++++++-------=
---
> > >>  1 file changed, 24 insertions(+), 24 deletions(-)
> > >>
> > >> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json =
b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> > >> index 80816d6402e9..f8784c608479 100644
> > >> --- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> > >> +++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> > >> @@ -60,7 +60,7 @@
> > >>      },
> > >>      {
> > >>          "BriefDescription": "Stalls due to short latency decimal fl=
oating ops.",
> > >> -        "MetricExpr": "(PM_CMPLU_STALL_DFU - PM_CMPLU_STALL_DFLONG)=
/PM_RUN_INST_CMPL",
> > >> +        "MetricExpr": "dfu_stall_cpi - dflong_stall_cpi",
> > >>          "MetricGroup": "cpi_breakdown",
> > >>          "MetricName": "dfu_other_stall_cpi"
> > >>      },
> > >> @@ -72,7 +72,7 @@
> > >>      },
> > >>      {
> > >>          "BriefDescription": "Completion stall by Dcache miss which =
resolved off node memory/cache",
> > >> -        "MetricExpr": "(PM_CMPLU_STALL_DMISS_L3MISS - PM_CMPLU_STAL=
L_DMISS_L21_L31 - PM_CMPLU_STALL_DMISS_LMEM - PM_CMPLU_STALL_DMISS_REMOTE)/=
PM_RUN_INST_CMPL",
> > >> +        "MetricExpr": "dmiss_non_local_stall_cpi - dmiss_remote_sta=
ll_cpi",
> > >>          "MetricGroup": "cpi_breakdown",
> > >>          "MetricName": "dmiss_distant_stall_cpi"
> > >>      },
> > >> @@ -90,7 +90,7 @@
> > >>      },
> > >>      {
> > >>          "BriefDescription": "Completion stall due to cache miss tha=
t resolves in the L2 or L3 without conflict",
> > >> -        "MetricExpr": "(PM_CMPLU_STALL_DMISS_L2L3 - PM_CMPLU_STALL_=
DMISS_L2L3_CONFLICT)/PM_RUN_INST_CMPL",
> > >> +        "MetricExpr": "dmiss_l2l3_stall_cpi - dmiss_l2l3_conflict_s=
tall_cpi",
> > >>          "MetricGroup": "cpi_breakdown",
> > >>          "MetricName": "dmiss_l2l3_noconflict_stall_cpi"
> > >>      },
> > >> @@ -114,7 +114,7 @@
> > >>      },
> > >>      {
> > >>          "BriefDescription": "Completion stall by Dcache miss which =
resolved outside of local memory",
> > >> -        "MetricExpr": "(PM_CMPLU_STALL_DMISS_L3MISS - PM_CMPLU_STAL=
L_DMISS_L21_L31 - PM_CMPLU_STALL_DMISS_LMEM)/PM_RUN_INST_CMPL",
> > >> +        "MetricExpr": "dmiss_l3miss_stall_cpi - dmiss_l21_l31_stall=
_cpi - dmiss_lmem_stall_cpi",
> > >>          "MetricGroup": "cpi_breakdown",
> > >>          "MetricName": "dmiss_non_local_stall_cpi"
> > >>      },
> > >> @@ -126,7 +126,7 @@
> > >>      },
> > >>      {
> > >>          "BriefDescription": "Stalls due to short latency double pre=
cision ops.",
> > >> -        "MetricExpr": "(PM_CMPLU_STALL_DP - PM_CMPLU_STALL_DPLONG)/=
PM_RUN_INST_CMPL",
> > >> +        "MetricExpr": "dp_stall_cpi - dplong_stall_cpi",
> > >>          "MetricGroup": "cpi_breakdown",
> > >>          "MetricName": "dp_other_stall_cpi"
> > >>      },
> > >> @@ -155,7 +155,7 @@
> > >>          "MetricName": "emq_full_stall_cpi"
> > >>      },
> > >>      {
> > >> -        "MetricExpr": "(PM_CMPLU_STALL_ERAT_MISS + PM_CMPLU_STALL_E=
MQ_FULL)/PM_RUN_INST_CMPL",
> > >> +        "MetricExpr": "erat_miss_stall_cpi + emq_full_stall_cpi",
> > >>          "MetricGroup": "cpi_breakdown",
> > >>          "MetricName": "emq_stall_cpi"
> > >>      },
> > >> @@ -173,7 +173,7 @@
> > >>      },
> > >>      {
> > >>          "BriefDescription": "Completion stall due to execution unit=
s for other reasons.",
> > >> -        "MetricExpr": "(PM_CMPLU_STALL_EXEC_UNIT - PM_CMPLU_STALL_F=
XU - PM_CMPLU_STALL_DP - PM_CMPLU_STALL_DFU - PM_CMPLU_STALL_PM - PM_CMPLU_=
STALL_CRYPTO - PM_CMPLU_STALL_VFXU - PM_CMPLU_STALL_VDP)/PM_RUN_INST_CMPL",
> > >> +        "MetricExpr": "exec_unit_stall_cpi - scalar_stall_cpi - vec=
tor_stall_cpi",
> > >>          "MetricGroup": "cpi_breakdown",
> > >>          "MetricName": "exec_unit_other_stall_cpi"
> > >>      },
> > >> @@ -197,7 +197,7 @@
> > >>      },
> > >>      {
> > >>          "BriefDescription": "Stalls due to short latency integer op=
s",
> > >> -        "MetricExpr": "(PM_CMPLU_STALL_FXU - PM_CMPLU_STALL_FXLONG)=
/PM_RUN_INST_CMPL",
> > >> +        "MetricExpr": "fxu_stall_cpi - fxlong_stall_cpi",
> > >>          "MetricGroup": "cpi_breakdown",
> > >>          "MetricName": "fxu_other_stall_cpi"
> > >>      },
> > >> @@ -221,7 +221,7 @@
> > >>      },
> > >>      {
> > >>          "BriefDescription": "Instruction Completion Table other sta=
lls",
> > >> -        "MetricExpr": "(PM_ICT_NOSLOT_CYC - PM_ICT_NOSLOT_IC_MISS -=
 PM_ICT_NOSLOT_BR_MPRED_ICMISS - PM_ICT_NOSLOT_BR_MPRED - PM_ICT_NOSLOT_DIS=
P_HELD)/PM_RUN_INST_CMPL",
> > >> +        "MetricExpr": "nothing_dispatched_cpi - ict_noslot_ic_miss_=
cpi - ict_noslot_br_mpred_icmiss_cpi - ict_noslot_br_mpred_cpi - ict_noslot=
_disp_held_cpi",
> > >>          "MetricGroup": "cpi_breakdown",
> > >>          "MetricName": "ict_noslot_cyc_other_cpi"
> > >>      },
> > >> @@ -245,7 +245,7 @@
> > >>      },
> > >>      {
> > >>          "BriefDescription": "ICT_NOSLOT_DISP_HELD_OTHER_CPI",
> > >> -        "MetricExpr": "(PM_ICT_NOSLOT_DISP_HELD - PM_ICT_NOSLOT_DIS=
P_HELD_HB_FULL - PM_ICT_NOSLOT_DISP_HELD_SYNC - PM_ICT_NOSLOT_DISP_HELD_TBE=
GIN - PM_ICT_NOSLOT_DISP_HELD_ISSQ)/PM_RUN_INST_CMPL",
> > >> +        "MetricExpr": "ict_noslot_disp_held_cpi - ict_noslot_disp_h=
eld_hb_full_cpi - ict_noslot_disp_held_sync_cpi - ict_noslot_disp_held_tbeg=
in_cpi - ict_noslot_disp_held_issq_cpi",
> > >>          "MetricGroup": "cpi_breakdown",
> > >>          "MetricName": "ict_noslot_disp_held_other_cpi"
> > >>      },
> > >> @@ -263,7 +263,7 @@
> > >>      },
> > >>      {
> > >>          "BriefDescription": "ICT_NOSLOT_IC_L2_CPI",
> > >> -        "MetricExpr": "(PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_IC_L3=
 - PM_ICT_NOSLOT_IC_L3MISS)/PM_RUN_INST_CMPL",
> > >> +        "MetricExpr": "ict_noslot_ic_miss_cpi - ict_noslot_ic_l3_cp=
i - ict_noslot_ic_l3miss_cpi",
> > >>          "MetricGroup": "cpi_breakdown",
> > >>          "MetricName": "ict_noslot_ic_l2_cpi"
> > >>      },
> > >> @@ -286,7 +286,7 @@
> > >>          "MetricName": "ict_noslot_ic_miss_cpi"
> > >>      },
> > >>      {
> > >> -        "MetricExpr": "(PM_NTC_ISSUE_HELD_DARQ_FULL + PM_NTC_ISSUE_=
HELD_ARB + PM_NTC_ISSUE_HELD_OTHER)/PM_RUN_INST_CMPL",
> > >> +        "MetricExpr": "ntc_issue_held_darq_full_cpi + ntc_issue_hel=
d_arb_cpi + ntc_issue_held_other_cpi",
> > >>          "MetricGroup": "cpi_breakdown",
> > >>          "MetricName": "issue_hold_cpi"
> > >>      },
> > >> @@ -327,7 +327,7 @@
> > >>          "MetricName": "lrq_other_stall_cpi"
> > >>      },
> > >>      {
> > >> -        "MetricExpr": "(PM_CMPLU_STALL_LMQ_FULL + PM_CMPLU_STALL_ST=
_FWD + PM_CMPLU_STALL_LHS + PM_CMPLU_STALL_LSU_MFSPR + PM_CMPLU_STALL_LARX =
+ PM_CMPLU_STALL_LRQ_OTHER)/PM_RUN_INST_CMPL",
> > >> +        "MetricExpr": "lmq_full_stall_cpi + st_fwd_stall_cpi + lhs_=
stall_cpi + lsu_mfspr_stall_cpi + larx_stall_cpi + lrq_other_stall_cpi",
> > >>          "MetricGroup": "cpi_breakdown",
> > >>          "MetricName": "lrq_stall_cpi"
> > >>      },
> > >> @@ -338,7 +338,7 @@
> > >>          "MetricName": "lsaq_arb_stall_cpi"
> > >>      },
> > >>      {
> > >> -        "MetricExpr": "(PM_CMPLU_STALL_LRQ_FULL + PM_CMPLU_STALL_SR=
Q_FULL + PM_CMPLU_STALL_LSAQ_ARB)/PM_RUN_INST_CMPL",
> > >> +        "MetricExpr": "lrq_full_stall_cpi + srq_full_stall_cpi + ls=
aq_arb_stall_cpi",
> > >>          "MetricGroup": "cpi_breakdown",
> > >>          "MetricName": "lsaq_stall_cpi"
> > >>      },
> > >> @@ -362,7 +362,7 @@
> > >>      },
> > >>      {
> > >>          "BriefDescription": "Completion LSU stall for other reasons=
",
> > >> -        "MetricExpr": "(PM_CMPLU_STALL_LSU - PM_CMPLU_STALL_LSU_FIN=
 - PM_CMPLU_STALL_STORE_FINISH - PM_CMPLU_STALL_STORE_DATA - PM_CMPLU_STALL=
_EIEIO - PM_CMPLU_STALL_STCX - PM_CMPLU_STALL_SLB - PM_CMPLU_STALL_TEND - P=
M_CMPLU_STALL_PASTE - PM_CMPLU_STALL_TLBIE - PM_CMPLU_STALL_STORE_PIPE_ARB =
- PM_CMPLU_STALL_STORE_FIN_ARB - PM_CMPLU_STALL_LOAD_FINISH + PM_CMPLU_STAL=
L_DCACHE_MISS - PM_CMPLU_STALL_LMQ_FULL - PM_CMPLU_STALL_ST_FWD - PM_CMPLU_=
STALL_LHS - PM_CMPLU_STALL_LSU_MFSPR - PM_CMPLU_STALL_LARX - PM_CMPLU_STALL=
_LRQ_OTHER + PM_CMPLU_STALL_ERAT_MISS + PM_CMPLU_STALL_EMQ_FULL - PM_CMPLU_=
STALL_LRQ_FULL - PM_CMPLU_STALL_SRQ_FULL - PM_CMPLU_STALL_LSAQ_ARB) / PM_RU=
N_INST_CMPL",
> > >> +        "MetricExpr": "lsu_stall_cpi - lsu_fin_stall_cpi - store_fi=
nish_stall_cpi - srq_stall_cpi - load_finish_stall_cpi + lsu_stall_dcache_m=
iss_cpi - lrq_stall_cpi + emq_stall_cpi - lsaq_stall_cpi",
> > >>          "MetricGroup": "cpi_breakdown",
> > >>          "MetricName": "lsu_other_stall_cpi"
> > >>      },
> > >> @@ -434,13 +434,13 @@
> > >>      },
> > >>      {
> > >>          "BriefDescription": "Cycles unaccounted for.",
> > >> -        "MetricExpr": "(PM_RUN_CYC - PM_1PLUS_PPC_CMPL - PM_CMPLU_S=
TALL_THRD - PM_CMPLU_STALL - PM_ICT_NOSLOT_CYC)/PM_RUN_INST_CMPL",
> > >> +        "MetricExpr": "run_cpi - completion_cpi - thread_block_stal=
l_cpi - stall_cpi - nothing_dispatched_cpi",
> > >>          "MetricGroup": "cpi_breakdown",
> > >>          "MetricName": "other_cpi"
> > >>      },
> > >>      {
> > >>          "BriefDescription": "Completion stall for other reasons",
> > >> -        "MetricExpr": "(PM_CMPLU_STALL - PM_CMPLU_STALL_NTC_DISP_FI=
N - PM_CMPLU_STALL_NTC_FLUSH - PM_CMPLU_STALL_LSU - PM_CMPLU_STALL_EXEC_UNI=
T - PM_CMPLU_STALL_BRU)/PM_RUN_INST_CMPL",
> > >> +        "MetricExpr": "stall_cpi - ntc_disp_fin_stall_cpi - ntc_flu=
sh_stall_cpi - lsu_stall_cpi - exec_unit_stall_cpi - bru_stall_cpi",
> > >>          "MetricGroup": "cpi_breakdown",
> > >>          "MetricName": "other_stall_cpi"
> > >>      },
> > >> @@ -469,7 +469,7 @@
> > >>          "MetricName": "run_cyc_cpi"
> > >>      },
> > >>      {
> > >> -        "MetricExpr": "(PM_CMPLU_STALL_FXU + PM_CMPLU_STALL_DP + PM=
_CMPLU_STALL_DFU + PM_CMPLU_STALL_PM + PM_CMPLU_STALL_CRYPTO)/PM_RUN_INST_C=
MPL",
> > >> +        "MetricExpr": "fxu_stall_cpi + dp_stall_cpi + dfu_stall_cpi=
 + pm_stall_cpi + crypto_stall_cpi",
> > >>          "MetricGroup": "cpi_breakdown",
> > >>          "MetricName": "scalar_stall_cpi"
> > >>      },
> > >> @@ -492,7 +492,7 @@
> > >>          "MetricName": "srq_full_stall_cpi"
> > >>      },
> > >>      {
> > >> -        "MetricExpr": "(PM_CMPLU_STALL_STORE_DATA + PM_CMPLU_STALL_=
EIEIO + PM_CMPLU_STALL_STCX + PM_CMPLU_STALL_SLB + PM_CMPLU_STALL_TEND + PM=
_CMPLU_STALL_PASTE + PM_CMPLU_STALL_TLBIE + PM_CMPLU_STALL_STORE_PIPE_ARB +=
 PM_CMPLU_STALL_STORE_FIN_ARB)/PM_RUN_INST_CMPL",
> > >> +        "MetricExpr": "store_data_stall_cpi + eieio_stall_cpi + stc=
x_stall_cpi + slb_stall_cpi + tend_stall_cpi + paste_stall_cpi + tlbie_stal=
l_cpi + store_pipe_arb_stall_cpi + store_fin_arb_stall_cpi",
> > >>          "MetricGroup": "cpi_breakdown",
> > >>          "MetricName": "srq_stall_cpi"
> > >>      },
> > >> @@ -558,7 +558,7 @@
> > >>      },
> > >>      {
> > >>          "BriefDescription": "Vector stalls due to small latency dou=
ble precision ops",
> > >> -        "MetricExpr": "(PM_CMPLU_STALL_VDP - PM_CMPLU_STALL_VDPLONG=
)/PM_RUN_INST_CMPL",
> > >> +        "MetricExpr": "vdp_stall_cpi - vdplong_stall_cpi",
> > >>          "MetricGroup": "cpi_breakdown",
> > >>          "MetricName": "vdp_other_stall_cpi"
> > >>      },
> > >> @@ -575,7 +575,7 @@
> > >>          "MetricName": "vdplong_stall_cpi"
> > >>      },
> > >>      {
> > >> -        "MetricExpr": "(PM_CMPLU_STALL_VFXU + PM_CMPLU_STALL_VDP)/P=
M_RUN_INST_CMPL",
> > >> +        "MetricExpr": "vfxu_stall_cpi + vdp_stall_cpi",
> > >>          "MetricGroup": "cpi_breakdown",
> > >>          "MetricName": "vector_stall_cpi"
> > >>      },
> > >> @@ -587,7 +587,7 @@
> > >>      },
> > >>      {
> > >>          "BriefDescription": "Vector stalls due to small latency int=
eger ops",
> > >> -        "MetricExpr": "(PM_CMPLU_STALL_VFXU - PM_CMPLU_STALL_VFXLON=
G)/PM_RUN_INST_CMPL",
> > >> +        "MetricExpr": "vfxu_stall_cpi - vfxlong_stall_cpi",
> > >>          "MetricGroup": "cpi_breakdown",
> > >>          "MetricName": "vfxu_other_stall_cpi"
> > >>      },
> > >> @@ -1844,7 +1844,7 @@
> > >>      },
> > >>      {
> > >>          "BriefDescription": "% of DL1 reloads from Private L3, othe=
r core per Inst",
> > >> -        "MetricExpr": "(PM_DATA_FROM_L31_MOD + PM_DATA_FROM_L31_SHR=
) * 100 / PM_RUN_INST_CMPL",
> > >> +        "MetricExpr": "dl1_reload_from_l31_mod_rate_percent + dl1_r=
eload_from_l31_shr_rate_percent",
> > >>          "MetricName": "dl1_reload_from_l31_rate_percent"
> > >>      },
> > >>      {
> > >> @@ -1979,7 +1979,7 @@
> > >>      },
> > >>      {
> > >>          "BriefDescription": "Completion stall because a different t=
hread was using the completion pipe",
> > >> -        "MetricExpr": "(PM_CMPLU_STALL_THRD - PM_CMPLU_STALL_EXCEPT=
ION - PM_CMPLU_STALL_ANY_SYNC - PM_CMPLU_STALL_SYNC_PMU_INT - PM_CMPLU_STAL=
L_SPEC_FINISH - PM_CMPLU_STALL_FLUSH_ANY_THREAD - PM_CMPLU_STALL_LSU_FLUSH_=
NEXT - PM_CMPLU_STALL_NESTED_TBEGIN - PM_CMPLU_STALL_NESTED_TEND - PM_CMPLU=
_STALL_MTFPSCR)/PM_RUN_INST_CMPL",
> > >> +        "MetricExpr": "thread_block_stall_cpi - exception_stall_cpi=
 - any_sync_stall_cpi - sync_pmu_int_stall_cpi - spec_finish_stall_cpi - fl=
ush_any_thread_stall_cpi - lsu_flush_next_stall_cpi - nested_tbegin_stall_c=
pi - nested_tend_stall_cpi - mtfpscr_stall_cpi",
> > >>          "MetricName": "other_thread_cmpl_stall"
> > >>      },
> > >>      {
> > >> --
> > >> 2.18.4
> > >>
>
> --
>
> - Arnaldo
