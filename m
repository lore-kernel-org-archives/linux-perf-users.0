Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D0D1A5AA;
	Wed, 12 Feb 2025 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739369861; cv=none; b=AlD5GoF1n7pDYRG3+y5PqJsun3eNspPbkjkhJUrr+nwsIBybYVi0TrCdj8b73HfsgDSYZDnswOJfH1dNHC/Lh3RbI3IgjeXRyOt5ZJ8CHn403hoZ59saLiuSxZviX/wxvhbFXT5cwgaN4JKxQso2OzgJapIKexfFMhK+bB84Fwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739369861; c=relaxed/simple;
	bh=6WAvBJBHdVzn+myfwRDMnLWtYz9ymtVmvd7tzc8LxD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEyyZQ/d9uIcqWsDSmRbeh9cHjmwSxzOLmtOhX3TaAkN51UuYB/ZDUVcfrG5YW/MqS0oI/cQRcJAUjEwXB9PgfctY1QkzDAJ0xLf41+rhx1Sms7RK17968Knmnj5uNtl78jjXFYwMO6sHlCQfOEDt6viy0vxjgggPcNJBRueTr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmWiEwQO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmWiEwQO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5E8C4CEDF;
	Wed, 12 Feb 2025 14:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739369859;
	bh=6WAvBJBHdVzn+myfwRDMnLWtYz9ymtVmvd7tzc8LxD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rmWiEwQO0Zi4JldM+xfFQxXB0k8MeS1mtTD2dy04YRB3u+qlMq6mjHoo886TnBnNU
	 RO7+Qi42NLTegVL2HCJdO8q7Y+hckRrXKAYH5y3uezIDGsQBhyCvCZTyS7/+KtPBAR
	 PSlsC4ry/Fmm1Tg0nDuZaOio2+FtHsSxJl31ci5FbR9Kjr+4HT4BDKElqWSR43TO/n
	 jUT5LIK1aZ1eRBDyVNIaw5FXz+0GzvNPvjcdv6G5OilGwsJ69t38pbtyFcosVb93Lj
	 qlkEL4k8DU/O6z10fXbGK3bihRrSS+jW4RTsjdoFamNXkfE/A+b/mAk50A0ZEsxN7n
	 YrYma0+swJNVA==
Date: Wed, 12 Feb 2025 15:17:36 +0100
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, Hao Ge <gehao@kylinos.cn>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Levi Yun <yeoreum.yun@arm.com>, Xu Yang <xu.yang_2@nxp.com>,
	Tengda Wu <wutengda@huaweicloud.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 01/10] perf bench evlist-open-close: Reduce scope of 2
 variables
Message-ID: <Z6ytgCGkdl07DewQ@x1>
References: <20250111190143.1029906-1-irogers@google.com>
 <20250111190143.1029906-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111190143.1029906-2-irogers@google.com>

On Sat, Jan 11, 2025 at 11:01:34AM -0800, Ian Rogers wrote:
> Make 2 global variables local. Reduces ELF binary size by removing
> relocations. For a no flags build, the perf binary size is reduced by
> 4,144 bytes on x86-64.

I'm trying to reproduce your results:

  $ gcc --version | head -1
  gcc (GCC) 14.2.1 20240912 (Red Hat 14.2.1-3)
  $
  $ rm -rf /tmp/build/$(basename $PWD)/ ; mkdir -p /tmp/build/$(basename $PWD)/  
  $ make -k O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin

Without your patch:

  $ ls -la ~/bin/perf
  -rwxr-xr-x. 2 acme acme 11411680 Feb 12 10:57 /home/acme/bin/perf
  $ size ~/bin/perf
      text     data     bss       dec     hex  filename
  10071297   302496   34540  10408333  9ed18d  /home/acme/bin/perf
  $

Then, with your patch:

  $ git log --oneline -1
  abd904389b3f0807 (HEAD -> perf-tools-next) perf bench evlist-open-close: Reduce scope of 2 variables
  $ perf -v
  perf version 6.13.rc2.gabd904389b3f
  $ size ~/bin/perf
      text     data     bss       dec     hex  filename
  10072001   301568   34540  10408109  9ed0ad  /home/acme/bin/perf
  $
  $ ls -la ~/bin/perf
  -rwxr-xr-x. 2 acme acme 11411632 Feb 12 11:02 /home/acme/bin/perf
  $

So a more modest 224 bytes reduction in the perf binary size.

In the distant past several of these moves from global to local were
made, for instance:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d20deb64e0490ee9442b5181bc08a62d2cadcb90

I tried but didn't find the before/after effects on binary size...

Anyways,

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks,

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/bench/evlist-open-close.c | 42 +++++++++++++++-------------
>  1 file changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/perf/bench/evlist-open-close.c b/tools/perf/bench/evlist-open-close.c
> index 5a27691469ed..79cedcf94a39 100644
> --- a/tools/perf/bench/evlist-open-close.c
> +++ b/tools/perf/bench/evlist-open-close.c
> @@ -46,25 +46,6 @@ static struct record_opts opts = {
>  	.ctl_fd_ack          = -1,
>  };
>  
> -static const struct option options[] = {
> -	OPT_STRING('e', "event", &event_string, "event", "event selector. use 'perf list' to list available events"),
> -	OPT_INTEGER('n', "nr-events", &nr_events,
> -		     "number of dummy events to create (default 1). If used with -e, it clones those events n times (1 = no change)"),
> -	OPT_INTEGER('i', "iterations", &iterations, "Number of iterations used to compute average (default=100)"),
> -	OPT_BOOLEAN('a', "all-cpus", &opts.target.system_wide, "system-wide collection from all CPUs"),
> -	OPT_STRING('C', "cpu", &opts.target.cpu_list, "cpu", "list of cpus where to open events"),
> -	OPT_STRING('p', "pid", &opts.target.pid, "pid", "record events on existing process id"),
> -	OPT_STRING('t', "tid", &opts.target.tid, "tid", "record events on existing thread id"),
> -	OPT_STRING('u', "uid", &opts.target.uid_str, "user", "user to profile"),
> -	OPT_BOOLEAN(0, "per-thread", &opts.target.per_thread, "use per-thread mmaps"),
> -	OPT_END()
> -};
> -
> -static const char *const bench_usage[] = {
> -	"perf bench internals evlist-open-close <options>",
> -	NULL
> -};
> -
>  static int evlist__count_evsel_fds(struct evlist *evlist)
>  {
>  	struct evsel *evsel;
> @@ -225,6 +206,29 @@ static char *bench__repeat_event_string(const char *evstr, int n)
>  
>  int bench_evlist_open_close(int argc, const char **argv)
>  {
> +	const struct option options[] = {
> +		OPT_STRING('e', "event", &event_string, "event",
> +			   "event selector. use 'perf list' to list available events"),
> +		OPT_INTEGER('n', "nr-events", &nr_events,
> +			    "number of dummy events to create (default 1). If used with -e, it clones those events n times (1 = no change)"),
> +		OPT_INTEGER('i', "iterations", &iterations,
> +			    "Number of iterations used to compute average (default=100)"),
> +		OPT_BOOLEAN('a', "all-cpus", &opts.target.system_wide,
> +			    "system-wide collection from all CPUs"),
> +		OPT_STRING('C', "cpu", &opts.target.cpu_list, "cpu",
> +			   "list of cpus where to open events"),
> +		OPT_STRING('p', "pid", &opts.target.pid, "pid",
> +			   "record events on existing process id"),
> +		OPT_STRING('t', "tid", &opts.target.tid, "tid",
> +			   "record events on existing thread id"),
> +		OPT_STRING('u', "uid", &opts.target.uid_str, "user", "user to profile"),
> +		OPT_BOOLEAN(0, "per-thread", &opts.target.per_thread, "use per-thread mmaps"),
> +		OPT_END()
> +	};
> +	const char *const bench_usage[] = {
> +		"perf bench internals evlist-open-close <options>",
> +		NULL
> +	};
>  	char *evstr, errbuf[BUFSIZ];
>  	int err;
>  
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 
