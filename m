Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D3F28E5;
	Fri, 31 Oct 2025 18:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761935960; cv=none; b=YjNonCc70ievModLzjpzNAb/63zp90zlicYXTS1ExVyA+abkiC5Ww4mJGP/ANI1Ce/PmhIAgGDdCRO5/9H0KgGZXzwVKEs/IiEX+8nfSA/D3EcGUtMszgrDvWkmYBf+WdEu7yad4Wi2KGwpoV6G4zCpQ+d2upkFt5TY4nOn44ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761935960; c=relaxed/simple;
	bh=Cp/Ig8HQ0YgYihIZ4UrrKsQNaMpNuOu/306SJ3Quz1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0FnKsNdfOWdC0SAxYHfyrQmP9p6RndumxRDIthT3M/lUlhIjdL4owk98PBKTfj+eBml5AYnpYgbnYjylWzSbRa0IwvuLG3Qfosp6A6IwHe2fJqRRM5f9eKi/4T53f8SUE0zPQV3gmsT7pms8N09KJ4KXgutK/XiDZMAcaSdkWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rh4bn06n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rh4bn06n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C48C4CEE7;
	Fri, 31 Oct 2025 18:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761935959;
	bh=Cp/Ig8HQ0YgYihIZ4UrrKsQNaMpNuOu/306SJ3Quz1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rh4bn06n54NHJMqmBGEnap3v3cLYXa0gI/ZzsAuAUaYYMlehXZfyDkTrKTwfzUZSQ
	 iZF/PEz/oJnP6JrNWWPHKDzsqtoIHlxlYwYTDlcA8WkF86oCypeNrYbefbZemG8qSm
	 oIH7WIONGv0TAk/FBnNrfKvGpqQie4AFma4yrQsdWy4lXStUKXmBjadAOvVA/WsuVB
	 20q3z20FsZ/SBBXi9c1yX+9HkXFuzCWL4MM1N7wNccdSWGtNX5GIwYBXg/Bw8W8Vyu
	 WdGIdX+qnSHXE/2hsl0o1/xdi5Le99CbK2voLH+7geJ2AOOgYVCaiaGTpcw7tReTye
	 c6PzKo6p1bznw==
Date: Fri, 31 Oct 2025 11:39:18 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf s390-sample-raw: Cache counter names
Message-ID: <aQUCVvIEC7brqaG-@google.com>
References: <20251031161213.1452901-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251031161213.1452901-1-irogers@google.com>

Hi Ian,

On Fri, Oct 31, 2025 at 09:12:13AM -0700, Ian Rogers wrote:
> Searching all event names is slower now that legacy names are
> included. Add a cache to avoid long iterative searches.
> 
> Reported-by: Thomas Richter <tmricht@linux.ibm.com>
> Closes: https://lore.kernel.org/linux-perf-users/09943f4f-516c-4b93-877c-e4a64ed61d38@linux.ibm.com/
> Signed-off-by: Ian Rogers <irogers@google.com>
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
> v3: Fix minor comment typo, add Thomas' tag.
> v2: Small tweak to the cache_key, just make it match the wanted event value.
> ---
>  tools/perf/util/s390-sample-raw.c | 56 ++++++++++++++++++++++++++++---
>  1 file changed, 51 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
> index 335217bb532b..4f269ea7c93b 100644
> --- a/tools/perf/util/s390-sample-raw.c
> +++ b/tools/perf/util/s390-sample-raw.c
> @@ -19,12 +19,14 @@
>  
>  #include <sys/stat.h>
>  #include <linux/compiler.h>
> +#include <linux/err.h>
>  #include <asm/byteorder.h>
>  
>  #include "debug.h"
>  #include "session.h"
>  #include "evlist.h"
>  #include "color.h"
> +#include "hashmap.h"
>  #include "sample-raw.h"
>  #include "s390-cpumcf-kernel.h"
>  #include "util/pmu.h"
> @@ -132,8 +134,8 @@ static int get_counterset_start(int setnr)
>  }
>  
>  struct get_counter_name_data {
> -	int wanted;
> -	char *result;
> +	long wanted;
> +	const char *result;
>  };
>  
>  static int get_counter_name_callback(void *vdata, struct pmu_event_info *info)
> @@ -151,12 +153,22 @@ static int get_counter_name_callback(void *vdata, struct pmu_event_info *info)
>  
>  	rc = sscanf(event_str, "event=%x", &event_nr);
>  	if (rc == 1 && event_nr == data->wanted) {
> -		data->result = strdup(info->name);
> +		data->result = info->name;
>  		return 1; /* Terminate the search. */
>  	}
>  	return 0;
>  }
>  
> +static size_t get_counter_name_hash_fn(long key, void *ctx __maybe_unused)
> +{
> +	return key;
> +}
> +
> +static bool get_counter_name_hashmap_equal_fn(long key1, long key2, void *ctx __maybe_unused)
> +{
> +	return key1 == key2;
> +}
> +
>  /* Scan the PMU and extract the logical name of a counter from the event. Input
>   * is the counter set and counter number with in the set. Construct the event
>   * number and use this as key. If they match return the name of this counter.
> @@ -164,17 +176,51 @@ static int get_counter_name_callback(void *vdata, struct pmu_event_info *info)
>   */
>  static char *get_counter_name(int set, int nr, struct perf_pmu *pmu)
>  {
> +	static struct hashmap *cache;
> +	static struct perf_pmu *cache_pmu;
> +	long cache_key = get_counterset_start(set) + nr;
>  	struct get_counter_name_data data = {
> -		.wanted = get_counterset_start(set) + nr,
> +		.wanted = cache_key,
>  		.result = NULL,
>  	};
> +	char *result = NULL;
>  
>  	if (!pmu)
>  		return NULL;
>  
> +	if (cache_pmu == pmu && hashmap__find(cache, cache_key, &result))
> +		return strdup(result);
> +
>  	perf_pmu__for_each_event(pmu, /*skip_duplicate_pmus=*/ true,
>  				 &data, get_counter_name_callback);
> -	return data.result;
> +
> +	if (data.result)
> +		result = strdup(data.result);
> +
> +	if (cache_pmu == NULL) {
> +		struct hashmap *tmp = hashmap__new(get_counter_name_hash_fn,
> +						   get_counter_name_hashmap_equal_fn,
> +						   /*ctx=*/NULL);
> +
> +		if (!IS_ERR(cache)) {

Shouldn't it be if (!IS_ERR(tmp)) ?

And it's not released.

Thanks,
Namhyung

> +			cache = tmp;
> +			cache_pmu = pmu;
> +		}
> +	}
> +
> +	if (cache_pmu == pmu) {
> +		char *old_value = NULL, *new_value = strdup(result);
> +
> +		if (new_value) {
> +			hashmap__set(cache, cache_key, new_value, /*old_key=*/NULL, &old_value);
> +			/*
> +			 * Free in case of a race, but resizing would be broken
> +			 * in that case.
> +			 */
> +			free(old_value);
> +		}
> +	}
> +	return result;
>  }
>  
>  static void s390_cpumcfdg_dump(struct perf_pmu *pmu, struct perf_sample *sample)
> -- 
> 2.51.1.930.gacf6e81ea2-goog
> 
