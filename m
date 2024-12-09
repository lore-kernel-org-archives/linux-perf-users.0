Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9F9288CC;
	Mon,  9 Dec 2024 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733755363; cv=none; b=Lnvv9bBP65tfiSSjiv2enuQM24ueLTWJihqAzTgRSVWc++59KXL8prbqk+J2FKWsAB8HNTw/8wzHAaXLOZlHezQ1w3tlWc2x16NHwPcZ0WlBTxHiiPQokbmndOI8KhgwUJjOAT7RW+eVWb6RBUYV6igyDO7AqKxuZ0fDcnZgD1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733755363; c=relaxed/simple;
	bh=6wtPqihXnbYLT5a15KUi3rytbMlJCKWOXYF76I2wQQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRYYnfl6lBRzw/z0jVysW0aONnW2ngefgnEgoHuhVLdeRUPMwFW0Cbvp98+ohYpA48LWmsMIuS1MmY7wd4VbicJyD6LEGFlY2aZV0IakChvSKHQrE38rHO5PQ7IifT62Cz/oB0Ixlt+ZzeQoImCcq+Xzy7S42qYKfPXiqpkcrV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXl9Pfo6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXl9Pfo6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D74C4CED1;
	Mon,  9 Dec 2024 14:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733755363;
	bh=6wtPqihXnbYLT5a15KUi3rytbMlJCKWOXYF76I2wQQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hXl9Pfo6hVi7oGyZv4FERCWgaRNJNhHO5/nNRPnXhPYcRcVc4doFBaLuYnjrYREz9
	 LqYHGgxdaKSOhxg8iWYaJQGUNcBQMzHQ5d//lxkf6HF3bA9613H2pZBCz/YIrbH7l/
	 AdyZDXvkc4kmA4+FcGFmCPBk2bT9a3LWx7USw2nCAGRxsMx/y2kcYhkmJBRda6OP2l
	 K3J8R17iUP5csqCIq/l1I/JA6Q1dpx9dPFwPf9y9WUo6Or1yuVKs1bPePWpldPQyI/
	 3TR3th9agBzNoGHhsdeI6uVjqH0FpHVBvpnUOw8lYgrytGazxjMt57resw58qUourR
	 Pq5VdtKyDEdpQ==
Date: Mon, 9 Dec 2024 11:42:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Chunxin Zang <spring.cxz@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	yangchen11@lixiang.com, zhouchunhua@lixiang.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	zangchunxin@lixiang.com
Subject: Re: [PATCH] perf evlist: Fix the warning logic about
 warn_user_request_cpu
Message-ID: <Z1cB28q8r54L59zU@x1>
References: <20240318121150.1552888-1-spring.cxz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318121150.1552888-1-spring.cxz@gmail.com>

On Mon, Mar 18, 2024 at 08:11:50PM +0800, Chunxin Zang wrote:
> The old logic in evlist__warn_user_requested_cpus incorrectly output
> the warning message when I run 'perf record -C xxx' command on my
> context(the cpu has 8 performance-cores and 8 efficient-cores.).
> 
> The old warning like this:
>   # perf record -C 17
>   WARNING: A requested CPU in '17' is not supported by PMU 'cpu_core' (CPUs 0-15) for event 'cycles:P'
>   # perf record -C 14
>   WARNING: A requested CPU in '14' is not supported by PMU 'cpu_atom' (CPUs 16-23) for event 'cycles:P'
>   # perf record -C 14-17
>   WARNING: A requested CPU in '15-16' is not supported by PMU 'cpu_atom' (CPUs 16-23) for event 'cycles:P'
>   WARNING: A requested CPU in '15-16' is not supported by PMU 'cpu_core' (CPUs 0-15) for event 'cycles:P'
> 
> After patching, the warning is as follows
>   # perf record -C 17
>   WARNING: A requested CPU '17' in '17' is not supported by PMU 'cpu_atom' (CPUs 16-23) for event 'cycles:P'

Looks wrong, i.e. I ask for CPU 17 and it says it is not in the range
16-23?

Ditto for the rest, no?

- Arnaldo

>   # perf record -C 14
>   WARNING: A requested CPU '14' in '14' is not supported by PMU 'cpu_core' (CPUs 0-15) for event 'cycles:P'
>   # perf record -C 15-18
>   WARNING: A requested CPU '16-18' in '15-18' is not supported by PMU 'cpu_atom' (CPUs 16-23) for event 'cycles:P'
>   WARNING: A requested CPU '15' in '15-18' is not supported by PMU 'cpu_core' (CPUs 0-15) for event 'cycles:P'
> 
> Signed-off-by: Chunxin Zang <spring.cxz@gmail.com>
> Reviewed-by: Chen Yang <yangchen11@lixiang.com>
> ---
>  tools/perf/util/evlist.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 55a300a0977b..82fee2e29966 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -2514,12 +2514,16 @@ void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_lis
>  
>  		to_test = pmu && pmu->is_core ? pmu->cpus : cpu_map__online();
>  		intersect = perf_cpu_map__intersect(to_test, user_requested_cpus);
> -		if (!perf_cpu_map__equal(intersect, user_requested_cpus)) {
> -			char buf[128];
>  
> -			cpu_map__snprint(to_test, buf, sizeof(buf));
> -			pr_warning("WARNING: A requested CPU in '%s' is not supported by PMU '%s' (CPUs %s) for event '%s'\n",
> -				cpu_list, pmu ? pmu->name : "cpu", buf, evsel__name(pos));
> +		if (intersect && perf_cpu_map__is_subset(user_requested_cpus, intersect)) {
> +			char buf_test[128];
> +			char buf_intersect[128];
> +
> +			cpu_map__snprint(to_test, buf_test, sizeof(buf_test));
> +			cpu_map__snprint(intersect, buf_intersect, sizeof(buf_intersect));
> +			pr_warning("WARNING: A requested CPU '%s' in '%s' is not supported by "
> +				   "PMU '%s' (CPUs %s) for event '%s'\n", buf_intersect, cpu_list,
> +				   pmu ? pmu->name : "cpu", buf_test, evsel__name(pos));
>  		}
>  		perf_cpu_map__put(intersect);
>  	}
> -- 
> 2.34.1
