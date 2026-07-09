Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC593932E5
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 03:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783569443; cv=none; b=iXUwTN822To6osZqwhHnJmWoQAUgYEYZtfVkhYM8j7FcHOq3PUh30Dvu3C34gqIDjPhMJQzxBiwEaQfIkTwWdGkivt0vaOx/UVPeKmV29TonNqiPJyLJUtAvQQTKQW86m1/FjrK2Kg5oDBLQx3eRYd7OwS8xMGXa3O3zrI3QruA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783569443; c=relaxed/simple;
	bh=L4i+kkJCSW0GkjXHgk22JMVpeT3yMf3IysX27e5ZxuY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NpJFK6ABGJO1sDp5ss+1WsZBotv8ALn28LVh0VpDMHwRKCxRI2mAz9+tyHh7F6Xk1uhT2KKv6i0txjqUGt38GQTPqbcoKADYEEg2N/+dqCJtF3xtoW5zxt3isrUzEZhe5RksZ4KGLGd8Y9IWCwgKUOByHuFDd1846ogVVltIaeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeufAZiP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeufAZiP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE901F000E9;
	Thu,  9 Jul 2026 03:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783569441;
	bh=OW4qYC3hQw/TswPdnKSKX9H8/vlEOjUUGdSU/jfDXzE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WeufAZiP4vy7ZbShI8attbYmamlW2sgvJ8ZZU9brLBwCMcnSIL/XmtFXJcoQq/aag
	 yM+1NoDVHzGCBXkp5cvad/3oww5oRAtwkRAidUvE/69ES7CYcMGHz0jmxBgTc1S8Yq
	 ewi5UlHFExgQrRGltwTgoMTIWTkwlrxRQDgRbbUDB/fAAiB/jA3BOCHljRFlhEyhKZ
	 40FbFJimCDaS4OjFRzL1VjAC79W+XQlqav9ci60N4LEjojKKt2iZnQiIiGlP41iOro
	 sWfv1tcFZ/lcbP99XAMIwrl0wNoVrBF7bWBe25/cw3vlPeOFEl5ymH9VZqBrcIHuT1
	 Hd+mzZZO8FznA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] perf annotate: Be robust to annotating without a
 thread
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260709033701.1117943-3-irogers@google.com>
References: <20260708234646.1040003-1-irogers@google.com>
 <20260709033701.1117943-1-irogers@google.com>
 <20260709033701.1117943-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 03:57:21 +0000
Message-Id: <20260709035721.9EE901F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Capstone disassembly silently falls back to the host architecture =
when `ms->thread` is `NULL`, breaking cross-platform annotation.

Pre-existing issues:
- [High] Missing error handling for `map_symbol__get_arch()` causes a NULL =
pointer dereference crash when processing unsupported architectures.
- [High] Unconditional dereference of `result->name` when `result` is NULL =
in `arch__find()` error logging.
--

--- Patch [3]: [PATCH v2 3/4] perf annotate: Be robust to annotating withou=
t a thread ---
commit 58ae613c4021f8e6e076d81d76c91fd8fc818a3e
Author: Ian Rogers <irogers@google.com>

perf annotate: Be robust to annotating without a thread

The patch makes perf annotate more robust when annotating without a thread
context by falling back to reading the e_machine from a map's dso. It also
ensures other uses of map_symbol thread don't assume it is non-NULL.

> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 02505222d8c2d..e89029f0d0958 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -982,21 +982,46 @@ void symbol__calc_percent(struct symbol *sym, struc=
t evsel *evsel)
[ ... ]
> -int thread__get_arch(struct thread *thread, const struct arch **parch)
> +int map_symbol__get_arch(struct map_symbol *ms, const struct arch **parc=
h)
>  {
> +	struct machine *machine =3D NULL;
> +	const char *cpuid =3D NULL;
>  	const struct arch *arch;
> -	struct machine *machine;
> -	uint32_t e_flags;
> -	uint16_t e_machine;
[ ... ]
> -	machine =3D maps__machine(thread__maps(thread));
> -	e_machine =3D thread__e_machine(thread, machine, &e_flags);
> -	arch =3D arch__find(e_machine, e_flags, machine->env ? machine->env->cp=
uid : NULL);
> +	arch =3D arch__find(e_machine, e_flags, cpuid);

[Severity: High]
This is a pre-existing issue, but can this error path in arch__find() crash?

If arch_new_fn[e_machine]() fails (e.g., rejecting a malformed CPUID string)
and returns NULL, it sets result to NULL. The error handling path checks if
result is NULL, but then immediately dereferences result->name in the print
statement:

tools/perf/util/disasm.c:arch__find() {
	...
	result =3D arch_new_fn[e_machine](&key, cpuid);
	if (!result) {
		pr_err("%s: failed to initialize %s (%u) arch priv area\n",
			__func__, result->name, e_machine);
		free(tmp);
		return NULL;
	}
	...
}

>  	if (arch =3D=3D NULL) {
>  		pr_err("%s: unsupported arch %d\n", __func__, e_machine);
>  		return errno;
>  	}
>  	if (parch)
>  		*parch =3D arch;
> =20
>  	return 0;
>  }

[Severity: High]
With the introduction of map_symbol__get_arch() to dynamically determine the
architecture via the DSO when ms->thread is NULL, will capstone disassembly
still work correctly when cross-compiling?

In tools/perf/util/capstone.c:symbol__disassemble_capstone():

	e_machine =3D thread__e_machine_endian(args->ms->thread,
					     /*machine=3D*/NULL,
					     /*e_flags=3D*/NULL, &is_big_endian);
	if (capstone_init(e_machine, &handle, is_64bit, is_big_endian, disassemble=
r_style) < 0)

And similarly in symbol__disassemble_capstone_powerpc():

	e_machine =3D thread__e_machine_endian(args->ms->thread,
					     /*machine=3D*/NULL,
					     /*e_flags=3D*/NULL, &is_big_endian);

Both functions bypass map_symbol__get_arch() entirely. When annotating with=
out
a thread context, ms->thread is NULL, which causes thread__e_machine_endian=
()
to fall back to the host machine's architecture instead of using the DSO. C=
an
this break cross-platform annotation for capstone?

> @@ -1266,7 +1291,7 @@ int hist_entry__annotate_printf(struct hist_entry *=
he, struct evsel *evsel)
> =20
>  	apd.addr_fmt_width =3D annotated_source__addr_fmt_width(&notes->src->so=
urce,
>  							      notes->src->start);
> -	thread__get_arch(ms->thread, &apd.arch);
> +	map_symbol__get_arch(ms, &apd.arch);

[Severity: High]
This is a pre-existing issue, but should the return value of
map_symbol__get_arch() be checked here?

If map_symbol__get_arch() fails (e.g., when encountering an unsupported
architecture), it returns an error code and leaves apd.arch as NULL. This N=
ULL
pointer is then passed through apd and eventually dereferenced:

annotation_line__print()
  __hist_entry__get_data_type()
    annotate_get_insn_location()
      arch__is_powerpc()

tools/perf/util/disasm.c:arch__is_powerpc() {
	return arch->id.e_machine =3D=3D EM_PPC || arch->id.e_machine =3D=3D EM_PP=
C64;
}

Can this lead to a segmentation fault when processing unsupported architect=
ures?

>  	apd.dbg =3D dso__debuginfo(dso);
> =20
>  	list_for_each_entry(pos, &notes->src->source, node) {
[ ... ]
> @@ -1371,7 +1396,7 @@ static int symbol__annotate_fprintf2(struct symbol =
*sym, FILE *fp,
>  	struct annotation_line *al;
> =20
>  	if (annotate_opts.code_with_type) {
> -		thread__get_arch(apd->he->ms.thread, &apd->arch);
> +		map_symbol__get_arch(&apd->he->ms, &apd->arch);

[Severity: High]
This is a pre-existing issue, but this call also ignores the return value,
which could lead to the same NULL pointer dereference described above.

>  		apd->dbg =3D dso__debuginfo(map__dso(apd->he->ms.map));
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709033701.1117=
943-1-irogers@google.com?part=3D3
