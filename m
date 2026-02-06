Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C082628D8DB;
	Fri,  6 Feb 2026 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770414605; cv=none; b=t7t84babHF8gBu3YliwQY4PX/yy9oqJos44Y8Wbnxhb1nl5J/ePg/yORIONBXjurJyVReQcFYv0I8H365Bfk9pT4QjWxaYaZV7vDo7JJnB7w6+81wHGx9R23yQbfwHo6RVmg4ox12xPL4/zf8y7yR89xDewJDnHJ2K8JxqJPr7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770414605; c=relaxed/simple;
	bh=7qwdYbVXYjyZ74/Q8mJgP2i47AUDTY9i+bbr2jD0Dxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vl6krBxuDOmIju5qotVUo8DRICLJWf1VgfaQTwhNsCGf5bgjJ35lxdppCmaWWNJ/O7W8xLUWRwFUDPw/BR4GSJRQDMIJlXPbn7lHkaKUvV+d7KQ/dwIOFWf/Qy08+u3SsCsxuArEEF9tRncz5+T74EZPAxZx7KxaSRRLaVqh9UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86108339;
	Fri,  6 Feb 2026 13:49:57 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 715833F740;
	Fri,  6 Feb 2026 13:50:03 -0800 (PST)
Date: Fri, 6 Feb 2026 21:50:01 +0000
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
Message-ID: <20260206215001.GJ3529712@e132581.arm.com>
References: <20260205183603.459363-1-irogers@google.com>
 <20260205183603.459363-2-irogers@google.com>
 <20260206104543.GE3529712@e132581.arm.com>
 <20260206123310.GF3529712@e132581.arm.com>
 <CAP-5=fV8ofWn2oYDip3pOX7+Cx0GyKckq_o0Q6qahuoqgydN7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fV8ofWn2oYDip3pOX7+Cx0GyKckq_o0Q6qahuoqgydN7w@mail.gmail.com>

On Fri, Feb 06, 2026 at 10:57:54AM -0800, Ian Rogers wrote:

[...]

> > > >  bool metricgroup__has_metric_or_groups(const char *pmu, const char *metric_or_groups)
> > > >  {
> > > > -   const struct pmu_metrics_table *tables[2] = {
> > > > -           pmu_metrics_table__find(),
> > > > -           pmu_metrics_table__default(),
> > > > -   };
> > > > +   const struct pmu_metrics_table *table = pmu_metrics_table__find();
> > >
> > > Here should be:
> > >
> > >   const struct pmu_metrics_table *table = pmu_metrics_table__default();
> >
> > Or, I think you should not change metricgroup__has_metric_or_groups().
> > The change only in metricgroup__parse_groups() can fix my issue.
> 
> This is wrong and the patch I tested I believe to be correct.

It is very likely you are not working on the issue same as mine.

> The table here is CPUID associated table and all the metric code will

As you said, the key point is CPUID.  On my board, as no corresponding
json file to support the CPU variant, it fails to find any table based
on the CPUID and pmu_metrics_table__find() always returns NULL.

The failure flow is:

  add_default_events()
    if (!metricgroup__has_metric_or_groups(pmu, default_metricgroup_names[i]))
        continue;
     ^^^
     Always return false

As a result, metricgroup__parse_groups() has no chance to be invoked
and no any events are added to the ev list.

This is why I suggested to keep default table in
metricgroup__has_metric_or_groups(), it can rallback to find default
table when CPUID is not supported.

> bottom out in metricgroup__for_each_metric where the CPUID table is
> the table parameter (its a parameter because of testing where we force
> the machine/model to "testarch"):
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/metricgroup.c?h=perf-tools-next#n430
> ```
> int metricgroup__for_each_metric(const struct pmu_metrics_table
> *table, pmu_metric_iter_fn fn, void *data)
> {
> ...
> const struct pmu_metrics_table *tables[2] = {
>     table,
>     pmu_metrics_table__default(),
> };
> 
> for (size_t i = 0; i < ARRAY_SIZE(tables); i++) {
>     int ret;
> 
>     if (!tables[i])
>         continue;
> ```
> If you make the table here the default table then you will process the
> default table twice in metricgroup__for_each_metric which will mean
> double metric look ups, etc.

In my case, it will not have double metric issue, as
pmu_metrics_table__find() cannot find any table, a NULL table pointer
will be passed to metricgroup__for_each_metric(), then only
pmu_metrics_table__default() will be used.

As a side question, using a single CPUID to look up metrics can be
error-prone on asymmetric systems (such as Arm big.LITTLE).  Since only
the first CPU ID is used to search the metrics table, could this cause
issues for other CPU variants?

Thanks,
Leo
