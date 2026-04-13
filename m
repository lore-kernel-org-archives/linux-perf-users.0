Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D9A30DD3C;
	Mon, 13 Apr 2026 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098506; cv=none; b=D/epOOBD5JrpLs6/xZ+uneNsfD/7j62eJjPfuHxr/8O4moFHIwYgVe7/g4NIUydey2/d2/dVb4hvnbHg+v3SZOCDMdn/Zf6c/jX/KAPUjU5x8C9H+egLXQ9MMRuVyqHeV5THtIWDmwEblavl8b2BKnNt/3DMn/lh6ebDw948ogs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098506; c=relaxed/simple;
	bh=Q8bwpBPr9WgGhPMlni6qjsJKqlKnnEQsRAbtW15HpGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcmzL4cYk1pfXrxqL9PzZLXcfzA8akqD9Bo5f3xsACTR2RVghdP3JTXo9SYjtoE10KPWCerCymYhfnrw9+1YHyWrVNh5Ty2KEmFtLjSf1Ou5Bt72/euFAC61EiFfyjHZxxdqQ8KqL2onTRTSDalX3g3m7sUJxVZju96knkDFFBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqJMt9td; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqJMt9td"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30A0C2BCB0;
	Mon, 13 Apr 2026 16:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776098505;
	bh=Q8bwpBPr9WgGhPMlni6qjsJKqlKnnEQsRAbtW15HpGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oqJMt9tdV4OuYLTj5docPoM1SkmD9QcehHpg0ICYmSpWa/1BhRKDdd/UWTmRnVVlw
	 ZyePZCMUN8eGhkR7h17feJU5bS4x8b+nL9NUKXfsuX6H/YqVBnfHVF7DRHhWynkU2+
	 4Yn/ol6JXHVgDUae85HOYN2+6kkejquyk7Ne1IMXxA5yXo3vZEiHK5BvTZt2ONHAhi
	 EAdC3t9eoqOn8d9Kgp6y32rWb8PWhx7fq2sBk7IvVuPWRkHWh+BfUrr7Z4oTN/EUzP
	 j7rMcfj/k4CxXidmE10pD+w7Jh+nlI0bvE57TlnoLRpRqK4zO22IL0Niv+fWElCZ4j
	 Y3n5TMNkWvdnw==
Date: Mon, 13 Apr 2026 09:41:42 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
	ak@linux.intel.com, alex@ghiti.fr,
	alexander.shishkin@linux.intel.com, anup@brainfault.org,
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com,
	blakejones@google.com, ctshao@google.com,
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com,
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com,
	james.clark@linaro.org, jolsa@kernel.org,
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn,
	palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org,
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn,
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com,
	zhouquan@iscas.ac.cn
Subject: Re: [PATCH v10 22/29] perf s390-sample-raw: Don't pass evsel or its
 PMU with sample
Message-ID: <ad0cxk1PJ4EcZi_H@google.com>
References: <20260411191710.524998-1-irogers@google.com>
 <20260412020833.641177-1-irogers@google.com>
 <20260412020833.641177-23-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260412020833.641177-23-irogers@google.com>

On Sat, Apr 11, 2026 at 07:08:25PM -0700, Ian Rogers wrote:
> The sample contains the evsel and its PMU so it is unnecessary to pass
> the evsel as well.

This patch is changed to minimize the diff.

Thanks,
Namhyung

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/s390-sample-raw.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
> index c6ae0ae8d86a..52bbca5c56c8 100644
> --- a/tools/perf/util/s390-sample-raw.c
> +++ b/tools/perf/util/s390-sample-raw.c
> @@ -222,8 +222,9 @@ static char *get_counter_name(int set, int nr, struct perf_pmu *pmu)
>  	return result;
>  }
>  
> -static void s390_cpumcfdg_dump(struct perf_pmu *pmu, struct perf_sample *sample)
> +static void s390_cpumcfdg_dump(struct perf_sample *sample)
>  {
> +	struct perf_pmu *pmu = sample->evsel->pmu;
>  	size_t i, len = sample->raw_size, offset = 0;
>  	unsigned char *buf = sample->raw_data;
>  	const char *color = PERF_COLOR_BLUE;
> @@ -284,8 +285,9 @@ static bool s390_pai_all_test(struct perf_sample *sample)
>  	return true;
>  }
>  
> -static void s390_pai_all_dump(struct evsel *evsel, struct perf_sample *sample)
> +static void s390_pai_all_dump(struct perf_sample *sample)
>  {
> +	struct evsel *evsel = sample->evsel;
>  	size_t len = sample->raw_size, offset = 0;
>  	unsigned char *p = sample->raw_data;
>  	const char *color = PERF_COLOR_BLUE;
> @@ -332,31 +334,32 @@ void evlist__s390_sample_raw(struct evlist *evlist, union perf_event *event,
>  			     struct perf_sample *sample)
>  {
>  	const char *pai_name;
> -	struct evsel *evsel;
>  
>  	if (event->header.type != PERF_RECORD_SAMPLE)
>  		return;
>  
> -	evsel = evlist__event2evsel(evlist, event);
> -	if (!evsel)
> -		return;
> +	if (!sample->evsel) {
> +		sample->evsel = evlist__event2evsel(evlist, event);
> +		if (!sample->evsel)
> +			return;
> +	}
>  
>  	/* Check for raw data in sample */
>  	if (!sample->raw_size || !sample->raw_data)
>  		return;
>  
>  	/* Display raw data on screen */
> -	if (evsel->core.attr.config == PERF_EVENT_CPUM_CF_DIAG) {
> -		if (!evsel->pmu)
> -			evsel->pmu = perf_pmus__find("cpum_cf");
> +	if (sample->evsel->core.attr.config == PERF_EVENT_CPUM_CF_DIAG) {
> +		if (!sample->evsel->pmu)
> +			sample->evsel->pmu = perf_pmus__find("cpum_cf");
>  		if (!s390_cpumcfdg_testctr(sample))
>  			pr_err("Invalid counter set data encountered\n");
>  		else
> -			s390_cpumcfdg_dump(evsel->pmu, sample);
> +			s390_cpumcfdg_dump(sample);
>  		return;
>  	}
>  
> -	switch (evsel->core.attr.config) {
> +	switch (sample->evsel->core.attr.config) {
>  	case PERF_EVENT_PAI_NNPA_ALL:
>  		pai_name = "NNPA_ALL";
>  		break;
> @@ -370,8 +373,8 @@ void evlist__s390_sample_raw(struct evlist *evlist, union perf_event *event,
>  	if (!s390_pai_all_test(sample)) {
>  		pr_err("Invalid %s raw data encountered\n", pai_name);
>  	} else {
> -		if (!evsel->pmu)
> -			evsel->pmu = perf_pmus__find_by_type(evsel->core.attr.type);
> -		s390_pai_all_dump(evsel, sample);
> +		if (!sample->evsel->pmu)
> +			sample->evsel->pmu = perf_pmus__find_by_type(sample->evsel->core.attr.type);
> +		s390_pai_all_dump(sample);
>  	}
>  }
> -- 
> 2.53.0.1213.gd9a14994de-goog
> 
