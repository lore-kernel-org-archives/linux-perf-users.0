Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8144F332EC5;
	Thu, 24 Sep 2026 06:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790233116; cv=none; b=YItKIBq2gZbw9o2Cq0ixaxEzbqzx32k0l+uDo5EpC74GVFpdybSeEx9XI6w72D8I4pkd0n09Wq3wqZxT60vwaH9HKtC4XGV2TsnHTEEU1VBtsUODsydCfDCeY9tlAN9njs6zLBKWaV5+8bMvOXidRrQn3Ez2zClOshZVrXY6xzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790233116; c=relaxed/simple;
	bh=cyMwoSMOTN35A++2Hw6Yi9HLiAAy1zXh+yACpjDrzZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gueNiV4T6D5L94DIaEV3DQLFjQTfKaAfs1nMLMnI0xNJebB5sh+aZ2TY+6joOpXRei85/k4Hq5WMPIeCxfg177wx0+wxmpo0CB4w3pJNHyhkHZtdos+8IzAYIctMwTSiORKS4S6OnGve6/HTFC6NmJ/ZA1Aje9Mt8QBVf9IC/fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7ogIJHn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7ogIJHn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDC61F0089A;
	Thu, 24 Sep 2026 06:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790233102;
	bh=9d1re5a5k+BJTCjzTduchI3q9cuVTrpcbqNPi7hcOq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R7ogIJHnRV55sOHukaF5w/X+fTvuKKrj7XkGdiVhyTHuM1XU5cGILGv3PCD3fjMdL
	 VXpde7KdpB71aZ2TToEkYqs/3GiC/BWQG5wnw4RVBtNpW+fmduuc1j5iAKwlbJmf9C
	 Xe74FeD/CKD2iIFzgyXL/d8FCbvjp41Tsx+wdmK3ttCByg0v50SAiKXzZv0pB1lmVJ
	 KvDmAkn9xmokVch88nDL5vw1OM5HZghunCpccMUHacqXuYUrn34SeVKD6jZipiCQ1t
	 qO5PjvYEON03mgaR9FCsXwPyDHd072ztiiDKxwFHAXyfhg8WYAAB7gcmX0xqjmLt+A
	 kI/8oLxd09UeQ==
Date: Wed, 23 Sep 2026 23:58:20 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, howardchu95@gmail.com, adrian.hunter@intel.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, atomlin@atomlin.com
Subject: Re: [PATCH v5 08/23] perf trace: Bounds check augmented arguments
 before reading them
Message-ID: <arTKDBOI3C2hBU56@z2>
References: <cover.1790145937.git.irogers@google.com>
 <99ab722ef23fa269a0c6a95381a7493fcd5d6e0a.1790145937.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <99ab722ef23fa269a0c6a95381a7493fcd5d6e0a.1790145937.git.irogers@google.com>

+ Cc: Aaron Tomlin

On Wed, Sep 23, 2026 at 12:13:48AM -0700, Ian Rogers wrote:
> Augmented arguments are length prefixed payloads that the BPF augmenter
> appends to a sample: a struct augmented_arg header holding the payload
> length, followed by the payload. arg->augmented.args points at the next
> unconsumed one and arg->augmented.size says how many bytes are left.
> 
> Both the length and the number of bytes remaining come from the sample,
> but syscall_arg__scnprintf_buf() takes the length on trust and loops
> over it with no bound at all, so a bogus value walks straight off the
> end of the static argbuf that syscall__augmented_args() copies into:
> 
>   #0 0x73104f in dump_stack debug.c:366
>   #1 0x7310c5 in sighandler_dump_stack debug.c:378
>   #2 0x7f749ea66fb0 in __restore_rt libc.so.6[19fb0]
>   #3 0x4c0fa0 in syscall_arg__scnprintf_buf builtin-trace.c:1955
>   #4 0x4c2f3d in syscall_arg_fmt__scnprintf_val builtin-trace.c:2632
>   #5 0x4c33ae in syscall__scnprintf_args builtin-trace.c:2722
>   #6 0x4c43d3 in trace__sys_enter builtin-trace.c:3094
>   #7 0x4c7865 in trace__handle_event builtin-trace.c:4013
> 
> syscall_arg__scnprintf_augmented_string() likewise prints the payload
> with "%.*s" and a length it has not checked, and both dereference the
> header before testing it for NULL.
> 
> btf_struct_scnprintf() already gets this right. Lift its check into a
> shared syscall_arg__augmented_args_valid() in beauty.h, which verifies
> that a whole header is present and that the payload it advertises fits
> in what is left, taking a @need argument for callers that go on to read
> a fixed sized type, and use it at each of these sites.
> 
> An unusable payload now makes syscall_arg__scnprintf_filename() fall
> back to the vfs_getname probe or the raw pointer, as it does when there
> is no augmented data at all, rather than printing nothing.
> 
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Closes: https://lore.kernel.org/linux-perf-users/arJ-gpzqOHk-gF8T@x2/
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Aaron Timlin posted similar bound checking series.

https://lore.kernel.org/r/20260919005530.728615-1-atomlin@atomlin.com

Thanks,
Namhyung

> ---
>  tools/perf/builtin-trace.c       | 29 ++++++++++++++-------
>  tools/perf/trace/beauty/beauty.h | 43 ++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 6ffd4a0718ca..eeaaab44016c 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1139,14 +1139,12 @@ static size_t btf_struct_scnprintf(const struct btf_type *type, struct btf *btf,
>  	LIBBPF_OPTS(btf_dump_opts, dump_opts);
>  	LIBBPF_OPTS(btf_dump_type_data_opts, dump_data_opts);
>  
> -	if (arg == NULL || arg->augmented.args == NULL || arg->augmented.size < (int)sizeof(*augmented_arg) ||
> +	/* btf_dump__dump_type_data() below reads type->size bytes of the payload. */
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
> @@ -1904,12 +1902,18 @@ static void thread__set_filename_pos(struct thread *thread, const char *bf,
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
> @@ -1922,7 +1926,12 @@ static size_t syscall_arg__scnprintf_filename(char *bf, size_t size,
>  {
>  	unsigned long ptr = arg->val;
>  
> -	if (arg->augmented.args)
> +	/*
> +	 * A truncated or otherwise unusable augmented payload is no better than
> +	 * not having one at all, so test it here and let the pointer or the
> +	 * vfs_getname probe name the file instead of printing nothing.
> +	 */
> +	if (syscall_arg__augmented_args_valid(arg, 0))
>  		return syscall_arg__scnprintf_augmented_string(arg, bf, size);
>  
>  	if (!arg->trace->vfs_getname)
> @@ -1938,13 +1947,15 @@ static size_t syscall_arg__scnprintf_filename(char *bf, size_t size,
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
> index 0f4801c61a5b..71f93372c34e 100644
> --- a/tools/perf/trace/beauty/beauty.h
> +++ b/tools/perf/trace/beauty/beauty.h
> @@ -124,6 +124,49 @@ struct syscall_arg {
>  
>  unsigned long syscall_arg__val(struct syscall_arg *arg, u8 idx);
>  
> +/**
> + * syscall_arg__augmented_args_valid: can the next augmented arg be read?
> + *
> + * Augmented arguments are a series of length prefixed payloads that the BPF
> + * augmenter appends to a sample, with arg->augmented.args pointing at the next
> + * unconsumed one and arg->augmented.size saying how many bytes are left.
> + *
> + * Both the remaining byte count and the length prefix come from the sample, so
> + * neither can be trusted: a sample that carries no augmented arguments at all
> + * can still have a few bytes of ring buffer padding after the tracepoint
> + * payload, and those bytes then look like a struct augmented_arg holding an
> + * arbitrary length.
> + *
> + * Check that a whole header is present and that the payload it advertises fits
> + * in what is left, so that a beautifier reading augmented_arg->value stays
> + * inside the sample.
> + *
> + * @need: how many bytes of payload the caller goes on to read, zero when it is
> + * driven by the length prefix itself rather than by a fixed sized type.
> + */
> +static inline bool syscall_arg__augmented_args_valid(struct syscall_arg *arg, size_t need)
> +{
> +	const struct augmented_arg *augmented_arg;
> +
> +	if (arg == NULL || arg->augmented.args == NULL)
> +		return false;
> +
> +	/* The header has to be there before its size field can be read. */
> +	if (arg->augmented.size < (int)sizeof(*augmented_arg))
> +		return false;
> +
> +	augmented_arg = arg->augmented.args;
> +
> +	/* A negative length would make the bounds below meaningless. */
> +	if (augmented_arg->size < 0)
> +		return false;
> +
> +	if (augmented_arg->size > arg->augmented.size - (int)sizeof(*augmented_arg))
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
