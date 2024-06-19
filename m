Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86B114BFA8;
	Wed, 19 Jun 2024 13:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718804934; cv=none; b=joqdWzwtHZU2FiS+qxJS2/0aE2rF54184wD7MRzHEpP/GX7/mh3ftYmy700YMndm2izS+XkaMd+oB55H0LyL4Dsw/h2R+P0FfcxILauITHfubh+YltSQIU9ERgMMTdD7h9dc9Bjccr/AMNkI+cGZLG+TaSTv6sBByw+wWQROoxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718804934; c=relaxed/simple;
	bh=zvONC2ivYSEAmd1ggzzhSUmy2nTfsJ5Xeszr5tbZ9zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKLkoDOKp61LaUZOLZl2g4MTXpL5kH/CnkWWmKO8uolG9kLZLwWrODamtPYesj9OLEaRdTYG8gMPsFsJwqlmuukmS0ZuketXpsR3fra3EfiJJJA+J4QY//e2XH/3tCE9NurqqoW+9YXvohF/Y/5lMfwB9EUOYHdDfvrULpONsXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfnyIcSM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfnyIcSM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20BDC2BBFC;
	Wed, 19 Jun 2024 13:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718804933;
	bh=zvONC2ivYSEAmd1ggzzhSUmy2nTfsJ5Xeszr5tbZ9zY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dfnyIcSMkAjwIJ8CiAOT0NPZXdnVqAgj1TAyTsXdB8txybcZdlxi1E3rDLPdUydSD
	 faGLZp5fHR3hzxzGexfZ1LGPrhhLQdq46AeHSdhJMZWrF4w9RMF3YS6t3H2SujDBlE
	 3Ea7nh65S+4yegNQUsJzxeNPKrA279JEoseUiHQo1Q7/yfr5zxAVxBe7EOEcPacbvZ
	 EiQfTsqEXh+00iDWKBI+p54yLEWHsF3heT74trO3p4ggtCl3n3tyX17bBrXxAt39/f
	 HLbujvnWrUOjkpE/rDXP7uON0gbIgOP12ah5VL5PYRxVF86HfPtmdT1nDFL+mZqttr
	 6dQzFt0Uxj6QQ==
Date: Wed, 19 Jun 2024 10:48:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 4/5] perf trace: Filter enum arguments with enum names
Message-ID: <ZnLhwFuQvP59p1BJ@x1>
References: <20240619082042.4173621-1-howardchu95@gmail.com>
 <20240619082042.4173621-5-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619082042.4173621-5-howardchu95@gmail.com>

On Wed, Jun 19, 2024 at 04:20:41PM +0800, Howard Chu wrote:
> Before:
> 
> perf $ ./perf trace -e timer:hrtimer_start --filter='mode!=HRTIMER_MODE_ABS_PINNED_HARD' --max-events=1
> No resolver (strtoul) for "mode" in "timer:hrtimer_start", can't set filter "(mode!=HRTIMER_MODE_ABS_PINNED_HARD) && (common_pid != 281988)"
> 
> After:
> 
> perf $ ./perf trace -e timer:hrtimer_start --filter='mode!=HRTIMER_MODE_ABS_PINNED_HARD' --max-events=1
>      0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff9498a6ca5f18, function: 0xffffffffa77a5be0, expires: 12351248764875, softexpires: 12351248764875, mode: HRTIMER_MODE_ABS)
> 
> && and ||:
> 
> perf $ ./perf trace -e timer:hrtimer_start --filter='mode != HRTIMER_MODE_ABS_PINNED_HARD && mode != HRTIMER_MODE_ABS' --max-events=1
>      0.000 Hyprland/534 timer:hrtimer_start(hrtimer: 0xffff9497801a84d0, function: 0xffffffffc04cdbe0, expires: 12639434638458, softexpires: 12639433638458, mode: HRTIMER_MODE_REL)
> 
> perf $ ./perf trace -e timer:hrtimer_start --filter='mode == HRTIMER_MODE_REL || mode == HRTIMER_MODE_PINNED' --max-events=1
>      0.000 ldlck-test/60639 timer:hrtimer_start(hrtimer: 0xffffb16404ee7bf8, function: 0xffffffffa7790420, expires: 12772614418016, softexpires: 12772614368016, mode: HRTIMER_MODE_REL)
> 
> Switching it up, using both enum name and integer value(--filter='mode == HRTIMER_MODE_ABS_PINNED_HARD || mode == 0'):
> 
> perf $ ./perf trace -e timer:hrtimer_start --filter='mode == HRTIMER_MODE_ABS_PINNED_HARD || mode == 0' --max-events=3
>      0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff9498a6ca5f18, function: 0xffffffffa77a5be0, expires: 12601748739825, softexpires: 12601748739825, mode: HRTIMER_MODE_ABS_PINNED_HARD)
>      0.036 :0/0 timer:hrtimer_start(hrtimer: 0xffff9498a6ca5f18, function: 0xffffffffa77a5be0, expires: 12518758748124, softexpires: 12518758748124, mode: HRTIMER_MODE_ABS_PINNED_HARD)
>      0.172 tmux: server/41881 timer:hrtimer_start(hrtimer: 0xffffb164081e7838, function: 0xffffffffa7790420, expires: 12518768255836, softexpires: 12518768205836, mode: HRTIMER_MODE_ABS)
> 
> P.S.
> perf $ pahole hrtimer_mode
> enum hrtimer_mode {
>         HRTIMER_MODE_ABS             = 0,
>         HRTIMER_MODE_REL             = 1,
>         HRTIMER_MODE_PINNED          = 2,
>         HRTIMER_MODE_SOFT            = 4,
>         HRTIMER_MODE_HARD            = 8,
>         HRTIMER_MODE_ABS_PINNED      = 2,
>         HRTIMER_MODE_REL_PINNED      = 3,
>         HRTIMER_MODE_ABS_SOFT        = 4,
>         HRTIMER_MODE_REL_SOFT        = 5,
>         HRTIMER_MODE_ABS_PINNED_SOFT = 6,
>         HRTIMER_MODE_REL_PINNED_SOFT = 7,
>         HRTIMER_MODE_ABS_HARD        = 8,
>         HRTIMER_MODE_REL_HARD        = 9,
>         HRTIMER_MODE_ABS_PINNED_HARD = 10,
>         HRTIMER_MODE_REL_PINNED_HARD = 11,
> };
> 
> Tested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Reviewed-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/builtin-trace.c | 89 ++++++++++++++++++++++++++++++++------
>  1 file changed, 76 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index bd16679fb4c0..1148c3edee97 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -904,11 +904,36 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
>  	    .strtoul	= STUL_STRARRAY_FLAGS, \
>  	    .parm	= &strarray__##array, }
>  
> -static int btf_enum_find_entry(struct btf *btf, char *type, struct syscall_arg_fmt *arg_fmt)
> +#define SCA_GETRANDOM_FLAGS syscall_arg__scnprintf_getrandom_flags

The above seems unrelated? (The definition of SCA_GETRANDOM_FLAGS) as it
is not used in any other place in this patch, right?

- Arnaldo

> +
> +static const struct btf_type *btf_find_type(struct btf *btf, char *type)
>  {
>  	const struct btf_type *bt;
> +	int id = btf__find_by_name(btf, type);
> +
> +	if (id < 0)
> +		return NULL;
> +
> +	bt = btf__type_by_id(btf, id);
> +	if (bt == NULL)
> +		return NULL;
> +
> +	return bt;
> +}
> +
> +struct btf_parm {
> +	struct btf *btf;
> +	char *type;
> +};
> +
> +static bool syscall_arg__strtoul_btf_enum(char *bf, size_t size, struct syscall_arg *arg, u64 *val)
> +{
> +	struct btf_parm *bparm = arg->parm;
> +	struct btf *btf = bparm->btf;
> +	char *type      = bparm->type;
>  	char enum_prefix[][16] = { "enum", "const enum" }, *ep;
> -	int id;
> +	struct btf_enum *be;
> +	const struct btf_type *bt;
>  	size_t i;
>  
>  	for (i = 0; i < ARRAY_SIZE(enum_prefix); i++) {
> @@ -917,11 +942,38 @@ static int btf_enum_find_entry(struct btf *btf, char *type, struct syscall_arg_f
>  			type += strlen(ep) + 1;
>  	}
>  
> -	id = btf__find_by_name(btf, type);
> -	if (id < 0)
> -		return -1;
> +	bt = btf_find_type(btf, type);
> +	if (bt == NULL)
> +		return false;
>  
> -	bt = btf__type_by_id(btf, id);
> +	for (be = btf_enum(bt), i = 0; i < btf_vlen(bt); ++i, ++be) {
> +		const char *name = btf__name_by_offset(btf, be->name_off);
> +		int max_len = max(size, strlen(name));
> +
> +		if (strncmp(name, bf, max_len) == 0) {
> +			*val = be->val;
> +			return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +#define STUL_BTF_ENUM syscall_arg__strtoul_btf_enum
> +
> +static int btf_enum_find_entry(struct btf *btf, char *type, struct syscall_arg_fmt *arg_fmt)
> +{
> +	char enum_prefix[][16] = { "enum", "const enum" }, *ep;
> +	const struct btf_type *bt;
> +	size_t i;
> +
> +	for (i = 0; i < ARRAY_SIZE(enum_prefix); i++) {
> +		ep = enum_prefix[i];
> +		if (strlen(type) > strlen(ep) + 1 && strstarts(type, ep))
> +			type += strlen(ep) + 1;
> +	}
> +
> +	bt = btf_find_type(btf, type);
>  	if (bt == NULL)
>  		return -1;
>  
> @@ -1850,6 +1902,7 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
>  			arg->scnprintf = SCA_FD;
>  		} else if (strstr(field->type, "enum") && use_btf != NULL) {
>  			*use_btf = arg->is_enum = true;
> +			arg->strtoul = STUL_BTF_ENUM;
>  		} else {
>  			const struct syscall_arg_fmt *fmt =
>  				syscall_arg_fmt__find_by_name(field->name);
> @@ -3776,7 +3829,8 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
>  	return __trace__deliver_event(trace, event->event);
>  }
>  
> -static struct syscall_arg_fmt *evsel__find_syscall_arg_fmt_by_name(struct evsel *evsel, char *arg)
> +static struct syscall_arg_fmt *evsel__find_syscall_arg_fmt_by_name(struct evsel *evsel, char *arg,
> +								   char **type)
>  {
>  	struct tep_format_field *field;
>  	struct syscall_arg_fmt *fmt = __evsel__syscall_arg_fmt(evsel);
> @@ -3785,8 +3839,10 @@ static struct syscall_arg_fmt *evsel__find_syscall_arg_fmt_by_name(struct evsel
>  		return NULL;
>  
>  	for (field = evsel->tp_format->format.fields; field; field = field->next, ++fmt)
> -		if (strcmp(field->name, arg) == 0)
> +		if (strcmp(field->name, arg) == 0) {
> +			*type = field->type;
>  			return fmt;
> +		}
>  
>  	return NULL;
>  }
> @@ -3824,14 +3880,14 @@ static int trace__expand_filter(struct trace *trace __maybe_unused, struct evsel
>  			struct syscall_arg_fmt *fmt;
>  			int left_size = tok - left,
>  			    right_size = right_end - right;
> -			char arg[128];
> +			char arg[128], *type;
>  
>  			while (isspace(left[left_size - 1]))
>  				--left_size;
>  
>  			scnprintf(arg, sizeof(arg), "%.*s", left_size, left);
>  
> -			fmt = evsel__find_syscall_arg_fmt_by_name(evsel, arg);
> +			fmt = evsel__find_syscall_arg_fmt_by_name(evsel, arg, &type);
>  			if (fmt == NULL) {
>  				pr_err("\"%s\" not found in \"%s\", can't set filter \"%s\"\n",
>  				       arg, evsel->name, evsel->filter);
> @@ -3843,9 +3899,16 @@ static int trace__expand_filter(struct trace *trace __maybe_unused, struct evsel
>  
>  			if (fmt->strtoul) {
>  				u64 val;
> -				struct syscall_arg syscall_arg = {
> -					.parm = fmt->parm,
> -				};
> +				struct syscall_arg syscall_arg;
> +				struct btf_parm bparm;
> +
> +				if (fmt->is_enum) {
> +					bparm.btf  = trace->btf;
> +					bparm.type = type;
> +					syscall_arg.parm = &bparm;
> +				} else {
> +					syscall_arg.parm = fmt->parm;
> +				}
>  
>  				if (fmt->strtoul(right, right_size, &syscall_arg, &val)) {
>  					char *n, expansion[19];
> -- 
> 2.45.2
> 
