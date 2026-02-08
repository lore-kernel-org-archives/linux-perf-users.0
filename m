Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8560254841;
	Sun,  8 Feb 2026 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770560947; cv=none; b=na/W3b1i+JEu6CUHmQF8JjFAAnXlgqtea25ptZvFsvKuxridxyUQ/3RwNPtJ+5qEEjhd/icqh9e/ioa99EWV1Fuq4rcLZf4Oz0lJrF0+u8fiMVrjyfJRSuEKGq9I5lbeBpk4pOM/FBZfGmykQ/xlZhG+4yYFTrpxIA8fJqtR11A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770560947; c=relaxed/simple;
	bh=nLQTa5cUOY0aUA99qqcz9iu5I66SRS+pxS8Bpoyf94w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d60lvVUBA9AY3n7I4PRLPS7/cWq1enOr8eNhCqxNmAHlESOcFo7SnGEpWrSQtKDx/QwoAAKEkKUQ53vXCCh6fl8IhNLE/Cdb6syHFQViuGK0qn9x/3YEiIC/K/FDpGB+kBU6jSgfTneROU5s0rZThCiuN0G8V+q8RNMvXU15fSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Plw4QF9g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Plw4QF9g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026BEC4CEF7;
	Sun,  8 Feb 2026 14:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770560947;
	bh=nLQTa5cUOY0aUA99qqcz9iu5I66SRS+pxS8Bpoyf94w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Plw4QF9gg//sQGKcwuGyIvxv3mby7AOvtzjjOw5Aoa5q/CNgppxYMXwFJfeDdrQO8
	 Q7I8D4rcw7d0usUt/daf18e8pqBXCJ7AHpI8YZX8PVVwLt/Kji/AAxjPZ8AxotBSYB
	 6pInP0VEX2uEVHKMuX9xkRLYoYW7wVfyfLK+D8Zo7eHnFCxnwCsRgH6btOKIo5UKeT
	 uFVHcFB+xSAjRGUz3pqdbTltjlVFnS+DbQ0UhwBu7Zw0gJYLFz3NPvVAanOcXdmAE4
	 dk0IVmokRSYMBtYyuJmVFo5u6DdXzc8T8KYdBTXMlKlt9eCS+4Vb7udZXYx5dBVtyq
	 bzHj+0naiwLJw==
Date: Sun, 8 Feb 2026 11:29:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: ctshao@google.com, namhyung@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, james.clark@linaro.org,
	jolsa@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org, yang.lee@linux.alibaba.com
Subject: Re: [PATCH v1] perf test parse-metric: Ensure aggregate counts
 appear to have run
Message-ID: <aYidsNiGztDlfJeh@x1>
References: <CAP-5=fXH1tP_x22_YXi3F3POjjTxc8216o6=F+19XSYEWGwgOA@mail.gmail.com>
 <20260208055455.2437197-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260208055455.2437197-1-irogers@google.com>

On Sat, Feb 07, 2026 at 09:54:55PM -0800, Ian Rogers wrote:
> Commit bb5a920b9099 ("perf stat: Ensure metrics are displayed even
> with failed events") made it so that counters which weren't enabled in
> the kernel were handled as NaN in metrics. This cased the "Parse and
> process metrics" test to start failing as it wasn't putting a non-zero
> value in these variables. Add arbitrary values of 1 to fix the test.
> 
> Fixes: bb5a920b9099 ("perf stat: Ensure metrics are displayed even with failed events")

Thanks, applied to perf-tools-next,

- Arnaldo
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/parse-metric.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> index 6bbc209a5c6a..7c7f489a5eb0 100644
> --- a/tools/perf/tests/parse-metric.c
> +++ b/tools/perf/tests/parse-metric.c
> @@ -41,6 +41,8 @@ static void load_runtime_stat(struct evlist *evlist, struct value *vals)
>  		count = find_value(evsel->name, vals);
>  		evsel->supported = true;
>  		evsel->stats->aggr->counts.val = count;
> +		evsel->stats->aggr->counts.ena = 1;
> +		evsel->stats->aggr->counts.run = 1;
>  	}
>  }
>  
> -- 
> 2.53.0.239.g8d8fc8a987-goog
