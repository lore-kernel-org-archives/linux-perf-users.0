Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE0E2DF134;
	Thu, 24 Sep 2026 06:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232287; cv=none; b=b5OjB67XtqMfaeLtWQtJ06/3ujUjYMMZYvqnNIuKm3N8nXkoYJiS8YSvaILmcZ3uXxBWbU8Vqo3VGvOGeojslRLq53Q7Op85p9EXG0TIBymX2Sno/UxMmRUlosqG0R8AKw5K79wEN1sKqIIUUvi+R7/N3jQeqzkf+5onTQWt+mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232287; c=relaxed/simple;
	bh=2Vrpx6FQAADF/hE/WYTXvOWwXq1Uw5H2lTs2DXRwbU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uw5qFdwgh4mhSd2u0u6ZJ2GVM0e4aDkUS0VkbC1IBeypn6cT0BUjcEUTxvy0G6jf0yQytJjOFmUmL+AE/7bm4WRqaMyXlk/ni4F0z0yDDfq9HSh76rvxm6xofqVb5KBXB2rS0wM2KaykHASq3eDDYNLGO4M5ixR/NbkbQuV1u/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzhrPapE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzhrPapE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E431F000FF;
	Thu, 24 Sep 2026 06:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790232284;
	bh=ul5MT4Ptf1Xsxe5EqArkMJQ3+Cs5LMxQSlU1qr/Xp18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BzhrPapEUG/Rt7LJUP+Vxpnbb/F3Cipw1zjcQI3Wgk6ldvQk5012Y4y81sFQm7RF+
	 KngZFOoij8NpwxQaPSVZVrCWnPHKynkpAjBqG7rrh/kH2qy0/vWOrUAcIdXEQGI8+X
	 R3hW+k0LROazxZq5lTviIJ66zA69YzCFektqF3ohV0DlwIX7SBcXgfYcae7oPfZQ3l
	 pH1vF2YhBAP9SeD/nkaJOso+3yVx9KROqd5o3ZJTOVkQiGB0v4Iprkclnnm4gglKiC
	 IloY5fT4kV4XqJaEG6pbYHUAH0oezBe++Lx1pQ3PsMFe6U5tG5EvCHqtm5Kri/Z+AB
	 sfRG7vkgsstOw==
Date: Wed, 23 Sep 2026 23:44:42 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, howardchu95@gmail.com, adrian.hunter@intel.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v5 07/23] perf trace: Skip internal tracepoint fields in
 formatting and beauty map
Message-ID: <arTG2hd1H2ZH4Nl0@z2>
References: <cover.1790145937.git.irogers@google.com>
 <4315f435177b66e0b25ca9b74a89cc2f51d3801d.1790145937.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4315f435177b66e0b25ca9b74a89cc2f51d3801d.1790145937.git.irogers@google.com>

On Wed, Sep 23, 2026 at 12:13:47AM -0700, Ian Rogers wrote:
> Linux 6.19+ added __data_loc char[] internal fields for string
> arguments in syscalls:sys_enter_<name> tracepoints (e.g.,
> __data_loc_oldname in sys_enter_renameat2). While is_internal_field()
> was added to detect them, several places did not properly account for
> them:
> 
> 1. In syscall_arg_fmt__init_array(), when an internal field was
>    skipped, the arg pointer was still incremented, causing the
>    subsequent argument formatters to be mismatched. Leaving the slot out
>    is only right for syscall tracepoints, where syscall__scnprintf_args()
>    indexes the array the same packed way and sc->nr_args is counted to
>    match. Every other tracepoint reaches the array through
>    trace__fprintf_tp_fields(), which advances the field list and the
>    array in lockstep, and for those a __data_loc char[] is an ordinary
>    dynamic string to be shown rather than something the kernel appended
>    to a syscall behind perf's back. Add a skip_internal argument so that
>    each caller gets the layout it indexes.
> 2. In syscall__scnprintf_args(), internal fields were not skipped,
>    causing spurious trailing arguments like ", 0, 16" to be formatted
>    and printed.
> 3. In trace__bpf_sys_enter_beauty_map(), internal fields were not
>    skipped, offsetting beauty array argument indices and breaking string
>    and buffer augmentation.
> 4. In trace__find_usable_bpf_prog_entry(), candidate pointer checks
>    matched on internal pointer fields, breaking signature compatibility
>    matching between syscalls for augmenter sharing. Introduce
>    next_user_arg() and advance both cursors with it, so that the two
>    argument lists are always compared at a real argument and the walk
>    ends when one syscall runs out of arguments rather than when one
>    happens to have trailing internal fields.
> 5. syscall__augmented_args() computed the augmented payload as
>    sample->raw_size - sc->args_size for any sys_enter style sample.
>    sc->args_size deliberately stops at the last non-internal field, so
>    on 6.19+ a native syscalls:sys_enter_<name> record leaves the
>    __data_loc words and their string payloads in the remainder. Those
>    bytes are not a struct augmented_arg, so
>    syscall_arg__scnprintf_augmented_string() read a bogus length and
>    walked arg->augmented.args out of bounds. This is reachable from
>    trace__event_handler(), which calls trace__fprintf_sys_enter() for
>    any evsel whose tracepoint name starts with "sys_enter_".
> 6. In syscall__read_info(), syscall__alloc_arg_fmts() was called before
>    checking and dropping the leading __syscall_nr (or nr) field, using
>    nr_fields - 1 unconditionally. If a tracepoint format lacks that
>    leading field, the allocated arg_fmt array is one entry too small and
>    syscall_arg_fmt__init_array() writes one entry past the end of the
>    heap buffer. Drop __syscall_nr/nr first and size the allocation from
>    the remaining fields.
> 
> Update these functions to check and skip is_internal_field() so that
> arguments are correctly formatted and beauty map entries match the
> expected syscall signatures, restrict syscall__augmented_args() to the
> __augmented_syscalls__ bpf-output evsel, and size arg_fmt after dropping
> the syscall number field.
> 
> Publish sc->args only once that allocation has succeeded. sc->name is
> set earlier in syscall__read_info(), and a later call takes a syscall
> with a name to have been read already and returns it as it stands, so
> a syscall left with arguments and no arg_fmt to describe them would be
> printed by walking the arguments and indexing an array that was never
> allocated.
> 
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-trace.c | 194 ++++++++++++++++++++++++++++---------
>  1 file changed, 148 insertions(+), 46 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index f90c6bb4d8b4..6ffd4a0718ca 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2276,22 +2276,40 @@ static bool field_is_ptr_sized(const struct tep_format_field *field)
>  	return field->size == ptr_size || field->size == sizeof(u64);
>  }
>  
> +/*
> + * @skip_internal: whether an internal field is left out of the array rather
> + * than given a slot of its own.
> + *
> + * Syscall tracepoints want it left out, as syscall__scnprintf_args() walks the
> + * array with an index that skips internal fields too and sc->nr_args is counted
> + * the same way.
> + *
> + * Other tracepoints do not: trace__fprintf_tp_fields() advances the field list
> + * and this array in lockstep, so every field needs a slot or the fields after
> + * an internal one are formatted with the wrong entry. For them a
> + * __data_loc char[] is also an ordinary dynamic string to be shown, rather than
> + * something the kernel appended to a syscall tracepoint behind perf's back.
> + */

Isn't it only called for syscall tracepoints?


>  static struct tep_format_field *
>  syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field *field,
> -			    bool *use_btf)
> +			    bool *use_btf, bool skip_internal)
>  {
>  	struct tep_format_field *last_field = NULL;
>  	int len;
>  
> -	for (; field; field = field->next, ++arg) {
> -		/* assume it's the last argument */
> -		if (is_internal_field(field))
> +	for (; field; field = field->next) {
> +		if (is_internal_field(field)) {
> +			if (!skip_internal)
> +				++arg;
>  			continue;

If so, it'd be much simpler if we do s/continue/break/ instead. :)


> +		}
>  
>  		last_field = field;
>  
> -		if (arg->scnprintf)
> +		if (arg->scnprintf) {
> +			++arg;
>  			continue;
> +		}
>  
>  		len = strlen(field->name);
>  
> @@ -2348,6 +2366,7 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
>  				}
>  			}
>  		}
> +		++arg;
>  	}
>  
>  	return last_field;
> @@ -2356,7 +2375,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
>  static int syscall__set_arg_fmts(struct syscall *sc)
>  {
>  	struct tep_format_field *last_field = syscall_arg_fmt__init_array(sc->arg_fmt, sc->args,
> -									  &sc->use_btf);
> +									  &sc->use_btf,
> +									  /*skip_internal=*/true);
>  
>  	if (last_field)
>  		sc->args_size = last_field->offset + last_field->size;
> @@ -2368,7 +2388,8 @@ static int syscall__read_info(struct syscall *sc, struct trace *trace)
>  {
>  	char tp_name[128];
>  	const char *name;
> -	struct tep_format_field *field;
> +	struct tep_format_field *args, *field;
> +	int nr_args;
>  	int err;
>  
>  	if (sc->nonexistent)
> @@ -2407,24 +2428,35 @@ static int syscall__read_info(struct syscall *sc, struct trace *trace)
>  		return err;
>  	}
>  
> -	/*
> -	 * The tracepoint format contains __syscall_nr field, so it's one more
> -	 * than the actual number of syscall arguments.
> -	 */
> -	if (syscall__alloc_arg_fmts(sc, sc->tp_format->format.nr_fields - 1))
> -		return -ENOMEM;
> -
> -	sc->args = sc->tp_format->format.fields;
> +	args = sc->tp_format->format.fields;
> +	nr_args = sc->tp_format->format.nr_fields;
>  	/*
>  	 * We need to check and discard the first variable '__syscall_nr'
>  	 * or 'nr' that mean the syscall number. It is needless here.
>  	 * So drop '__syscall_nr' or 'nr' field but does not exist on older kernels.
> +	 *
> +	 * Do this before allocating, and size the array from what is left, so
> +	 * that a format without the field does not leave
> +	 * syscall_arg_fmt__init_array() walking one entry past the end.
>  	 */
> -	if (sc->args && (!strcmp(sc->args->name, "__syscall_nr") || !strcmp(sc->args->name, "nr"))) {
> -		sc->args = sc->args->next;
> -		--sc->nr_args;
> +	if (args && (!strcmp(args->name, "__syscall_nr") || !strcmp(args->name, "nr"))) {
> +		args = args->next;
> +		--nr_args;
>  	}
>  
> +	if (syscall__alloc_arg_fmts(sc, nr_args))
> +		return -ENOMEM;
> +
> +	/*
> +	 * Only now that there is an arg_fmt for each of them are the arguments
> +	 * published. sc->name was set above, so a later syscall__read_info()
> +	 * takes this syscall to be read already and returns it as it stands;
> +	 * were sc->args set with sc->arg_fmt still NULL, the printing of that
> +	 * syscall would walk the arguments and index an array that does not
> +	 * exist.
> +	 */
> +	sc->args = args;
> +

I think it's better to split this change.  It looks independent to the
skip-internal-fields.

>  	field = sc->args;
>  	while (field) {
>  		if (is_internal_field(field))
> @@ -2452,7 +2484,8 @@ static int evsel__init_tp_arg_scnprintf(struct evsel *evsel, bool *use_btf)
>  		const struct tep_event *tp_format = evsel__tp_format(evsel);
>  
>  		if (tp_format) {
> -			syscall_arg_fmt__init_array(fmt, tp_format->format.fields, use_btf);
> +			syscall_arg_fmt__init_array(fmt, tp_format->format.fields, use_btf,
> +						    /*skip_internal=*/false);
>  			return 0;
>  		}
>  	}
> @@ -2642,10 +2675,16 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
>  	if (sc->args != NULL) {
>  		struct tep_format_field *field;
>  
> -		for (field = sc->args; field;
> -		     field = field->next, ++arg.idx, bit <<= 1) {
> -			if (arg.mask & bit)
> +		for (field = sc->args; field; field = field->next) {
> +			/* Skip internal fields so they are not printed as spurious arguments */
> +			if (is_internal_field(field))
> +				continue;

Similarly, it can stop when it's an internal field or arg.idx equals to
sc->nr_args.


> +
> +			if (arg.mask & bit) {
> +				++arg.idx;
> +				bit <<= 1;
>  				continue;
> +			}
>  
>  			arg.fmt = &sc->arg_fmt[arg.idx];
>  			val = syscall_arg__val(&arg, arg.idx);
> @@ -2664,8 +2703,11 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
>  			 */
>  			if (val == 0 && !trace->show_zeros &&
>  			    !(sc->arg_fmt && sc->arg_fmt[arg.idx].show_zero) &&
> -			    !(sc->arg_fmt && sc->arg_fmt[arg.idx].strtoul == STUL_BTF_TYPE))
> +			    !(sc->arg_fmt && sc->arg_fmt[arg.idx].strtoul == STUL_BTF_TYPE)) {
> +				++arg.idx;
> +				bit <<= 1;
>  				continue;
> +			}
>  
>  			printed += scnprintf(bf + printed, size - printed, "%s", printed ? ", " : "");
>  
> @@ -2680,12 +2722,16 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
>  								   size - printed, val, field->type);
>  				if (btf_printed) {
>  					printed += btf_printed;
> +					++arg.idx;
> +					bit <<= 1;
>  					continue;
>  				}
>  			}
>  
>  			printed += syscall_arg_fmt__scnprintf_val(&sc->arg_fmt[arg.idx],
>  								  bf + printed, size - printed, &arg, val);
> +			++arg.idx;
> +			bit <<= 1;
>  		}
>  	} else if (IS_ERR(sc->tp_format)) {
>  		/*
> @@ -2946,7 +2992,9 @@ static int trace__fprintf_sample(struct trace *trace, struct perf_sample *sample
>  	return printed;
>  }
>  
> -static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sample, int *augmented_args_size, int raw_augmented_args_size)
> +static void *syscall__augmented_args(struct trace *trace, struct syscall *sc,
> +				     struct perf_sample *sample,
> +				     int *augmented_args_size, int raw_augmented_args_size)
>  {
>  	/*
>  	 * For now with BPF raw_augmented we hook into raw_syscalls:sys_enter
> @@ -2964,6 +3012,24 @@ static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sam
>  	 */
>  	int args_size = raw_augmented_args_size ?: sc->args_size;
>  
> +	/*
> +	 * Augmented arguments are a perf trace specific payload, they are only
> +	 * ever appended to samples emitted by the BPF __augmented_syscalls__
> +	 * bpf-output event.
> +	 *
> +	 * Native syscalls:sys_enter_NAME tracepoints may also carry trailing
> +	 * data of their own: since Linux 6.19 they append __data_loc char[]
> +	 * fields plus the string payloads they point at. Those bytes are not a
> +	 * struct augmented_arg, so treating them as one would make
> +	 * syscall_arg__scnprintf_augmented_string() read a bogus length and
> +	 * walk arg->augmented.args far out of bounds.
> +	 *
> +	 * So only look for augmented arguments on the event that can actually
> +	 * produce them.
> +	 */
> +	if (sample->evsel != trace->syscalls.events.bpf_output)
> +		return NULL;
> +
>  	*augmented_args_size = sample->raw_size - args_size;
>  	if (*augmented_args_size > 0) {
>  		static uintptr_t argbuf[1024]; /* assuming single-threaded */
> @@ -3022,17 +3088,13 @@ static int trace__sys_enter(struct trace *trace,
>  	if (!(trace->duration_filter || trace->summary_only || trace->min_stack))
>  		trace__printf_interrupted_entry(trace);
>  	/*
> -	 * If this is raw_syscalls.sys_enter, then it always comes with the 6 possible
> -	 * arguments, even if the syscall being handled, say "openat", uses only 4 arguments
> -	 * this breaks syscall__augmented_args() check for augmented args, as we calculate
> -	 * syscall->args_size using each syscalls:sys_enter_NAME tracefs format file,
> -	 * so when handling, say the openat syscall, we end up getting 6 args for the
> -	 * raw_syscalls:sys_enter event, when we expected just 4, we end up mistakenly
> -	 * thinking that the extra 2 u64 args are the augmented filename, so just check
> -	 * here and avoid using augmented syscalls when the evsel is the raw_syscalls one.
> +	 * syscall__augmented_args() only returns a payload for the BPF
> +	 * __augmented_syscalls__ event, so raw_syscalls:sys_enter (which always
> +	 * carries all 6 possible arguments rather than sc->args_size worth) and
> +	 * the native syscalls:sys_enter_NAME tracepoints are both handled there.
>  	 */
> -	if (evsel != trace->syscalls.events.sys_enter)
> -		augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls_args_size);

Looks like an independent fix too.


> +	augmented_args = syscall__augmented_args(trace, sc, sample, &augmented_args_size,
> +						 trace->raw_augmented_syscalls_args_size);
>  	ttrace->entry_time = sample->time;
>  	ttrace->entry_cpu = sample->cpu;
>  	msg = ttrace->entry_str;
> @@ -3077,7 +3139,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct perf_sample *sam
>  	struct syscall *sc;
>  	char msg[1024];
>  	void *args, *augmented_args = NULL;
> -	int augmented_args_size, e_machine;
> +	int augmented_args_size = 0, e_machine;
>  	size_t printed = 0;
>  
>  
> @@ -3095,7 +3157,8 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct perf_sample *sam
>  		goto out_put;
>  
>  	args = perf_evsel__sc_tp_ptr(args, sample);
> -	augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls_args_size);
> +	augmented_args = syscall__augmented_args(trace, sc, sample, &augmented_args_size,
> +						 trace->raw_augmented_syscalls_args_size);
>  	printed += syscall__scnprintf_args(sc, msg, sizeof(msg), args, augmented_args, augmented_args_size, trace, thread);
>  	fprintf(trace->output, "%.*s", (int)printed, msg);
>  	err = 0;
> @@ -4127,10 +4190,16 @@ static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, i
>  	if (trace->btf == NULL)
>  		return -1;
>  
> -	for (i = 0, field = sc->args; field; ++i, field = field->next) {
> +	for (i = 0, field = sc->args; field; field = field->next) {
> +		/* Skip internal fields to keep beauty array index aligned with syscall arguments */
> +		if (is_internal_field(field))
> +			continue;

Ditto.  Please just break.


> +
>  		// XXX We're only collecting pointer payloads _from_ user space
> -		if (!sc->arg_fmt[i].from_user)
> +		if (!sc->arg_fmt[i].from_user) {
> +			++i;
>  			continue;
> +		}
>  
>  		struct_offset = strstr(field->type, "struct ");
>  		if (struct_offset == NULL)
> @@ -4149,8 +4218,10 @@ static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, i
>  			name[cnt] = '\0';
>  
>  			/* cache struct's btf_type and type_id */
> -			if (syscall_arg_fmt__cache_btf_struct(&sc->arg_fmt[i], trace->btf, name))
> +			if (syscall_arg_fmt__cache_btf_struct(&sc->arg_fmt[i], trace->btf, name)) {
> +				++i;
>  				continue;
> +			}
>  
>  			bt = sc->arg_fmt[i].type;
>  			beauty_array[i] = bt->size;
> @@ -4176,7 +4247,9 @@ static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, i
>  			struct tep_format_field *field_tmp;
>  
>  			/* find the size of the buffer that appears in pairs with buf */
> -			for (j = 0, field_tmp = sc->args; field_tmp; ++j, field_tmp = field_tmp->next) {
> +			for (j = 0, field_tmp = sc->args; field_tmp; field_tmp = field_tmp->next) {
> +				if (is_internal_field(field_tmp))
> +					continue;
>  				if (!(field_tmp->flags & TEP_FIELD_IS_POINTER) && /* only integers */
>  				    (strstr(field_tmp->name, "count") ||
>  				     strstr(field_tmp->name, "siz") ||  /* size, bufsiz */
> @@ -4186,8 +4259,10 @@ static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, i
>  					can_augment = true;
>  					break;
>  				}
> +				++j;
>  			}
>  		}
> +		++i;
>  	}
>  
>  	if (can_augment)
> @@ -4196,6 +4271,19 @@ static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, i
>  	return -1;
>  }
>  
> +/*
> + * Advance to the first field that is a real syscall argument, so that callers
> + * walking two argument lists in step never have to reason about internal
> + * fields appearing in one list but not the other.
> + */
> +static struct tep_format_field *next_user_arg(struct tep_format_field *field)
> +{
> +	while (field && is_internal_field(field))
> +		field = field->next;
> +
> +	return field;
> +}

I don't think it's necessary.  The internal arguments come at the end.
Just stopping at an internal field or counting number of args would be
simpler.

Thanks,
Namhyung


> +
>  static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace,
>  							     struct syscall *sc)
>  {
> @@ -4203,7 +4291,7 @@ static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace
>  	/*
>  	 * We're only interested in syscalls that have a pointer:
>  	 */
> -	for (field = sc->args; field; field = field->next) {
> +	for (field = next_user_arg(sc->args); field; field = next_user_arg(field->next)) {
>  		if (field->flags & TEP_FIELD_IS_POINTER)
>  			goto try_to_find_pair;
>  	}
> @@ -4221,21 +4309,31 @@ static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace
>  		    pair->bpf_prog.sys_enter == unaugmented_prog)
>  			continue;
>  
> -		for (field = sc->args, candidate_field = pair->args;
> -		     field && candidate_field; field = field->next, candidate_field = candidate_field->next) {
> +		/*
> +		 * Both cursors only ever point at real arguments, so the loop
> +		 * ends when one of the two syscalls runs out of them, rather
> +		 * than when one happens to have trailing internal fields.
> +		 */
> +		field = next_user_arg(sc->args);
> +		candidate_field = next_user_arg(pair->args);
> +		while (field && candidate_field) {
>  			bool is_pointer = field->flags & TEP_FIELD_IS_POINTER,
>  			     candidate_is_pointer = candidate_field->flags & TEP_FIELD_IS_POINTER;
>  
>  			if (is_pointer) {
> -			       if (!candidate_is_pointer) {
> +				if (!candidate_is_pointer) {
>  					// The candidate just doesn't copies our pointer arg, might copy other pointers we want.
> +					field = next_user_arg(field->next);
> +					candidate_field = next_user_arg(candidate_field->next);
>  					continue;
> -			       }
> +				}
>  			} else {
>  				if (candidate_is_pointer) {
>  					// The candidate might copy a pointer we don't have, skip it.
>  					goto next_candidate;
>  				}
> +				field = next_user_arg(field->next);
> +				candidate_field = next_user_arg(candidate_field->next);
>  				continue;
>  			}
>  
> @@ -4256,6 +4354,8 @@ static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace
>  				goto next_candidate;
>  
>  			is_candidate = true;
> +			field = next_user_arg(field->next);
> +			candidate_field = next_user_arg(candidate_field->next);
>  		}
>  
>  		if (!is_candidate)
> @@ -4267,7 +4367,9 @@ static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace
>  		 * more than what is common to the two syscalls.
>  		 */
>  		if (candidate_field) {
> -			for (candidate_field = candidate_field->next; candidate_field; candidate_field = candidate_field->next)
> +			candidate_field = next_user_arg(candidate_field->next);
> +			for (; candidate_field;
> +			     candidate_field = next_user_arg(candidate_field->next))
>  				if (candidate_field->flags & TEP_FIELD_IS_POINTER)
>  					goto next_candidate;
>  		}
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 
