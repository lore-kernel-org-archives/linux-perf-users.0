Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7964D1E515;
	Mon,  9 Dec 2024 22:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733784120; cv=none; b=f5pE6bqYzIKDqU7n4SPHwW8PskL4nlR9BagIe9oENeuZirdA2Ih7pf7Sj4+U4wrnDKPVgyTdZcLdaVfdgCX5OzVhWgUHrw7G/csySrG/rWL54BCjDHl3q5DfvbOWJxYUItgUtYhFHrumdVhQsDEVoW7aGs3TYF6dkQxqDdSpmWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733784120; c=relaxed/simple;
	bh=iFRvvWU6QYulZIvePgrcE3oP3TgpLKs1XopIPM70r4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COqYZHUGNF9XHleodGq2iTs3CAxJc+g3oIYNA4XoQ8gQbonmSVhgYCVzP+tE75G7JP8OQhZ9ltTrMo0nzRuWzH9nXwfwLFGZQEfVbG971HNwPdlV8kJyC/5UoCx0QwZfLrpJDrL+ugjhySEQaDmqhtqgdAcJHk+FvUWxgcXk1nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBNlzMVV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBNlzMVV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F417C4CEDD;
	Mon,  9 Dec 2024 22:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733784120;
	bh=iFRvvWU6QYulZIvePgrcE3oP3TgpLKs1XopIPM70r4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nBNlzMVVOIoUj4jLgf04fEXR1GapEfmcdo/udKXGx88Zq6mZ/VczgqxcV41f9mRNc
	 jHcoDU8tEHHzLQz+sIHdrPoXGg0BlVPa+Eumwrz52VuWso7tyn13ypPebUNeFFikGc
	 yOnGkWMZn61FlNpWqG/1v9xQnfYZdzTpSwtGUBPQN8elEt1n/cUpEIiiryw1Y7rA/w
	 5HAt8f4hgqww+X9HLn3tMtrb70IyyL7MeKdpsdwiN4KCoepK+jeXDcDt2XOwlvl3RI
	 vDZgQ6F1q8OAiOODGhl5o5VRln61/45HBOb9f8aba6n9PPiljd2qlnqk+wbdl5mpCq
	 HSsB0SJoYuCRw==
Date: Mon, 9 Dec 2024 14:41:58 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 1/3] perf lock: Fix parse_lock_type which only
 retrieve one lock flag
Message-ID: <Z1dyNuTsCgsY3TAZ@google.com>
References: <20241209200104.870531-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241209200104.870531-1-ctshao@google.com>

On Mon, Dec 09, 2024 at 12:01:00PM -0800, Chun-Tse Shao wrote:
> `parse_lock_type` can only add the first lock flag in `lock_type_table`
> given input `str`. For example, for `Y rwlock`, it only adds `rwlock:R`
> into this perf session. Another example is for `-Y mutex`, it only adds
> the mutex without `LCB_F_SPIN` flag. The patch fixes this issue, makes
> sure both `rwlock:R` and `rwlock:W` will be added with `-Y rwlock`, and
> so on.
> 
> Testing:
>   $ ./perf lock con -ab -Y mutex,rwlock -- perf bench sched pipe
>   # Running 'sched/pipe' benchmark:
>   # Executed 1000000 pipe operations between two processes
> 
>        Total time: 9.313 [sec]
> 
>          9.313976 usecs/op
>            107365 ops/sec
>    contended   total wait     max wait     avg wait         type   caller
> 
>          176      1.65 ms     19.43 us      9.38 us        mutex   pipe_read+0x57
>           34    180.14 us     10.93 us      5.30 us        mutex   pipe_write+0x50
>            7     77.48 us     16.09 us     11.07 us        mutex   do_epoll_wait+0x24d
>            7     74.70 us     13.50 us     10.67 us        mutex   do_epoll_wait+0x24d
>            3     35.97 us     14.44 us     11.99 us     rwlock:W   ep_done_scan+0x2d
>            3     35.00 us     12.23 us     11.66 us     rwlock:W   do_epoll_wait+0x255
>            2     15.88 us     11.96 us      7.94 us     rwlock:W   do_epoll_wait+0x47c
>            1     15.23 us     15.23 us     15.23 us     rwlock:W   do_epoll_wait+0x4d0
>            1     14.26 us     14.26 us     14.26 us     rwlock:W   ep_done_scan+0x2d
>            2     14.00 us      7.99 us      7.00 us        mutex   pipe_read+0x282
>            1     12.29 us     12.29 us     12.29 us     rwlock:R   ep_poll_callback+0x35
>            1     12.02 us     12.02 us     12.02 us     rwlock:W   do_epoll_ctl+0xb65
>            1     10.25 us     10.25 us     10.25 us     rwlock:R   ep_poll_callback+0x35
>            1      7.86 us      7.86 us      7.86 us        mutex   do_epoll_ctl+0x6c1
>            1      5.04 us      5.04 us      5.04 us        mutex   do_epoll_ctl+0x3d4
> 
> Fixes: d783ea8f62c4 ("perf lock contention: Simplify parse_lock_type()")
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/builtin-lock.c | 64 ++++++++++++++++++++++++---------------
>  1 file changed, 39 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 062e2b56a2ab..7e36bbe3cb80 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -1591,8 +1591,6 @@ static const struct {
>  	{ LCB_F_PERCPU | LCB_F_WRITE,	"pcpu-sem:W",	"percpu-rwsem" },
>  	{ LCB_F_MUTEX,			"mutex",	"mutex" },
>  	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex",	"mutex" },
> -	/* alias for get_type_flag() */
> -	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex-spin",	"mutex" },
>  };
>  
>  static const char *get_type_str(unsigned int flags)
> @@ -1617,19 +1615,6 @@ static const char *get_type_name(unsigned int flags)
>  	return "unknown";
>  }
>  
> -static unsigned int get_type_flag(const char *str)
> -{
> -	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
> -		if (!strcmp(lock_type_table[i].name, str))
> -			return lock_type_table[i].flags;
> -	}
> -	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
> -		if (!strcmp(lock_type_table[i].str, str))
> -			return lock_type_table[i].flags;
> -	}
> -	return UINT_MAX;
> -}
> -
>  static void lock_filter_finish(void)
>  {
>  	zfree(&filters.types);
> @@ -2350,29 +2335,58 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
>  			   int unset __maybe_unused)
>  {
>  	char *s, *tmp, *tok;
> -	int ret = 0;
>  
>  	s = strdup(str);
>  	if (s == NULL)
>  		return -1;
>  
>  	for (tok = strtok_r(s, ", ", &tmp); tok; tok = strtok_r(NULL, ", ", &tmp)) {
> -		unsigned int flags = get_type_flag(tok);
> +		bool found = false;
>  
> -		if (flags == -1U) {
> -			pr_err("Unknown lock flags: %s\n", tok);
> -			ret = -1;
> -			break;
> +		/* `tok` is `str` in `lock_type_table` if it contains ':'. */
> +		if (strchr(tok, ':')) {
> +			for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
> +				if (!strcmp(lock_type_table[i].str, tok) &&
> +				    add_lock_type(lock_type_table[i].flags)) {
> +					found = true;
> +					break;
> +				}
> +			}
> +
> +			if (!found) {
> +				pr_err("Unknown lock flags name: %s\n", tok);
> +				free(s);
> +				return -1;
> +			}
> +
> +			continue;
>  		}
>  
> -		if (!add_lock_type(flags)) {
> -			ret = -1;
> -			break;
> +		/*
> +		 * Otherwise `tok` is `name` in `lock_type_table`.
> +		 * Single lock name could contain multiple flags.
> +		 */
> +		for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
> +			if (!strcmp(lock_type_table[i].name, tok)) {
> +				if (add_lock_type(lock_type_table[i].flags)) {
> +					found = true;
> +				} else {
> +					free(s);
> +					return -1;
> +				}
> +			}
>  		}
> +
> +		if (!found) {
> +			pr_err("Unknown lock name: %s\n", tok);
> +			free(s);
> +			return -1;
> +		}
> +
>  	}
>  
>  	free(s);
> -	return ret;
> +	return 0;
>  }
>  
>  static bool add_lock_addr(unsigned long addr)
> -- 
> 2.47.0.338.g60cca15819-goog
> 
