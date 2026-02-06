Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3162848A8;
	Fri,  6 Feb 2026 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770381195; cv=none; b=ui7hbaag/iVKnIe2NZi47Ullq2XxypU0wrU3XetTD2Pghnxn06s53soxsnjKf65pyDky2gGU7/+lxq/c8mQnlrqRK/JriKPumS1je7NGCZA4INepLfWKtoAhH14HESsxGP8CBdK3744VeaR7gLJ1/PPYRsOt0pITXLEGT0UpuCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770381195; c=relaxed/simple;
	bh=QkkVg8VfqoMTA7JSLDs9urMdyDvtibO3YyE35JA9lLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRrDocegXs0wwLADLj++TsbRKKr5IXdTLoD/NP3sNPVRq8/nJfpSWIMZvNF/ybtTGIe96r4JFA2BPqC+Vrik08SQ21QPdxbqbOhNxlned1/QEAoqMimeG8lT3Z+VZipo17NRmdAZ8oLPvdfZjOd4R9fCgZk4mxI2hRq+P5vqaqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05792339;
	Fri,  6 Feb 2026 04:33:07 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4C803F632;
	Fri,  6 Feb 2026 04:33:12 -0800 (PST)
Date: Fri, 6 Feb 2026 12:33:10 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] perf metricgroup: Don't early exit if no CPUID
 table exists
Message-ID: <20260206123310.GF3529712@e132581.arm.com>
References: <20260205183603.459363-1-irogers@google.com>
 <20260205183603.459363-2-irogers@google.com>
 <20260206104543.GE3529712@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206104543.GE3529712@e132581.arm.com>

On Fri, Feb 06, 2026 at 10:45:43AM +0000, Leo Yan wrote:
> On Thu, Feb 05, 2026 at 10:36:03AM -0800, Ian Rogers wrote:
> > The failure to find a table of metrics with a CPUID shouldn't early
> > exit as the metric code will now also consider the default table.
> > When searching for a metric or metric group,
> > pmu_metrics_table__for_each_metric considers all tables and so the
> > caller doesn't need to switch the table to do this.
> > 
> > Fixes: c7adeb0974f1 ("perf jevents: Add set of common metrics based on default ones")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/metricgroup.c | 18 +++++-------------
> >  1 file changed, 5 insertions(+), 13 deletions(-)
> > 
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index 40a1e14de418..46bf4dfeebc8 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -1562,8 +1562,6 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
> >  {
> >  	const struct pmu_metrics_table *table = pmu_metrics_table__find();
> >  
> > -	if (!table)
> > -		return -EINVAL;
> >  	if (hardware_aware_grouping)
> >  		pr_debug("Use hardware aware grouping instead of traditional metric grouping method\n");
> >  
> > @@ -1601,22 +1599,16 @@ static int metricgroup__has_metric_or_groups_callback(const struct pmu_metric *p
> >  
> >  bool metricgroup__has_metric_or_groups(const char *pmu, const char *metric_or_groups)
> >  {
> > -	const struct pmu_metrics_table *tables[2] = {
> > -		pmu_metrics_table__find(),
> > -		pmu_metrics_table__default(),
> > -	};
> > +	const struct pmu_metrics_table *table = pmu_metrics_table__find();
> 
> Here should be:
> 
>   const struct pmu_metrics_table *table = pmu_metrics_table__default();

Or, I think you should not change metricgroup__has_metric_or_groups().
The change only in metricgroup__parse_groups() can fix my issue.

Thanks,
Leo
