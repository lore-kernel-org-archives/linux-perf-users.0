Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F6329DB60;
	Fri, 11 Apr 2025 22:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744412096; cv=none; b=Rtc9mqrOZj7RuDSvL8S4OX/mKh9XGWCOSyHQZog/TR9OKJLLwhhKoC0XJrDtfg4lOPA9eyKaZzTU2vY0nw1LnpgSAk0Ih+ZBRLr8OkO7X33pCmde1jJMcqbp95tJ7glbxDOc3THpk0a9UOgSzhbPyTiQV7zOjYxfxkBCKX5cLog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744412096; c=relaxed/simple;
	bh=DsJ6dg0TVtT6PcK383MVTqhEOvAjGoTH/7Jk7npKAsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1dUHGK6EBAjSK7bs/BAJqF6b+nLbFJQJh5Ben/3iQNCinbn2WSJxxnM1hcW3+EcTPAd4vIisGoVZI6FyBl9/m5eyrV2aREPuXHSTcx63mWHSCzdnt8Fo6Dblm2mExXPDdYLiOgxFXRvL65EEnvm5AvIa5r95rMVSXWUgum2kM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5pKcsnW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5pKcsnW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12175C4CEE2;
	Fri, 11 Apr 2025 22:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744412095;
	bh=DsJ6dg0TVtT6PcK383MVTqhEOvAjGoTH/7Jk7npKAsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O5pKcsnWP2XNkXInPxG91EhUfdMrEKfGFPvqSZh8tm1b9UWRDNgh9aPz3k+qLVk+L
	 xO1cOZHN2vBGTk8Ed2LeJxq5U2Tll3glQfhc6nWodpFtYBQC17z7WKEQISLsfAGEFY
	 9qDwORT0gS14HhNpGpVl8l7XsVkugtrcGwZyG8+F/4KU+Sab4uZOdcdeu608XgEgJK
	 xt952GSvA/cpzRlHBUTFkBaK7UC0O5iTqbu8pFtGJrfRH0S+LcsB4Rq6/L2t8MCIHJ
	 BTXn+Oz6N4yEF41VrzR0ctKtSj1uBxAVmF2/wRo+atRVpQwU/BgnchKtwHpZkQOtZx
	 nG7Lkz+cIxv5A==
Date: Fri, 11 Apr 2025 15:54:53 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>,
	John Garry <john.g.garry@oracle.com>,
	Howard Chu <howardchu95@gmail.com>, Levi Yun <yeoreum.yun@arm.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/16] perf intel-tpebs: Add mutex for tpebs_results
Message-ID: <Z_mdvahT2i6djhj1@z2>
References: <20250409061043.700792-1-irogers@google.com>
 <20250409061043.700792-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250409061043.700792-12-irogers@google.com>

On Tue, Apr 08, 2025 at 11:10:38PM -0700, Ian Rogers wrote:
> Ensure sample reader isn't racing with events being added/removed.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/intel-tpebs.c | 51 ++++++++++++++++++++++++++++++-----
>  1 file changed, 44 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
> index f648fca17556..c5ccdbc42dc6 100644
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

The mutex_unlock() is missing here.

Thanks,
Namhyung

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
> -- 
> 2.49.0.504.g3bcea36a83-goog
> 
