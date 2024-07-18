Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC3913D297;
	Thu, 18 Jul 2024 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721313217; cv=none; b=MHl3NRCzH55Q+gKcDWqiPGoIu7TY720/U4NQx621HE2rOQfPfWJG6seIJRC1pbh9aIpj6KIBWXI42RQCkhnK0qjpTwolQolUqXx6sgtazl+mxVPnp2ot8gcfrwNJjgWOWDzCyWVGk+QDDC6GdcpaxyT6SFivv3iSRUGCHAqfwc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721313217; c=relaxed/simple;
	bh=VLixru2Pqt6o7xFhONllJFE+qak37O4TjVrg5z0nt8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UCJTgG0pV3PbExQYMk5Of/FClYDxhTyWPKYiWnHpBuOJge+G0EvmBU0h32BAmQr8+BNk3Zd7Sv9Wff1VvK12EzaDqEPz4RtXnccwTQd2772ZeBNHHlMsTXzMLjmXyhUQXMcJNWRHpErz3Ex+hUEhwK6MIbiFq3HwEzWYYEF75e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lh0r1w7b; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lh0r1w7b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721313216; x=1752849216;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=VLixru2Pqt6o7xFhONllJFE+qak37O4TjVrg5z0nt8U=;
  b=lh0r1w7b/Vh3ryNZKzDZZy3eYr1NkaeaDl+J6ie/4aDSHT7DsgUitEjF
   HyL8aIgc6DRbc+DmfYj5fZzg9CeOTYiqcZUm2bJ6Te+STTlbTbpQyuOop
   Ar7tRBnTrVzcf89gVsZA9Brll6vFGvD1G6g7WWz5tXS9HwNJePCiV04ZO
   cPIyskerKJzZLBn3dry3jOPOqJSGiabgNo+IiL1sF34jBP53lfbp0vR8z
   vUkqBuMX9yzdHoUCuirDw8qLWm37soTuBN+BSdVXdZWt7bKilgPqRijgY
   Yu9dkSe4nYBUaBseXQQzUrWW4VetK3nt0dviGHVxHCGvaq80CKjblyGHK
   w==;
X-CSE-ConnectionGUID: YJkSSWaeR4aF0tk62uco1w==
X-CSE-MsgGUID: YVAKv8FfTTyncJzJCxnCmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="18991730"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="18991730"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 07:33:34 -0700
X-CSE-ConnectionGUID: fMNICR6ITqa1M04QyBxkqQ==
X-CSE-MsgGUID: 43kEBYk0QoG4xKsELz5s3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="55302682"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 07:33:35 -0700
Received: from [10.212.127.244] (kliang2-mobl1.ccr.corp.intel.com [10.212.127.244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 5F73820CFED5;
	Thu, 18 Jul 2024 07:33:31 -0700 (PDT)
Message-ID: <92ceb8b5-240a-4715-98db-c73e8e9d3e50@linux.intel.com>
Date: Thu, 18 Jul 2024 10:33:30 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] perf pmu: Add support for event.cpus files in
 sysfs
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
 James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Dominique Martinet <asmadeus@codewreck.org>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, ananth.narayan@amd.com,
 gautham.shenoy@amd.com, kprateek.nayak@amd.com, sandipan.das@amd.com
References: <20240718003025.1486232-1-irogers@google.com>
 <20240718003025.1486232-4-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240718003025.1486232-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-07-17 8:30 p.m., Ian Rogers wrote:
> If an event file exists in sysfs, check if a event.cpus file exists
> and read a perf_cpu_map from it if it does. This allows particular
> events to have a different set of CPUs compared to the PMU.
> 
> One scenario where this could be useful is when a PMU is set up with a
> cpumask/events per SMT thread but some events record for all SMT
> threads. Programming an event on each SMT thread will cause
> unnecessary counters to be programmed and the aggregate value to be
> too large.

If I understand the scenario correctly, I think the issue should have
been addressed since ICX, with the introduction of  the "SMT-aware
events". Is there a specific event which still has the issue on newer
platforms?

> 
> Another scenario where this could be useful if when a PMU has
> historically had a cpumask at the package level, but now newer per
> die, core or CPU information is available.

The traditional way to support new counters with a different scope is to
add a new PMU.

> 
> Additional context for the motivation is in these patches and
> conversation:
> https://lore.kernel.org/lkml/20240711102436.4432-1-Dhananjay.Ugwekar@amd.com/

I don't see the advantages of the new event.cpus way.
The aggregation should be the same.
The RAPL counters are free-running counters. So there is no difference
whether grouping or not grouping.

But it makes the kernel driver complex, since it has to maintain at
least two different cpumasks.
The tool becomes complex either, since it has to take care of the
per-event CPU override case. The json file must also be updated to add a
new field cpumask.

Thanks,
Kan
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  .../sysfs-bus-event_source-devices-events     | 14 ++++++
>  tools/perf/util/parse-events.c                | 45 ++++++++++---------
>  tools/perf/util/pmu.c                         | 44 +++++++++++++++++-
>  tools/perf/util/pmu.h                         |  1 +
>  4 files changed, 82 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> index e7efeab2ee83..d8e3a4dd3ba7 100644
> --- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> @@ -70,6 +70,20 @@ Description:	Per-pmu performance monitoring events specific to the running syste
>  		This is referred to as "event parameterization". Event
>  		parameters have the format 'param=?'.
>  
> +What: /sys/bus/event_source/devices/<pmu>/events/<event>.cpus
> +Date: 2024/07/17
> +Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> +Description:	Perf event CPUs
> +
> +		A list of CPUs on which a the perf event should be
> +		opened by default. This is an event specific variant
> +		of /sys/bus/event_source/devices/<pmu>/cpumask.
> +
> +		Examples (each of these lines would be in a separate file):
> +
> +			0,2,4,6
> +			0-7
> +
>  What: /sys/bus/event_source/devices/<pmu>/events/<event>.unit
>  Date: 2014/02/24
>  Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 43501eb56336..b181f83c9678 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1425,12 +1425,13 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
>  				bool auto_merge_stats)
>  {
>  	struct perf_event_attr attr;
> -	struct perf_pmu_info info;
> +	struct perf_pmu_info info = {};
>  	struct evsel *evsel;
>  	struct parse_events_error *err = parse_state->error;
>  	LIST_HEAD(config_terms);
>  	struct parse_events_terms parsed_terms;
>  	bool alias_rewrote_terms = false;
> +	int ret = 0;
>  
>  	if (verbose > 1) {
>  		struct strbuf sb;
> @@ -1465,8 +1466,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
>  
>  	parse_events_terms__init(&parsed_terms);
>  	if (const_parsed_terms) {
> -		int ret = parse_events_terms__copy(const_parsed_terms, &parsed_terms);
> -
> +		ret = parse_events_terms__copy(const_parsed_terms, &parsed_terms);
>  		if (ret)
>  			return ret;
>  	}
> @@ -1474,15 +1474,15 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
>  
>  	/* Configure attr/terms with a known PMU, this will set hardcoded terms. */
>  	if (config_attr(&attr, &parsed_terms, parse_state->error, config_term_pmu)) {
> -		parse_events_terms__exit(&parsed_terms);
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto out_err;
>  	}
>  
>  	/* Look for event names in the terms and rewrite into format based terms. */
>  	if (!parse_state->fake_pmu && perf_pmu__check_alias(pmu, &parsed_terms,
>  							    &info, &alias_rewrote_terms, err)) {
> -		parse_events_terms__exit(&parsed_terms);
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto out_err;
>  	}
>  
>  	if (verbose > 1) {
> @@ -1497,13 +1497,13 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
>  	/* Configure attr/terms again if an alias was expanded. */
>  	if (alias_rewrote_terms &&
>  	    config_attr(&attr, &parsed_terms, parse_state->error, config_term_pmu)) {
> -		parse_events_terms__exit(&parsed_terms);
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto out_err;
>  	}
>  
>  	if (get_config_terms(&parsed_terms, &config_terms)) {
> -		parse_events_terms__exit(&parsed_terms);
> -		return -ENOMEM;
> +		ret = -ENOMEM;
> +		goto out_err;
>  	}
>  
>  	/*
> @@ -1512,24 +1512,23 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
>  	 */
>  	if (pmu->perf_event_attr_init_default &&
>  	    get_config_chgs(pmu, &parsed_terms, &config_terms)) {
> -		parse_events_terms__exit(&parsed_terms);
> -		return -ENOMEM;
> +		ret = -ENOMEM;
> +		goto out_err;
>  	}
>  
>  	if (!parse_state->fake_pmu &&
>  	    perf_pmu__config(pmu, &attr, &parsed_terms, parse_state->error)) {
> -		free_config_terms(&config_terms);
> -		parse_events_terms__exit(&parsed_terms);
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto out_err;
>  	}
>  
>  	evsel = __add_event(list, &parse_state->idx, &attr, /*init_attr=*/true,
>  			    get_config_name(&parsed_terms),
>  			    get_config_metric_id(&parsed_terms), pmu,
> -			    &config_terms, auto_merge_stats, /*cpu_list=*/NULL);
> +			    &config_terms, auto_merge_stats, info.cpus);
>  	if (!evsel) {
> -		parse_events_terms__exit(&parsed_terms);
> -		return -ENOMEM;
> +		ret = -ENOMEM;
> +		goto out_err;
>  	}
>  
>  	if (evsel->name)
> @@ -1542,13 +1541,17 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
>  		return 0;
>  	}
>  
> -	parse_events_terms__exit(&parsed_terms);
>  	free((char *)evsel->unit);
>  	evsel->unit = strdup(info.unit);
>  	evsel->scale = info.scale;
>  	evsel->per_pkg = info.per_pkg;
>  	evsel->snapshot = info.snapshot;
> -	return 0;
> +out_err:
> +	parse_events_terms__exit(&parsed_terms);
> +	if (ret)
> +		free_config_terms(&config_terms);
> +	perf_cpu_map__put(info.cpus);
> +	return ret;
>  }
>  
>  int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 5148b6639dd3..280b2499c861 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -73,6 +73,11 @@ struct perf_pmu_alias {
>  	 * differ from the PMU name as it won't have suffixes.
>  	 */
>  	char *pmu_name;
> +	/**
> +	 * @cpus: A possible per-event cpumap that overrides that given for the
> +	 * PMU.
> +	 */
> +	struct perf_cpu_map *cpus;
>  	/** @unit: Units for the event, such as bytes or cache lines. */
>  	char unit[UNIT_MAX_LEN+1];
>  	/** @scale: Value to scale read counter values by. */
> @@ -332,6 +337,32 @@ static int perf_pmu__parse_scale(struct perf_pmu *pmu, struct perf_pmu_alias *al
>  	return ret;
>  }
>  
> +static void perf_pmu__parse_cpus(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
> +{
> +	char path[PATH_MAX];
> +	size_t len;
> +	FILE *file;
> +	int fd;
> +
> +	len = perf_pmu__event_source_devices_scnprintf(path, sizeof(path));
> +	if (!len)
> +		return;
> +	scnprintf(path + len, sizeof(path) - len, "%s/events/%s.cpus", pmu->name, alias->name);
> +
> +	fd = open(path, O_RDONLY);
> +	if (fd == -1)
> +		return; /* Expected common case. */
> +
> +	file = fdopen(fd, "r");
> +	if (!file) {
> +		close(fd);
> +		return;
> +	}
> +
> +	alias->cpus = perf_cpu_map__read(file);
> +	fclose(file);
> +}
> +
>  static int perf_pmu__parse_unit(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
>  {
>  	char path[PATH_MAX];
> @@ -493,6 +524,7 @@ static void read_alias_info(struct perf_pmu *pmu, struct perf_pmu_alias *alias)
>  	/*
>  	 * load unit name and scale if available
>  	 */
> +	perf_pmu__parse_cpus(pmu, alias);
>  	perf_pmu__parse_unit(pmu, alias);
>  	perf_pmu__parse_scale(pmu, alias);
>  	perf_pmu__parse_per_pkg(pmu, alias);
> @@ -618,7 +650,7 @@ static inline bool pmu_alias_info_file(const char *name)
>  	size_t len;
>  
>  	len = strlen(name);
> -	if (len > 5 && !strcmp(name + len - 5, ".unit"))
> +	if (len > 5 && (!strcmp(name + len - 5, ".cpus") || !strcmp(name + len - 5, ".unit")))
>  		return true;
>  	if (len > 6 && !strcmp(name + len - 6, ".scale"))
>  		return true;
> @@ -1560,6 +1592,12 @@ static int check_info_data(struct perf_pmu *pmu,
>  	 * define unit, scale and snapshot, fail
>  	 * if there's more than one.
>  	 */
> +	if (!perf_cpu_map__is_empty(info->cpus) && !perf_cpu_map__is_empty(alias->cpus)) {
> +		parse_events_error__handle(err, column,
> +					strdup("Attempt to set event's cpus twice"),
> +					NULL);
> +		return -EINVAL;
> +	}
>  	if (info->unit && alias->unit[0]) {
>  		parse_events_error__handle(err, column,
>  					strdup("Attempt to set event's unit twice"),
> @@ -1579,6 +1617,9 @@ static int check_info_data(struct perf_pmu *pmu,
>  		return -EINVAL;
>  	}
>  
> +	if (!perf_cpu_map__is_empty(alias->cpus))
> +		info->cpus = perf_cpu_map__get(alias->cpus);
> +
>  	if (alias->unit[0])
>  		info->unit = alias->unit;
>  
> @@ -1610,6 +1651,7 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
>  	 * Mark unit and scale as not set
>  	 * (different from default values, see below)
>  	 */
> +	info->cpus     = NULL;
>  	info->unit     = NULL;
>  	info->scale    = 0.0;
>  	info->snapshot = false;
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index b2d3fd291f02..b1ccfe8d3df4 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -177,6 +177,7 @@ struct perf_pmu {
>  extern struct perf_pmu perf_pmu__fake;
>  
>  struct perf_pmu_info {
> +	struct perf_cpu_map *cpus;
>  	const char *unit;
>  	double scale;
>  	bool per_pkg;
