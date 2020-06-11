From: Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 1/2] perf expr: Add d_ratio operation
Date: Wed, 10 Jun 2020 17:00:49 -0700
Message-ID: <CAP-5=fV3_ieXtAvo0kmXRkU8i4R0sxxZvMxTXbuk8bUWPZKDmQ@mail.gmail.com>
References: <20200610051717.170457-1-irogers@google.com> <20200610154129.GA1776102@krava>
 <20200610164304.GA29052@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200610164304.GA29052@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, John Garry <john.garry@huawei.com>, Paul Clarke <pc@us.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>, Stephane Eranian <eranian@google.com>, linux-perf-users <linux-perf-users@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Jun 10, 2020 at 9:43 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Jun 10, 2020 at 05:41:29PM +0200, Jiri Olsa escreveu:
> > On Tue, Jun 09, 2020 at 10:17:15PM -0700, Ian Rogers wrote:
> > > This simplifies computing ratios in json expressions.
> >
> > please put in the comment some usage example and add
> > a test for this to tests/expr.c
> >
> > same for the '<>' operators in the other patch
> >
> > I'll put documentation on this together with the rest to
> > stat man page with my other changes, so no need to document
> > this, but at least bit more details in changelog ;-)
>
> Removed those from my local branch, pushed what I have to tmp.perf/core

These should be addressed in v2:
https://lore.kernel.org/lkml/20200610235823.52557-1-irogers@google.com/T/#t

Thanks,
Ian

> - Arnaldo
>
> > thanks,
> > jirka
> >
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/expr.l |  1 +
> > >  tools/perf/util/expr.y | 14 ++++++++++++--
> > >  2 files changed, 13 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> > > index f397bf8b1a48..298d86660a96 100644
> > > --- a/tools/perf/util/expr.l
> > > +++ b/tools/perf/util/expr.l
> > > @@ -100,6 +100,7 @@ symbol          ({spec}|{sym})+
> > >             }
> > >     }
> > >
> > > +d_ratio            { return D_RATIO; }
> > >  max                { return MAX; }
> > >  min                { return MIN; }
> > >  if         { return IF; }
> > > diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> > > index bf3e898e3055..fe145344bb39 100644
> > > --- a/tools/perf/util/expr.y
> > > +++ b/tools/perf/util/expr.y
> > > @@ -10,6 +10,14 @@
> > >  #include "smt.h"
> > >  #include <string.h>
> > >
> > > +static double d_ratio(double val0, double val1)
> > > +{
> > > +   if (val1 == 0) {
> > > +           return 0;
> > > +   }
> > > +   return  val0 / val1;
> > > +}
> > > +
> > >  %}
> > >
> > >  %define api.pure full
> > > @@ -28,7 +36,7 @@
> > >  %token <num> NUMBER
> > >  %token <str> ID
> > >  %destructor { free ($$); } <str>
> > > -%token MIN MAX IF ELSE SMT_ON
> > > +%token MIN MAX IF ELSE SMT_ON D_RATIO
> > >  %left MIN MAX IF
> > >  %left '|'
> > >  %left '^'
> > > @@ -64,7 +72,8 @@ other: ID
> > >  }
> > >  |
> > >  MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')' | ','
> > > -
> > > +|
> > > +D_RATIO
> > >
> > >  all_expr: if_expr                  { *final_val = $1; }
> > >     ;
> > > @@ -105,6 +114,7 @@ expr:     NUMBER
> > >     | MIN '(' expr ',' expr ')' { $$ = $3 < $5 ? $3 : $5; }
> > >     | MAX '(' expr ',' expr ')' { $$ = $3 > $5 ? $3 : $5; }
> > >     | SMT_ON                 { $$ = smt_on() > 0; }
> > > +   | D_RATIO '(' expr ',' expr ')' { $$ = d_ratio($3,$5); }
> > >     ;
> > >
> > >  %%
> > > --
> > > 2.27.0.278.ge193c7cf3a9-goog
> > >
> >
>
> --
>
> - Arnaldo
