From: Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2 06/11] perf expr: parse numbers as doubles
Date: Mon, 27 Apr 2020 11:03:13 -0700
Message-ID: <CAP-5=fUWtQBBNqyr=xhKUO+jHxq=04SrBYD2Yh6QiH55BvtEWw@mail.gmail.com>
References: <20200422220430.254014-1-irogers@google.com> <20200422220430.254014-7-irogers@google.com>
 <0cee674e-4084-07cb-1954-05dafc371648@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0cee674e-4084-07cb-1954-05dafc371648@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kajoljain <kjain@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Haiyan Song <haiyanx.song@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Song Liu <songliubraving@fb.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, John Garry <john.garry@huawei.com>, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Paul Clarke <pc@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>Stephane Eranian <e>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Apr 27, 2020 at 4:12 AM kajoljain <kjain@linux.ibm.com> wrote:
>
> On 4/23/20 3:34 AM, Ian Rogers wrote:
> > This is expected in expr.y and metrics use floating point values such as
> > x86 broadwell IFetch_Line_Utilization.
> >
> > Fixes: 26226a97724d (perf expr: Move expr lexer to flex)
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/expr.l | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> > index 95bcf3629edf..0efda2ce2766 100644
> > --- a/tools/perf/util/expr.l
> > +++ b/tools/perf/util/expr.l
> > @@ -10,12 +10,12 @@
> >  char *expr_get_text(yyscan_t yyscanner);
> >  YYSTYPE *expr_get_lval(yyscan_t yyscanner);
> >
> > -static int __value(YYSTYPE *yylval, char *str, int base, int token)
> > +static double __value(YYSTYPE *yylval, char *str, int token)
> >  {
> > -     u64 num;
> > +     double num;
> >
> >       errno = 0;
> > -     num = strtoull(str, NULL, base);
> > +     num = strtod(str, NULL);
> >       if (errno)
> >               return EXPR_ERROR;
> >
> > @@ -23,12 +23,12 @@ static int __value(YYSTYPE *yylval, char *str, int base, int token)
> >       return token;
> >  }
> >
> > -static int value(yyscan_t scanner, int base)
> > +static int value(yyscan_t scanner)
> >  {
> >       YYSTYPE *yylval = expr_get_lval(scanner);
> >       char *text = expr_get_text(scanner);
> >
> > -     return __value(yylval, text, base, NUMBER);
> > +     return __value(yylval, text, NUMBER);
> >  }
> >
> >  /*
> > @@ -68,7 +68,7 @@ static int str(yyscan_t scanner, int token)
> >  }
> >  %}
> >
> > -number               [0-9]+
> > +number               [0-9]*\.?[0-9]+
> >
>
> Hi Ian,
>     In this patch I saw the parsing of expression with '+number         [0-9]*\.?[0-9]+'
> Could you please explain why '?' is introduced here, so that I can be sure that this is
> not conflicting with my change to add '?'

Hi Kajol,
the '?' here is part of the regular expression. Basically it is saying
that a number is a possible set of integers possibly followed by a '.'
and then 1 or more integers. The expression comes from having seen
Intel's metrics are of the form '.1234' in some of their topdown
spreadsheets, so we need to be able to handle cases like '1.2', '123'
and '.1234'. Having looked at your patch I don't believe it
interferes.

> In this patch : https://lkml.org/lkml/2020/4/1/1427
> I have used '?' symbol as part of metric expression in order to replace '?' with runtime
> parameter.

Interesting, I'll follow up with comments on that e-mail.

Thanks!
Ian

> Thanks,
> Kajol Jain
>
>
> >  sch          [-,=]
> >  spec         \\{sch}
> > @@ -92,7 +92,7 @@ min         { return MIN; }
> >  if           { return IF; }
> >  else         { return ELSE; }
> >  #smt_on              { return SMT_ON; }
> > -{number}     { return value(yyscanner, 10); }
> > +{number}     { return value(yyscanner); }
> >  {symbol}     { return str(yyscanner, ID); }
> >  "|"          { return '|'; }
> >  "^"          { return '^'; }
> >
