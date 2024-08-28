Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5501AC43B;
	Wed, 28 Aug 2024 21:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879102; cv=none; b=TuiWT2RAujXkuTQfYcPbkd2bY8DHN2qiA67Ulpj0Tf2cUdNVe7V+yoglCMaNxDo9CJgXHXsTHLFaxNPxzb6yjtiXUPZiy8wyAV7Y1MFPuuErP2Afkq4MnYDCVLKni1vxUlB4H0pMLmhszZsYNDWByrBPUlJmTb1l8x1D0TTd+6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879102; c=relaxed/simple;
	bh=0M5faLQUvzi2dMqRmWIXyv4aqaeiB+j4DOHlfGlwVn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMtv7/dFGzqY/Jp5otYd9ECSrp15iXdmUo7g88TYjjOOX2m4PRvxGutA3Nv435wrZshN2CnaoONpNw0C0KSRgdT7pYX1QA2N+a9L4Mslv4umn7YzfJvxii90bxYtUEl/5AqUXpERgB1T05KEZSMwTEsl9znNXd1pkTWYzshdUpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3Yp/MFN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3Yp/MFN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72150C4CEC1;
	Wed, 28 Aug 2024 21:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724879102;
	bh=0M5faLQUvzi2dMqRmWIXyv4aqaeiB+j4DOHlfGlwVn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u3Yp/MFN7nx3LvrC8HzlDayYJJOigLNwkBTH+4ijXce9nDmY51ckAC/ysysgHcJ9U
	 aJVO77tJaTgtDqL3M333QIGopGchkShR5ouHdvWazn+qtNUms8T0NClYePpWQ7X6pT
	 ek/ygX4Cms0kqtIGnjjkcICDh4agFJ7r7zKzIotLy/17EKKaO7Z8WQ6+Ibo7lrwnJY
	 22+Isc0qEeF5F0teROs2+27hmXPKJk6pvXTB/wdhrfsfk1WN3vY2dRZ1uS1Syd0OTw
	 lQxGUOLtyLKi7RR0+mkp5ypUeANs/445ZeCueYVz0Tbin43ptVaAxTY/RHOcpFLbf1
	 mbqHaKBX1Iuow==
Date: Wed, 28 Aug 2024 18:04:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v3 4/8] perf trace: Pretty print struct data
Message-ID: <Zs-Q-ZyZKd_NzsIv@x1>
References: <20240824163322.60796-1-howardchu95@gmail.com>
 <20240824163322.60796-5-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824163322.60796-5-howardchu95@gmail.com>

On Sun, Aug 25, 2024 at 12:33:18AM +0800, Howard Chu wrote:
> Change the arg->augmented.args to arg->augmented.args->value to skip the
> header for customized pretty printers, since we collect data in BPF
> using the general augment_sys_enter(), which always adds the header.
> 
> Use btf_dump API to pretty print augmented struct pointer.
> 
> Prefer existed pretty-printer than btf general pretty-printer.
> 
> set compact = true and skip_names = true, so that no newline character
> and argument name are printed.
> 
> Committer notes:
> 
> Simplified the btf_dump_snprintf callback to avoid using multiple
> buffers, as discussed in the thread accessible via the Link tag below.
> 
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/r/20240815013626.935097-7-howardchu95@gmail.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/builtin-trace.c                | 65 +++++++++++++++++++++--
>  tools/perf/trace/beauty/perf_event_open.c |  2 +-
>  tools/perf/trace/beauty/sockaddr.c        |  2 +-
>  tools/perf/trace/beauty/timespec.c        |  2 +-
>  4 files changed, 63 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 43b1f63415b4..048bcb92624c 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -990,6 +990,54 @@ static size_t btf_enum_scnprintf(const struct btf_type *type, struct btf *btf, c
>  	return 0;
>  }
>  
> +struct trace_btf_dump_snprintf_ctx {
> +	char   *bf;
> +	size_t printed, size;
> +};
> +
> +static void trace__btf_dump_snprintf(void *vctx, const char *fmt, va_list args)
> +{
> +	struct trace_btf_dump_snprintf_ctx *ctx = vctx;
> +
> +	ctx->printed += vscnprintf(ctx->bf + ctx->printed, ctx->size - ctx->printed, fmt, args);
> +}
> +
> +static size_t btf_struct_scnprintf(const struct btf_type *type, struct btf *btf, char *bf, size_t size, struct syscall_arg *arg)
> +{
> +	struct trace_btf_dump_snprintf_ctx ctx = {
> +		.bf   = bf,
> +		.size = size,
> +	};
> +	struct augmented_arg *augmented_arg = arg->augmented.args;
> +	int type_id = arg->fmt->type_id, consumed;
> +	struct btf_dump *btf_dump;
> +
> +	LIBBPF_OPTS(btf_dump_opts, dump_opts);
> +	LIBBPF_OPTS(btf_dump_type_data_opts, dump_data_opts);
> +
> +	if (arg == NULL || arg->augmented.args == NULL)
> +		return 0;
> +
> +	dump_data_opts.compact     = true;
> +	dump_data_opts.skip_names  = true;
> +
> +	btf_dump = btf_dump__new(btf, trace__btf_dump_snprintf, &ctx, &dump_opts);
> +	if (btf_dump == NULL)
> +		return 0;
> +
> +	/* pretty print the struct data here */
> +	if (btf_dump__dump_type_data(btf_dump, type_id, arg->augmented.args->value, type->size, &dump_data_opts) == 0)
> +		return 0;
> +
> +	consumed = sizeof(*augmented_arg) + augmented_arg->size;
> +	arg->augmented.args = ((void *)arg->augmented.args) + consumed;
> +	arg->augmented.size -= consumed;
> +
> +	btf_dump__free(btf_dump);
> +
> +	return ctx.printed;
> +}
> +
>  static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg *arg, char *bf,
>  				   size_t size, int val, char *type)
>  {
> @@ -1009,6 +1057,8 @@ static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg *arg,
>  
>  	if (btf_is_enum(arg_fmt->type))
>  		return btf_enum_scnprintf(arg_fmt->type, trace->btf, bf, size, val);
> +	else if (btf_is_struct(arg_fmt->type))
> +		return btf_struct_scnprintf(arg_fmt->type, trace->btf, bf, size, arg);
>  
>  	return 0;
>  }
> @@ -2222,6 +2272,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
>  		.show_string_prefix = trace->show_string_prefix,
>  	};
>  	struct thread_trace *ttrace = thread__priv(thread);
> +	void *default_scnprintf;
>  
>  	/*
>  	 * Things like fcntl will set this in its 'cmd' formatter to pick the
> @@ -2263,11 +2314,15 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
>  			if (trace->show_arg_names)
>  				printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
>  
> -			btf_printed = trace__btf_scnprintf(trace, &arg, bf + printed,
> -							   size - printed, val, field->type);
> -			if (btf_printed) {
> -				printed += btf_printed;
> -				continue;
> +			default_scnprintf = sc->arg_fmt[arg.idx].scnprintf;
> +
> +			if (default_scnprintf == NULL || default_scnprintf == SCA_PTR) {
> +				btf_printed = trace__btf_scnprintf(trace, &arg, bf + printed,
> +								   size - printed, val, field->type);
> +				if (btf_printed) {
> +					printed += btf_printed;
> +					continue;
> +				}

Ok, we agreed on this one, and you noted that that in this cset comment,
good.

Next time make a note after the cset commit log message and before the
actual patch, something like:

vN: prefer pre-existing userspace scnprintf if explicitely specified,
only fallbacking to the generic BTF one when none is specified.

>  			}
>  
>  			printed += syscall_arg_fmt__scnprintf_val(&sc->arg_fmt[arg.idx],
> diff --git a/tools/perf/trace/beauty/perf_event_open.c b/tools/perf/trace/beauty/perf_event_open.c
> index 01ee15fe9d0c..632237128640 100644
> --- a/tools/perf/trace/beauty/perf_event_open.c
> +++ b/tools/perf/trace/beauty/perf_event_open.c
> @@ -76,7 +76,7 @@ static size_t perf_event_attr___scnprintf(struct perf_event_attr *attr, char *bf

But this part will work if we use the old collectors in the BPF skel?

I.e. isn't this a change in the protocol of the BPF colector with the
userpace augmented snprintf routines?

If I remember we discussed that first you make this change in the
protocol, test it with the pre-existing BPF collector, it works. Ok, now
we have a new protocol and we then use it in the generic BTF-based BPF
collector. This way that option of using the BTF-based collector or the
preexisting BPF collector works.

I'll try to do this.

- Arnaldo
  
>  static size_t syscall_arg__scnprintf_augmented_perf_event_attr(struct syscall_arg *arg, char *bf, size_t size)
>  {
> -	return perf_event_attr___scnprintf((void *)arg->augmented.args, bf, size, arg->trace->show_zeros);
> +	return perf_event_attr___scnprintf((void *)arg->augmented.args->value, bf, size, arg->trace->show_zeros);
>  }
>  
>  static size_t syscall_arg__scnprintf_perf_event_attr(char *bf, size_t size, struct syscall_arg *arg)
> diff --git a/tools/perf/trace/beauty/sockaddr.c b/tools/perf/trace/beauty/sockaddr.c
> index 2e0e867c0c1b..6ecebf776899 100644
> --- a/tools/perf/trace/beauty/sockaddr.c
> +++ b/tools/perf/trace/beauty/sockaddr.c
> @@ -47,7 +47,7 @@ static size_t (*af_scnprintfs[])(struct sockaddr *sa, char *bf, size_t size) = {
>  
>  static size_t syscall_arg__scnprintf_augmented_sockaddr(struct syscall_arg *arg, char *bf, size_t size)
>  {
> -	struct sockaddr *sa = (struct sockaddr *)arg->augmented.args;
> +	struct sockaddr *sa = (struct sockaddr *)arg->augmented.args->value;
>  	char family[32];
>  	size_t printed;
>  
> diff --git a/tools/perf/trace/beauty/timespec.c b/tools/perf/trace/beauty/timespec.c
> index e1a61f092aad..b14ab72a2738 100644
> --- a/tools/perf/trace/beauty/timespec.c
> +++ b/tools/perf/trace/beauty/timespec.c
> @@ -7,7 +7,7 @@
>  
>  static size_t syscall_arg__scnprintf_augmented_timespec(struct syscall_arg *arg, char *bf, size_t size)
>  {
> -	struct timespec *ts = (struct timespec *)arg->augmented.args;
> +	struct timespec *ts = (struct timespec *)arg->augmented.args->value;
>  
>  	return scnprintf(bf, size, "{ .tv_sec: %" PRIu64 ", .tv_nsec: %" PRIu64 " }", ts->tv_sec, ts->tv_nsec);
>  }
> -- 
> 2.45.2
