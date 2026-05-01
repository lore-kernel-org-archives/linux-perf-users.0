Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31062325707
	for <linux-perf-users@vger.kernel.org>; Fri,  1 May 2026 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777661817; cv=none; b=DVJEll2Asjg+4SkvcXJYZdVEmWtLWWQuCJy1tnY4CTK/gUq/9d4tCoFrcaiSLi27GWPpcQjZSMNIoWuQJu+FKJEDIK4qIFNyJLj3CfMxiNXy4mEhJ9dHP5OW5VI+9tVP7q3hemXEXL0rKt7grENzJzuW1lMJeVbtdU3PHF8G90w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777661817; c=relaxed/simple;
	bh=n5F51NBrDDczPBhJ9m0efJAHWj0UHdb/5ISn+gPL0Ms=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GzqSlk5Id6BL0FaUPkv8GhOZKWeCUexZMU0ZovXhE/YUJ/DmxBKpIxKtPcU6owNQapgoJD0JaiIrUJcrv26ojNkGPC3hgTeP2JAyYN322vIR9fFtrKsnOfxg5byqU1jt85TGd/UiGTu34Mdtuk14TzreTr4Joc7FBNkKZBTtf1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=px4ugKkk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="px4ugKkk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1B6C2BCB4;
	Fri,  1 May 2026 18:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777661816;
	bh=n5F51NBrDDczPBhJ9m0efJAHWj0UHdb/5ISn+gPL0Ms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=px4ugKkkO2Vt0t7ElYeHwBAYUfdrbTvtjG4mRkZwsRvuUhXwuA8YjzBfeSvTNdBEE
	 AMXYOnnJwZqkZ+CAUc7KfUpky/R2tb2ZZqMDYWLqwTeNvBX9ZNLXJCObTm83oghgfu
	 dQhKYwCjvlSBLlDQRiw7dmPuSyiG9NUSE0VlFaSrJc/mhjNQN2TAsFz28odSZ1K15J
	 SveYZrYKAiSw/LysWYQ2N9UwGNLKV1AlbHtHSo4RZjSN4RzmsioubtDsYilJX8eVJO
	 qD3kvaOjLSJAzWxTwv1r95de33w2D8DKwXiNnR6cXhDIWA+2Enelgxq5POulWtllFl
	 SRp8MjBhOEs2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/4] perf env: Add perf_env__e_machine helper and use
 in perf_env__arch
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260501182021.3651851-2-irogers@google.com>
References: <20260501182021.3651851-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 May 2026 18:56:56 +0000
Message-Id: <20260501185656.AA1B6C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Premature caching of fallback e_machine defeats dynamic thread-bas=
ed architecture detection.
- [High] Canonicalization of `env->arch` breaks `perf_env__kernel_is_64_bit=
()`, falsely treating 64-bit traces as 32-bit.
- [High] Older 32-bit perf.data files are falsely promoted to 64-bit due to=
 uninitialized `kernel_is_64_bit` state.
- [High] Inconsistent caching causes `perf_env__arch()` to unpredictably re=
turn unnormalized or canonical strings depending on initialization order.
- [High] Changing the format of the `HEADER_ARCH` string written to `perf.d=
ata` files breaks backward compatibility and existing tests.
- [Medium] OOM during string allocation in `process_arch()` causes a silent=
 NULL pointer dereference in downstream consumers.
--

commit 3dd924151546a227a61b859787ac74725a289795
Author: Ian Rogers <irogers@google.com>

perf env: Add perf_env__e_machine helper and use in perf_env__arch

Add a helper that lazily computes the e_machine and falls back of
EM_HOST. Use the perf_env's arch to compute the e_machine if
available. Use a binary search for some efficiency in this, but handle
somewhat complex duplicate rules. Switch perf_env__arch to be derived
the e_machine for consistency. This switches arch from being uname
derived to matching that of the perf binary (via EM_HOST). Update
session to use the helper, which may mean using EM_HOST when no
threads are available. This also updates the perf data file header
that gets the e_machine/e_flags from the session.

> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 1e54e2c863605..1671769d44411 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c

[ ... ]

> @@ -627,6 +629,40 @@ static uint16_t perf_arch_to_e_machine(const char *p=
erf_arch, int is_64_bit)

[ ... ]

> +	switch (result->e_machine) {
> +	case EM_ARM:
> +		return !strcmp(perf_arch, "arm64") ? EM_AARCH64 : EM_ARM;
> +	case EM_AVR:
> +		return !strcmp(perf_arch, "avr32") ? EM_AVR32 : EM_AVR;
> +	case EM_PPC:
> +		return (is_64_bit !=3D 0) || strstarts(perf_arch, "ppc64") ? EM_PPC64 =
: EM_PPC;
> +	case EM_SPARC:
> +		return (is_64_bit !=3D 0) || !strcmp(perf_arch, "sparc64") ? EM_SPARCV=
9 : EM_SPARC;

Does this logic introduce a regression that inadvertently promotes older 32=
-bit
perf.data files to 64-bit?

When process_arch() reads an older data file, it calls perf_env__e_machine()
which invokes this function. At that point, env->kernel_is_64_bit is still
uninitialized, holding a value of -1.

Since -1 !=3D 0 evaluates to true, would this unconditionally return EM_PPC=
64
and EM_SPARCV9 for older 32-bit ppc and sparc traces?

[ ... ]

> @@ -685,15 +688,20 @@ const char *perf_env__arch(struct perf_env *env)

[ ... ]

> +	/*
> +	 * Lazily compute/allocate arch. The e_machine may have been
> +	 * read from a data file and so may not be EM_HOST.
> +	 */
> +	e_machine =3D perf_env__e_machine(env, /*e_flags=3D*/NULL);
> +	arch =3D e_machine_to_perf_arch(e_machine);
> +	env->arch =3D strdup(arch);

Could this lead to a regression with inconsistent behavior depending on
initialization order?

If perf_env__read_arch() runs first, it caches the raw uname string
(like x86_64). If perf_env__arch() runs first, it calculates and caches the
canonical string (like x86).

Will this unpredictability break strict string comparisons against env->arch
elsewhere in the codebase?

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index f30e48eb3fc32..8d5152bde25d5 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c

[ ... ]

> @@ -379,21 +379,28 @@ static int write_arch(struct feat_fd *ff, struct ev=
list *evlist)
>  {
>  	struct utsname uts;
> -	int ret;
> +	const char *arch =3D NULL;
> =20
> -	ret =3D uname(&uts);
> -	if (ret < 0)
> -		return -1;
> +	if (evlist->session) {
> +		/* Force the computation in the perf_env of the e_machine of the threa=
ds. */
> +		perf_session__e_machine(evlist->session, /*e_flags=3D*/NULL);
> +		arch =3D perf_env__arch(perf_session__env(evlist->session));
> +	}

Does writing the canonicalized string here cause a regression by breaking
backward compatibility with existing tests?

By calling perf_env__arch(), this writes strings like "powerpc" into the
HEADER_ARCH section of the data file, rather than the raw uts.machine
strings like "ppc64le".

Tests such as test__session_topology parse HEADER_ARCH and conditionally
skip topology validations using checks like strncmp(env->arch, "ppc64le", 7=
).
Will this change cause those validations to run on unsupported platforms
and fail?

[ ... ]

> @@ -2684,10 +2691,30 @@ static int process_arch(struct feat_fd *ff, void =
*data __maybe_unused)
> +{
> +	uint16_t saved_e_machine =3D ff->ph->env.e_machine;
> +
> +	free(ff->ph->env.arch);
> +	ff->ph->env.arch =3D do_read_string(ff);
> +	if (!ff->ph->env.arch)
> +		return -ENOMEM;
> +	/*
> +	 * Make the arch string canonical by computing the e_machine from it,
> +	 * then turning the e_machine back into an arch string.
> +	 */
> +	ff->ph->env.e_machine =3D EM_NONE;
> +	if (perf_env__e_machine(&ff->ph->env, /*e_flags=3D*/NULL) !=3D EM_NONE)=
 {
> +		zfree(&ff->ph->env.arch);
> +		perf_env__arch(&ff->ph->env);
> +	}

Will replacing env->arch with the canonicalized string introduce a regressi=
on
that breaks 64-bit architecture detection?

The function perf_env__init_kernel_mode() expects env->arch to contain the
raw uname string, matching exactly against strings like "x86_64" or "s390x".
Since env->arch now contains the canonical string (e.g., "x86"), won't
env->kernel_is_64_bit erroneously evaluate to 0 for 64-bit traces?

Also, is it possible for env->arch to be left as NULL here, leading to a
regression where downstream consumers crash?

If the strdup() inside perf_env__arch() fails due to memory pressure,
perf_env__arch() will safely return a static string, but env->arch will
remain NULL.

Since process_arch() ignores the return value of perf_env__arch(), will
consumers crash when attempting to use env->arch directly?

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index fe0de2a0277f0..bc7add02a2de4 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c

[ ... ]

> @@ -3048,10 +3053,8 @@ uint16_t perf_session__e_machine(struct perf_sessi=
on *session, uint32_t *e_flags
> =20
>  	/*
>  	 * Couldn't determine from the perf_env or current set of
> -	 * threads. Default to the host.
> +	 * threads. Potentially use logic that uses the arch string otherwise
> +	 * default to the host.
>  	 */
> -	if (e_flags)
> -		*e_flags =3D EF_HOST;
> -
> -	return EM_HOST;
> +	return perf_env__e_machine(env, e_flags);
>  }

Can this lead to a regression where the session architecture gets
permanently locked to the host architecture?

If perf_session__e_machine() is called early (for example, from
write_e_machine() before threads are synthesized),
machines__for_each_thread() will find no threads.

The function will then fall back to perf_env__e_machine() here, which
computes and permanently caches EM_HOST into env->e_machine.

Because env->e_machine is now cached and !=3D EM_NONE, all future calls
will take the fast-path at the top of this function, completely bypassing
the dynamic thread scanning logic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260501182021.3651=
851-1-irogers@google.com?part=3D1
