Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02525339395
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 03:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792292417; cv=none; b=k6tKyMbM1mRxuAKnvn3ldDZscmUj3NevnLuxfyjZlKA0hKGq/C78GFfxkV/gN7FdwLi6/em+zqStoeH+ZikLvtrMibEiD66sCN0CUDjg3DkfsLSOE+N6Dv3TmOgNaHJlEXb4rvWsXxZi0IeMEIwr0VurDzdKsyV/5l3vuQyKbtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792292417; c=relaxed/simple;
	bh=2nP5TPsNYTOK56jNseuQawFotI3MmwAPcuDVPxZauwE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=sKzlqlJuPwktg2EyP0d+hEA2UxI2cgfoL7Rw/KF2GdHqwjRVb2OTwtjK+8lsXyewZqXetPFW2JFiU1AKc6JISfpmB27HMnpBARJkJTW+zvxw3gT6w4rtZCs7vKYAgTQOd+if2q3Wz2NN9SAdDNmEoIErytJFhpfqyy2wvTXtuKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8lBC6G6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8lBC6G6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4129C1F000C4;
	Sun, 18 Oct 2026 03:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792292415;
	bh=5SaB7O8cA6ldc7QANa4Ik/rwID5WaWG+CZkBZYrm2Jg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a8lBC6G67UKh8H6xeRBSogcKN+5Ao24F12OEt+TFse3HD3gmesF6CqiKtdyH9CRDK
	 bXdptbLQL7zAP4Sp/h/uBwJ5PZt+4CTzfimJan2DxGPM7lerhkuF45plduqBhp+7Eu
	 hq3VUI2advORogJZecVSC0+AqvVjpYqG7tFbDvdHB/yMhcCxjBfnCcUsbUfXKv5Xmo
	 2yfECxBcTM76gcA3/KUWnlUf7yXEA4GWE+WMruOxixc7UEnzkARQmaM1TZzL5Ib5WN
	 dG0iAUdQtBgA8CFIWBeF1sAHWyCAyMOsDUXN3ff1vTmYFN/+1wau8Zv5mE/KUuxVm1
	 XpLYQCtaEGBlA==
Message-ID: <sashiko-outbox-175899@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v8 4/6] perf ftrace: Support display of
 inlined functions in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261018023753.584873-5-atomlin@atomlin.com>
References: <20261018023753.584873-1-atomlin@atomlin.com>
 <20261018023753.584873-5-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 03:00:14 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Medium] perf ftrace: find_func_column() misses latency-format column in =
verbose mode
- [Medium] perf ftrace: select_tracer() overrides function_graph tracer wit=
h --inline
- [Medium] perf ftrace: idle tasks across CPUs share a single ftrace_task_s=
tate
- [Medium] perf ftrace: perf_ftrace__setup_inlines() ignores vmlinux load f=
ailures
- [Medium] perf test ftrace: test_inline_processing() hardcodes build-speci=
fic offset
--

commit a1b712dfdc11c697976e8ccf628bd22443d5d421
Author: Aaron Tomlin <atomlin@atomlin.com>

perf ftrace: Support display of inlined functions in function graph tracer

This commit introduces the --inline option to perf ftrace to resolve caller
return addresses via DWARF debug information in vmlinux and synthesize
inlined function frames into the function_graph call stream. It also adds p=
er-
task call stack tracking, the -k/--vmlinux option, and unit tests in
tools/perf/tests/ftrace.c.

> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index c715cbebaabe9..cdacf5af14a65 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c

[ ... ]

> @@ -1973,6 +1991,20 @@ int cmd_ftrace(int argc, const char **argv)
> =20
>  	switch (subcmd) {
>  	case PERF_FTRACE_TRACE:
> +		if (ftrace.use_inline) {
> +			if (ftrace.tracer && strcmp(ftrace.tracer, "function_graph") !=3D 0) {
> +				pr_err("Error: --inline option is only supported with function_graph=
 tracer\n");
> +				ret =3D -EINVAL;
> +				goto out_delete_filters;
> +			}
> +			ftrace.tracer =3D "function_graph";
> +		}

[Severity: Medium]
Can select_tracer() override ftrace.tracer back to "function" after this
check runs?

In cmd_ftrace(), ftrace.tracer defaults to DEFAULT_TRACER ("function_graph"=
),
so running perf ftrace -T <func> --inline (or -N <func> --inline) passes th=
is
validation. However, when __cmd_ftrace() starts, it calls select_tracer():

tools/perf/builtin-ftrace.c:select_tracer() {
	bool graph =3D !list_empty(&ftrace->graph_funcs) ||
		     !list_empty(&ftrace->nograph_funcs);
	bool func =3D !list_empty(&ftrace->filters) ||
		    !list_empty(&ftrace->notrace);

	/* The function_graph has priority over function tracer. */
	if (graph)
		ftrace->tracer =3D "function_graph";
	else if (func)
		ftrace->tracer =3D "function";
    ...
}

Because filters or notrace is non-empty and graph_funcs/nograph_funcs are
empty, select_tracer() overwrites ftrace->tracer to "function", causing
__cmd_ftrace() to configure the function tracer while feeding its output in=
to
ftrace_process_fgraph_line(). Conversely, if ftrace.tracer is set to
"function" in perfconfig and the user runs perf ftrace -G <func> --inline,
cmd_ftrace() rejects it before select_tracer() can select "function_graph".

Should the --inline tracer check or enforcement happen in integration with
select_tracer()?

> diff --git a/tools/perf/tests/ftrace.c b/tools/perf/tests/ftrace.c
> index 596cecee844e3..6e20a61860a9e 100644
> --- a/tools/perf/tests/ftrace.c
> +++ b/tools/perf/tests/ftrace.c
> @@ -62,6 +66,465 @@ static int test_filter_retaddr(void)
>  	return TEST_OK;
>  }
> =20
> +#define TEST_CHECK(text, cond)					\
> +do {								\
> +	if (!(cond)) {						\
> +		pr_debug("FAILED %s:%d %s\n", __FILE__, __LINE__, text); \
> +		ret =3D TEST_FAIL;				\
> +		goto out_cleanup;				\
> +	}							\
> +} while (0)
> +
> +static int test_inline_processing(void)
> +{
> +	static const char line_entry[] =3D " 0)               |  wake_up_new_ta=
sk() {";
> +	static const char line_enqueue[] =3D
> +		" 0)               |    enqueue_task() { /* <-wake_up_new_task+0x1d1/0=
x3e0 */";

[ ... ]

> +	vmlinux =3D vmlinux_path__find();
> +
> +	/* If vmlinux is present, test resolving symbols */
> +	if (vmlinux) {
> +		symbol_conf.vmlinux_name =3D vmlinux;
> +		symbol_conf.ignore_vmlinux_buildid =3D true;
> +		ret =3D perf_ftrace__setup_inlines(&ftrace);
> +		if (ret < 0 || !ftrace.machine) {
> +			ret =3D TEST_SKIP;
> +			goto out_cleanup;
> +		}
> +
> +		out =3D open_memstream(&out_buf, &out_len);
> +		if (!out) {
> +			ret =3D TEST_FAIL;
> +			goto out_cleanup;
> +		}
> +
> +		/* Feed simulated function graph trace lines */
> +		ftrace_process_fgraph_line(&ftrace, line_entry, out);
> +		ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
> +		ftrace_process_fgraph_line(&ftrace, line_exit_enqueue, out);
> +		ftrace_process_fgraph_line(&ftrace, line_exit_task, out);
> +
> +		fclose(out);
> +		ftrace_cpu_states__clear();
> +
> +		pr_debug("Processed output:\n%s\n", out_buf);
> +
> +		/* Verify activate_task entry with inline hint */
> +		TEST_CHECK("contains activate_task entry with inline hint",
> +			   strstr(out_buf, "activate_task() { /* (inline) */") !=3D NULL);

[Severity: Medium]
Will test_inline_processing() fail on systems where the host vmlinux does n=
ot
have an inlined activate_task() call specifically at wake_up_new_task+0x1d1?

When vmlinux_path__find() finds a host vmlinux file, the test feeds
line_enqueue with the hardcoded offset wake_up_new_task+0x1d1/0x3e0 and
requires DWARF resolution to produce "activate_task() { /* (inline) */". Be=
cause
the instruction offset +0x1d1 (and whether activate_task is inlined) depends
on the architecture, compiler, optimization flags, and kernel configuration,
as well as DWARF support in both vmlinux and the perf build, this check will
return TEST_FAIL on other kernel builds.

Also, symbol_conf.vmlinux_name and symbol_conf.ignore_vmlinux_buildid are
modified here without being restored in out_cleanup.

> diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
> index aaf108369c365..020551a4d7e00 100644
> --- a/tools/perf/util/ftrace.c
> +++ b/tools/perf/util/ftrace.c

[ ... ]

> +static bool parse_context_switch(const char *line)
> +{
> +	const char *arrow =3D strstr(line, " =3D> ");
> +	const char *p;
> +	const char *next;
> +	const char *hyphen;
> +	char *endptr;
> +	long cpu_val;
> +	long pid_val;
> +
> +	if (!arrow)
> +		return false;
> +
> +	/* Find CPU number before ')' */
> +	p =3D skip_spaces(line);
> +	cpu_val =3D strtol(p, &endptr, 10);
> +	if (endptr =3D=3D p || *endptr !=3D ')')
> +		return false;
> +
> +	if (cpu_val < 0 || cpu_val >=3D FTRACE_MAX_CPUS)
> +		return false;
> +
> +	/* Parse the target task's PID after the arrow (" =3D> comm-pid") */
> +	next =3D skip_spaces(arrow + 4);
> +	hyphen =3D strrchr(next, '-');
> +	if (!hyphen)
> +		return false;
> +
> +	pid_val =3D strtol(hyphen + 1, &endptr, 10);
> +	if (endptr =3D=3D hyphen + 1)
> +		return false;
> +
> +	ftrace_cpu_tasks[cpu_val] =3D get_task_state((pid_t)pid_val);
> +	return true;
> +}

[Severity: Medium]
What happens in system-wide tracing when multiple CPUs switch to the idle
task (<idle>-0)?

Each CPU has its own swapper thread, all with PID 0, which ftrace formats as
"<idle>-0" in context-switch banners and in the verbose comm-pid column. Wh=
en
parse_context_switch() or find_func_column() sees "<idle>-0", pid_val is 0 =
and
get_task_state(0) returns the same struct ftrace_task_state instance for all
idle CPUs.

If multiple CPUs are executing in idle simultaneously, won't their interlea=
ved
trace lines share and corrupt the same stack, depth, and inlined_depth? (No=
te
that get_cpu_state() uses -1 - cpu before a banner is seen; should pid_val =
=3D=3D 0
similarly map to a per-CPU state such as -1 - cpu_val?)

[ ... ]

> +static void make_blank_prefix(const struct perf_ftrace *ftrace, const ch=
ar *line,
> +			      const char *pipe_char, char *buf, size_t size)
> +{
> +	size_t len =3D pipe_char - line + 1;
> +	const char *start_delim =3D NULL;
> +	char *c;
> +
> +	if (!size)
> +		return;
> +
> +	if (len >=3D size)
> +		len =3D size - 1;
> +
> +	memcpy(buf, line, len);
> +	buf[len] =3D '\0';
> +
> +	if (*pipe_char =3D=3D '|') {
> +		if (ftrace->graph_verbose) {
> +			/* In verbose mode, duration starts after the comm-pid '|' */
> +			for (const char *p =3D pipe_char - 1; p >=3D line; p--) {
> +				if (*p =3D=3D '|') {
> +					start_delim =3D p;
> +					break;
> +				}
> +			}
> +		} else {
> +			/* In default mode, duration starts after CPU ')' */
> +			start_delim =3D strchr(line, ')');
> +		}
> +
> +		if (start_delim && start_delim < pipe_char && start_delim < line + len=
) {
> +			char *end =3D buf + (pipe_char - line);
> +
> +			if (end > buf + len)
> +				end =3D buf + len;
> +			for (c =3D buf + (start_delim - line) + 1; c < end; c++)
> +				*c =3D ' ';
> +		}
> +	}
> +}
> +
> +/**
> + * find_func_column - Locate the function call column in a trace record
> + * @ftrace: Perf ftrace context
> + * @line: The trace record to parse
> + * @cpu: Pointer to store the CPU number
> + *
> + * Locate the context columns that precede the function call column of a
> + * function_graph trace record. Depending on the funcgraph-* options set
> + * up by perf, a record looks like:
> + *
> + *   [ abstime |]  CPU)  [ comm-pid |]  [ duration |]  func
> + *
> + * The abstime and comm-pid columns are only present with --graph-opts
> + * verbose.
> + *
> + * Return: A pointer to the last character of the context columns (the f=
inal
> + * '|' delimiter). Returns NULL if @line is not a trace record.
> + */
> +static const char *find_func_column(const struct perf_ftrace *ftrace,
> +				    const char *line, int *cpu)
> +{
> +	const char *p =3D line;
> +	char *endptr;
> +	long val;
> +
> +	if (ftrace->graph_verbose) {
> +		p =3D strchr(p, '|');
> +		if (!p)
> +			return NULL;
> +		p++;
> +	}
> +
> +	p =3D skip_spaces(p);
> +	val =3D strtol(p, &endptr, 10);
> +	if (endptr =3D=3D p || *endptr !=3D ')')
> +		return NULL;
> +	p =3D endptr;
> +
> +	if (ftrace->graph_verbose) {
> +		const char *proc_start =3D p;
> +
> +		p =3D strchr(p, '|');
> +		if (!p)
> +			return NULL;
> +
> +		if (val >=3D 0 && val < FTRACE_MAX_CPUS) {
> +			const char *h =3D p - 1;
> +
> +			while (h >=3D proc_start && *h !=3D '-')
> +				h--;
> +			if (h >=3D proc_start && *h =3D=3D '-') {
> +				long pid_val =3D strtol(h + 1, NULL, 10);
> +				ftrace_cpu_tasks[(int)val] =3D get_task_state((pid_t)pid_val);
> +			}
> +		}
> +	}
> +
> +	p =3D strchr(p + 1, '|');
> +	if (!p)
> +		return NULL;
> +
> +	*cpu =3D (int)val;
> +	return p;
> +}

[Severity: Medium]
Does find_func_column() account for the latency-format column when
ftrace->graph_verbose is enabled?

In tools/perf/builtin-ftrace.c, set_tracing_funcgraph_verbose() enables thr=
ee
tracing options:

static int set_tracing_funcgraph_verbose(struct perf_ftrace *ftrace)
{
	if (!ftrace->graph_verbose)
		return 0;

	if (write_tracing_option_file("funcgraph-proc", "1") < 0)
		return -1;

	if (write_tracing_option_file("funcgraph-abstime", "1") < 0)
		return -1;

	if (write_tracing_option_file("latency-format", "1") < 0)
		return -1;

	return 0;
}

When latency-format is enabled alongside funcgraph-abstime and funcgraph-pr=
oc,
the kernel's function_graph tracer emits four '|' delimiters before the
function column:

  <abstime> | <cpu>) <comm>-<pid> | <lat-fmt> | <duration> | <func>

However, find_func_column() only advances past three '|' characters in
verbose mode, returning a pointer to the '|' at the end of the latency-form=
at
column instead of the '|' at the end of the duration column.

Consequently, in ftrace_process_fgraph_line():
1. On entry lines with a blank duration column, func_start points to the
   duration column's trailing "|  func() {", so extract_entry_func_name()
   extracts "|" as the function name.
2. On exit lines with a duration (e.g. "  1.234 us    |  }"), func_start
   points to the duration value rather than '}', so is_exit is false and
   function exits are never detected.
3. make_blank_prefix() blanks out the latency-format column and truncates t=
he
   prefix before the duration column.

[ ... ]

> +int perf_ftrace__setup_inlines(struct perf_ftrace *ftrace)
> +{
> +	struct map *kmap;
> +
> +	if (!ftrace->use_inline)
> +		return 0;
> +
> +	symbol_conf.try_vmlinux_path =3D (symbol_conf.vmlinux_name =3D=3D NULL);
> +	symbol_conf.inline_name =3D true;
> +	if (symbol_conf.vmlinux_name)
> +		symbol_conf.ignore_vmlinux_buildid =3D true;
> +
> +	if (symbol__init(NULL) < 0) {
> +		pr_warning("Failed to initialize symbols for inlined functions\n");
> +		return -1;
> +	}
> +
> +	ftrace->machine =3D machine__new_host(NULL);
> +	if (!ftrace->machine) {
> +		pr_warning("Failed to create host machine for symbols\n");
> +		return -1;
> +	}
> +
> +	if (symbol_conf.vmlinux_name) {
> +		kmap =3D machine__kernel_map(ftrace->machine);
> +		if (kmap)
> +			dso__load_vmlinux(map__dso(kmap), kmap, symbol_conf.vmlinux_name, fal=
se);
> +	} else {
> +		machine__load_vmlinux_path(ftrace->machine);
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Should perf_ftrace__setup_inlines() check the return values of
dso__load_vmlinux() and machine__load_vmlinux_path()?

Both functions return <=3D 0 when loading vmlinux fails (for example, if the
user passes a non-existent or invalid path via -k/--vmlinux, or if no vmlin=
ux
with symbols is found on the system). Because the return values are ignored
and perf_ftrace__setup_inlines() unconditionally returns 0,perf ftrace
--inline proceeds without a loaded vmlinux DSO (and test_inline_processing()
does not skip when vmlinux cannot be loaded).

If loading fails, should perf_ftrace__setup_inlines() clean up ftrace->mach=
ine
and return an error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018023753.5848=
73-1-atomlin@atomlin.com?part=3D4
