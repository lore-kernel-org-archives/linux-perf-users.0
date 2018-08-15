From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH V2] perf parser: Improve error message for PMU address
 filters
Date: Wed, 15 Aug 2018 16:39:48 -0300
Message-ID: <20180815193948.GB5976@kernel.org>
References: <20180704121345.19025-1-jackdev@mailbox.org>
 <20180704152536.GC19164@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180704152536.GC19164@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Jack Henschel <jackdev@mailbox.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Jul 04, 2018 at 05:25:36PM +0200, Jiri Olsa escreveu:
> On Wed, Jul 04, 2018 at 02:13:45PM +0200, Jack Henschel wrote:
> > This is the second version of a patch that improves the error
> > message of the perf events parser when the PMU hardware does not support
> > address filters.
> > 
> > Previously, the perf returned the following error:
> > > $ perf record -e intel_pt// --filter 'filter sys_write'
> > > --filter option should follow a -e tracepoint or HW tracer option
> > This implies there is some syntax error present in the command line,
> > which is not true. Rather, notify the user that the CPU does not have
> > support for this feature.
> > 
> > For example, Intel chips based on the Broadwell micro-archticture have
> > the Intel PT PMU, but do not support address filtering.
> > 
> > Now, perf prints the following error message:
> > > $ perf record -e intel_pt// --filter 'filter sys_write'
> > > This CPU does not support address filtering
> > 
> > Signed-off-by: Jack Henschel <jackdev@mailbox.org>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, tested and applied,

- Arnaldo
 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/util/parse-events.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index 15eec49e71a1..f8cd3e7c9186 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -1991,8 +1991,11 @@ static int set_filter(struct perf_evsel *evsel, const void *arg)
> >  	int nr_addr_filters = 0;
> >  	struct perf_pmu *pmu = NULL;
> >  
> > -	if (evsel == NULL)
> > -		goto err;
> > +	if (evsel == NULL) {
> > +		fprintf(stderr,
> > +			"--filter option should follow a -e tracepoint or HW tracer option\n");
> > +		return -1;
> > +	}
> >  
> >  	if (evsel->attr.type == PERF_TYPE_TRACEPOINT) {
> >  		if (perf_evsel__append_tp_filter(evsel, str) < 0) {
> > @@ -2014,8 +2017,11 @@ static int set_filter(struct perf_evsel *evsel, const void *arg)
> >  		perf_pmu__scan_file(pmu, "nr_addr_filters",
> >  				    "%d", &nr_addr_filters);
> >  
> > -	if (!nr_addr_filters)
> > -		goto err;
> > +	if (!nr_addr_filters) {
> > +		fprintf(stderr,
> > +			"This CPU does not support address filtering\n");
> > +		return -1;
> > +	}
> >  
> >  	if (perf_evsel__append_addr_filter(evsel, str) < 0) {
> >  		fprintf(stderr,
> > @@ -2024,12 +2030,6 @@ static int set_filter(struct perf_evsel *evsel, const void *arg)
> >  	}
> >  
> >  	return 0;
> > -
> > -err:
> > -	fprintf(stderr,
> > -		"--filter option should follow a -e tracepoint or HW tracer option\n");
> > -
> > -	return -1;
> >  }
> >  
> >  int parse_filter(const struct option *opt, const char *str,
> > -- 
> > 2.18.0
> > 
