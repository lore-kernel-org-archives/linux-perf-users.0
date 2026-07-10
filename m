Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DECC149DF1
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2026 03:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783653445; cv=none; b=tBn5GJ3SARJYI5vhtbQphURcH4RMQ3jf66lObqK6HCH4svG/DpWmA9wTEsHme42ZdxkuBATczzEN/STYs9bQTMe2kPjqwjWhMRK8xuVL7Ch5hhofld+mWvx8Pr282agRCuM753Co8h5gZ0On1yh77oRm9nNQe/R6TaesxRVXmUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783653445; c=relaxed/simple;
	bh=p5jyTzOXexJsZSHEhJ0fwxzLRh8MmBenj1sqslcDXAA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mH7LF+yr1RE1XgNS3Zs2irLAneVGaLeIgpdtrg8v6CBs9OmDDSZeUiSErzTeN3EOQJS/kMtYBQU2sYRy9RPf2XJz6AfX8xNrS1ru28AZUBdhrpkVj+zsSPZsWMeCIr8KCAbP2nKzxy/INcCXMU6E8FTZ12m3fnRBivO0C0EUZjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHsu2gLd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHsu2gLd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF3F1F000E9;
	Fri, 10 Jul 2026 03:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783653442;
	bh=qH68QyJJCLkDqdHMwNUpsaXaQo2Lq238JqMJ1ngcPVM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kHsu2gLdyFH50lXnZLxz4iVRWZ0mqaZbeECV7t0C8ObMNIfqFFLKYQSAn+9SDQEIp
	 audsY7X2tjtAsXZnBO1zLbSdg6fJgfnrphi/XxV01JRM3mNRtGe/Jz6ZC7BzL9spnM
	 AdwEjSvEGwXpooEUZF0qxOXyWTdALxEZkkhMLwnlnrBueFfMGB/bFpvHeJ6nnWT3m4
	 gclzhWFhzqa2GsQZIetRL3ECafY3h8SA3Xw8XiekmzX0XFKv6mVe53XCsXAFYl4R66
	 sgUCPOAMMjsjgGYXSkt82e2ihmEi6DXLoItrA25veqNSZ+wvTzXPrrz3S3ElfmgJy8
	 A6EauKm3go90g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 9/9] perf annotate: Be robust to annotating without a
 thread
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260710024952.1668911-9-irogers@google.com>
References: <20260709165220.1411149-1-irogers@google.com>
 <20260710024952.1668911-1-irogers@google.com>
 <20260710024952.1668911-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 03:17:22 +0000
Message-Id: <20260710031722.8EF3F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The newly added error check for `map_symbol__get_arch` returns e=
arly and leaves malformed output on stdout.
- [Medium] Inconsistent fallback logic for `e_machine` causes capstone init=
ialization to fail when a DSO architecture cannot be determined.
--

--- Patch [9]: [PATCH v4 9/9] perf annotate: Be robust to annotating withou=
t a thread ---
commit 0c50b4f94a148dd6a11cef4fb5824f4934eab627
Author: Ian Rogers <irogers@google.com>
Subject: perf annotate: Be robust to annotating without a thread

If a thread isn't given to thread__get_arch, try harder to determine the ar=
ch
for disassembly by falling back to reading e_machine from a map's dso or
defaulting to the host. Ensure other uses of map_symbol thread don't assume
it is non-NULL.

> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 02505222d8c2d..b6041f8608164 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
[ ... ]
> @@ -1266,7 +1291,10 @@ int hist_entry__annotate_printf(struct hist_entry =
*he, struct evsel *evsel)
> =20
>  	apd.addr_fmt_width =3D annotated_source__addr_fmt_width(&notes->src->so=
urce,
>  							      notes->src->start);
> -	thread__get_arch(ms->thread, &apd.arch);
> +	if (map_symbol__get_arch(ms, &apd.arch)) {
> +		free(filename);
> +		return -ENOTSUP;
> +	}

[Severity: Medium]
Does returning early here leave the console output in a malformed state?

Looking at hist_entry__annotate_printf(), we've already printed the
"Source code & Disassembly..." header and a dotted line to stdout before
reaching this point. Aborting here without a newline might leave the
user's console output half-printed and corrupted.

>  	apd.dbg =3D dso__debuginfo(dso);
> =20
>  	list_for_each_entry(pos, &notes->src->source, node) {
[ ... ]
> diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
> index 5ad537fea4360..15152a2c1b25c 100644
> --- a/tools/perf/util/capstone.c
> +++ b/tools/perf/util/capstone.c
> @@ -411,9 +411,18 @@ int symbol__disassemble_capstone(const char *filenam=
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
> +		e_machine =3D dso__e_machine_endian(dso, /*machine=3D*/NULL, /*e_flags=
=3D*/NULL,
> +						  &is_big_endian);
> +	} else {
> +		e_machine =3D thread__e_machine_endian(NULL,
> +						     /*machine=3D*/NULL,
> +						     /*e_flags=3D*/NULL, &is_big_endian);
> +	}

[Severity: Medium]
If dso__e_machine_endian() returns EM_NONE, does this bypass the host
architecture fallback?

When annotating without a thread but with a valid DSO, we take this path.
If the DSO's ELF header is missing or unreadable and yields EM_NONE, the
if/else structure prevents us from executing the thread__e_machine_endian(N=
ULL)
fallback. This could cause capstone_init() to fail and force a fallback to
the slower objdump.

>  	if (capstone_init(e_machine, &handle, is_64bit, is_big_endian, disassem=
bler_style) < 0)
>  		goto err;
> =20
> @@ -526,9 +535,18 @@ int symbol__disassemble_capstone_powerpc(const char =
*filename __maybe_unused,
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
> +		e_machine =3D dso__e_machine_endian(dso, /*machine=3D*/NULL, /*e_flags=
=3D*/NULL,
> +						  &is_big_endian);
> +	} else {
> +		e_machine =3D thread__e_machine_endian(NULL,
> +						     /*machine=3D*/NULL,
> +						     /*e_flags=3D*/NULL, &is_big_endian);
> +	}

[Severity: Medium]
Does this have the same fallback logic issue as symbol__disassemble_capston=
e()?

If dso__e_machine_endian() returns EM_NONE, it appears we will skip the
fallback here as well.

>  	if (capstone_init(e_machine, &handle, is_64bit, is_big_endian, disassem=
bler_style) < 0)
>  		goto err;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710024952.1668=
911-1-irogers@google.com?part=3D9
