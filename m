Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E47718FDBE
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 00:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777769577; cv=none; b=Cdc4cfXk6jTwL9+EAF+IbsNVK9uNu1NC21cj1n175JBK9X0/OSA5G32StMD7L1T0VQfGx/7kB2e8HpfHdrxs3qREadYMV8d5yFjgd7kX+RyYIZmgcFXkdDGB5k1hTLmae3mhhARh8jNWZkU571dzbzWnNuOU0k5dd/qqiaJZo+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777769577; c=relaxed/simple;
	bh=8xjjh0kZ4sB93F/AqSS7P9b6j7L4HZuZaDXpYO3Qfzc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OQ4mT2S7Ghb1/5XZ9wLmBAiR4+xAQGUGsXR5dLQtS/9umgRscElxYX8dgjd7bhOOl0K8ocEDGfGFEZL++kchRg45NOUoSLRfkmdWbZLqJEhDindipAsv9jRpeiTxzcwbCe+IQzOhL14f9AKGJZxriJLhpnqF05AIu5eNFY2Nr7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+phWDav; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+phWDav"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16405C19425;
	Sun,  3 May 2026 00:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777769577;
	bh=8xjjh0kZ4sB93F/AqSS7P9b6j7L4HZuZaDXpYO3Qfzc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=d+phWDavsg0SjTBUmY9xWwtWqgQQ+YPHSHG4ZCIfqMF2Styk7p2w7qZ74NyzBibsi
	 7xj50z8r09F4TybB86mlVdyfZT9gY6Lvurm6xlkTgGz3jpamNqDQ2B4a9EoE6ycha7
	 Qigm+3VBfl+kmVL1DptUc7xv0f3xzVeMR3f/TDspSK/9LKqx69VycqoWKpB8MyYAXD
	 +2GSVZrg3eg2fX5Bw/Pvvoizk2j0xjw7xOQnA/83X7ULPh0xI1DKztlKexeZUAax46
	 NVAMpqkjo2HCot09f8tY50UZVwU/k5QRXRr7FfytGPjRsdRAr/08RGRN+DNbmclLJl
	 9wnVE1QrqolBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 01/18] perf env: Add perf_env__e_machine helper and
 use in perf_env__arch
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260503002248.1040791-2-irogers@google.com>
References: <20260503002248.1040791-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 00:52:56 +0000
Message-Id: <20260503005257.16405C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Backwards and forwards compatibility breakage via architecture nor=
malization.
- [High] Architecture misclassification and data loss due to guaranteed EM_=
HOST fallback.
- [High] Premature caching of the fallback architecture disables thread-bas=
ed evaluation.
- [High] Flawed 64-bit kernel detection for MIPS, RISC-V, and legacy endian=
ness suffixes.
--

commit 745bee191a4ba7e972076983225158e66679b6ae
Author: Ian Rogers <irogers@google.com>

perf env: Add perf_env__e_machine helper and use in perf_env__arch

This commit introduces a helper to lazily compute the e_machine from the
perf environment and uses the session's e_machine to derive the architecture
string. It updates the data file header writing to fetch the e_machine and
arch from the session if available.

> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 1e54e2c86360..0edc67a468ab 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
[ ... ]
> @@ -309,12 +311,21 @@ void perf_env__init(struct perf_env *env)
> =20
>  static void perf_env__init_kernel_mode(struct perf_env *env)
>  {
> -	const char *arch =3D perf_env__raw_arch(env);
> +	uint16_t e_machine =3D env->e_machine;
> =20
> -	if (!strncmp(arch, "x86_64", 6) || !strncmp(arch, "aarch64", 7) ||
> -	    !strncmp(arch, "arm64", 5) || !strncmp(arch, "mips64", 6) ||
> -	    !strncmp(arch, "parisc64", 8) || !strncmp(arch, "riscv64", 7) ||
> -	    !strncmp(arch, "s390x", 5) || !strncmp(arch, "sparc64", 7))
> +	if (env->arch && (e_machine =3D=3D EM_NONE || e_machine =3D=3D EM_MIPS =
|| e_machine =3D=3D EM_RISCV)) {
> +		if (str_ends_with(env->arch, "64") || !strncmp(env->arch, "s390x", 5))
> +			env->kernel_is_64_bit =3D 1;
> +		else
> +			env->kernel_is_64_bit =3D 0;
> +		return;
> +	}

e_machine_to_perf_arch() returns base strings like "mips" or "riscv" without
a "64" suffix. Does this cause new 64-bit MIPS and RISC-V traces to be
misclassified as 32-bit since str_ends_with() will return false?

Additionally, older perf.data files may contain endianness suffixes like
"mips64el" which correctly matched the previous strncmp() logic. Will these
legacy files fail the new str_ends_with("64") check and corrupt 64-bit
traces?

[ ... ]
> @@ -588,51 +599,187 @@ void cpu_cache_level__free(struct cpu_cache_level =
*cache)
[ ... ]
> -static const char *normalize_arch(char *arch)
> -{
> -	if (!strcmp(arch, "x86_64"))
> -		return "x86";
> -	if (arch[0] =3D=3D 'i' && arch[2] =3D=3D '8' && arch[3] =3D=3D '6')
> -		return "x86";
> -	if (!strcmp(arch, "sun4u") || !strncmp(arch, "sparc", 5))
> -		return "sparc";
> -	if (!strncmp(arch, "aarch64", 7) || !strncmp(arch, "arm64", 5))
> -		return "arm64";
> -	if (!strncmp(arch, "arm", 3) || !strcmp(arch, "sa110"))
> -		return "arm";
> -	if (!strncmp(arch, "s390", 4))
> -		return "s390";
> -	if (!strncmp(arch, "parisc", 6))
> -		return "parisc";
> -	if (!strncmp(arch, "powerpc", 7) || !strncmp(arch, "ppc", 3))
> -		return "powerpc";
> -	if (!strncmp(arch, "mips", 4))
> -		return "mips";
> -	if (!strncmp(arch, "sh", 2) && isdigit(arch[2]))
> -		return "sh";
> -	if (!strncmp(arch, "loongarch", 9))
> -		return "loongarch";
> -
> -	return arch;
[ ... ]
>  const char *perf_env__arch(struct perf_env *env)
>  {
> -	char *arch_name;
> +	uint16_t e_machine;
> +	const char *arch;
> =20
> -	if (!env || !env->arch) { /* Assume local operation */
> -		static struct utsname uts =3D { .machine[0] =3D '\0', };
> -		if (uts.machine[0] =3D=3D '\0' && uname(&uts) < 0)
> -			return NULL;
> -		arch_name =3D uts.machine;
> -	} else
> -		arch_name =3D env->arch;
> +	if (!env)
> +		return e_machine_to_perf_arch(EM_HOST);
> +
> +	if (env->arch)
> +		return env->arch;
> =20
> -	return normalize_arch(arch_name);
> +	/*
> +	 * Lazily compute/allocate arch. The e_machine may have been
> +	 * read from a data file and so may not be EM_HOST.
> +	 */
> +	e_machine =3D perf_env__e_machine(env, /*e_flags=3D*/NULL);
> +	arch =3D e_machine_to_perf_arch(e_machine);
> +	env->arch =3D strdup(arch);
> +	/*
> +	 * Avoid potential crashes on the arch string if memory allocation in
> +	 * strdup fails and NULL were to be returned.
> +	 */
> +	return env->arch ?: arch;
>  }

The removal of normalize_arch() appears to break both backward and forward
compatibility.

When reading older perf.data files, env->arch is populated with the raw
string from the file (e.g., "x86_64"). Without normalize_arch(),
perf_env__arch() will return "x86_64", potentially breaking internal logic
that expects the normalized "x86".

Conversely, for new files, e_machine_to_perf_arch() generates normalized
names like "x86". Older versions of the perf tool expect the raw string for
64-bit detection:

perf_env__init_kernel_mode() {
    const char *arch =3D perf_env__raw_arch(env);

    if (!strncmp(arch, "x86_64", 6) || ...
}

Does this mean older perf binaries will incorrectly parse new 64-bit
perf.data files as 32-bit traces?

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index f30e48eb3fc3..f1ae61392cce 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
[ ... ]
> -static int write_arch(struct feat_fd *ff,
> -		      struct evlist *evlist __maybe_unused)
> +static int write_arch(struct feat_fd *ff, struct evlist *evlist)
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

Is it intended that perf_env__arch() permanently caches the fallback
architecture here?

perf_session__e_machine() avoids caching the fallback EM_HOST when no
threads are present, noting: "Don't cache in the perf_env in case later
threads indicate a better ELF machine type."

However, immediately afterward, perf_env__arch() calls perf_env__e_machine(=
),
which populates env->e_machine =3D EM_HOST. Because it gets cached, will all
subsequent evaluations for the session short-circuit and return EM_HOST,
ignoring the true thread architecture once threads are added?

> =20
> -	return do_write_string(ff, uts.machine);
> +	if (!arch) {
> +		int ret =3D uname(&uts);
> +
> +		if (ret < 0)
> +			return -1;
> +		arch =3D uts.machine;
> +	}
> +	return do_write_string(ff, arch);
>  }

Can the if (!arch) block ever be reached?

perf_env__arch() is guaranteed to return a valid string (or "unknown"),
meaning arch will never be NULL. This skips the uname(&uts) fallback
entirely.

As a result, if it falls back to EM_HOST, won't a 32-bit perf binary
running on a 64-bit kernel incorrectly record a 32-bit system architecture?

Additionally, for system architectures missing from the prefix_to_e_machine
table (e.g., hexagon, openrisc), won't it permanently record "unknown" in
the header instead of the correct uname information?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503002248.1040=
791-1-irogers@google.com?part=3D1
