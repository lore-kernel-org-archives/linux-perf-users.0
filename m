Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE5520A5E9;
	Wed, 11 Dec 2024 19:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733944568; cv=none; b=Vgr6Uh3GBLLLvlswH85cFvFTQO9KAQJv2JVK2L4sXEIrwN2osn37DMGC8q5bvYMcCc+IaeJABFQ+YD7NV93dXWfQvYObfNDPOj1icqatMADfiBhl8G3YTU2BN3i0fyCu/SuTbnGj6Tai82U4XdhezsuJ/8b90V5Wme/ZY1r9R+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733944568; c=relaxed/simple;
	bh=p0I3eAlC7b3PnBkktDgRru+nX0TcY+mtMy1hmXYQsL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHF6jaGVxXu7jfNu1/Fucp5kwGvLQ2e9pBoe7SHoKEGzVv/+kZHp5M0jNWR3jrUC4ml096sIj98cjQbrTEEXlrOiEZzz2mXtnlgCchNgTs3I/hDWbTS6DK+x4h3NdCsbJ9KrRJRHKNRTjb81liu9KYxQC9rBkBd+X02RVRl/LmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tC0Rtszh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tC0Rtszh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE628C4CED2;
	Wed, 11 Dec 2024 19:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733944568;
	bh=p0I3eAlC7b3PnBkktDgRru+nX0TcY+mtMy1hmXYQsL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tC0Rtszhjo2e6+97zK24za+HDrsByCbDBDvOT4BGYUH6o8G+E/nbXp/1hxkWTWau/
	 t0RFiupyYTW/iqZTXvo+cr/YNDVtF1qSuSLAaimwIXZm84cQMWQWSU9MsZyD0lDLcU
	 hpr83/H48RsqrDsnKHRzneoE+EOMXRXKnx14fIyVeFHA+wZ0bmLnRKuPIFmb1AWYwY
	 qMc9ooTwL0g7RgcwIXAqe0S4V/1cWarvN2NjW5JL4pGaSHGNmlpmNlECaltnOF/EvD
	 xUwVXVQisTvImA/bSx/wSZTLebbJ3qcHgnb3kkRUy8+K0sX7B5xfkAqZFtpntiiPjq
	 mmMCDCLMfkC1w==
Date: Wed, 11 Dec 2024 11:16:06 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, nick.forrington@arm.com,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 3/3] perf lock: Rename fields in lock_type_table
Message-ID: <Z1nk9owKE_xHVh1i@google.com>
References: <20241210200847.1023139-1-ctshao@google.com>
 <20241210200847.1023139-3-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241210200847.1023139-3-ctshao@google.com>

On Tue, Dec 10, 2024 at 12:08:22PM -0800, Chun-Tse Shao wrote:
> `lock_type_table` contains `name` and `str` which can be confusing.
> Rename them to `flags_name` and `lock_name` and add descriptions to
> enhance understanding.
> Tested by building perf for x86.
> 
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/builtin-lock.c | 33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 50630551adad..74085c8e32d3 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -1575,8 +1575,13 @@ static void sort_result(void)
>  
>  static const struct {
>  	unsigned int flags;
> -	const char *str;
> -	const char *name;
> +	/*
> +	 * Name of the lock flags (access), with delimeter ':'.
> +	 * For example, rwsem:R of rwsem:W.
> +	 */
> +	const char *flags_name;
> +	/* Name of the lock (type), for example, rwlock or rwsem. */
> +	const char *lock_name;
>  } lock_type_table[] = {
>  	{ 0,				"semaphore",	"semaphore" },
>  	{ LCB_F_SPIN,			"spinlock",	"spinlock" },
> @@ -1593,24 +1598,24 @@ static const struct {
>  	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex",	"mutex" },
>  };
>  
> -static const char *get_type_str(unsigned int flags)
> +static const char *get_type_flags_name(unsigned int flags)
>  {
>  	flags &= LCB_F_MAX_FLAGS - 1;
>  
>  	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
>  		if (lock_type_table[i].flags == flags)
> -			return lock_type_table[i].str;
> +			return lock_type_table[i].flags_name;
>  	}
>  	return "unknown";
>  }
>  
> -static const char *get_type_name(unsigned int flags)
> +static const char *get_type_lock_name(unsigned int flags)
>  {
>  	flags &= LCB_F_MAX_FLAGS - 1;
>  
>  	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
>  		if (lock_type_table[i].flags == flags)
> -			return lock_type_table[i].name;
> +			return lock_type_table[i].lock_name;
>  	}
>  	return "unknown";
>  }
> @@ -1717,7 +1722,7 @@ static void print_lock_stat_stdio(struct lock_contention *con, struct lock_stat
>  
>  	switch (aggr_mode) {
>  	case LOCK_AGGR_CALLER:
> -		fprintf(lock_output, "  %10s   %s\n", get_type_str(st->flags), st->name);
> +		fprintf(lock_output, "  %10s   %s\n", get_type_flags_name(st->flags), st->name);
>  		break;
>  	case LOCK_AGGR_TASK:
>  		pid = st->addr;
> @@ -1727,7 +1732,7 @@ static void print_lock_stat_stdio(struct lock_contention *con, struct lock_stat
>  		break;
>  	case LOCK_AGGR_ADDR:
>  		fprintf(lock_output, "  %016llx   %s (%s)\n", (unsigned long long)st->addr,
> -			st->name, get_type_name(st->flags));
> +			st->name, get_type_lock_name(st->flags));
>  		break;
>  	case LOCK_AGGR_CGROUP:
>  		fprintf(lock_output, "  %s\n", st->name);
> @@ -1768,7 +1773,7 @@ static void print_lock_stat_csv(struct lock_contention *con, struct lock_stat *s
>  
>  	switch (aggr_mode) {
>  	case LOCK_AGGR_CALLER:
> -		fprintf(lock_output, "%s%s %s", get_type_str(st->flags), sep, st->name);
> +		fprintf(lock_output, "%s%s %s", get_type_flags_name(st->flags), sep, st->name);
>  		if (verbose <= 0)
>  			fprintf(lock_output, "\n");
>  		break;
> @@ -1780,7 +1785,7 @@ static void print_lock_stat_csv(struct lock_contention *con, struct lock_stat *s
>  		break;
>  	case LOCK_AGGR_ADDR:
>  		fprintf(lock_output, "%llx%s %s%s %s\n", (unsigned long long)st->addr, sep,
> -			st->name, sep, get_type_name(st->flags));
> +			st->name, sep, get_type_lock_name(st->flags));
>  		break;
>  	case LOCK_AGGR_CGROUP:
>  		fprintf(lock_output, "%s\n",st->name);
> @@ -2343,10 +2348,10 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
>  	for (tok = strtok_r(s, ", ", &tmp); tok; tok = strtok_r(NULL, ", ", &tmp)) {
>  		bool found = false;
>  
> -		/* `tok` is `str` in `lock_type_table` if it contains ':'. */
> +		/* `tok` is a flags name if it contains ':'. */
>  		if (strchr(tok, ':')) {
>  			for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
> -				if (!strcmp(lock_type_table[i].str, tok) &&
> +				if (!strcmp(lock_type_table[i].flags_name, tok) &&
>  				    add_lock_type(lock_type_table[i].flags)) {
>  					found = true;
>  					break;
> @@ -2363,14 +2368,14 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
>  		}
>  
>  		/*
> -		 * Otherwise `tok` is `name` in `lock_type_table`.
> +		 * Otherwise `tok` is a lock name.
>  		 * Single lock name could contain multiple flags.
>  		 * Replace alias `pcpu-sem` with actual name `percpu-rwsem.
>  		 */
>  		if (!strcmp(tok, "pcpu-sem"))
>  			tok = (char *)"percpu-rwsem";
>  		for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
> -			if (!strcmp(lock_type_table[i].name, tok)) {
> +			if (!strcmp(lock_type_table[i].lock_name, tok)) {
>  				if (add_lock_type(lock_type_table[i].flags)) {
>  					found = true;
>  				} else {
> -- 
> 2.47.1.545.g3c1d2e2a6a-goog
> 
