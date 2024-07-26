Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09696D51A
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Jul 2024 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722003791; cv=none; b=E3fR1tAbb73iJ7zKRbcuQtNTpKCp8DgaJ0TBlYZMuUJr3jJHXRAsmQSiIbU4uerOiBcHnzlYoiECS7rbE56Taydsg/jtYObmcH4eTDYjH4E6ZJY+WBH85Vpunq4YexodD4ZqhF/hN0i8d/3jf1qPBI8fGN7N1aMaAP8QST5Cqco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722003791; c=relaxed/simple;
	bh=rUszhg+IgEuGQl60GYtcyfvDW5tuROLOPkfzbLFfZNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKT19kznEHXlzvDWW0dcXGqSAsag2SZluQBefVQv3oRN/pqoRsrxcx/OwKAzUkf0iSJ7DR4ASGqtGUJl7QToAcjw7gjocCz6o/GepiWJfXj3X+ZWl6euMqlRqfi8jRAizJVEamFbe9F102Ad9D4+oQ6shkHJE0I1BaC04vpT+yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFEX/PTc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFEX/PTc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D18EC32782;
	Fri, 26 Jul 2024 14:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722003790;
	bh=rUszhg+IgEuGQl60GYtcyfvDW5tuROLOPkfzbLFfZNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QFEX/PTc1z5X37i6vCXhKkpt3/59nNIizRTHgn2H0Ulmm6q6h3gha3aCui9rmNKOJ
	 q1+nNd2+PF1jqrQeVE70faL++hzZnxtstdtkzPakfqrb5nB/NLBovGIPsZi2XhnYmi
	 uim/Ioos3Yixj3PcvxnIIvAy4Mjj9PART1udijwgcYZfILhZ4QMJieEsnV49ZXYR2z
	 3sWqvNXdD9wpq2G6uVdqjtnmi3FCK9dCYMg7eG+iWJiLO6t95I538PvwlHqjujnR3Y
	 SpGnNFtcBX1jbbXTj5epHNOTxhwUrh6ZCJGcu14RAWNleS5KeAhLm2sUrSIrOFzOhV
	 3L9U+zJf0hyIQ==
Date: Fri, 26 Jul 2024 11:23:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: jolsa@kernel.org, irogers@google.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
	atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v13 1/7] tools/lib/subcmd: Don't free the usage string
Message-ID: <ZqOxSubGZ6O4K6Gz@x1>
References: <20240718085957.550858-1-adityag@linux.ibm.com>
 <20240718085957.550858-2-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718085957.550858-2-adityag@linux.ibm.com>

On Thu, Jul 18, 2024 at 02:29:51PM +0530, Aditya Gupta wrote:
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
> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Cc: Disha Goel <disgoel@linux.vnet.ibm.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Kajol Jain <kjain@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Fixes: 230a7a71f922 ("libsubcmd: Fix parse-options memory leak")
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> 
> ---
> Note:
> This patch is independent of the series.
> 
> But I kept it along with the series, since the rest of the patches should
> be applied only after this patch is applied (else the 'free' in
> builtin-check.c will crash)
> ---
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

Can we instead add a parse_options_exit(const char *usagestr[]) that
does the free?

So that we don't expose these internal details of libsubcmd and if
something else needs to be done at exit time, thenm that is the place to
add.

Thanks,

- Arnaldo
  
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
