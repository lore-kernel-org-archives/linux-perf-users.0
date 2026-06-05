Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E6737DE84;
	Fri,  5 Jun 2026 23:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780701790; cv=none; b=SK+rOk3eQytB5iKKKi1nkTp79cavPp5SBewZxMXOFuTBJCGbVS07LnMDRH5ALteAnhRFm0q7AstJk+0A8He0OludyK6ZzytrY9CXD3jUmupTpA5zLhdK2izMH3/kE6loYdAkCXyMe4f+la+9n3udpA37SJ/9lpU1W2oiekKuk5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780701790; c=relaxed/simple;
	bh=di0+x/syK8hUcfKSgqKgQJQbcvHEnyApR3k7IDNVcx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yg8qx2I8+5oKz1tDuieKWaQyQlQHHQEd/6n6RmvcfrUJkHgMeGawCjoes/yRiYm1nNK8JFW0FVH38YygtYlZpf0Od68DZprOn3qdlSfA4gcO4Ymp/O6EdFBn1pUlonBBqwKQ1Gr6gTlLhaB+VWhouy/2LnCCafSybbkDDLNy128=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnSm5ti8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnSm5ti8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012111F00893;
	Fri,  5 Jun 2026 23:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780701788;
	bh=D0hoDG61g8Id1AOThLcjxR1M9qVFsJv/qstmeQqXyW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cnSm5ti8a9fWClOjjQv2l6o6x1DAf4y5fbF2DH1EK2SaiRTZvb4LZqliWAcCUzf79
	 0vWUB/rFtoV2QjrrWUXHu52aOMui610bgyFP1VW0TGOx5Tdr592PuVt9zmVn6w6gW1
	 HqHJZoa97YBpde42Q3gJipBc5H4eoAbnM77acoA5/L/inI91qE6R7e9PCtJYrFQzv+
	 vXqZhi67FZWcNPrFaq/6eZdVLsPPUWdo4liZjSRN/l047wslT2albQahodIVsl7FD1
	 2BR4AaXaAZLYI4EtjQRbJAdmmM2s1wXEe2BMJ6rxN+Z3mIpUst6vgBPXthO2b/LpMA
	 Ikm9RYVn1Cbew==
Date: Fri, 5 Jun 2026 20:23:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/4] perf timechart: Fix memory leaks during record
Message-ID: <aiNaWPG8sTp_WLh-@x1>
References: <20260605231155.2415760-1-namhyung@kernel.org>
 <20260605231155.2415760-3-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605231155.2415760-3-namhyung@kernel.org>

On Fri, Jun 05, 2026 at 04:11:53PM -0700, Namhyung Kim wrote:
> The command line options can be passed without copy as their lifetime is
> limited within the same function.

From a quick look:

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-timechart.c | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
> index 7c4ace51302e260c..d56adb41dcf9bb69 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c
> @@ -1582,6 +1582,8 @@ static void timechart__release(struct timechart *tchart)
>  			free(c);
>  			c = next_comm;
>  		}
> +
> +		free(p);
>  		p = next_pid;
>  	}
>  
> @@ -1820,6 +1822,7 @@ static int timechart__io_record(int argc, const char **argv, const char *output_
>  		"syscalls:sys_exit_select",
>  	};
>  	unsigned int poll_events_nr = ARRAY_SIZE(poll_events);
> +	int ret;
>  
>  	rec_argc = common_args_nr +
>  		disk_events_nr * 4 +
> @@ -1838,7 +1841,7 @@ static int timechart__io_record(int argc, const char **argv, const char *output_
>  
>  	p = rec_argv;
>  	for (i = 0; i < common_args_nr; i++)
> -		*p++ = strdup(common_args[i]);
> +		*p++ = common_args[i];
>  
>  	for (i = 0; i < disk_events_nr; i++) {
>  		if (!is_valid_tracepoint(disk_events[i])) {
> @@ -1847,7 +1850,7 @@ static int timechart__io_record(int argc, const char **argv, const char *output_
>  		}
>  
>  		*p++ = "-e";
> -		*p++ = strdup(disk_events[i]);
> +		*p++ = disk_events[i];
>  		*p++ = "--filter";
>  		*p++ = filter;
>  	}
> @@ -1858,7 +1861,7 @@ static int timechart__io_record(int argc, const char **argv, const char *output_
>  		}
>  
>  		*p++ = "-e";
> -		*p++ = strdup(net_events[i]);
> +		*p++ = net_events[i];
>  		*p++ = "--filter";
>  		*p++ = filter;
>  	}
> @@ -1869,7 +1872,7 @@ static int timechart__io_record(int argc, const char **argv, const char *output_
>  		}
>  
>  		*p++ = "-e";
> -		*p++ = strdup(poll_events[i]);
> +		*p++ = poll_events[i];
>  		*p++ = "--filter";
>  		*p++ = filter;
>  	}
> @@ -1877,7 +1880,11 @@ static int timechart__io_record(int argc, const char **argv, const char *output_
>  	for (i = 0; i < (unsigned int)argc; i++)
>  		*p++ = argv[i];
>  
> -	return cmd_record(rec_argc, rec_argv);
> +	ret = cmd_record(rec_argc, rec_argv);
> +
> +	free(rec_argv);
> +	free(filter);
> +	return ret;
>  }
>  
>  
> @@ -1888,6 +1895,7 @@ static int timechart__record(struct timechart *tchart, int argc, const char **ar
>  	const char **rec_argv;
>  	const char **p;
>  	unsigned int record_elems;
> +	int ret;
>  
>  	const char * const common_args[] = {
>  		"record", "-a", "-R", "-c", "1", "-o", output_data,
> @@ -1952,24 +1960,27 @@ static int timechart__record(struct timechart *tchart, int argc, const char **ar
>  
>  	p = rec_argv;
>  	for (i = 0; i < common_args_nr; i++)
> -		*p++ = strdup(common_args[i]);
> +		*p++ = common_args[i];
>  
>  	for (i = 0; i < backtrace_args_no; i++)
> -		*p++ = strdup(backtrace_args[i]);
> +		*p++ = backtrace_args[i];
>  
>  	for (i = 0; i < tasks_args_nr; i++)
> -		*p++ = strdup(tasks_args[i]);
> +		*p++ = tasks_args[i];
>  
>  	for (i = 0; i < power_args_nr; i++)
> -		*p++ = strdup(power_args[i]);
> +		*p++ = power_args[i];
>  
>  	for (i = 0; i < old_power_args_nr; i++)
> -		*p++ = strdup(old_power_args[i]);
> +		*p++ = old_power_args[i];
>  
>  	for (j = 0; j < (unsigned int)argc; j++)
>  		*p++ = argv[j];
>  
> -	return cmd_record(rec_argc, rec_argv);
> +	ret = cmd_record(rec_argc, rec_argv);
> +
> +	free(rec_argv);
> +	return ret;
>  }
>  
>  static int
> -- 
> 2.54.0.1032.g2f8565e1d1-goog
