Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1185A2F2A;
	Mon,  7 Apr 2025 19:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744054391; cv=none; b=UrFK08r7VbJZFoATOHN6wHG11L6xBEfNmmmwdePXsEzfyAlsSI2KenLuc51a2DRUCjJ9exZnkGGbNtAzQrhkLDWz3jtztSQ3MtkHXfv9cGmZ1qrXPvZryEIifjyBPUh69p3sQlHAh51Cx1o+tQKiKHwByOnDoFgQ5ojilhyksPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744054391; c=relaxed/simple;
	bh=RrtH/nD1uFMYPrOsQE4EjIFgCUo0VKpTZ+3/dIza3Tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sfL85C3OC7A8DSFqqjdPD7bAvLfDb4Rc62zdUgfECW4HXvOfLZP4tdkBhbKM4wIUgDoOjedTHMp2oR0BdUCUgW4O9tenLmX0Zohjc8JE5duJxm3fPUnj8ifCWsrwqFTG+P88ebolTV+MtrQoiztFubqjULY4r2X5Q+Kc7/+FGz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CxIpMACt; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CxIpMACt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744054389; x=1775590389;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=RrtH/nD1uFMYPrOsQE4EjIFgCUo0VKpTZ+3/dIza3Tk=;
  b=CxIpMACt4c1mhBXd6WFIIfrxuOQvxi6h8R+PGktlyb6tTEM4bvCZdxXK
   iBL1DuJ79MnmhrsK7AxKZ1Skjg816y252o8l4/uqNmFbmL+ii98RyV3Y6
   I8q8kQy5z8E4gcfZRaOtIge3XBVkswSZI0T/YfOtMoD297vGMT73MqRPM
   R0FM4PCmG4p8Gx8xMQniunrG6GphM2JWDRwxJgjKpCoDk+Qymb9LtH0TB
   FvidnAAe0wephdCyOWObYykRXJTlbXh5nl+XcFXbXQJHAvby5UBa7Wzh5
   c3nK9Q4PrA/REG/IWqGa91lJmixBFAvk9OD1k81bu/itFL2InZ6KX1hoX
   g==;
X-CSE-ConnectionGUID: G29oGrjgQpylSgD6dKQSug==
X-CSE-MsgGUID: jwV55EQ6Su6RsubSM/Yqow==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45578368"
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="45578368"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 12:33:08 -0700
X-CSE-ConnectionGUID: dQ5nDWjXRpSrqe10qDlYIg==
X-CSE-MsgGUID: brwscPrJTG+Bw0uVFofDFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="132183735"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 12:33:08 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id D0F6020B5736;
	Mon,  7 Apr 2025 12:33:04 -0700 (PDT)
Message-ID: <7457b450-9f13-4528-b5e1-2f10f0a7be12@linux.intel.com>
Date: Mon, 7 Apr 2025 15:33:03 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/16] perf intel-tpebs: Refactor tpebs_results list
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Weilin Wang <weilin.wang@intel.com>, James Clark <james.clark@linaro.org>,
 Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>,
 Howard Chu <howardchu95@gmail.com>, Levi Yun <yeoreum.yun@arm.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250407050101.1389825-1-irogers@google.com>
 <20250407050101.1389825-10-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250407050101.1389825-10-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-04-07 1:00 a.m., Ian Rogers wrote:
> evsel names and metric-ids are used for matching but this can be
> problematic, for example, multiple occurrences of the same retirement
> latency event become a single event for the record. Change the name of
> the record events so they are unique and reflect the evsel of the
> retirement latency event that opens them (the retirement latency
> event's evsel address is embedded within them). This allows an evsel
> based close to close the event when the retirement latency event is
> closed. This is important as perf stat has an evlist and the session
> listen to the record events has an evlist, knowing which event should
> remove the tpebs_retire_lat can't be tied to an evlist list as there
> is more than 1, so closing which evlist should cause the tpebs to
> stop? Using the evsel and the last one out doing the tpebs_stop is
> cleaner.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-stat.c     |   2 -
>  tools/perf/util/evlist.c      |   1 -
>  tools/perf/util/evsel.c       |   2 +-
>  tools/perf/util/intel-tpebs.c | 152 ++++++++++++++++++++--------------
>  tools/perf/util/intel-tpebs.h |   2 +-
>  5 files changed, 94 insertions(+), 65 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 68ea7589c143..80e491bd775b 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -681,8 +681,6 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
>  	if (child_pid != -1)
>  		kill(child_pid, SIGTERM);
>  
> -	tpebs_delete();
> -
>  	return COUNTER_FATAL;
>  }
>  
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index c1a04141aed0..0a21da4f990f 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -183,7 +183,6 @@ void evlist__delete(struct evlist *evlist)
>  	if (evlist == NULL)
>  		return;
>  
> -	tpebs_delete();
>  	evlist__free_stats(evlist);
>  	evlist__munmap(evlist);
>  	evlist__close(evlist);
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 121283f2f382..554252ed1aab 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2759,7 +2759,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
>  void evsel__close(struct evsel *evsel)
>  {
>  	if (evsel__is_retire_lat(evsel))
> -		tpebs_delete();
> +		evsel__tpebs_close(evsel);
>  	perf_evsel__close(&evsel->core);
>  	perf_evsel__free_id(&evsel->core);
>  }
> diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
> index e42f3ec39a64..e3227646a9cc 100644
> --- a/tools/perf/util/intel-tpebs.c
> +++ b/tools/perf/util/intel-tpebs.c
> @@ -35,10 +35,10 @@ static struct child_process tpebs_cmd;
>  
>  struct tpebs_retire_lat {
>  	struct list_head nd;
> -	/* Event name */
> -	char *name;
> -	/* Event name with the TPEBS modifier R */
> -	const char *tpebs_name;
> +	/** @evsel: The evsel that opened the retire_lat event. */
> +	struct evsel *evsel;
> +	/** @event: Event passed to perf record. */
> +	char *event;
>  	/* Count of retire_latency values found in sample data */
>  	size_t count;
>  	/* Sum of all the retire_latency values in sample data */
> @@ -49,6 +49,8 @@ struct tpebs_retire_lat {
>  	bool started;
>  };
>  
> +static struct tpebs_retire_lat *tpebs_retire_lat__find(struct evsel *evsel);
> +
>  static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[], int ack_fd[])
>  {
>  	const char **record_argv;
> @@ -85,7 +87,7 @@ static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[],
>  
>  	list_for_each_entry(t, &tpebs_results, nd) {
>  		record_argv[i++] = "-e";
> -		record_argv[i++] = t->name;
> +		record_argv[i++] = t->event;
>  	}
>  	record_argv[i++] = NULL;
>  	assert(i == 10 + 2 * tpebs_event_size || i == 8 + 2 * tpebs_event_size);
> @@ -108,27 +110,20 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>  				struct evsel *evsel,
>  				struct machine *machine __maybe_unused)
>  {
> -	int ret = 0;
> -	const char *evname;
>  	struct tpebs_retire_lat *t;
>  
> -	evname = evsel__name(evsel);
> -
> +	t = tpebs_retire_lat__find(evsel);
> +	if (!t)
> +		return -EINVAL;
>  	/*
>  	 * Need to handle per core results? We are assuming average retire
>  	 * latency value will be used. Save the number of samples and the sum of
>  	 * retire latency value for each event.
>  	 */
> -	list_for_each_entry(t, &tpebs_results, nd) {
> -		if (!strcmp(evname, t->name)) {
> -			t->count += 1;
> -			t->sum += sample->retire_lat;
> -			t->val = (double) t->sum / t->count;
> -			break;
> -		}
> -	}
> -
> -	return ret;
> +	t->count += 1;
> +	t->sum += sample->retire_lat;
> +	t->val = (double) t->sum / t->count;
> +	return 0;
>  }
>  
>  static int process_feature_event(struct perf_session *session,
> @@ -183,50 +178,98 @@ static int tpebs_stop(void)
>  	return ret;
>  }
>  
> -static char *evsel__tpebs_name(struct evsel *evsel)
> +/**
> + * evsel__tpebs_event() - Create string event encoding to pass to `perf record`.
> + */
> +static int evsel__tpebs_event(struct evsel *evsel, char **event)
>  {
>  	char *name, *modifier;
> +	int ret;
>  
>  	name = strdup(evsel->name);
> -	if (!name)
> -		return NULL;
> +	if (!*name)
> +		return -ENOMEM;

if (!name)?

Thanks,
Kan

>  
>  	modifier = strrchr(name, 'R');
>  	if (!modifier) {
> -		pr_err("Tpebs event missing modifier '%s'\n", name);
> -		free(name);
> -		return NULL;
> +		ret = -EINVAL;
> +		goto out;
>  	}
> -
>  	*modifier = 'p';
> -	return name;
> +	modifier = strchr(name, ':');
> +	if (!modifier)
> +		modifier = strrchr(name, '/');
> +	if (!modifier) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	*modifier = '\0';
> +	if (asprintf(event, "%s/name=tpebs_event_%p/%s", name, evsel, modifier + 1) > 0)
> +		ret = 0;
> +	else
> +		ret = -ENOMEM;
> +out:
> +	if (ret)
> +		pr_err("Tpebs event modifier broken '%s'\n", evsel->name);
> +	free(name);
> +	return ret;
>  }
>  
>  static struct tpebs_retire_lat *tpebs_retire_lat__new(struct evsel *evsel)
>  {
>  	struct tpebs_retire_lat *result = zalloc(sizeof(*result));
> +	int ret;
>  
>  	if (!result)
>  		return NULL;
>  
> -	result->tpebs_name = evsel->name;
> -	result->name = evsel__tpebs_name(evsel);
> -	if (!result->name) {
> +	ret = evsel__tpebs_event(evsel, &result->event);
> +	if (ret) {
>  		free(result);
>  		return NULL;
>  	}
> +	result->evsel = evsel;
>  	list_add_tail(&result->nd, &tpebs_results);
>  	return result;
>  }
>  
> +static void tpebs_retire_lat__delete(struct tpebs_retire_lat *r)
> +{
> +	zfree(&r->event);
> +	free(r);
> +}
> +
>  static struct tpebs_retire_lat *tpebs_retire_lat__find(struct evsel *evsel)
>  {
>  	struct tpebs_retire_lat *t;
> +	uint64_t num;
> +	const char *evsel_name;
>  
> +	/*
> +	 * Evsels will match for evlist with the retirement latency event. The
> +	 * name with "tpebs_event_" prefix will be present on events being read
> +	 * from `perf record`.
> +	 */
> +	if (evsel__is_retire_lat(evsel)) {
> +		list_for_each_entry(t, &tpebs_results, nd) {
> +			if (t->evsel == evsel)
> +				return t;
> +		}
> +		return NULL;
> +	}
> +	evsel_name = strstr(evsel->name, "tpebs_event_");
> +	if (!evsel_name) {
> +		/* Unexpected that the perf record should have other events. */
> +		return NULL;
> +	}
> +	errno = 0;
> +	num = strtoull(evsel_name + 12, NULL, 16);
> +	if (errno) {
> +		pr_err("Bad evsel for tpebs find '%s'\n", evsel->name);
> +		return NULL;
> +	}
>  	list_for_each_entry(t, &tpebs_results, nd) {
> -		if (t->tpebs_name == evsel->name ||
> -		    !strcmp(t->tpebs_name, evsel->name) ||
> -		    (evsel->metric_id && !strcmp(t->tpebs_name, evsel->metric_id)))
> +		if ((uint64_t)t->evsel == num)
>  			return t;
>  	}
>  	return NULL;
> @@ -363,8 +406,12 @@ int evsel__tpebs_open(struct evsel *evsel)
>  		close(ack_fd[0]);
>  		close(ack_fd[1]);
>  	}
> -	if (ret)
> -		tpebs_delete();
> +	if (ret) {
> +		struct tpebs_retire_lat *t = tpebs_retire_lat__find(evsel);
> +
> +		list_del_init(&t->nd);
> +		tpebs_retire_lat__delete(t);
> +	}
>  	return ret;
>  }
>  
> @@ -414,34 +461,19 @@ int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread)
>  	return 0;
>  }
>  
> -static void tpebs_retire_lat__delete(struct tpebs_retire_lat *r)
> -{
> -	zfree(&r->name);
> -	free(r);
> -}
> -
> -
> -/*
> - * tpebs_delete - delete tpebs related data and stop the created thread and
> - * process by calling tpebs_stop().
> - *
> - * This function is called from evlist_delete() and also from builtin-stat
> - * stat_handle_error(). If tpebs_start() is called from places other then perf
> - * stat, need to ensure tpebs_delete() is also called to safely free mem and
> - * close the data read thread and the forked perf record process.
> +/**
> + * evsel__tpebs_close() - delete tpebs related data. If the last event, stop the
> + * created thread and process by calling tpebs_stop().
>   *
> - * This function is also called in evsel__close() to be symmetric with
> - * tpebs_start() being called in evsel__open(). We will update this call site
> - * when move tpebs_start() to evlist level.
> + * This function is called in evsel__close() to be symmetric with
> + * evsel__tpebs_open() being called in evsel__open().
>   */
> -void tpebs_delete(void)
> +void evsel__tpebs_close(struct evsel *evsel)
>  {
> -	struct tpebs_retire_lat *r, *rtmp;
> +	struct tpebs_retire_lat *t = tpebs_retire_lat__find(evsel);
>  
> -	tpebs_stop();
> +	tpebs_retire_lat__delete(t);
>  
> -	list_for_each_entry_safe(r, rtmp, &tpebs_results, nd) {
> -		list_del_init(&r->nd);
> -		tpebs_retire_lat__delete(r);
> -	}
> +	if (list_empty(&tpebs_results))
> +		tpebs_stop();
>  }
> diff --git a/tools/perf/util/intel-tpebs.h b/tools/perf/util/intel-tpebs.h
> index cc98203719c8..5c671181ec60 100644
> --- a/tools/perf/util/intel-tpebs.h
> +++ b/tools/perf/util/intel-tpebs.h
> @@ -11,7 +11,7 @@ struct evsel;
>  extern bool tpebs_recording;
>  
>  int evsel__tpebs_open(struct evsel *evsel);
> -void tpebs_delete(void);
> +void evsel__tpebs_close(struct evsel *evsel);
>  int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread);
>  
>  #endif /* __INTEL_TPEBS_H */

