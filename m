From: Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 1/2] perf: Fix POWER9 metric 'lsu_other_stall_cpi'
Date: Thu, 7 May 2020 10:21:55 -0700
Message-ID: <CAP-5=fXKprz247P8iwH4EwxVarS_j_Y=fNRxBryPAi3N97ksPg@mail.gmail.com>
References: <1588868938-21933-1-git-send-email-pc@us.ibm.com>
 <1588868938-21933-2-git-send-email-pc@us.ibm.com> <20200507164825.GE31109@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200507164825.GE31109@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: "Paul A. Clarke" <pc@us.ibm.com>, linux-perf-users <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, ananth@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.ibm.com, mpe@ellerman.id.au
List-Id: linux-perf-users.vger.kernel.org

On Thu, May 7, 2020 at 9:48 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, May 07, 2020 at 11:28:57AM -0500, Paul A. Clarke escreveu:
> > From: "Paul A. Clarke" <pc@us.ibm.com>
> >
> > The metric definition is too long for the current value of EXPR_MAX_OTHER.
> > Increase the value EXPR_MAX_OTHER sufficiently to allow
> > 'lsu_other_stall_cpi' to build properly.
>
> I already have a patch from Ian that bumps this further:

I sent out:
https://lore.kernel.org/lkml/20200507081436.49071-2-irogers@google.com/
which removes this constant and moves the code to use a hashmap.
Unfortunately, the hashmap comes from libbpf and so there is a
dependency issue to resolve. Perhaps libapi can have a hashmap? I'm
not sure who resolves these issues. A short-term fix is just to make
the constant bigger.

Thanks,
Ian

> [acme@five perf]$ git log -p tools/perf/util/expr.h
> commit 26d3350db3e4668c1b1ff7f81c419afe71a2e8d9
> Author: Ian Rogers <irogers@google.com>
> Date:   Fri May 1 10:33:26 2020 -0700
>
>     perf expr: Increase max other
>
>     Large metrics such as Branch_Misprediction_Cost_SMT on x86 broadwell
>     need more space.
>
>     Signed-off-by: Ian Rogers <irogers@google.com>
>     Acked-by: Jiri Olsa <jolsa@redhat.com>
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>     Cc: Andi Kleen <ak@linux.intel.com>
>     Cc: Haiyan Song <haiyanx.song@intel.com>
>     Cc: Jin Yao <yao.jin@linux.intel.com>
>     Cc: John Garry <john.garry@huawei.com>
>     Cc: Kajol Jain <kjain@linux.ibm.com>
>     Cc: Kan Liang <kan.liang@linux.intel.com>
>     Cc: Leo Yan <leo.yan@linaro.org>
>     Cc: Mark Rutland <mark.rutland@arm.com>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Paul Clarke <pc@us.ibm.com>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>     Cc: Song Liu <songliubraving@fb.com>
>     Cc: Stephane Eranian <eranian@google.com>
>     Link: http://lore.kernel.org/lkml/20200501173333.227162-6-irogers@google.com
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index 87d627bb699b..40fc452b0f2b 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -2,7 +2,7 @@
>  #ifndef PARSE_CTX_H
>  #define PARSE_CTX_H 1
>
> -#define EXPR_MAX_OTHER 20
> +#define EXPR_MAX_OTHER 64
>  #define MAX_PARSE_ID EXPR_MAX_OTHER
>
>  struct expr_parse_id {
>
>
> > Before:
> > --
> > $ perf list | grep lsu_other
> >   lsu_other_stall_cpi
> > # perf stat -a --metrics lsu_other_stall_cpi /bin/sleep 1
> > Cannot find metric or group `lsu_other_stall_cpi'
> >
> >  Usage: perf stat [<options>] [<command>]
> >
> >     -M, --metrics <metric/metric group list>
> >                           monitor specified metrics or metric groups (separated by ,)
> > --
> >
> > After:
> > --
> > # perf stat -a --metrics lsu_other_stall_cpi /bin/sleep 1
> >
> >  Performance counter stats for 'system wide':
> >
> >        438,086,889      pm_cmplu_stall_lsu        #     1.74 lsu_other_stall_cpi
> > [...]
> > --
> >
> > Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> > ---
> >  tools/perf/util/expr.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> > index 87d627bb699b..a0991959cca4 100644
> > --- a/tools/perf/util/expr.h
> > +++ b/tools/perf/util/expr.h
> > @@ -2,7 +2,7 @@
> >  #ifndef PARSE_CTX_H
> >  #define PARSE_CTX_H 1
> >
> > -#define EXPR_MAX_OTHER 20
> > +#define EXPR_MAX_OTHER 28
> >  #define MAX_PARSE_ID EXPR_MAX_OTHER
> >
> >  struct expr_parse_id {
> > --
> > 2.18.2
> >
>
> --
>
> - Arnaldo
