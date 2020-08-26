From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf test: Perf test 67 dumps core on s390
Date: Wed, 26 Aug 2020 08:33:04 -0300
Message-ID: <20200826113304.GC1059382@kernel.org>
References: <20200825071211.16959-1-tmricht@linux.ibm.com>
 <CAP-5=fUkOyVUgagpkh6zgbjA1Dd0oP_WmP4HVA8f6J3WifwM9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP-5=fUkOyVUgagpkh6zgbjA1Dd0oP_WmP4HVA8f6J3WifwM9w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Aug 25, 2020 at 02:04:30PM -0700, Ian Rogers escreveu:
> On Tue, Aug 25, 2020 at 12:12 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> >
> > Linux 5.9 introduced perf test case "Parse and process metrics" and
> > on s390 this test case always dumps core:

<SNIP>

> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

I'll add your comments and...
 
> This also shows up with address sanitizer on all architectures
> (perhaps change the patch title) and perhaps add a "Fixes: <commit>"
> tag.
> =================================================================
> ==4718==ERROR: AddressSanitizer: global-buffer-overflow on address
> 0x55c93b4d59e8 at pc 0x55c93a1541e2 bp 0x7ffd24327c60 sp
> 0x7ffd24327c58
> READ of size 8 at 0x55c93b4d59e8 thread T0
>     #0 0x55c93a1541e1 in find_metric tools/perf/util/metricgroup.c:764:2
> > +++ b/tools/perf/tests/parse-metric.c
> > @@ -70,6 +70,11 @@ static struct pmu_event pme_test[] = {
> >  {
> >         .metric_expr    = "1/m3",
> >         .metric_name    = "M3",
> > +},
> > +{
> > +       .metric_expr    = NULL,
> > +       .metric_name    = NULL,
> > +       .metric_group   = NULL

No need to set all three to NULL, just one is enough and then the
compiler will zero out all the rest.

- Arnaldo
