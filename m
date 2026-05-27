Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F9F405C2D;
	Wed, 27 May 2026 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779903074; cv=none; b=bXIMA3nLO32mZGJlMQ7gvblfmcjjYlboisB41hNg38fKjUREelYMCi58qQoli7fxg3gZQ9lBxHfscG6cKggRmtgdg9PeHTLz9FCSpf5ixNI7vacMjRlHeF09VkWUM0TDXhk+awkVsOI/gf5RJ/J8myvYF/i+fWcUduXUdUYi/+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779903074; c=relaxed/simple;
	bh=Z+vPXqSOm+G7mXk4/U0RGoS2jxH5lQ4bzneOtOixuCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGWPV87j/9DmCHHqJgisFaLtjQUDYBU9JC5MnwDfiPs54YFeQL+X7AZ+ilq0BQmlnnH100SmMQoX7iLtAZeXjZHG3Y9JdHJ63j+tl1/TT3D3cM83Ovj6dB9OHIco2Zy0u1vxB72mrwaYJYdhsE6swPJvYkqVZSkXn2fgdTNojY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JX7OFpij; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JX7OFpij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0381F000E9;
	Wed, 27 May 2026 17:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779903073;
	bh=vY62grrEIHqdO0dybcwtRbuvdkCFiVagizaoj0BodA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JX7OFpijj6eYhssj9Gv4I19RV6a4/F37gfDLb/PTvI4Why9W6PI0UAMhdYA17NpTC
	 56F7H3xM6jxT4UrhXSw68w67Ph3Qa+YQI9ERi7mxk5y+XpyFfruCuLDAc3KDG8LaWn
	 PtDj3cTV2nIIPHQcNaf/6UmM5P62fiXKhoTq+BOR9GIhyjvWTIOFGjF9e7vn7w1pEb
	 5iiusyAcz9WahxVgl9azPfOfxgyXWyCfK0EJBjPudFIf3uX0RLrgxQsRg+0gzAKvg2
	 wQQ6iqiwMG/Wo9TumntwJdIklrV3JZZNW2zONC2Cv63Oo+dZP7eavxgZEV9XW7CxQ6
	 zD9NKTRBRb4Vw==
Date: Wed, 27 May 2026 10:31:10 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v3] perf bench: add --write-size option to sched pipe
Message-ID: <ahcqXqbjNlU-viPj@google.com>
References: <20260527-perf_bench_pipe-v3-1-9eee9465d673@debian.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260527-perf_bench_pipe-v3-1-9eee9465d673@debian.org>

On Wed, May 27, 2026 at 06:42:59AM -0700, Breno Leitao wrote:
> The default ping-pong uses sizeof(int) (4 bytes) per iteration, which
> exercises only the pipe-buffer merge path and keeps allocation entirely
> out of the picture. That makes the bench a useful scheduler / context-
> switch latency probe but unable to surface anything from the pipe
> page-allocation hot path.
> 
> Add a -s/--write-size option that sets the bytes written and read per
> ping-pong iteration. The buffer is allocated for each side via
> struct thread_data and replaces the on-stack int previously used. The
> default remains sizeof(int) so existing invocations are unchanged.
> 
> With --write-size set above PAGE_SIZE the bench drives anon_pipe_write()
> through alloc_page() (or the bulk pre-alloc, if the relevant patch is
> applied), which is what we want when measuring pipe locking and page
> allocation work.
> 
> The bench is a ping-pong: both sides call write() before read(), so a
> single write_size payload must fit entirely in the pipe buffer or both
> sides deadlock waiting for the other to drain. Resize the pipe via
> F_SETPIPE_SZ to match write_size (skipped at the sizeof(int) default),
> and error out cleanly when the request exceeds
> /proc/sys/fs/pipe-max-size.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> This patch has been valuable for testing and verifying the pipe
> enhancements currently under discussion at
> https://lore.kernel.org/all/20260515-fix_pipe-v1-0-b14c840c7555@debian.org/
> ---
> Changes in v3:
> - Loop on short read()/write() in the worker via new
>   pipe_xread()/pipe_xwrite() helpers, instead of asserting that the
>   full payload is always transferred in one call (suggested by
>   Namhyung).
> - Link to v2: https://patch.msgid.link/20260521-perf_bench_pipe-v2-1-720b6ff7f0fa@debian.org
> 
> Changes in v2:
> - Reject --write-size == 0 to avoid a zero-byte ping-pong that spins
>   (blocking mode) or hangs on epoll_wait (non-blocking mode).
> - Validate --write-size <= INT_MAX and drop the (int) casts in the
>   read/write BUG_ON and fcntl(F_SETPIPE_SZ) checks, so the comparisons
>   are unambiguous regardless of the requested size.
> - Fix "acommodate" typo in the pipe-resize comment.
> - Link to v1: https://patch.msgid.link/20260515-perf_bench_pipe-v1-1-3c5b805ba178@debian.org
> 
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.com>
> To: Arnaldo Carvalho de Melo <acme@kernel.org>
> To: Namhyung Kim <namhyung@kernel.org>
> To: Mark Rutland <mark.rutland@arm.com>
> To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> To: Jiri Olsa <jolsa@kernel.org>
> To: Ian Rogers <irogers@google.com>
> To: Adrian Hunter <adrian.hunter@intel.com>
> To: James Clark <james.clark@linaro.org>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  tools/perf/bench/sched-pipe.c | 102 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 89 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
> index 70139036d68f..7a14abc36047 100644
> --- a/tools/perf/bench/sched-pipe.c
> +++ b/tools/perf/bench/sched-pipe.c
> @@ -22,6 +22,7 @@
>  #include <string.h>
>  #include <errno.h>
>  #include <fcntl.h>
> +#include <limits.h>
>  #include <assert.h>
>  #include <sys/epoll.h>
>  #include <sys/time.h>
> @@ -39,6 +40,7 @@ struct thread_data {
>  	int			epoll_fd;
>  	bool			cgroup_failed;
>  	pthread_t		pthread;
> +	char			*buf;
>  };
>  
>  #define LOOPS_DEFAULT 1000000
> @@ -48,6 +50,7 @@ static	int			loops = LOOPS_DEFAULT;
>  static bool			threaded;
>  
>  static bool			nonblocking;
> +static unsigned int		write_size = sizeof(int);
>  static char			*cgrp_names[2];
>  static struct cgroup		*cgrps[2];
>  
> @@ -88,6 +91,8 @@ static const struct option options[] = {
>  	OPT_BOOLEAN('n', "nonblocking",	&nonblocking,	"Use non-blocking operations"),
>  	OPT_INTEGER('l', "loop",	&loops,		"Specify number of loops"),
>  	OPT_BOOLEAN('T', "threaded",	&threaded,	"Specify threads/process based task setup"),
> +	OPT_UINTEGER('s', "write-size", &write_size,
> +		     "Bytes per ping-pong write (default 4-bytes). Use larger values to exercise the pipe page-allocation path."),
>  	OPT_CALLBACK('G', "cgroups", NULL, "SEND,RECV",
>  		     "Put sender and receivers in given cgroups",
>  		     parse_two_cgroups),
> @@ -170,25 +175,57 @@ static void exit_cgroup(int nr)
>  	free(cgrp_names[nr]);
>  }
>  
> +/*
> + * Loop on short read()/write(): the kernel may return fewer bytes than
> + * requested, and in non-blocking mode the writer can transiently hit
> + * EWOULDBLOCK while the peer is still draining a full pipe (capacity is
> + * sized to write_size).
> + */
> +static inline int write_pipe(struct thread_data *td)
> +{
> +	unsigned int done = 0;
> +	int ret;
> +
> +	while (done < write_size) {
> +		ret = write(td->pipe_write, td->buf + done, write_size - done);
> +		if (ret < 0) {
> +			if (nonblocking && errno == EWOULDBLOCK)
> +				continue;

Don't we also need the blocking part?


> +			return ret;
> +		}
> +		done += ret;
> +	}
> +	return done;
> +}
> +
>  static inline int read_pipe(struct thread_data *td)
>  {
> -	int ret, m;
> -retry:
> -	if (nonblocking) {
> -		ret = epoll_wait(td->epoll_fd, &td->epoll_ev, 1, -1);
> -		if (ret < 0)
> +	unsigned int done = 0;
> +	int ret;
> +
> +	while (done < write_size) {
> +		if (nonblocking) {
> +			ret = epoll_wait(td->epoll_fd, &td->epoll_ev, 1, -1);
> +			if (ret < 0)
> +				return ret;
> +		}
> +		ret = read(td->pipe_read, td->buf + done, write_size - done);
> +		if (ret < 0) {
> +			if (nonblocking && errno == EWOULDBLOCK)
> +				continue;
> +			return ret;
> +		}
> +		if (ret == 0)
>  			return ret;

Maybe it doesn't matter.. but shouldn't it return 'done' instead?


> +		done += ret;
>  	}
> -	ret = read(td->pipe_read, &m, sizeof(int));
> -	if (nonblocking && ret < 0 && errno == EWOULDBLOCK)
> -		goto retry;
> -	return ret;
> +	return done;
>  }
>  
>  static void *worker_thread(void *__tdata)
>  {
>  	struct thread_data *td = __tdata;
> -	int i, ret, m = 0;
> +	int i, ret;
>  
>  	ret = enter_cgroup(td->nr);
>  	if (ret < 0) {
> @@ -204,15 +241,38 @@ static void *worker_thread(void *__tdata)
>  	}
>  
>  	for (i = 0; i < loops; i++) {
> -		ret = write(td->pipe_write, &m, sizeof(int));
> -		BUG_ON(ret != sizeof(int));
> +		ret = write_pipe(td);
> +		BUG_ON(ret < 0 || (unsigned int)ret != write_size);
>  		ret = read_pipe(td);
> -		BUG_ON(ret != sizeof(int));
> +		BUG_ON(ret < 0 || (unsigned int)ret != write_size);

Nit: maybe comparing to the write_size is enough as it cannot be
negative or bigger than INTMAX.

Thanks,
Namhyung


>  	}
>  
>  	return NULL;
>  }
>  
> +/*
> + * On a custom write_size, resize the pipes so a single payload fits.
> + */
> +static int resize_pipes(int wfd1, int wfd2)
> +{
> +	int r1, r2;
> +
> +	if (write_size <= sizeof(int))
> +		return 0;
> +
> +	r1 = fcntl(wfd1, F_SETPIPE_SZ, write_size);
> +	r2 = fcntl(wfd2, F_SETPIPE_SZ, write_size);
> +	if (r1 < 0 || r2 < 0 ||
> +	    (unsigned int)r1 < write_size ||
> +	    (unsigned int)r2 < write_size) {
> +		fprintf(stderr,
> +			"--write-size %u exceeds /proc/sys/fs/pipe-max-size\n",
> +			write_size);
> +		return -1;
> +	}
> +	return 0;
> +}
> +
>  int bench_sched_pipe(int argc, const char **argv)
>  {
>  	struct thread_data threads[2] = {};
> @@ -233,12 +293,25 @@ int bench_sched_pipe(int argc, const char **argv)
>  
>  	argc = parse_options(argc, argv, options, bench_sched_pipe_usage, 0);
>  
> +	if (write_size == 0 || write_size > INT_MAX) {
> +		fprintf(stderr, "--write-size must be in 1..%d\n", INT_MAX);
> +		return -1;
> +	}
> +
>  	if (nonblocking)
>  		flags |= O_NONBLOCK;
>  
>  	BUG_ON(pipe2(pipe_1, flags));
>  	BUG_ON(pipe2(pipe_2, flags));
>  
> +	if (resize_pipes(pipe_1[1], pipe_2[1]) < 0)
> +		return -1;
> +
> +	for (t = 0; t < nr_threads; t++) {
> +		threads[t].buf = calloc(1, write_size);
> +		BUG_ON(!threads[t].buf);
> +	}
> +
>  	gettimeofday(&start, NULL);
>  
>  	for (t = 0; t < nr_threads; t++) {
> @@ -287,6 +360,9 @@ int bench_sched_pipe(int argc, const char **argv)
>  	gettimeofday(&stop, NULL);
>  	timersub(&stop, &start, &diff);
>  
> +	for (t = 0; t < nr_threads; t++)
> +		free(threads[t].buf);
> +
>  	exit_cgroup(0);
>  	exit_cgroup(1);
>  
> 
> ---
> base-commit: e7e28506af98ce4e1059e5ec59334b335c00a246
> change-id: 20260515-perf_bench_pipe-bae2ec777c4b
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 
