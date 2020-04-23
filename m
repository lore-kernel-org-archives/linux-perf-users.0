From: Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2 10/11] perf expr: print a debug message for division by zero
Date: Thu, 23 Apr 2020 07:16:48 -0700
Message-ID: <CAP-5=fVp7qJWqLfLQKeRmhnucWj2dYQ4K8RSAuiJ5TLd_PqXog@mail.gmail.com>
References: <20200422220430.254014-1-irogers@google.com> <20200422220430.254014-11-irogers@google.com>
 <20200423112837.GE1136647@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200423112837.GE1136647@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Haiyan Song <haiyanx.song@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Song Liu <songliubraving@fb.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, John Garry <john.garry@huawei.com>, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Paul Clarke <pc@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Apr 23, 2020 at 4:28 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Apr 22, 2020 at 03:04:29PM -0700, Ian Rogers wrote:
> > If an expression yields 0 and is then divided-by/modulus-by then the
> > parsing aborts. Add a debug error message to better enable debugging
> > when this happens.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/expr.y | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> > index 54260094b947..21e82a1e11a2 100644
> > --- a/tools/perf/util/expr.y
> > +++ b/tools/perf/util/expr.y
> > @@ -103,8 +103,18 @@ expr:      NUMBER
> >       | expr '+' expr         { $$ = $1 + $3; }
> >       | expr '-' expr         { $$ = $1 - $3; }
> >       | expr '*' expr         { $$ = $1 * $3; }
> > -     | expr '/' expr         { if ($3 == 0) YYABORT; $$ = $1 / $3; }
> > -     | expr '%' expr         { if ((long)$3 == 0) YYABORT; $$ = (long)$1 % (long)$3; }
> > +     | expr '/' expr         { if ($3 == 0) {
> > +                                     pr_debug("division by zero\n");
> > +                                     YYABORT;
> > +                               }
> > +                               $$ = $1 / $3;
> > +                             }
> > +     | expr '%' expr         { if ((long)$3 == 0) {
>
> is that (long) cast necessary? it's missing for the '/' case

Andi Kleen could say for sure :-) From my observation, the values are
typically doubles and definitely need to be in the divide case. There
is also code handling them as longs such as |, &, ^:
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/tools/perf/util/expr.y#n100
There's an experiment to see if all of the long handling code could be
removed. This change isn't modifying the existing behavior.

Thanks,
Ian

> jirka
>
> > +                                     pr_debug("division by zero\n");
> > +                                     YYABORT;
> > +                               }
> > +                               $$ = (long)$1 % (long)$3;
> > +                             }
> >       | '-' expr %prec NEG    { $$ = -$2; }
> >       | '(' if_expr ')'       { $$ = $2; }
> >       | MIN '(' expr ',' expr ')' { $$ = $3 < $5 ? $3 : $5; }
> > --
> > 2.26.2.303.gf8c07b1a785-goog
> >
>
