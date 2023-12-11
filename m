Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0260653E34
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Dec 2023 21:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0gyCbUm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566BDC433C8;
	Mon, 11 Dec 2023 21:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702329193;
	bh=cKsZJJjh0zgXBpBkaqIeqMSNNR6XLiEhaKhcou5UHqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V0gyCbUmW0AGexABCR8rMe7FoBLbN90HmT64c5DOHxC9vI/6rIE56Tm1jDi+m8xIX
	 iGWuf3dayc3CQjuTtJJwpqyiHM5CPzVdnXc+ESEqecf6dD5jjYWxkLlr+CAhOZ+Rhk
	 RK8vyqnmURqT53wDP0Csa4GxOGHBvPDd936X+jGUlEWvAvozfPRVeXej3mHu0Rh/Gu
	 SSLIQGtRChXQ4utFlw2Vw39EUbyu6ib+HCq9+HuKQGR964nvJ1cqGDM6E98CvammSd
	 1CIh76Q/z1MTB7JduV41NVHj1r0m0NhuD6x5ZGL3dEgx64YFzi7TDjIIrH9UX7nUbJ
	 G8jjgDi/cG1tg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id CF8F4403EF; Mon, 11 Dec 2023 18:13:10 -0300 (-03)
Date: Mon, 11 Dec 2023 18:13:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: kan.liang@linux.intel.com
Cc: irogers@google.com, namhyung@kernel.org, mark.rutland@arm.com,
	maz@kernel.org, marcan@marcan.st, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf top: Use evsel's cpus to replace user_requested_cpus
Message-ID: <ZXd7ZuxbNNsjAyqm@kernel.org>
References: <20231208210855.407580-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208210855.407580-1-kan.liang@linux.intel.com>
X-Url: http://acmel.wordpress.com

Em Fri, Dec 08, 2023 at 01:08:55PM -0800, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> perf top errors out on a hybrid machine
>  $perf top
> 
>  Error:
>  The cycles:P event is not supported.
> 
> The user_requested_cpus may contain CPUs that are invalid for a hybrid
> PMU. It causes perf_event_open to fail.

?

All perf top expects is that the "cycles", the most basic one, be
collected, on all CPUs in the system.

> The commit ef91871c960e ("perf evlist: Propagate user CPU maps
> intersecting core PMU maps") already intersect the requested CPU map
> with the CPU map of the PMU. Use the evsel's cpus to replace
> user_requested_cpus.
 
> The evlist's threads is also propagated to evsel's threads in
> __perf_evlist__propagate_maps(). Replace it as well.

Thanks, but please try to add more detail to the fix so as to help
others to consider looking at the patch.

- Arnaldo
 
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Closes: https://lore.kernel.org/linux-perf-users/ZXNnDrGKXbEELMXV@kernel.org/
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/builtin-top.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index ea8c7eca5eee..cce9350177e2 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1027,8 +1027,8 @@ static int perf_top__start_counters(struct perf_top *top)
>  
>  	evlist__for_each_entry(evlist, counter) {
>  try_again:
> -		if (evsel__open(counter, top->evlist->core.user_requested_cpus,
> -				     top->evlist->core.threads) < 0) {
> +		if (evsel__open(counter, counter->core.cpus,
> +				counter->core.threads) < 0) {
>  
>  			/*
>  			 * Specially handle overwrite fall back.
> -- 
> 2.35.1
> 

-- 

- Arnaldo
