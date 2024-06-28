Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC0915572B;
	Fri, 28 Jun 2024 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578653; cv=none; b=LFDZ5YDlEZ/YnhT3gx3zX91dy/hix7nGN/90515u9OyLPh5EDqjma7WmrxG5YLiToOF2b8wzUWUEFXhmjRBwzFoGCKBZCg4cAscJMPPaLxGh0cUSwfC4aAxGER7hSrBgvepBWbcHfJtxjVgXjiIqWCoMf+2Q6IiniDt2hos/dSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578653; c=relaxed/simple;
	bh=oHrvVYVwVtxTuBATd0X+cvAxrdzOWVBjCxaLB7d8rfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+u3Lk7gFXrqEkUdAcRb6xXEyKqPy4713MQlkJRy0r7sKqT4ssojaym94lL3d0IOWKU/D9jm0SGt04dsKNiL05lUEcR9NqFuzFgntWafao7FwDpuyXlXomFyb0B9Ls4CkJ5vKMy/TeWTr/o0tfgLlK84d9E0ikrU9/sAPksBpqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaCQUUzX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaCQUUzX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8EDC2BBFC;
	Fri, 28 Jun 2024 12:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719578652;
	bh=oHrvVYVwVtxTuBATd0X+cvAxrdzOWVBjCxaLB7d8rfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YaCQUUzXPASMLGpZ+PkNam/1jhx2WH9y2nV9x4FC+eka3SLUXNXoWA4lmB8qf29d1
	 6fhil6xzpmJVlCW20zF5hzEvAoS5bMfb3wk6INJ7gAoW/Y3DLxFTmKtoSGSMSYg0RY
	 MN6uqqby2qFTRqcWIoQTgcLjqu+5DJgevHErUqJXylkVB33tDZxzRKEg59eQjxJqrs
	 O/QbKLPPEM8kphy95TMfH6XNO4zTCU7hhm9bdEYymWaRfPN+OrGWrKzLBAmi47JmDk
	 MTuts4GlWow8W2qOvRekTmzLRQCzd8FffSthdunD9lxnHpi2OE3o1Qm6TrL5vZpcpy
	 i8r/cmo8Y4cJQ==
Date: Fri, 28 Jun 2024 09:44:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf stat: Use field separator in the metric header
Message-ID: <Zn6wGMShHo9iNHGu@x1>
References: <20240627200353.1230407-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627200353.1230407-1-namhyung@kernel.org>

On Thu, Jun 27, 2024 at 01:03:52PM -0700, Namhyung Kim wrote:
> It didn't use the passed field separator (using -x option) when it
> prints the metric headers and always put "," between the fields.
> 
> Before:
>   $ sudo ./perf stat -a -x : --per-core -M tma_core_bound --metric-only true
>   core,cpus,%  tma_core_bound:     <<<--- here: "core,cpus," but ":" expected
>   S0-D0-C0:2:10.5:
>   S0-D0-C1:2:14.8:
>   S0-D0-C2:2:9.9:
>   S0-D0-C3:2:13.2:
> 
> After:
>   $ sudo ./perf stat -a -x : --per-core -M tma_core_bound --metric-only true
>   core:cpus:%  tma_core_bound:
>   S0-D0-C0:2:10.5:
>   S0-D0-C1:2:15.0:
>   S0-D0-C2:2:16.5:
>   S0-D0-C3:2:12.5:
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo

> ---
>  tools/perf/util/stat-display.c | 37 ++++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 91d2f7f65df7..e8673c9f6b49 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -47,16 +47,27 @@ static int aggr_header_lens[] = {
>  };
>  
>  static const char *aggr_header_csv[] = {
> -	[AGGR_CORE] 	= 	"core,cpus,",
> -	[AGGR_CACHE]	= 	"cache,cpus,",
> -	[AGGR_DIE] 	= 	"die,cpus,",
> -	[AGGR_SOCKET] 	= 	"socket,cpus,",
> -	[AGGR_NONE] 	= 	"cpu,",
> -	[AGGR_THREAD] 	= 	"comm-pid,",
> -	[AGGR_NODE] 	= 	"node,",
> +	[AGGR_CORE] 	= 	"core%scpus%s",
> +	[AGGR_CACHE]	= 	"cache%scpus%s",
> +	[AGGR_DIE] 	= 	"die%scpus%s",
> +	[AGGR_SOCKET] 	= 	"socket%scpus%s",
> +	[AGGR_NONE] 	= 	"cpu%s",
> +	[AGGR_THREAD] 	= 	"comm-pid%s",
> +	[AGGR_NODE] 	= 	"node%s",
>  	[AGGR_GLOBAL] 	=	""
>  };
>  
> +static int aggr_header_num[] = {
> +	[AGGR_CORE] 	= 	2,
> +	[AGGR_CACHE]	= 	2,
> +	[AGGR_DIE] 	= 	2,
> +	[AGGR_SOCKET] 	= 	2,
> +	[AGGR_NONE] 	= 	1,
> +	[AGGR_THREAD] 	= 	1,
> +	[AGGR_NODE] 	= 	1,
> +	[AGGR_GLOBAL] 	=	0,
> +};
> +
>  static const char *aggr_header_std[] = {
>  	[AGGR_CORE] 	= 	"core",
>  	[AGGR_CACHE] 	= 	"cache",
> @@ -1185,8 +1196,18 @@ static void print_metric_headers_csv(struct perf_stat_config *config,
>  {
>  	if (config->interval)
>  		fputs("time,", config->output);
> -	if (!config->iostat_run)
> +	if (config->iostat_run)
> +		return;
> +
> +	if (aggr_header_num[config->aggr_mode] == 1) {
> +		fprintf(config->output, aggr_header_csv[config->aggr_mode],
> +			config->csv_sep);
> +	} else if (aggr_header_num[config->aggr_mode] == 2) {
> +		fprintf(config->output, aggr_header_csv[config->aggr_mode],
> +			config->csv_sep, config->csv_sep);
> +	} else {
>  		fputs(aggr_header_csv[config->aggr_mode], config->output);
> +	}
>  }
>  
>  static void print_metric_headers_json(struct perf_stat_config *config __maybe_unused,
> -- 
> 2.45.2.803.g4e1b14247a-goog
