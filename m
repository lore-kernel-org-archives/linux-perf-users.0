Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CF4378823;
	Wed, 30 Sep 2026 04:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790741758; cv=none; b=OZ6aPnJAU/j2s9C+NlIsbBFgsDgBkBUt3Z/4y74INedzjiZL7FDNRxSU8//vm9PmcIcIqatLm4mzYtqTXZ7mBHvaYGf4ZKuXpFRO7eg8FVdd6wVhxvFiwbA4S3pI0ymw2Bpegw4t+FQWGOmaVln8ldu+Gp0ii21A5TxkFtjLd2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790741758; c=relaxed/simple;
	bh=CIXIzkbXMmKQ5jAbYHHqYpDNIb6gSdlF4o2Q69gJhTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABA5FC9B5/+q5ZviisXkA9z6joruxZ+cm2SA5/2rJfOHpWSXB8/B/Yc8Mp0PsRTHpORQIh1HNaXa1h1n5CDFfAWEkX9iesk+NIVPu3aBN/l6SEOOqtrBQ8boS6fEcLoYxHgsb6olNILoWZ+CssG4KbMf/GWVu6obOX+vTfbk2Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FC3WWlmD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FC3WWlmD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0EC1F000FF;
	Wed, 30 Sep 2026 04:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790741756;
	bh=6/otGvuRtigsBPkxcPsET88cBu7mN+IvbEgMcsUyri8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FC3WWlmD3CZNGsMuUoyg9ovZHeKSz3YRk85wKDLxzBg9e0uCFvcArQ/y+MJ4dPU3v
	 mupmvMsvc9PoTQsbeSpqprzZXFn5bzZuhOMlsCzG09rTh65kLo1dj4RT2+z+rdME8X
	 CoV6gUu6zWvxo55wvAaAk8zuA2Dh05D4bMvcjV87RcUHEXY5Xh4duXvf50JE2pxj4d
	 82Qxmhhl0akbaSohaRU5bFxVSIz7b4pD3INViphf4pegS9w7OMuANincf60JXB5biF
	 y0+G6y7AH99aADbyGbp5TmMUCkyJ9K1v7ce03aiNV8XO7LaJV2bpyszUNV55MbwvrE
	 a85QIxcINQCzA==
Date: Tue, 29 Sep 2026 21:15:54 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 04/26] perf trace: Bounds check augmented arguments
 before reading them
Message-ID: <aryM-gu0FlmB1-Jw@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260928182605.3649015-5-irogers@google.com>

On Mon, Sep 28, 2026 at 11:25:43AM -0700, Ian Rogers wrote:
> syscall_arg__scnprintf_buf() and syscall_arg__scnprintf_augmented_string()
> trust the augmented arg's size, so a bad one reads out of bounds:
> 
>   #3 0x4c0fa0 in syscall_arg__scnprintf_buf builtin-trace.c:1955
>   #4 0x4c2f3d in syscall_arg_fmt__scnprintf_val builtin-trace.c:2632
>   #5 0x4c33ae in syscall__scnprintf_args builtin-trace.c:2722
>   #6 0x4c43d3 in trace__sys_enter builtin-trace.c:3094
>   #7 0x4c7865 in trace__handle_event builtin-trace.c:4013
> 
> Move the check in btf_struct_scnprintf() to a helper,
> syscall_arg__augmented_args_valid(), and use it in both. When the check
> fails, syscall_arg__scnprintf_filename() now falls back to vfs_getname or
> the pointer.
> 
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Closes: https://lore.kernel.org/linux-perf-users/arJ-gpzqOHk-gF8T@x2/
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/builtin-trace.c       | 23 ++++++++++++++---------
>  tools/perf/trace/beauty/beauty.h | 17 +++++++++++++++++
>  2 files changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index c39de91140a0..85db74965280 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1139,14 +1139,11 @@ static size_t btf_struct_scnprintf(const struct btf_type *type, struct btf *btf,
>  	LIBBPF_OPTS(btf_dump_opts, dump_opts);
>  	LIBBPF_OPTS(btf_dump_type_data_opts, dump_data_opts);
>  
> -	if (arg == NULL || arg->augmented.args == NULL || arg->augmented.size < (int)sizeof(*augmented_arg) ||
> +	if (!syscall_arg__augmented_args_valid(arg, type->size) ||
>  	    arg->fmt == NULL || !arg->fmt->from_user)
>  		return 0;
>  
>  	augmented_arg = arg->augmented.args;
> -	if (augmented_arg->size <= 0 || augmented_arg->size > arg->augmented.size - (int)sizeof(*augmented_arg) ||
> -	    (size_t)augmented_arg->size < type->size)
> -		return 0;
>  
>  	dump_data_opts.compact	  = true;
>  	dump_data_opts.skip_names = !arg->trace->show_arg_names;
> @@ -1904,12 +1901,18 @@ static void thread__set_filename_pos(struct thread *thread, const char *bf,
>  static size_t syscall_arg__scnprintf_augmented_string(struct syscall_arg *arg, char *bf, size_t size)
>  {
>  	struct augmented_arg *augmented_arg = arg->augmented.args;
> -	size_t printed = scnprintf(bf, size, "\"%.*s\"", augmented_arg->size, augmented_arg->value);
> +	size_t printed;
> +	int consumed;
> +
> +	if (!syscall_arg__augmented_args_valid(arg, 0))
> +		return 0;
> +
> +	printed = scnprintf(bf, size, "\"%.*s\"", augmented_arg->size, augmented_arg->value);
>  	/*
>  	 * So that the next arg with a payload can consume its augmented arg, i.e. for rename* syscalls
>  	 * we would have two strings, each prefixed by its size.
>  	 */
> -	int consumed = sizeof(*augmented_arg) + augmented_arg->size;
> +	consumed = sizeof(*augmented_arg) + augmented_arg->size;
>  
>  	arg->augmented.args = ((void *)arg->augmented.args) + consumed;
>  	arg->augmented.size -= consumed;
> @@ -1922,7 +1925,7 @@ static size_t syscall_arg__scnprintf_filename(char *bf, size_t size,
>  {
>  	unsigned long ptr = arg->val;
>  
> -	if (arg->augmented.args)
> +	if (syscall_arg__augmented_args_valid(arg, 0))
>  		return syscall_arg__scnprintf_augmented_string(arg, bf, size);
>  
>  	if (!arg->trace->vfs_getname)
> @@ -1938,13 +1941,15 @@ static size_t syscall_arg__scnprintf_filename(char *bf, size_t size,
>  static size_t syscall_arg__scnprintf_buf(char *bf, size_t size, struct syscall_arg *arg)
>  {
>  	struct augmented_arg *augmented_arg = arg->augmented.args;
> -	unsigned char *orig = (unsigned char *)augmented_arg->value;
>  	size_t printed = 0;
> +	unsigned char *orig;
>  	int consumed;
>  
> -	if (augmented_arg == NULL)
> +	if (!syscall_arg__augmented_args_valid(arg, 0))
>  		return 0;
>  
> +	orig = (unsigned char *)augmented_arg->value;
> +
>  	for (int j = 0; j < augmented_arg->size; ++j) {
>  		bool control_char = orig[j] <= MAX_CONTROL_CHAR || orig[j] >= MAX_ASCII;
>  		/* print control characters (0~31 and 127), and non-ascii characters in \(digits) */
> diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
> index 0f4801c61a5b..1cd307328bb2 100644
> --- a/tools/perf/trace/beauty/beauty.h
> +++ b/tools/perf/trace/beauty/beauty.h
> @@ -124,6 +124,23 @@ struct syscall_arg {
>  
>  unsigned long syscall_arg__val(struct syscall_arg *arg, u8 idx);
>  
> +/* Is there a whole augmented arg left with at least @need bytes of payload? */
> +static inline bool syscall_arg__augmented_args_valid(struct syscall_arg *arg, size_t need)
> +{
> +	const struct augmented_arg *augmented_arg;
> +
> +	if (arg == NULL || arg->augmented.args == NULL ||
> +	    arg->augmented.size < (int)sizeof(*augmented_arg))
> +		return false;
> +
> +	augmented_arg = arg->augmented.args;
> +	if (augmented_arg->size < 0 ||
> +	    augmented_arg->size > arg->augmented.size - (int)sizeof(*augmented_arg))
> +		return false;
> +
> +	return (size_t)augmented_arg->size >= need;
> +}
> +
>  size_t syscall_arg__scnprintf_strarray_flags(char *bf, size_t size, struct syscall_arg *arg);
>  #define SCA_STRARRAY_FLAGS syscall_arg__scnprintf_strarray_flags
>  
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 
