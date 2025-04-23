Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7C327C17C;
	Wed, 23 Apr 2025 14:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418200; cv=none; b=eW6M35+282erK9jFuVeN2nn3KMlgcf9ndVBr5Z7gVIUipfbsdEfQcNcGe4Uty+00/ZKh44DuelzZEz6EjWsHDtp64xHEO4VFTAUZeYa8zyZCKjOdpEulbzQAf5uh63JjysgigYs3gixSIYvVY3qYFEotDdzTny2OtI6U/+Ie8Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418200; c=relaxed/simple;
	bh=CcnWWaraODw9SuKt8kDAC0krPCJiWe4ppv3BuwGOnPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piE/4QPRqZHUe3AgCmncPGolIBxKYci6ZI+HWdgmCnMHYoumGNeMKHPTTJSza7kHWk4PlS/l+5FJpBqO1ZroPshXRT5mgLWsgFUVG62xMdugVWzWaY9cJgfCHjQiFMCw92AxuPWEEQQp2+6A+AHphhnMRg//IIhsOZUNbpNcHCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsXkaJba; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsXkaJba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC15C4CEE2;
	Wed, 23 Apr 2025 14:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745418198;
	bh=CcnWWaraODw9SuKt8kDAC0krPCJiWe4ppv3BuwGOnPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tsXkaJbawDIRGlUM4SjTsvjb+UnrVISvHnzVbtSUUYaZm4YLGQBbTa5lp72ZHHhnI
	 mTmgmX2UPYRW9j1cEye/I8G6zYqzoYeaIJg8VXDk5IWf49Ch4iE7ueuTkAQzNdrqQx
	 ZWpzTb3bexY8jMu1+mPhK8YGZxjltPP7doNyd1Nv7Amgk5m9hTixmutNPDIUkPpqtT
	 2gEkINnRLifd+iRPimiBFwTZ3R2JZvLT9dd1XTg8h3qEulyFpxy8vg3xBWE1e3Mcpr
	 RL2MNI1vMVG5ZTu0Kxzu+H6AtofiBShALnhXwZdJafUcIfErXmpTdS0JoDN9SpIyIB
	 vQfylKq8Ww8gQ==
Date: Wed, 23 Apr 2025 11:23:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Caleb Biggers <caleb.biggers@intel.com>,
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>
Subject: Re: [PATCH v5 09/16] perf intel-tpebs: Refactor tpebs_results list
Message-ID: <aAj30xLNXtXhn6IP@x1>
References: <20250414174134.3095492-1-irogers@google.com>
 <20250414174134.3095492-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250414174134.3095492-10-irogers@google.com>

On Mon, Apr 14, 2025 at 10:41:27AM -0700, Ian Rogers wrote:
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
> Tested-by: Weilin Wang <weilin.wang@intel.com>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-stat.c     |   2 -
>  tools/perf/util/evlist.c      |   1 -
>  tools/perf/util/evsel.c       |   2 +-
>  tools/perf/util/intel-tpebs.c | 150 +++++++++++++++++++++-------------
>  tools/perf/util/intel-tpebs.h |   2 +-
>  5 files changed, 93 insertions(+), 64 deletions(-)
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
<SNIP>

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

I'm adding the following patch to address building on 32-bit systems:

  20     4.97 debian:experimental-x-mips    : FAIL gcc version 14.2.0 (Debian 14.2.0-13) 
    util/intel-tpebs.c: In function 'tpebs_retire_lat__find':
    util/intel-tpebs.c:377:21: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
      377 |                 if ((uint64_t)t->evsel == num)
          |                     ^
    cc1: all warnings being treated as errors

- Arnaldo

⬢ [acme@toolbx perf-tools-next]$ git diff
diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index a723687e67f6d7b3..b48f3692c798f924 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -242,7 +242,7 @@ static void tpebs_retire_lat__delete(struct tpebs_retire_lat *r)
 static struct tpebs_retire_lat *tpebs_retire_lat__find(struct evsel *evsel)
 {
        struct tpebs_retire_lat *t;
-       uint64_t num;
+       unsigned long num;
        const char *evsel_name;
 
        /*
@@ -269,7 +269,7 @@ static struct tpebs_retire_lat *tpebs_retire_lat__find(struct evsel *evsel)
                return NULL;
        }
        list_for_each_entry(t, &tpebs_results, nd) {
-               if ((uint64_t)t->evsel == num)
+               if ((unsigned long)t->evsel == num)
                        return t;
        }
        return NULL;

