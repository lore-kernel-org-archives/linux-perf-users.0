Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B83382F31
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 07:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297721; cv=none; b=A+sEijDp64S79sXg8+b4MONnW9Ps1jggS4g+u20m+GBqaXvawDY6QXDy52KVQkS4g7XfABxB4HgkyHMNSqsmNUfapS5wtXYiBeKV7P0t+sprdETBAJwL+4I0HX4YUwPLfdJ2E9R++qBZuQ5JJcDVKRbIdNPpxjdPSmU3+aJqDn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297721; c=relaxed/simple;
	bh=v10R07C0bWrM7llFnF7YQhOFuhodI4jL4kURqtPWDWE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C10+tRr4X+1ysYt5ExAOwg5X15DomjciUUybyQkQ9oKT+GycQUQRwS7Bkx0u2drzob51oauWk0fpwCHnysiv7e0r4+VoWCDG5U8mTs9fBORf+YQV75AtLxx1+uYq2bRgXPG6AouPCTC3Tt+81iO4nuFjAiBOsTrQNdKFgZi8Tkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ha5yPf/0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ha5yPf/0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170721F00893;
	Mon,  1 Jun 2026 07:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780297720;
	bh=ZHWqcO6ysfEjPaLEfgjkVgtQQyGPZ/SuNKRbTgkuas0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ha5yPf/0pY0g7sdgBuoyOiboDwpPZOQnslmUSSnhTQ0pZYuhYGcp05xbhp1qpf8cI
	 DoKeIox+DQ7U7RuIJKVtDkyhbEAZ0vSo7uemDm9p3cMtChMeQokuJAKXkbURY4LbVY
	 wQhE3JwFIFxkIEFh6XqjlaONakiOz6P8gwjScFyr/lsI26pjm4No+iwOqx1CRWqrIp
	 Fi1DwzuIJwWPHr5UV2LFDQfMnod8igA9YiDxhxVCCh28w3MW7eZDdBbc5exRohqC0a
	 mUbuaYbtA1DCfsaltYZ/I4UhHL2X0uq4BTlDA9Q1KDggnI0xezlX/8s4xfR9DH914b
	 BmfL3vtJYWRxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 01/18] perf env: Add perf_env__e_machine helper and
 use in perf_env__arch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260601065407.1597927-2-irogers@google.com>
References: <20260601065407.1597927-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 07:08:39 +0000
Message-Id: <20260601070840.170721F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] x86_64 is severely misclassified as 32-bit locally and in newl=
y recorded `perf.data` files due to normalization overwriting the architect=
ure string.
- [High] Removing `normalize_arch` breaks the parsing of older `perf.data` =
files by returning unnormalized architecture strings.
- [High] Kernel 64-bit detection fails for architectures with endianness or=
 variant suffixes due to a strict `str_ends_with` check.
- [High] Unsynchronized lazy initialization of `perf_env` fields (`arch`, `=
e_machine`, `e_flags`) causes data races and memory leaks.
--

commit a1c7d037273069adc911ec02be28b6159d9a6b8e
Author: Ian Rogers <irogers@google.com>

perf env: Add perf_env__e_machine helper and use in perf_env__arch

Add a helper that lazily computes the e_machine and falls back to EM_HOST.
Use the perf_env's arch to compute the e_machine if available, using a
binary search for efficiency while handling duplicate rules.

> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 20953ef7b9d8f..23dcd7a108a10 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
[ ... ]
> @@ -309,15 +311,27 @@ void perf_env__init(struct perf_env *env)
> =20
>  static void perf_env__init_kernel_mode(struct perf_env *env)
>  {
> -	const char *arch =3D perf_env__raw_arch(env);
> +	const char *arch =3D env->arch;
[ ... ]
> +	if (arch) {
> +		if (str_ends_with(arch, "64") || !strncmp(arch, "s390x", 5))

[Severity: High]
Does this strict str_ends_with(arch, "64") check reject valid 64-bit
architectures that possess trailing variant suffixes?

For example, architectures like "aarch64_be", "mips64el", or "riscv64gc" do
not end exactly in "64". Will they fail this check and be incorrectly class=
ified
as 32-bit (env->kernel_is_64_bit =3D 0), which could break unwinding and BPF
parsing on those platforms?

[Severity: Critical]
Additionally, could this str_ends_with() check cause standard x86_64 system=
s to
be misclassified as 32-bit locally and in newly recorded perf.data files?

When recording a new perf.data file on x86_64, perf_env__arch() maps the ho=
st
machine to the normalized string "x86" and caches it in env->arch. Later, w=
hen
perf_env__init_kernel_mode() evaluates the cached "x86" string here,
str_ends_with("x86", "64") will evaluate to false, erroneously setting
env->kernel_is_64_bit to 0.

> +			env->kernel_is_64_bit =3D 1;
> +		else
> +			env->kernel_is_64_bit =3D 0;
> +		return;
> +	}
[ ... ]
> @@ -588,51 +602,249 @@ void cpu_cache_level__free(struct cpu_cache_level =
*cache)
[ ... ]
>  const char *perf_env__arch(struct perf_env *env)
>  {
> -	char *arch_name;
> +	uint16_t e_machine;
> +	const char *arch;
> =20
> -	if (!env || !env->arch) { /* Assume local operation */
> +	if (!env) {
[ ... ]
> +	if (env->arch)
> +		return env->arch;

[Severity: High]
By returning env->arch directly and removing the normalize_arch() call, does
this break the parsing of older perf.data files?

When reading from older files, env->arch contains the raw unnormalized stri=
ng
(e.g., "x86_64") from the HEADER_ARCH section. Returning this unnormalized
string directly bypasses standard perf architecture aliases, which could br=
eak
callers expecting canonical names, such as arch_syscalls__strerrno_function=
().

> =20
> -	return normalize_arch(arch_name);
[ ... ]
> +	/*
> +	 * Only cache the normalized arch string in env->arch if the
> +	 * e_machine was successfully resolved (i.e. not the unpopulated
> +	 * fallback to EM_HOST), allowing threads to dynamically indicate
> +	 * a better ELF machine type later.
> +	 */
> +	if (env && env->e_machine !=3D EM_NONE)
> +		env->arch =3D strdup(arch);

[Severity: High]
Since perf_env can be shared across multiple threads during concurrent event
processing (e.g., in perf report), could this unsynchronized lazy caching of
env->arch via strdup() lead to data races and memory leaks?

Multiple threads observing env->arch as NULL could concurrently allocate and
overwrite the same pointer. Additionally, without memory barriers, concurre=
nt
readers might observe a non-NULL env->arch pointer but read uninitialized
memory. Similar unsynchronized lazy writes seem to happen for env->e_machine
and env->e_flags in perf_env__e_machine().

> +	/*
> +	 * Avoid potential crashes on the arch string if memory allocation in
> +	 * strdup fails and NULL were to be returned.
> +	 */
> +	return env->arch ?: arch;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601065407.1597=
927-1-irogers@google.com?part=3D1
