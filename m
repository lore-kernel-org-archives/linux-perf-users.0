Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A955B18EBF
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 03:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721272330; cv=none; b=QTjqjBCphNLPJbVJFcSJ31eEcUI112VgnYiLHFaK77FuKb84kUs8pSheMogyadKX3oF9BLmm+4Z6KxSX1oNwLbxFIkpQT5P3kvHduSpXxkAe6si5cKwPEYgX2dzTow+GjGeU0yr4Ye+1MaUdvwjJqoMu/B2wmHMkD4tcXvSOjg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721272330; c=relaxed/simple;
	bh=w5/85RdFl+8Vx0ZQWvP37cBxciSRDyJRRx6d6zPWtVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gfy9F5VHOOaoG87XspEcpNNBA6Wpyt3dphfuRfwUDIUCdHnoiFyR3KcYp98WY6GzPOuA35RRaBARK0yUVJR6EbujDnBCgwcWQ3MVlhRoti5I78hj5whbuN09HX80Saedq8h5HblFt1uvsWmiWKUwWQMdej84ijDVlWmWRG+uYrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pw9UDoQa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pw9UDoQa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BC2C2BD10;
	Thu, 18 Jul 2024 03:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721272330;
	bh=w5/85RdFl+8Vx0ZQWvP37cBxciSRDyJRRx6d6zPWtVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pw9UDoQaCsFwxkJf/XAg+UeOc7qkWRqIs8a1ALcstA65iOAyZMoc+lEgarig9Irh5
	 AQJt/hrg1kcRUumfwjhfA3kN4UnsgKouTCsIsqgyCA5k9D6LduIZCNq85zuykucl3j
	 NFbgsxuqVNMcmder7Zfw9ak1sBwN3Xc2/cDXd3luLscv6xuQB/zYnTAjev7l0tmN6Y
	 atLkVC8ceFhRsfOSlodF6NnnExjcgAGjRMUv1sn0G73T/SGX7XBbSMIXBU5MxVvDFC
	 z83IWnYT7I3I3PDuVNmGZFVOlvxuWVS9YOHarP74WyZV/JOkIsF3yHYh/EfVEkLPiV
	 pCLcrjxOqjsFA==
Date: Wed, 17 Jul 2024 20:12:07 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>
Subject: Re: [RFC PATCH] tools/lib/subcmd: Don't free the usage string
Message-ID: <ZpiIB_1jSNvj95PL@google.com>
References: <20240717103351.268344-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240717103351.268344-1-adityag@linux.ibm.com>

On Wed, Jul 17, 2024 at 04:03:51PM +0530, Aditya Gupta wrote:
> Currently, commands which depend on 'parse_options_subcommand()' don't
> show the usage string, and instead show '(null)'
> 
>     $ ./perf sched
> 	Usage: (null)
> 
>     -D, --dump-raw-trace  dump raw trace in ASCII
>     -f, --force           don't complain, do it
>     -i, --input <file>    input file name
>     -v, --verbose         be more verbose (show symbol address, etc)
> 
> 'parse_options_subcommand()' is generally expected to initialise the usage
> string, with information in the passed 'subcommands[]' array
> 
> This behaviour was changed in:
> 
>     commit 230a7a71f9221 ("libsubcmd: Fix parse-options memory leak")
> 
> Where the generated usage string is deallocated, and usage[0] string is
> reassigned as NULL.
> 
> As discussed in [1], free the allocated usage string in the main function
> itself, and don't reset usage string to NULL in parse_options_subcommand
> 
> With this change, the behaviour is restored.
> 
>     $ ./perf sched
>         Usage: perf sched [<options>] {record|latency|map|replay|script|timehist}
> 
>            -D, --dump-raw-trace  dump raw trace in ASCII
>            -f, --force           don't complain, do it
>            -i, --input <file>    input file name
>            -v, --verbose         be more verbose (show symbol address, etc)
> 
> [1]: https://lore.kernel.org/linux-perf-users/htq5vhx6piet4nuq2mmhk7fs2bhfykv52dbppwxmo3s7du2odf@styd27tioc6e/
> 
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Fixes: 230a7a71f922 ("libsubcmd: Fix parse-options memory leak")
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/lib/subcmd/parse-options.c | 8 +++-----
>  tools/perf/builtin-kmem.c        | 2 ++
>  tools/perf/builtin-kvm.c         | 3 +++
>  tools/perf/builtin-kwork.c       | 3 +++
>  tools/perf/builtin-lock.c        | 3 +++
>  tools/perf/builtin-mem.c         | 3 +++
>  tools/perf/builtin-sched.c       | 3 +++
>  7 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
> index 4b60ec03b0bb..eb896d30545b 100644
> --- a/tools/lib/subcmd/parse-options.c
> +++ b/tools/lib/subcmd/parse-options.c
> @@ -633,10 +633,11 @@ int parse_options_subcommand(int argc, const char **argv, const struct option *o
>  			const char *const subcommands[], const char *usagestr[], int flags)
>  {
>  	struct parse_opt_ctx_t ctx;
> -	char *buf = NULL;
>  
>  	/* build usage string if it's not provided */
>  	if (subcommands && !usagestr[0]) {
> +		char *buf = NULL;
> +
>  		astrcatf(&buf, "%s %s [<options>] {", subcmd_config.exec_name, argv[0]);
>  
>  		for (int i = 0; subcommands[i]; i++) {
> @@ -678,10 +679,7 @@ int parse_options_subcommand(int argc, const char **argv, const struct option *o
>  			astrcatf(&error_buf, "unknown switch `%c'", *ctx.opt);
>  		usage_with_options(usagestr, options);
>  	}
> -	if (buf) {
> -		usagestr[0] = NULL;
> -		free(buf);
> -	}
> +
>  	return parse_options_end(&ctx);
>  }
>  
> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> index 6fd95be5032b..6b88b8b40784 100644
> --- a/tools/perf/builtin-kmem.c
> +++ b/tools/perf/builtin-kmem.c
> @@ -2058,6 +2058,8 @@ int cmd_kmem(int argc, const char **argv)
>  
>  out_delete:
>  	perf_session__delete(session);
> +	/* free usage string allocated by parse_options_subcommand */
> +	free((void *)kmem_usage[0]);
>  
>  	return ret;
>  }
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index 71165036e4ca..988bef73bd09 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -2187,5 +2187,8 @@ int cmd_kvm(int argc, const char **argv)
>  	else
>  		usage_with_options(kvm_usage, kvm_options);
>  
> +	/* free usage string allocated by parse_options_subcommand */
> +	free((void *)kvm_usage[0]);
> +
>  	return 0;
>  }
> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> index 56e3f3a5e03a..fd53838b5a78 100644
> --- a/tools/perf/builtin-kwork.c
> +++ b/tools/perf/builtin-kwork.c
> @@ -2520,5 +2520,8 @@ int cmd_kwork(int argc, const char **argv)
>  	} else
>  		usage_with_options(kwork_usage, kwork_options);
>  
> +	/* free usage string allocated by parse_options_subcommand */
> +	free((void *)kwork_usage[0]);
> +
>  	return 0;
>  }
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 0253184b3b58..b25d50716e63 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -2713,6 +2713,9 @@ int cmd_lock(int argc, const char **argv)
>  		usage_with_options(lock_usage, lock_options);
>  	}
>  
> +	/* free usage string allocated by parse_options_subcommand */
> +	free((void *)lock_usage[0]);
> +
>  	zfree(&lockhash_table);
>  	return rc;
>  }
> diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
> index 863fcd735dae..b7c1cf6d0e5a 100644
> --- a/tools/perf/builtin-mem.c
> +++ b/tools/perf/builtin-mem.c
> @@ -517,5 +517,8 @@ int cmd_mem(int argc, const char **argv)
>  	else
>  		usage_with_options(mem_usage, mem_options);
>  
> +	/* free usage string allocated by parse_options_subcommand */
> +	free((void *)mem_usage[0]);
> +
>  	return 0;
>  }
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 8750b5f2d49b..d6acc53ae89e 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -3805,5 +3805,8 @@ int cmd_sched(int argc, const char **argv)
>  		usage_with_options(sched_usage, sched_options);
>  	}
>  
> +	/* free usage string allocated by parse_options_subcommand */
> +	free((void *)sched_usage[0]);
> +
>  	return 0;
>  }
> -- 
> 2.45.2
> 
