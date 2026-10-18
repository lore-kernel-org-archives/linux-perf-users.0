Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBE122D7A9
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 02:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792291885; cv=none; b=huaSyPMAPdNNU3NW3+kXshgkStRicR5TbNff11+vq0BdOW1Fgk/gwvwwNDKd+MjfrsgktbXspKXzdoURb0lFV3zOurSxtCyVK7bnO3AITxh3npo6h7rXhBV0GmRSbqE/uqbExmAp2xos6IlEhL+kr5h/fW42o24bCDCjZTWcUX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792291885; c=relaxed/simple;
	bh=vddCnHC66IqcduReXbUwRh/puBIiChGiuuYoq/YJpn8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=CFuqC/lMTu3mNfeM4NEwYDZnRqo2MgzrAchvBu9ONXwCGPA/OOwifeew2PDS9hlUHHBsq3nYJHM5xQyvPDn7IoK5GC7D+zFDEbJ0pI6xl5UfL24Wj+ISipebILSgfRxFvTaiTECDQBA7bMVhXpkBp9sn82aPKp4OtGLGvpwLG/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMzJRBJu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMzJRBJu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0A11F000CA;
	Sun, 18 Oct 2026 02:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792291883;
	bh=0EEtEOcsKKyCr3X57VoL6rFOLv82K/k4Ku+KDhI6Y7g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iMzJRBJuk61dyVa67QsIpe/4Osz64oIan/XPwlY1xwemY41bT6XxKu3wdKNpZGZjz
	 QZLJq1dGImnIXcFeEjxw1iEDk1YO7BComdH3DxefLp4VeFQYdT7CUOodxkOMorQJ0+
	 vXNZD2XsYLVOXSyK+k6GLnrCAbAab+0R/PGIw9ZruJL+A3NpwCNvjVe4sxSwUE4Fm2
	 RCjh27G0PSB37TGFztR2t+aLGm78y/EcWZFyx60P/PCw/EeGqdKnIDBpnb1dk9PUc/
	 BfhQY94QhTWlkCGngLKWcJ/Wv76jB5WA3mgj7E2UHsoESfOnwFtL85l5nb2tUjid75
	 fIFWQP98Vu72g==
Message-ID: <sashiko-outbox-175896@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v8 5/6] perf ftrace: Support omitting
 execution duration in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261018023753.584873-6-atomlin@atomlin.com>
References: <20261018023753.584873-1-atomlin@atomlin.com>
 <20261018023753.584873-6-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 02:51:23 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf ftrace: missing latency-format column handling in find_func=
_column()
- [Medium] perf ftrace: IRQ markers misparsed as functions in find_func_col=
umn()
--

commit 00347b16046d3c2aa23a7cbbe87ca2f63a2e9477
Author: Aaron Tomlin <atomlin@atomlin.com>

perf ftrace: Support omitting execution duration in function graph tracer

This commit adds the noduration sub-option under --graph-opts to omit
function execution duration in the function_graph tracer by setting the
kernel's funcgraph-duration option to 0. It also updates trace line
parsing for inline function synthesis and rejects using noduration with
perf ftrace profile.

> diff --git a/tools/perf/tests/ftrace.c b/tools/perf/tests/ftrace.c
> index 6e20a61860a9e..d83dee5a050dd 100644
> --- a/tools/perf/tests/ftrace.c
> +++ b/tools/perf/tests/ftrace.c

[ ... ]

> @@ -422,20 +461,36 @@ static int test_column_layouts(void)
>  {
>  	static const struct {
>  		const char *desc;
> -				bool verbose;
> +		bool noduration;
> +		bool verbose;
>  		const char *in;
>  		const char *expected;
>  	} cases[] =3D {
>  		{
> -			"default layout", false,
> +			"default layout", false, false,
>  			" 7)               |  wake_up_new_task() { /* <-kernel_clone+0x160/0x=
510 */",
>  			" 7)               |  wake_up_new_task() {\n",
>  		},
>  		{
> -			"verbose layout", true,
> +			"noduration layout", true, false,
> +			" 7)   housekeeping_any_cpu(); /* <-ring_buffer_unlock_commit+0x1a0/0=
x1f0 */",
> +			" 7)   housekeeping_any_cpu();\n",
> +		},
> +		{
> +			"verbose layout", false, true,
>  			" 1234.567890 |   7)   bash-1234    |               |  wake_up_new_ta=
sk() { /* <-kernel_clone+0x160/0x510 */",
>  			" 1234.567890 |   7)   bash-1234    |               |  wake_up_new_ta=
sk() {\n",
>  		},
> +		{
> +			"verbose noduration layout", true, true,
> +			" 1234.567890 |   7)   bash-1234    |  wake_up_new_task() { /* <-kern=
el_clone+0x160/0x510 */",
> +			" 1234.567890 |   7)   bash-1234    |  wake_up_new_task() {\n",
> +		},

[ ... ]

> diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
> index 020551a4d7e00..66c19116ee64e 100644
> --- a/tools/perf/util/ftrace.c
> +++ b/tools/perf/util/ftrace.c
> @@ -388,6 +388,9 @@ static void make_blank_prefix(const struct perf_ftrac=
e *ftrace, const char *line
>  	memcpy(buf, line, len);
>  	buf[len] =3D '\0';
> =20
> +	if (ftrace->graph_noduration)
> +		return;
> +
>  	if (*pipe_char =3D=3D '|') {
>  		if (ftrace->graph_verbose) {
>  			/* In verbose mode, duration starts after the comm-pid '|' */
> @@ -426,10 +429,12 @@ static void make_blank_prefix(const struct perf_ftr=
ace *ftrace, const char *line
>   *   [ abstime |]  CPU)  [ comm-pid |]  [ duration |]  func
>   *
>   * The abstime and comm-pid columns are only present with --graph-opts
> - * verbose.
> + * verbose, whereas the duration column, and thus its '|' delimiter, is
> + * omitted with --graph-opts noduration.
>   *
>   * Return: A pointer to the last character of the context columns (the f=
inal
> - * '|' delimiter). Returns NULL if @line is not a trace record.
> + * '|' delimiter, or the CPU ')' when no delimiter follows it). Returns =
NULL
> + * if @line is not a trace record (e.g. a header or a context switch mar=
ker).
>   */
>  static const char *find_func_column(const struct perf_ftrace *ftrace,
>  				    const char *line, int *cpu)
> @@ -470,9 +475,14 @@ static const char *find_func_column(const struct per=
f_ftrace *ftrace,
>  		}
>  	}
> =20
> -	p =3D strchr(p + 1, '|');
> -	if (!p)
> +	if (!ftrace->graph_noduration) {
> +		p =3D strchr(p + 1, '|');
> +		if (!p)
> +			return NULL;

[Severity: Medium]
When perf ftrace trace is invoked with --inline and --graph-opts
verbose,noduration (or --graph-opts verbose), set_tracing_funcgraph_verbose=
()
in tools/perf/builtin-ftrace.c enables latency-format in addition to
funcgraph-proc and funcgraph-abstime:

tools/perf/builtin-ftrace.c:set_tracing_funcgraph_verbose() {
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

In the kernel's function_graph tracer, TRACE_ITER(LATENCY_FMT) causes
print_graph_prologue() -> print_graph_lat_fmt() in
kernel/trace/trace_functions_graph.c to emit an additional pipe-delimited
column (such as " .... | ") between the comm-pid column and the duration
(or function) column:

kernel/trace/trace_functions_graph.c:print_graph_prologue() {
	/* Proc */
	if (flags & TRACE_GRAPH_PRINT_PROC) {
		print_graph_proc(s, ent->pid);
		trace_seq_puts(s, " | ");
	}

	/* Latency format */
	if (tr->trace_flags & TRACE_ITER(LATENCY_FMT))
		print_graph_lat_fmt(s, ent);
}

When both ftrace->graph_verbose and ftrace->graph_noduration are enabled,
find_func_column() skips the strchr(p + 1, '|') step and stops at the '|'
delimiter immediately after comm-pid instead of advancing past the
latency-format '|' delimiter. As a result, ftrace_process_fgraph_line()
treats the latency flags as the function column, which breaks function
entry parsing, exit brace detection, indentation, and blank_prefix
truncation in make_blank_prefix().

Should find_func_column(), make_blank_prefix(), and the test cases in
test_inline_processing() and test_column_layouts() account for the
latency-format column when ftrace->graph_verbose is set?

> +	} else if (strstr(p, " =3D> ")) {
> +		/* Context switch marker: " CPU) comm-pid =3D> comm-pid" */
>  		return NULL;
> +	}

[Severity: Medium]
What happens to IRQ boundary markers ("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>" and=
 "<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D") when
perf ftrace trace is run with --inline and --graph-opts noduration?

In kernel/trace/trace_functions_graph.c, print_graph_irq() wraps the IRQ
arrows with print_graph_duration():

kernel/trace/trace_functions_graph.c:print_graph_irq() {
	/* No overhead */
	print_graph_duration(tr, 0, s, flags | FLAGS_FILL_START);

	if (type =3D=3D TRACE_GRAPH_ENT)
		trace_seq_puts(s, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>");
	else
		trace_seq_puts(s, "<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D");

	print_graph_duration(tr, 0, s, flags | FLAGS_FILL_END);
	trace_seq_putc(s, '\n');
}

When funcgraph-duration is disabled, print_graph_duration() returns early
without printing a trailing '|', so the kernel emits lines like
" 0) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>" and " 0) <=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D".

In find_func_column(), the noduration path filters out " =3D> " context
switch markers, but returns a pointer to ')' for IRQ markers. When an
interrupt occurs while cs->inlined_depth > 0, ftrace_process_fgraph_line()
treats "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>" as a function call and shifts it b=
y extra_indent.
Should find_func_column() also return NULL for these IRQ markers when
ftrace->graph_noduration is enabled?

> =20
>  	*cpu =3D (int)val;
>  	return p;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018023753.5848=
73-1-atomlin@atomlin.com?part=3D5
