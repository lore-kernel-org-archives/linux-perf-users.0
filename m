Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4BE1B87F0;
	Mon, 10 Mar 2025 20:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741638708; cv=none; b=n8nxyCOnRqxYAK3LtTIdAjJSfp4U99CgwFdbs3+MJ54+TG52FWcr2bNTij24X/XOfXd9p3Hocq2yHpY9OrFGclgxusLlXmqEWPcVQ1Gk1meo6VsH9Uol3UA0StbRIxA3yoda4qkpJIPaW3JrKx3r9HYFUtZVILHPLY86HTzndQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741638708; c=relaxed/simple;
	bh=wqwG90EKh+JKAewBGlOY847BC5tTSk1WR1QSUCMgTLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaltsOMoZeGsTi6NK47EhkXXWNpopQyZWnS4QxIW6nKQEHrKstlf0p/isrFWFCdF5DWVHsMDOwF2tT8SFEZ93O10GDWLz+Mhhe0Mt6HjM0UZaAbCp3JibxKCKP9Vx+WAJfi+Qgh6wd99/itLDp3lKL8bv6iKbKsbfAxEb2fR/ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIfiwtrA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIfiwtrA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226F6C4CEE5;
	Mon, 10 Mar 2025 20:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741638707;
	bh=wqwG90EKh+JKAewBGlOY847BC5tTSk1WR1QSUCMgTLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jIfiwtrANyeJ1aGfVsu8tw3mw+yLe4+oCX9AQZWFi0DiBq0etpJQcEKN31WmMGMnr
	 br7WUKzs0M9HICWd0IXxIKxsi1S1wSQvuXznwwhKjR5V9R9j4cHyW+8gfpv6yY2fCU
	 sHV3cj7osTZthJUbEQd2guV8OqV8wGahwoT+u5T5ELqzDote4ShqzcgoHFIHivkFW9
	 irfYuZSjOWqWRYikGC7zPWRP63quWIGjyCDdvTk21qkglGHktgsa1jMTGDQ3hKwulJ
	 gIxd+EW0P6ZyshmtqwASQ6OB/NpcpoS/kc51t+YKSnl5tCq7jiWaTEchHW/VhYYjyB
	 Xqq5QhQxD5n8g==
Date: Mon, 10 Mar 2025 17:31:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	James Clark <james.clark@linaro.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: Re: [PATCH v2 02/11] perf evlist: Add success path to
 evlist__create_syswide_maps
Message-ID: <Z89MMMncPTvG8bdf@x1>
References: <20250228222308.626803-1-irogers@google.com>
 <20250228222308.626803-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228222308.626803-3-irogers@google.com>

On Fri, Feb 28, 2025 at 02:22:59PM -0800, Ian Rogers wrote:
> Over various refactorings evlist__create_syswide_maps has been made to
> only ever return with -ENOMEM. Fix this so that when
> perf_evlist__set_maps is successfully called, 0 is returned.

I think this was when the problem was introduced:

Fixes: 8c0498b6891d7ca5 ("perf evlist: Fix create_syswide_maps() not propagating maps")

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Reviewed-by: Howard Chu <howardchu95@gmail.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/evlist.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index f0dd174e2deb..633df7d9204c 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1373,19 +1373,18 @@ static int evlist__create_syswide_maps(struct evlist *evlist)
>  	 */
>  	cpus = perf_cpu_map__new_online_cpus();
>  	if (!cpus)
> -		goto out;
> +		return -ENOMEM;
>  
>  	threads = perf_thread_map__new_dummy();
> -	if (!threads)
> -		goto out_put;
> +	if (!threads) {
> +		perf_cpu_map__put(cpus);
> +		return -ENOMEM;
> +	}
>  
>  	perf_evlist__set_maps(&evlist->core, cpus, threads);
> -
>  	perf_thread_map__put(threads);
> -out_put:
>  	perf_cpu_map__put(cpus);
> -out:
> -	return -ENOMEM;
> +	return 0;
>  }
>  
>  int evlist__open(struct evlist *evlist)
> -- 
> 2.48.1.711.g2feabab25a-goog
