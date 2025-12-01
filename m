Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AD43358DB;
	Mon,  1 Dec 2025 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764611120; cv=none; b=S9ZzUz0kGBOHkiplIkOmarekQ3fJG4WuAcR5lFx3B8VGtqunGlY+/8QZizNysubpFM5NzFRVDCJZMRJe137tmq6oYDbC37avhvu7mLZ7HSYi2KWG6M+eVpt288pTYKdYlGu36pztuKjBvr3pyImiVPhW8z2c1veiaVrW3xV8sVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764611120; c=relaxed/simple;
	bh=UHxVdwHJBFCMEFXIBq7zIcLi/ZDSmsBUJs2UoELLypc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMKiLMHmUD4sxcbKajdcPWv/ls4wq/FIkyPmyShF8cFC9POV/n50PKa4zEZ/ggizsVoze70MgZXzZqAwFtJcRFNOUhsquRZphttJIpzul0RnD3dzHAC7A/i2nLklpSrOceWXay1Fj+Ree6oojidecyfepq/JmeIkWTkE3xajg9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uA/bkuta; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uA/bkuta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10384C4CEF1;
	Mon,  1 Dec 2025 17:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764611119;
	bh=UHxVdwHJBFCMEFXIBq7zIcLi/ZDSmsBUJs2UoELLypc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uA/bkuta/tnAir77wTo76P5y+0Ila6duFnGMa3BkZ4nCWQEK6CftRzZg8UMH0loGX
	 G3udFtc1RdWbQeX9CdXqbskbUi30AeXEODUSs7r0ugVKQHKgpl+UhFV3nnjJtDSSwo
	 Kfm4c5tLiNv1DLJT2GMMLrfn5mmy7j6qOgYfpc+ImGdJ8kk32rahXoTMtw28imE4ik
	 vUjyXtG+AmtqFly23thlIvwTSchmnvN1fE0eEJnjyZI3o8BwPW15e6bvkqjjsTU70F
	 wu8tpQd4rRi8OyL4IbeV1Y1fiEV7SJb7LY8NdxB0Hkl28zJBAdWE+16iDhhHiooOqz
	 G5Qn7huc5hIyA==
Date: Mon, 1 Dec 2025 14:45:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>, Leo Yan <leo.yan@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 09/17] perf c2c: Clean up some defensive gets and make
 asan clean
Message-ID: <aS3UK1QYkf5vD7Mp@x1>
References: <20251122081929.7588-1-irogers@google.com>
 <20251122081929.7588-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122081929.7588-10-irogers@google.com>

On Sat, Nov 22, 2025 at 12:19:21AM -0800, Ian Rogers wrote:
> To deal with histogram code that had missing gets the c2c code had
> some defensive gets. Those other issues were cleaned up by the
> reference count checker, clean them up for the c2c command here.

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-c2c.c | 36 ++++++++++++++----------------------
>  1 file changed, 14 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 14c3823f8fed..d390ae4e3ec8 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -322,7 +322,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>  	struct c2c_stats stats = { .nr_entries = 0, };
>  	struct hist_entry *he;
>  	struct addr_location al;
> -	struct mem_info *mi, *mi_dup;
> +	struct mem_info *mi = NULL;
>  	struct callchain_cursor *cursor;
>  	int ret;
>  
> @@ -349,20 +349,15 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>  		goto out;
>  	}
>  
> -	/*
> -	 * The mi object is released in hists__add_entry_ops,
> -	 * if it gets sorted out into existing data, so we need
> -	 * to take the copy now.
> -	 */
> -	mi_dup = mem_info__get(mi);
> -
>  	c2c_decode_stats(&stats, mi);
>  
>  	he = hists__add_entry_ops(&c2c_hists->hists, &c2c_entry_ops,
>  				  &al, NULL, NULL, mi, NULL,
>  				  sample, true);
> -	if (he == NULL)
> -		goto free_mi;
> +	if (he == NULL) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
>  
>  	c2c_he = container_of(he, struct c2c_hist_entry, he);
>  	c2c_add_stats(&c2c_he->stats, &stats);
> @@ -393,17 +388,19 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>  		int cpu = sample->cpu == (unsigned int) -1 ? 0 : sample->cpu;
>  		int node = c2c.cpu2node[cpu];
>  
> -		mi = mi_dup;
> -
>  		c2c_hists = he__get_c2c_hists(he, c2c.cl_sort, 2, machine->env);
> -		if (!c2c_hists)
> -			goto free_mi;
> +		if (!c2c_hists) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
>  
>  		he = hists__add_entry_ops(&c2c_hists->hists, &c2c_entry_ops,
>  					  &al, NULL, NULL, mi, NULL,
>  					  sample, true);
> -		if (he == NULL)
> -			goto free_mi;
> +		if (he == NULL) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
>  
>  		c2c_he = container_of(he, struct c2c_hist_entry, he);
>  		c2c_add_stats(&c2c_he->stats, &stats);
> @@ -421,14 +418,9 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>  	}
>  
>  out:
> +	mem_info__put(mi);
>  	addr_location__exit(&al);
>  	return ret;
> -
> -free_mi:
> -	mem_info__put(mi_dup);
> -	mem_info__put(mi);
> -	ret = -ENOMEM;
> -	goto out;
>  }
>  
>  static const char * const c2c_usage[] = {
> -- 
> 2.52.0.rc2.455.g230fcf2819-goog
