From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 4/4 v3] perf stat: Add transaction flag (-T) support for
 s390
Date: Mon, 25 Jun 2018 13:33:53 -0700
Message-ID: <20180625203353.GC19456@tassilo.jf.intel.com>
References: <20180625125856.20262-1-tmricht@linux.ibm.com>
 <20180625145247.GY20477@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180625145247.GY20477@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

> > +bool metricgroup__has_metric(const char *metric)
> > +{
> > +	struct pmu_events_map *map = perf_pmu__find_map(NULL);
> > +	struct pmu_event *pe;
> > +	int i;
> > +
> > +	if (!map)
> > +		return false;
> > +
> > +	for (i = 0; ; i++) {
> > +		pe = &map->table[i];
> > +
> > +		if (!pe->name && !pe->metric_group && !pe->metric_name)
> > +			break;
> > +		if (!pe->metric_expr)
> > +			continue;
> > +		if (match_metric(pe->metric_group, metric) ||
> > +		    match_metric(pe->metric_name, metric))

Why both the group and the metric?

I would just match the metric_name

Otherwise it's impossible to have a group called "transaction"

With that fixed it's ok for me.

Acked-by: Andi Kleen <ak@linux.intel.com>

-Andi
