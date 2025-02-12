Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664E51CBEAA;
	Wed, 12 Feb 2025 14:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739371897; cv=none; b=lt8xYCDjsf82x68LwO5xm6TbyJAIAbV3yUmU/RbxAwnAV6f4j16tlSGjjyZFy9DyHjRKUMrJqRo2YANAIQ32yYjyZyPKX70849S95v9EgVMlixmElsGCGBp8IOs/vHEapmYuGRf88bdRmZUleGZk6eAJmq9QlnpD1B+M+KF457s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739371897; c=relaxed/simple;
	bh=DT2qpYod79A56zkvTm8XrJXSJkU7xXsoFoZuVDVtqaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUGe3uNUESXGdooAmoNE/i+cHT3iqqG/6wC4aKSE8qsSr9fUpqT1pCqW7GOMxJ3fGiMfW8wJxxNdACI9yuNKdE10mjItjeKaE4Mpq4eLqes1rpjAG6GpzNWIXhhBapGokPis28LjyqMw1o4upy1tENKCTRkyAd84VdM6lS8nJa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uty14UuS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uty14UuS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2D9C4CEDF;
	Wed, 12 Feb 2025 14:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739371896;
	bh=DT2qpYod79A56zkvTm8XrJXSJkU7xXsoFoZuVDVtqaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uty14UuS0zwxjVzwWFRh+KOcjOV/jzkoOriK2AjGx39nKzNvZHtW0ygiOK7wv8+Rp
	 Z3a9+l6NzB102nTvbADrhpCJ5EgVQeHY0TpMOm9E5QRC0ciK19zy6QU+v3ItzC1FCL
	 u4bTLDWwWt8qxx1XzXvUaDDEpUacgJkt50GW14hoOhZRcV0j400E+GlWGtbxxaN6GD
	 JeqAbheX8EW9+nFZFuJ6H8EBfXKlGU0JXFbOomYmmB/0ML9L5iXae+1KkPUmvsCi+P
	 Ms7twnKr1XMD+dv5nxXHYk9eQrA3hegi8jMIBiyW08FpSrBGeU7nYsMpyIvdYa49O/
	 uT7LJ9RtyE2ug==
Date: Wed, 12 Feb 2025 15:51:33 +0100
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, Hao Ge <gehao@kylinos.cn>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Levi Yun <yeoreum.yun@arm.com>, Xu Yang <xu.yang_2@nxp.com>,
	Tengda Wu <wutengda@huaweicloud.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 02/10] perf parse-events filter: Use evsel__find_pmu
Message-ID: <Z6y1dbyF1xY1FvsB@x1>
References: <20250111190143.1029906-1-irogers@google.com>
 <20250111190143.1029906-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111190143.1029906-3-irogers@google.com>

On Sat, Jan 11, 2025 at 11:01:35AM -0800, Ian Rogers wrote:
> Rather than manually scanning PMUs, use evsel__find_pmu that can use
> the PMU set during event parsing.

Right, and then evsel__find_pmu() also does some extra checks to call
pmu_read_sysfs() more selectively, right?

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 1e23faa364b1..f147e13a7017 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -2406,9 +2406,8 @@ foreach_evsel_in_last_glob(struct evlist *evlist,
>  static int set_filter(struct evsel *evsel, const void *arg)
>  {
>  	const char *str = arg;
> -	bool found = false;
>  	int nr_addr_filters = 0;
> -	struct perf_pmu *pmu = NULL;
> +	struct perf_pmu *pmu;
>  
>  	if (evsel == NULL) {
>  		fprintf(stderr,
> @@ -2426,16 +2425,11 @@ static int set_filter(struct evsel *evsel, const void *arg)
>  		return 0;
>  	}
>  
> -	while ((pmu = perf_pmus__scan(pmu)) != NULL)
> -		if (pmu->type == evsel->core.attr.type) {
> -			found = true;
> -			break;
> -		}
> -
> -	if (found)
> +	pmu = evsel__find_pmu(evsel);
> +	if (pmu) {
>  		perf_pmu__scan_file(pmu, "nr_addr_filters",
>  				    "%d", &nr_addr_filters);
> -
> +	}
>  	if (!nr_addr_filters)
>  		return perf_bpf_filter__parse(&evsel->bpf_filters, str);
>  
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
