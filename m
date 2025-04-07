Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BEC21B8E0;
	Mon,  7 Apr 2025 19:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055384; cv=none; b=u7tJ2wmm3ymtkn8z4VNJdvvqtN22eSlqppkKwpG1D68hNlnsXvl8EcOcdVsmLG+ox9etZTNauFo+0JpZnlyWWT6r67NnIEWh3PXqdw4mu4xUAiCVhzK7vPlPypyZ0wmAs5ewQHVT5zhEvEMd78u6cKBlUmX6qXR56XDdi7kMuyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055384; c=relaxed/simple;
	bh=kPGGYwictMgHdBQaCS8AmmSg6ru18siQsL4XgYKrIcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dr+8yE3U6RBF3FjQfkZKgtGL+LsEbM2rYKyyYi/M8pElTACqpZPxpu+EBO1DJnnYAE2x4iSfGxobchRgIawtsFigcbF/2b9vQ2HRYzw7l8zX+XArno0D0ZMOki6p3hkxylHi7bugLMKiIZs2N6bjywR4sdW3XRsaweX7FJk7kII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YUABHNQw; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YUABHNQw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744055382; x=1775591382;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=kPGGYwictMgHdBQaCS8AmmSg6ru18siQsL4XgYKrIcM=;
  b=YUABHNQwSz40yfRb7QofjcRgw+/LQQLeEZhAwBJwkplkJAxA/bWJSy/t
   WwQwubHcjpxYASjOnqBC9HRoFtbf4iIRP7DWYybSM02J9h/ndjSQuvSQt
   k0xBfLOCQlxvgJrGE0kEhIiC+WH1y3YRPCQ//dES9DhHDIHjep3Puzazd
   X+gck/vuJldb5Y37paZDyUweEIETtr3Ucobe7bvnD0Q6LFUry8Vv2xl/7
   dApPVws/4RMCwlyz+3e4HC83slx2tM7aJqEm08//Ze8ujm6/b8zOt0lz9
   HvMTFHlO2dLoWthUDdnncWzv1oIpFclOgUusCT0vUkkwCmEAcg6eItiR4
   g==;
X-CSE-ConnectionGUID: 0NHQYgZKRGezbTDPjZ5lNQ==
X-CSE-MsgGUID: RLDzG2ePRFKgil+ry5OKRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45176242"
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="45176242"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 12:49:41 -0700
X-CSE-ConnectionGUID: fIsnkrXlSWWWpTwiZBU0qg==
X-CSE-MsgGUID: /FULNuoyRf6f/Ty4h6KGtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="159048984"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 12:49:41 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 2519D20B5736;
	Mon,  7 Apr 2025 12:49:37 -0700 (PDT)
Message-ID: <26916c80-f42b-47a4-8d6e-7d9b3d84163a@linux.intel.com>
Date: Mon, 7 Apr 2025 15:49:36 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/16] perf intel-tpebs: Add mutex for tpebs_results
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
 <20250407050101.1389825-12-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250407050101.1389825-12-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-04-07 1:00 a.m., Ian Rogers wrote:
> Ensure sample reader isn't racing with events being added/removed.

Is it a bug fix?

I think the tpebs have been merged for a while. Should the backport be
required?

Thanks,
Kan>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/intel-tpebs.c | 51 ++++++++++++++++++++++++++++++-----
>  1 file changed, 44 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
> index 452ce3698221..29616d087bce 100644
> --- a/tools/perf/util/intel-tpebs.c
> +++ b/tools/perf/util/intel-tpebs.c
> @@ -16,6 +16,7 @@
>  #include "debug.h"
>  #include "evlist.h"
>  #include "evsel.h"
> +#include "mutex.h"
>  #include "session.h"
>  #include "tool.h"
>  #include "cpumap.h"
> @@ -32,6 +33,7 @@ bool tpebs_recording;
>  static LIST_HEAD(tpebs_results);
>  static pthread_t tpebs_reader_thread;
>  static struct child_process tpebs_cmd;
> +static struct mutex tpebs_mtx;
>  
>  struct tpebs_retire_lat {
>  	struct list_head nd;
> @@ -51,6 +53,19 @@ struct tpebs_retire_lat {
>  
>  static struct tpebs_retire_lat *tpebs_retire_lat__find(struct evsel *evsel);
>  
> +static void tpebs_mtx_init(void)
> +{
> +	mutex_init(&tpebs_mtx);
> +}
> +
> +static struct mutex *tpebs_mtx_get(void)
> +{
> +	static pthread_once_t tpebs_mtx_once = PTHREAD_ONCE_INIT;
> +
> +	pthread_once(&tpebs_mtx_once, tpebs_mtx_init);
> +	return &tpebs_mtx;
> +}
> +
>  static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[], int ack_fd[])
>  {
>  	const char **record_argv;
> @@ -59,13 +74,15 @@ static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[],
>  	char cpumap_buf[50];
>  	struct tpebs_retire_lat *t;
>  
> +	mutex_lock(tpebs_mtx_get());
>  	list_for_each_entry(t, &tpebs_results, nd)
>  		tpebs_event_size++;
>  
>  	record_argv = malloc((10 + 2 * tpebs_event_size) * sizeof(*record_argv));
> -	if (!record_argv)
> +	if (!record_argv) {
> +		mutex_unlock(tpebs_mtx_get());
>  		return -ENOMEM;
> -
> +	}
>  	record_argv[i++] = "perf";
>  	record_argv[i++] = "record";
>  	record_argv[i++] = "-W";
> @@ -101,6 +118,7 @@ static int evsel__tpebs_start_perf_record(struct evsel *evsel, int control_fd[],
>  	list_for_each_entry(t, &tpebs_results, nd)
>  		t->started = true;
>  
> +	mutex_unlock(tpebs_mtx_get());
>  	return ret;
>  }
>  
> @@ -112,9 +130,12 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>  {
>  	struct tpebs_retire_lat *t;
>  
> +	mutex_lock(tpebs_mtx_get());
>  	t = tpebs_retire_lat__find(evsel);
> -	if (!t)
> +	if (!t) {
> +		mutex_unlock(tpebs_mtx_get());
>  		return -EINVAL;
> +	}
>  	/*
>  	 * Need to handle per core results? We are assuming average retire
>  	 * latency value will be used. Save the number of samples and the sum of
> @@ -123,6 +144,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>  	t->count += 1;
>  	t->sum += sample->retire_lat;
>  	t->val = (double) t->sum / t->count;
> +	mutex_unlock(tpebs_mtx_get());
>  	return 0;
>  }
>  
> @@ -229,7 +251,6 @@ static struct tpebs_retire_lat *tpebs_retire_lat__new(struct evsel *evsel)
>  		return NULL;
>  	}
>  	result->evsel = evsel;
> -	list_add_tail(&result->nd, &tpebs_results);
>  	return result;
>  }
>  
> @@ -282,16 +303,22 @@ static struct tpebs_retire_lat *tpebs_retire_lat__find(struct evsel *evsel)
>  static int evsel__tpebs_prepare(struct evsel *evsel)
>  {
>  	struct evsel *pos;
> -	struct tpebs_retire_lat *tpebs_event = tpebs_retire_lat__find(evsel);
> +	struct tpebs_retire_lat *tpebs_event;
>  
> +	mutex_lock(tpebs_mtx_get());
> +	tpebs_event = tpebs_retire_lat__find(evsel);
>  	if (tpebs_event) {
>  		/* evsel, or an identically named one, was already prepared. */
> +		mutex_unlock(tpebs_mtx_get());
>  		return 0;
>  	}
>  	tpebs_event = tpebs_retire_lat__new(evsel);
>  	if (!tpebs_event)
>  		return -ENOMEM;
>  
> +	list_add_tail(&tpebs_event->nd, &tpebs_results);
> +	mutex_unlock(tpebs_mtx_get());
> +
>  	/*
>  	 * Eagerly prepare all other evsels on the list to try to ensure that by
>  	 * open they are all known.
> @@ -317,6 +344,7 @@ static int evsel__tpebs_prepare(struct evsel *evsel)
>  int evsel__tpebs_open(struct evsel *evsel)
>  {
>  	int ret;
> +	bool tpebs_empty;
>  
>  	/* We should only run tpebs_start when tpebs_recording is enabled. */
>  	if (!tpebs_recording)
> @@ -336,7 +364,10 @@ int evsel__tpebs_open(struct evsel *evsel)
>  	if (ret)
>  		return ret;
>  
> -	if (!list_empty(&tpebs_results)) {
> +	mutex_lock(tpebs_mtx_get());
> +	tpebs_empty = list_empty(&tpebs_results);
> +	mutex_unlock(tpebs_mtx_get());
> +	if (!tpebs_empty) {
>  		struct pollfd pollfd = { .events = POLLIN, };
>  		int control_fd[2], ack_fd[2], len;
>  		char ack_buf[8];
> @@ -436,8 +467,10 @@ int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread)
>  	 */
>  	tpebs_stop();
>  
> +	mutex_lock(tpebs_mtx_get());
>  	t = tpebs_retire_lat__find(evsel);
>  	val = rint(t->val);
> +	mutex_unlock(tpebs_mtx_get());
>  
>  	if (old_count) {
>  		count->val = old_count->val + val;
> @@ -460,9 +493,13 @@ int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread)
>   */
>  void evsel__tpebs_close(struct evsel *evsel)
>  {
> -	struct tpebs_retire_lat *t = tpebs_retire_lat__find(evsel);
> +	struct tpebs_retire_lat *t;
>  
> +	mutex_lock(tpebs_mtx_get());
> +	t = tpebs_retire_lat__find(evsel);
> +	list_del_init(&t->nd);
>  	tpebs_retire_lat__delete(t);
> +	mutex_unlock(tpebs_mtx_get());
>  
>  	if (list_empty(&tpebs_results))
>  		tpebs_stop();

