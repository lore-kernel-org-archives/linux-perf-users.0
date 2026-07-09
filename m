Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37734385D61
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783616660; cv=none; b=ufmKeZ9+/MdHigimc4wV7QmFwuBooCceF8PU6RHjgxpL5IeC6CTWhbv07JgsDzyT1WCEi3dhonFXKyn/LY7l3UsqrttkdD14ftrO4ocdlxhM8u4VS0EMQ7quTTYhszoqQNUCqLQK/RjbtZylbhkCVkA8taibLJY2VB64Kh4o3iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783616660; c=relaxed/simple;
	bh=xJKkcxig8ReuDc4GOkRx/B3OxXHWOsj3IAkyfiZfans=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qBNV9O4hxZn0P2tN7wypiNhBhOIMvcfBwB3JDGncXPyNTHTjOxGCi9ljq5R7pgDe2AtSdPptYyXZ1LZEWSXD2hWXE7e29gt1K9eOiKvVp7MAM9Q3PsJ5KOtcVo9zMJ57uCt/t2PG32dcxUlM1anUlbL5R8gWIrUatKLQaPgQJP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fs4cCKIZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fs4cCKIZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A681F000E9;
	Thu,  9 Jul 2026 17:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783616658;
	bh=XFQKOTPxPkGs+nEDUS1c+3Vo31aTN93wtnQVDWyXgQ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fs4cCKIZ5mnKl8PCoYjQlPEpB88e8417zfwxbvgslJ1BOrPJFx6JK061nAKh+cChh
	 k5kWe82vWG28KVjy57z/1Gz58sEyqgWhwmEXbGAW5Vct+bz5Ktn7IXIXnyDm8juJNG
	 9hGtyBwVLZv3qYfLYw6R5j9qgjT3Wu8js44dQtEwqdg9FVScLHVmkyuSr/gFtEqbh0
	 SHN3qK1dfYUJN2mVblTcU4ct5fd4X6WVKS9f+vhj0b3nZZ203T/ghCk1w3EaTpHoM4
	 5axe9E0jcfSOMReGPXf/3riVZQnN2SOYu6wGCp2ZhSFCo0HUzSrc/IHLyLHZeY8IHN
	 egMt282DLpuYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] perf annotate: Be robust to annotating without a
 thread
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260709165220.1411149-3-irogers@google.com>
References: <20260709033701.1117943-1-irogers@google.com>
 <20260709165220.1411149-1-irogers@google.com>
 <20260709165220.1411149-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 17:04:18 +0000
Message-Id: <20260709170418.A4A681F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Capstone initialization bypasses the DSO architecture fallback whe=
n a thread is not provided, breaking cross-architecture disassembly.
- [Medium] Memory leak of dynamically allocated `filename` in `hist_entry__=
annotate_printf` when `map_symbol__get_arch` fails.
--

--- Patch [3]: [PATCH v3 3/4] perf annotate: Be robust to annotating withou=
t a thread ---
commit 73f48ecf5d22ea055ab30fc02eef31fb06587ac0
Author: Ian Rogers <irogers@google.com>

perf annotate: Be robust to annotating without a thread

If a thread isn't given to thread__get_arch try harder to determine
the arch for disassembly. Do this by passing an entire map_symbol and
using fallback paths such as reading the e_machine from a map's
dso. At the same time ensure some other uses of map_symbol thread
don't assume it is non-NULL to avoid segvs.

> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c

[ ... ]

> @@ -1266,7 +1291,8 @@ int hist_entry__annotate_printf(struct hist_entry *=
he, struct evsel *evsel)
> =20
>  	apd.addr_fmt_width =3D annotated_source__addr_fmt_width(&notes->src->so=
urce,
>  							      notes->src->start);
> -	thread__get_arch(ms->thread, &apd.arch);
> +	if (map_symbol__get_arch(ms, &apd.arch))
> +		return -ENOTSUP;

[Severity: Medium]
Does this code leak the allocated filename?

Earlier in hist_entry__annotate_printf(), filename is allocated dynamically:

filename =3D strdup(dso__long_name(dso));

But this newly added error path returns directly, bypassing the free(filena=
me)
cleanup that happens at the end of the function when an unsupported
architecture is processed.

>  	apd.dbg =3D dso__debuginfo(dso);
> =20
>  	list_for_each_entry(pos, &notes->src->source, node) {

[ ... ]

> diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
> --- a/tools/perf/util/capstone.c
> +++ b/tools/perf/util/capstone.c
> @@ -414,6 +414,10 @@ int symbol__disassemble_capstone(const char *filenam=
e, struct symbol *sym,
>  	e_machine =3D thread__e_machine_endian(args->ms->thread,
>  					     /*machine=3D*/NULL,
>  					     /*e_flags=3D*/NULL, &is_big_endian);
> +	if (e_machine =3D=3D EM_NONE && dso) {
> +		e_machine =3D dso__e_machine_endian(dso, /*machine=3D*/NULL, /*e_flags=
=3D*/NULL,
> +						  &is_big_endian);
> +	}

[Severity: High]
Will this fallback logic ever execute when the thread is NULL?

The commit message mentions falling back to the DSO architecture when a thr=
ead
is missing. However, if args->ms->thread is NULL, thread__e_machine_endian()
returns the host system's architecture (e.g., EM_X86_64) rather than EM_NON=
E.

Because e_machine is not EM_NONE, this newly added fallback check is bypass=
ed,
and capstone is initialized with the host architecture. Can this break
cross-architecture analysis for threads without a valid machine?

>  	if (capstone_init(e_machine, &handle, is_64bit, is_big_endian, disassem=
bler_style) < 0)
>  		goto err;

[ ... ]

> @@ -529,6 +533,10 @@ int symbol__disassemble_capstone_powerpc(const char =
*filename __maybe_unused,
>  	e_machine =3D thread__e_machine_endian(args->ms->thread,
>  					     /*machine=3D*/NULL,
>  					     /*e_flags=3D*/NULL, &is_big_endian);
> +	if (e_machine =3D=3D EM_NONE && dso) {
> +		e_machine =3D dso__e_machine_endian(dso, /*machine=3D*/NULL, /*e_flags=
=3D*/NULL,
> +						  &is_big_endian);
> +	}

[Severity: High]
Is this the same fallback issue as above?

When args->ms->thread is NULL, thread__e_machine_endian() returns the host
architecture instead of EM_NONE, bypassing the dso fallback logic in the
powerpc implementation as well.

>  	if (capstone_init(e_machine, &handle, is_64bit, is_big_endian, disassem=
bler_style) < 0)
>  		goto err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709165220.1411=
149-1-irogers@google.com?part=3D3
