Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352EF1D9A6D;
	Mon,  2 Dec 2024 20:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172574; cv=none; b=uPAqc8zPOTjXKAF7ReKZwvHJtc7YgKUqdxvqv3kUW4mWwlirOPTs8/3/QkOyiTvCnwhKQkwEnTDL50JUfTcO8RSCefBxjj8+5f/7ChIyBtRf/T0SLTSAblSvVE01pRAU/jojWusoVhmuDYLFwHPtYeZkiATKnO5d//S+jFZtkzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172574; c=relaxed/simple;
	bh=jw5PhHY0O7ZQ6RDT40NYjeEtF7JpvHduvTrGvUcU10Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDOAc1cIJ1ihe2OarpclNhbIlXz67LgMksxptFbUwWgC63hZDTrxhCjszbPLpkuTQf/Kr3o+2VCr/61uUMoFJqLTzSRX7pVv3lvNYFrG5qi26fGChJhYi/ze2lNyAmyHVsxJRsdp7dbVqOxoarIhbwrwanbz7ZXUOynUzDg+id0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0UDrNwm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0UDrNwm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0D5C4CED1;
	Mon,  2 Dec 2024 20:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733172574;
	bh=jw5PhHY0O7ZQ6RDT40NYjeEtF7JpvHduvTrGvUcU10Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n0UDrNwmPQpoS5RM3gCnYOC7v7GG6Fl/JMtRi5WqbloJa4D+9FQ9VTEg/EW2HdJR9
	 nOQkNd3TeVFnBfG5y9bGfejHbfPunsQO/UB07bpw7UN/1aAoF84qLv5aajylIlhDWQ
	 NCllNrCCbEscs/4gN5jRQhDLBHiudIn5dXxrXRhC3vPVvgAf92DPKWixjcptZpVS4M
	 9ka4lO4aT+sRIQ09wPdIAQEAcspmRvDc7KTs6yveAbehzJEQ4+hpiT/BsNZVTHQ7z+
	 56br/j3S2EqmeeLIfY/l2bvi4ouf8OfrsBoqN7IFPaWMAwkxu7FCWmOxZLA6g/v0R+
	 AH+58oXkz6c8g==
Date: Mon, 2 Dec 2024 12:49:31 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 2/2] perf lock: Fix parse_lock_type which only
 retrieve one lock flag
Message-ID: <Z04dWxBBEfcXK8z5@google.com>
References: <20241126212255.3793822-1-ctshao@google.com>
 <20241126212255.3793822-2-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241126212255.3793822-2-ctshao@google.com>

Hello,

On Tue, Nov 26, 2024 at 01:22:54PM -0800, Chun-Tse Shao wrote:
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
>        Total time: 8.425 [sec]
> 
>          8.425402 usecs/op
>            118688 ops/sec
>    contended   total wait     max wait     avg wait         type   caller
> 
>          194      1.68 ms     44.16 us      8.66 us        mutex   pipe_read+0x57
>           10    423.03 us     44.27 us     42.30 us     rwlock:W   do_exit+0x365
>           54    254.67 us     58.87 us      4.72 us        mutex   pipe_write+0x50
>           21    146.64 us     11.54 us      6.98 us        mutex   pipe_read+0x282
>           10    141.27 us     20.62 us     14.13 us     rwlock:W   release_task+0x6f
>            5     58.92 us     16.37 us     11.78 us        mutex   do_epoll_wait+0x24d
>            3     29.81 us     17.66 us      9.94 us        mutex   do_epoll_ctl+0x6c1
>            4     26.82 us     11.02 us      6.70 us        mutex   do_epoll_wait+0x24d
>            2     18.32 us     12.49 us      9.16 us     rwlock:W   do_epoll_wait+0x255
>            1     11.34 us     11.34 us     11.34 us     rwlock:W   ep_done_scan+0x2d
>            1     11.02 us     11.02 us     11.02 us     rwlock:R   mm_update_next_owner+0x4e
>            1     10.60 us     10.60 us     10.60 us     rwlock:W   do_epoll_ctl+0xb65
>            1      9.90 us      9.90 us      9.90 us     rwlock:W   do_exit+0x365
> 
> Fixes: d783ea8f62c4 ("perf lock contention: Simplify parse_lock_type()")

I think it won't apply to earlier kernels because you changed the field
names in the previous commit.  I think you can switch the order of the
commits so that we can have the fix first.


> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
>  tools/perf/builtin-lock.c | 68 ++++++++++++++++++++++++++-------------
>  1 file changed, 45 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index c528aff1c9d5..c1870c287580 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -1622,19 +1622,6 @@ static const char *get_type_lock_name(unsigned int flags)
>  	return "unknown";
>  }
>  
> -static unsigned int get_type_flag(const char *str)
> -{
> -	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
> -		if (!strcmp(lock_type_table[i].flags_name, str))
> -			return lock_type_table[i].flags;
> -	}
> -	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
> -		if (!strcmp(lock_type_table[i].lock_name, str))
> -			return lock_type_table[i].flags;
> -	}
> -	return UINT_MAX;
> -}
> -
>  static void lock_filter_finish(void)
>  {
>  	zfree(&filters.types);
> @@ -2356,29 +2343,64 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
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
> +		/* `tok` is a flags name if it contains ':'. */
> +		if (strchr(tok, ':')) {
> +			for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
> +				if (!strcmp(lock_type_table[i].flags_name, tok) &&
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
> +		 * Otherwise `tok` is a lock name.
> +		 * Single lock name could contain multiple flags.
> +		 */
> +		/*
> +		 * By documentation, `percpu-rwmem` should be `pcpu-sem`.
> +		 * For backward compatibility, we replace `pcpu-sem` with `percpu-rwmem`.
> +		 */
> +		if (!strcmp(tok, "pcpu-sem"))
> +			tok = (char *)"percpu-rwsem";

I think it's better to split the pcpu-sem part into a separate commit as
it fixes a different issue.  Also you'd better merge the block commits.

Thanks,
Namhyung


> +
> +		for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
> +			if (!strcmp(lock_type_table[i].lock_name, tok)) {
> +				if (add_lock_type(lock_type_table[i].flags)) {
> +					found = true;
> +				} else {
> +					free(s);
> +					return -1;
> +				}
> +			}
> +		}
> +
> +		if (!found) {
> +			pr_err("Unknown lock name: %s\n", tok);
> +			free(s);
> +			return -1;
>  		}
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
