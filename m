Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8136D1B1
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Jan 2024 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706623019; cv=none; b=X/Ph29e+C0BOfiyILt2p3TCH8u25s4JjXXidtK2PYQc+uwc3RSVnbby4YutSahIzIkn+8SyDr0WzHwvE6482u3YPjdKk5QBuqLAPbnV4tpByP7LpH/XzTLi1zrTKzjDvEh8il+6HmMeIALBnvfbNiKptpfAtFZm2IzOVMa0Q7Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706623019; c=relaxed/simple;
	bh=IgblYM/JvKwkvJhjHiQfRZlMtKCKoimbaVQrirtPfz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lg2XgY0q9QPpKXapqrBnveh9V9r3l1paeSx2pYexOXU+t2+oep/kVqg5TuVMPe43oIDjwIXNTbKVhcLM5/LjhK5QMZRsXn8OLxz1Tz5yce+O+dEM04t7VsJGX8HTuZN+rBjHJQt0CGDNncAVAn2aFeLGjt1APZGDhD8f9RFqGu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4soGmin; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4soGmin"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86706C43390;
	Tue, 30 Jan 2024 13:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706623018;
	bh=IgblYM/JvKwkvJhjHiQfRZlMtKCKoimbaVQrirtPfz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q4soGminCkMF2vlSbwev2AqwzhvzhzYe6eAC+IJ1RozcJLdHiygbLiezXMMEALSJp
	 mbdipEg9TFUJxMqgu/vE3bJmZX+5FJfNNOD+ohHRXLv8RkY6455xdrAMYiKdUId/v2
	 ibiUHVsMhM0WLWbPwu/pMN8GKdaOQ3IAxN9yIiZMgH9Vqh8x7Kk5XE6zoZE5EFB9TM
	 smib6uO87rxgBCzw1QdVijiPzkUDTIBwL7u5y5YjW1mBkaioIS+XBNklykafuYA4uc
	 1dhc0T2BS5mU6sVS84QlYgeazp6+A5vHkxVlp97g6ptLkvo4fFJUFVPHQVLspWu3x6
	 8XxleNLKJ7dsw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 1CDBC40441; Tue, 30 Jan 2024 10:56:56 -0300 (-03)
Date: Tue, 30 Jan 2024 10:56:56 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: peterz@infradead.org, mingo@redhat.com,
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	Sun Haiyong <sunhaiyong@loongson.cn>
Subject: Re: [PATCH] tools/perf: Fix compiler error when using gcc-14.
Message-ID: <ZbkAKA8g4Z_XlMNh@kernel.org>
References: <20240106094129.3337057-1-siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240106094129.3337057-1-siyanteng@loongson.cn>
X-Url: http://acmel.wordpress.com

Em Sat, Jan 06, 2024 at 05:41:29PM +0800, Yanteng Si escreveu:
> From: Sun Haiyong <sunhaiyong@loongson.cn>
> 
> the definition of calloc is as follows:
>     void *calloc(size_t nmemb, size_t size);
> number of members is in the first parameter and the size is in the second
> parameter.
> 
> fixed error message on the gcc 14 20240102:
> error: 'calloc' sizes specified with 'sizeof' in the earlier argument and
> not in the later argument [-Werror=calloc-transposed-args]

Just fyi I merged this into perf-tools.

- Arnaldo
 
> Signed-off-by: Sun Haiyong <sunhaiyong@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  tools/perf/builtin-record.c        | 4 ++--
>  tools/perf/util/hist.c             | 4 ++--
>  tools/perf/util/metricgroup.c      | 2 +-
>  tools/perf/util/synthetic-events.c | 4 ++--
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 91e6828c38cc..86c910125172 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -4080,8 +4080,8 @@ int cmd_record(int argc, const char **argv)
>  	}
>  
>  	if (rec->switch_output.num_files) {
> -		rec->switch_output.filenames = calloc(sizeof(char *),
> -						      rec->switch_output.num_files);
> +		rec->switch_output.filenames = calloc(rec->switch_output.num_files,
> +						      sizeof(char *));
>  		if (!rec->switch_output.filenames) {
>  			err = -EINVAL;
>  			goto out_opts;
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 0888b7163b7c..fa359180ebf8 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -491,8 +491,8 @@ static int hist_entry__init(struct hist_entry *he,
>  	}
>  
>  	if (symbol_conf.res_sample) {
> -		he->res_samples = calloc(sizeof(struct res_sample),
> -					symbol_conf.res_sample);
> +		he->res_samples = calloc(symbol_conf.res_sample,
> +					sizeof(struct res_sample));
>  		if (!he->res_samples)
>  			goto err_srcline;
>  	}
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index ca3e0404f187..966cca5a3e88 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -286,7 +286,7 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
>  	*out_metric_events = NULL;
>  	ids_size = hashmap__size(ids);
>  
> -	metric_events = calloc(sizeof(void *), ids_size + 1);
> +	metric_events = calloc(ids_size + 1, sizeof(void *));
>  	if (!metric_events)
>  		return -ENOMEM;
>  
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 3712186353fb..2a0289c14959 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -1055,11 +1055,11 @@ int perf_event__synthesize_threads(struct perf_tool *tool,
>  	if (thread_nr > n)
>  		thread_nr = n;
>  
> -	synthesize_threads = calloc(sizeof(pthread_t), thread_nr);
> +	synthesize_threads = calloc(thread_nr, sizeof(pthread_t));
>  	if (synthesize_threads == NULL)
>  		goto free_dirent;
>  
> -	args = calloc(sizeof(*args), thread_nr);
> +	args = calloc(thread_nr, sizeof(*args));
>  	if (args == NULL)
>  		goto free_threads;
>  
> -- 
> 2.31.4
> 

-- 

- Arnaldo
