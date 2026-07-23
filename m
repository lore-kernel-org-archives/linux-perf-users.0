Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69803387588
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jul 2026 05:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784784878; cv=none; b=u2HlmdZ91rKsMphFUC9QZfG07G+iaD4YbxmvJ4xeOCCg7DcP4RsjBeJ0SgGEzgcrbdSJ9MkV3NlRn9I0b5ixms0mVdiQDjygVUFn9G0gaFykQ7Vutph+42fPemIFXUtQjaSWKZJjNqNDrMC3c9EeSEQaZn31qh9PXc6wBJBlYxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784784878; c=relaxed/simple;
	bh=GxDHG2SZdKbPJMyCl7UlwgYKPYrDcco4QIDAbIks8T4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aDY/+9vzmI4z6o5XBmc7xcSuwlPZa7qCu78qQdM6XJTxMuiAZco0U+t5qOfScDuwgoGHrKdesQPONsF12IKovQ6jVyD22wGk2qY6GwLM8tei2y1ra2U1FKHMa7iNLDqzbUxNVAYedrf4OSeIzeIbVNJqxTjEIMbMyHbg2zhF288=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5E3B25c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5E3B25c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D048A1F000E9;
	Thu, 23 Jul 2026 05:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784784877;
	bh=mbJ+zRMBdW8NoJTKlqETsFtcHLMYfzTDcx8lAro4AnQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B5E3B25cVYT43QFBk2jD7NDjRZRIMD9a3KI98CX0dUzt7AZnyI+Bbk6AA2VHaOs/l
	 42qeAFPmY0UUFvBIcwdfHBQqKNRYFQHCJYVKmb6hPUcs5ufSpr4hTY3qSpquBIWRwh
	 xyYlcH1jcSgNQKQJx67nS32QDmnWb47D9kh5T9NHwk9Zqq19a1rIDLXXH92+K4aLSM
	 ptQo3EdEp3iSdvqpBby9Y/EDR448Ig6jNczO9pLpTNvdlrsECt74vDlZg8+siolnS5
	 wONSxgoqZ7vmyMUJzrIFk/K2tyd3XHiEPZ5oq9iH0uBBKZrXIrYONMtM9T7/im/XlD
	 RmOez9SqOB+Iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/6] perf annotate: Be robust to annotating without a
 thread
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260723045949.988740-6-irogers@google.com>
References: <20260716072351.560311-1-irogers@google.com>
 <20260723045949.988740-1-irogers@google.com>
 <20260723045949.988740-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 05:34:36 +0000
Message-Id: <20260723053436.D048A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The patch actively introduces a silent fallback to the host archit=
ecture for userspace maps, defeating its stated purpose.
- [Medium] Returning a positive error code (ENOTSUP) from hist_entry__annot=
ate_printf causes the caller to misinterpret the error as a valid count of =
filtered lines.
--

--- Patch [5]: [PATCH v7 5/6] perf annotate: Be robust to annotating withou=
t a thread ---
commit fcda5c254c589dfc6e3daa2b89d76183be5ba280
Author: Ian Rogers <irogers@google.com>

perf annotate: Be robust to annotating without a thread

This commit attempts to improve architecture detection for map symbols when
a thread isn't provided. It implements fallbacks using the DSO ELF header
and kmaps to avoid incorrectly falling back to the host architecture during
cross-platform analysis.

> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 53b2a224b21df..df70e95a84704 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
[ ... ]
> @@ -982,24 +982,43 @@ void symbol__calc_percent(struct symbol *sym, struc=
t evsel *evsel)
[ ... ]
> +	if (ms->thread) {
> +		machine =3D maps__machine(thread__maps(ms->thread));
> +		e_machine =3D thread__e_machine(ms->thread, machine, &e_flags);
> +		if (machine && machine->env)
> +			cpuid =3D machine->env->cpuid;
> +	} else if (dso) {
> +		struct maps *kmaps =3D (map && dso__kernel(dso)) ? map__kmaps(map) : N=
ULL;
> +		struct machine *kmap_machine =3D kmaps ? maps__machine(kmaps) : NULL;
> +
> +		e_machine =3D dso__e_machine(dso, kmap_machine, &e_flags);
> +		if (kmap_machine && kmap_machine->env)
> +			cpuid =3D kmap_machine->env->cpuid;
>  	}
> =20
> -	machine =3D maps__machine(thread__maps(thread));
> -	e_machine =3D thread__e_machine(thread, machine, &e_flags);
> -	arch =3D arch__find(e_machine, e_flags, machine->env ? machine->env->cp=
uid : NULL);
> +	if (e_machine =3D=3D EM_NONE)
> +		e_machine =3D thread__e_machine(NULL, NULL, &e_flags);

[Severity: High]
Does this code silently fall back to the host architecture, defeating the s=
tated
purpose of the patch? The commit message mentions "perfectly preventing sil=
ent,
incorrect host fallbacks to uname()", but when a user-space DSO is missing =
or
uses JIT, dso__e_machine() might return EM_NONE. Passing NULL to
thread__e_machine() triggers the uname() fallback, which assigns EM_HOST and
could cause Capstone to disassemble using the wrong architecture instead of
correctly aborting.

> +
> +	arch =3D arch__find(e_machine, e_flags, cpuid);
>  	if (arch =3D=3D NULL) {
[ ... ]
> @@ -1251,6 +1270,11 @@ int hist_entry__annotate_printf(struct hist_entry =
*he, struct evsel *evsel)
>  		evsel_name =3D buf;
>  	}
> =20
> +	if (map_symbol__get_arch(ms, &apd.arch)) {
> +		free(filename);
> +		return ENOTSUP;

[Severity: Medium]
Will returning a positive error code (ENOTSUP) here cause the caller to
misinterpret the error as a valid count of filtered lines?=20
perf_top__show_details() interprets any positive return value from
hist_entry__annotate_printf() as the number of lines filtered out, incorrec=
tly
printing '95 lines not displayed' rather than handling the failure. Should =
this
return a negative error code like -ENOTSUP?

> +	}
> +
>  	graph_dotted_len =3D printf(" %-*.*s|	Source code & Disassembly of %s f=
or %s (%" PRIu64 " samples, "
>  				  "percent: %s)\n",
>  				  width, width, symbol_conf.show_total_period ? "Period" :
> diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
> index 00e0141cae8db..74213daf87862 100644
> --- a/tools/perf/util/capstone.c
> +++ b/tools/perf/util/capstone.c
[ ... ]
> @@ -423,9 +423,22 @@ int symbol__disassemble_capstone(const char *filenam=
e, struct symbol *sym,
>  	    !strcmp(args->options->disassembler_style, "att"))
>  		disassembler_style =3D true;
> =20
> -	e_machine =3D thread__e_machine_endian(args->ms->thread,
> -					     /*machine=3D*/NULL,
> -					     /*e_flags=3D*/NULL, &is_big_endian);
> +	if (args->ms->thread) {
> +		e_machine =3D thread__e_machine_endian(args->ms->thread,
> +						     /*machine=3D*/NULL,
> +						     /*e_flags=3D*/NULL, &is_big_endian);
> +	} else if (dso) {
> +		struct maps *kmaps =3D (map && dso__kernel(dso)) ? map__kmaps(map) : N=
ULL;
> +		struct machine *kmap_machine =3D kmaps ? maps__machine(kmaps) : NULL;
> +
> +		e_machine =3D dso__e_machine_endian(dso, kmap_machine, /*e_flags=3D*/N=
ULL,
> +						  &is_big_endian);
> +	}
> +	if (!e_machine || e_machine =3D=3D EM_NONE) {
> +		e_machine =3D thread__e_machine_endian(NULL,
> +						     /*machine=3D*/NULL,
> +						     /*e_flags=3D*/NULL, &is_big_endian);

[Severity: High]
Does this code also silently fall back to the host architecture here? Simil=
ar to
map_symbol__get_arch(), passing NULL to thread__e_machine_endian() results =
in
using the host architecture instead of aborting properly when annotating
cross-platform perf.data files.

> +	}
>  	if (capstone_init(e_machine, &handle, is_64bit, is_big_endian, disassem=
bler_style) < 0)
>  		goto err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723045949.9887=
40-1-irogers@google.com?part=3D5
