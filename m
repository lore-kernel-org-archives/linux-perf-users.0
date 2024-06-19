Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FDB1E492;
	Wed, 19 Jun 2024 13:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718804664; cv=none; b=SWyysccYEJyLa972ZHdu+5k0dneX1c65NspsMo38hLattT/OKDbLerfF7UP32dNpporWahikOOhECDS3BLjZEB8hJtOAcw6G4u55zjf80WZdOUsBeK7fgPKW7XvgiPuICg9vPx1rW0d1YMCZ1jjKk7u6TE+joes2/CzGslVZ6Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718804664; c=relaxed/simple;
	bh=Wkexoc0cDdq8jJKOXWR0FU3hrNxUSmtW5T6O6D7F3Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mV7jZXVS+bwDoo/T0RL7LJg1YJXNy7vNt3mTmpC5AAbQfQqmElVbfNQGdr6/q7jnyjAGe4gvxgk90w8NsdYUXJZe2xBw5r1d+bXUyBVizXTkEP49baGR2315S9oxRUn8JW8P7AwRBtYrQGTZQWNM2yQu4o0xM1mI/NeKpJtWrGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObJ/Z1FC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObJ/Z1FC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA67C32781;
	Wed, 19 Jun 2024 13:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718804664;
	bh=Wkexoc0cDdq8jJKOXWR0FU3hrNxUSmtW5T6O6D7F3Yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ObJ/Z1FCQR6mn0JbTmkcT53fSUEgKgpO/D9aU5ce1jKEF+Ht6qH3Ut7hpkgNvs5aJ
	 Lzb54kmMWEcq9nQV9PqrReJMnFs6bgYfBCmAdHwVCtC+PJNXKfuH8ISGbnmmXoQBbj
	 spgVjR6ZGn6/O8kRGUsDfgmEevnk6IDLD3ZEtfSPYdg893QirSIF2tvW4EaoirFzPt
	 nrJWe29+ObJuD3GkkQ4WjymWrpDhWrh9UZkKNs4K6po8TQtqPR1z1Jk/dMrEeGGWZO
	 8IBXYfGk/Bk+Pwt+u/767WJFT3NXjEI2AsAmGF/0rWrfNlTmMsQVL6zx7e9BG7h92V
	 JqEpmWLZtGw/Q==
Date: Wed, 19 Jun 2024 10:44:18 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 2/5] perf trace: Augment enum syscall arguments with
 BTF
Message-ID: <ZnLgstTgrFRYu0aD@x1>
References: <20240619082042.4173621-1-howardchu95@gmail.com>
 <20240619082042.4173621-3-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240619082042.4173621-3-howardchu95@gmail.com>

On Wed, Jun 19, 2024 at 04:20:39PM +0800, Howard Chu wrote:
> This is a feature implemented on the basis of the previous bug fix
> https://lore.kernel.org/linux-perf-users/d18a9606-ac9f-4ca7-afaf-fcf4c951cb90@web.de/T/#t
> 
> In this patch, BTF is used to turn enum value to the corresponding
> enum variable name. There is only one system call that uses enum value
> as its argument, that is `landlock_add_rule()`.
> 
> The vmlinux btf is loaded lazily, when user decided to trace the
> `landlock_add_rule` syscall. But if one decides to run `perf trace`
> without any arguments, the behaviour is to trace `landlock_add_rule`,
> so vmlinux btf will be loaded by default.
> 
> before:
> 
> ```
> perf $ ./perf trace -e landlock_add_rule
>      0.000 ( 0.008 ms): ldlck-test/438194 landlock_add_rule(rule_type: 2)                                       = -1 EBADFD (File descriptor in bad state)
>      0.010 ( 0.001 ms): ldlck-test/438194 landlock_add_rule(rule_type: 1)                                       = -1 EBADFD (File descriptor in bad state)
> ```
> 
> after:
> 
> ```
> perf $ ./perf trace -e landlock_add_rule
>      0.000 ( 0.029 ms): ldlck-test/438194 landlock_add_rule(rule_type: LANDLOCK_RULE_NET_PORT)                  = -1 EBADFD (File descriptor in bad state)
>      0.036 ( 0.004 ms): ldlck-test/438194 landlock_add_rule(rule_type: LANDLOCK_RULE_PATH_BENEATH)              = -1 EBADFD (File descriptor in bad state)
> ```
> Tested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Reviewed-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/builtin-trace.c | 96 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 91 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index c4fa8191253d..d93f34e9af74 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -19,6 +19,7 @@
>  #ifdef HAVE_LIBBPF_SUPPORT
>  #include <bpf/bpf.h>
>  #include <bpf/libbpf.h>
> +#include <bpf/btf.h>
>  #ifdef HAVE_BPF_SKEL
>  #include "bpf_skel/augmented_raw_syscalls.skel.h"
>  #endif
> @@ -110,6 +111,11 @@ struct syscall_arg_fmt {
>  	const char *name;
>  	u16	   nr_entries; // for arrays
>  	bool	   show_zero;
> +	bool	   is_enum;
> +	struct {
> +		void	*entries;
> +		u16	nr_entries;
> +	}	   btf_entry;
>  };
>  
>  struct syscall_fmt {
> @@ -140,6 +146,7 @@ struct trace {
>  #ifdef HAVE_BPF_SKEL
>  	struct augmented_raw_syscalls_bpf *skel;
>  #endif
> +	struct btf		*btf;
>  	struct record_opts	opts;
>  	struct evlist	*evlist;
>  	struct machine		*host;
> @@ -897,6 +904,56 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
>  	    .strtoul	= STUL_STRARRAY_FLAGS, \
>  	    .parm	= &strarray__##array, }
>  
> +static int btf_enum_find_entry(struct btf *btf, char *type, struct syscall_arg_fmt *arg_fmt)
> +{
> +	const struct btf_type *bt;
> +	char enum_prefix[][16] = { "enum", "const enum" }, *ep;
> +	int id;
> +	size_t i;
> +
> +	for (i = 0; i < ARRAY_SIZE(enum_prefix); i++) {
> +		ep = enum_prefix[i];
> +		if (strlen(type) > strlen(ep) + 1 && strstarts(type, ep))

No need for the strlen test? I.e. plain using strstarts() should be
enough?

> +			type += strlen(ep) + 1;
> +	}
> +
> +	id = btf__find_by_name(btf, type);
> +	if (id < 0)
> +		return -1;
> +
> +	bt = btf__type_by_id(btf, id);
> +	if (bt == NULL)

a pr_debug() stating that something that tracefs says should be in BTF
and isn't found there seems to be of value here.

> +		return -1;
> +
> +	arg_fmt->btf_entry.entries    = btf_enum(bt);
> +	arg_fmt->btf_entry.nr_entries = btf_vlen(bt);
> +
> +	return 0;
> +}
> +
> +static size_t btf_enum_scnprintf(char *bf, size_t size, int val, struct btf *btf, char *type,
> +				 struct syscall_arg_fmt *arg_fmt)
> +{
> +	struct btf_enum *be;
> +	int i;
> +
> +	/* if btf_entry is NULL, find and save it to arg_fmt */
> +	if (arg_fmt->btf_entry.entries == NULL)
> +		if (btf_enum_find_entry(btf, type, arg_fmt))
> +			return 0;
> +
> +	be = (struct btf_enum *)arg_fmt->btf_entry.entries;

	struct btf_enum *be = (struct btf_enum *)arg_fmt->btf_entry.entries;

 arg_fmt->btf_entry.entries is (void *), so we don't need the (struct
btf_enum *) cast here, removing it makes the code more compact. And
since we move the declaration to the same line, the info about its type
is there as well.

> +
> +	for (i = 0; i < arg_fmt->btf_entry.nr_entries; ++i, ++be) {

         
	for (int i = 0; i < arg_fmt->btf_entry.nr_entries; ++i, ++be) {

⬢[acme@toolbox perf-tools-next]$ git grep 'for (int ' tools/perf/ | wc -l
99
⬢[acme@toolbox perf-tools-next]$

Doing it this way makes the code more compact and is allowed even in
kernel code since some time ago:

⬢[acme@toolbox perf-tools-next]$ git grep 'for (int ' drivers/ | wc -l
294
⬢[acme@toolbox perf-tools-next]$ git grep 'for (int ' kernel/ | wc -l
12
⬢[acme@toolbox perf-tools-next]$ git grep 'for (int ' net/ | wc -l
3
⬢[acme@toolbox perf-tools-next]$ git grep 'for (int ' mm/ | wc -l
21
⬢[acme@toolbox perf-tools-next]$

> +		if (be->val == val) {
> +			return scnprintf(bf, size, "%s",
> +					 btf__name_by_offset(btf, be->name_off));
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  #include "trace/beauty/arch_errno_names.c"
>  #include "trace/beauty/eventfd.c"
>  #include "trace/beauty/futex_op.c"
> @@ -1699,6 +1756,15 @@ static void trace__symbols__exit(struct trace *trace)
>  	symbol__exit();
>  }
>  
> +static void trace__load_vmlinux_btf(struct trace *trace)
> +{
> +	trace->btf = btf__load_vmlinux_btf();
> +	if (verbose > 0) {
> +		fprintf(trace->output, trace->btf ? "vmlinux BTF loaded\n" :
> +						    "Failed to load vmlinux BTF\n");
> +	}
> +}
> +
>  static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
>  {
>  	int idx;
> @@ -1744,7 +1810,7 @@ static const struct syscall_arg_fmt *syscall_arg_fmt__find_by_name(const char *n
>  }
>  
>  static struct tep_format_field *
> -syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field *field)
> +syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field *field, bool *use_btf)
>  {
>  	struct tep_format_field *last_field = NULL;
>  	int len;
> @@ -1782,6 +1848,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
>  			 * 7 unsigned long
>  			 */
>  			arg->scnprintf = SCA_FD;
> +		} else if (strstr(field->type, "enum") && use_btf != NULL) {
> +			*use_btf = arg->is_enum = true;

Here you have to check if use_btf is NULL, as you, in this patch, later
call syscall_arg_fmt__init_array(arg, field, NULL) in
evsel__init_tp_arg_scnprintf(), probably you tested it all at the end of
the patch series, we have to make sure that it works after each patch,
so that we keep the codebase bisectable.

>  		} else {
>  			const struct syscall_arg_fmt *fmt =
>  				syscall_arg_fmt__find_by_name(field->name);
> @@ -1796,9 +1864,10 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
>  	return last_field;
>  }
>  
> -static int syscall__set_arg_fmts(struct syscall *sc)
> +static int syscall__set_arg_fmts(struct syscall *sc, bool *use_btf)
>  {
> -	struct tep_format_field *last_field = syscall_arg_fmt__init_array(sc->arg_fmt, sc->args);
> +	struct tep_format_field *last_field = syscall_arg_fmt__init_array(sc->arg_fmt, sc->args,
> +									  use_btf);
>  
>  	if (last_field)
>  		sc->args_size = last_field->offset + last_field->size;
> @@ -1810,7 +1879,9 @@ static int trace__read_syscall_info(struct trace *trace, int id)
>  {
>  	char tp_name[128];
>  	struct syscall *sc;
> +	int err;
>  	const char *name = syscalltbl__name(trace->sctbl, id);
> +	bool use_btf = false;
>  
>  #ifdef HAVE_SYSCALL_TABLE_SUPPORT
>  	if (trace->syscalls.table == NULL) {
> @@ -1883,7 +1954,12 @@ static int trace__read_syscall_info(struct trace *trace, int id)
>  	sc->is_exit = !strcmp(name, "exit_group") || !strcmp(name, "exit");
>  	sc->is_open = !strcmp(name, "open") || !strcmp(name, "openat");
>  
> -	return syscall__set_arg_fmts(sc);
> +	err = syscall__set_arg_fmts(sc, &use_btf);
> +
> +	if (use_btf && trace->btf == NULL)
> +		trace__load_vmlinux_btf(trace);
> +
> +	return err;
>  }
>  
>  static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
> @@ -1891,7 +1967,7 @@ static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
>  	struct syscall_arg_fmt *fmt = evsel__syscall_arg_fmt(evsel);
>  
>  	if (fmt != NULL) {
> -		syscall_arg_fmt__init_array(fmt, evsel->tp_format->format.fields);
> +		syscall_arg_fmt__init_array(fmt, evsel->tp_format->format.fields, NULL);
>  		return 0;
>  	}
>  
> @@ -2103,6 +2179,16 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
>  			if (trace->show_arg_names)
>  				printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
>  
> +			if (sc->arg_fmt[arg.idx].is_enum && trace->btf) {
> +				size_t p = btf_enum_scnprintf(bf + printed, size - printed, val,
> +							      trace->btf, field->type,
> +							      &sc->arg_fmt[arg.idx]);
> +				if (p) {
> +					printed += p;
> +					continue;
> +				}
> +			}
> +
>  			printed += syscall_arg_fmt__scnprintf_val(&sc->arg_fmt[arg.idx],
>  								  bf + printed, size - printed, &arg, val);
>  		}
> -- 
> 2.45.2
> 
