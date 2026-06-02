Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EA03D1CB0
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780415032; cv=none; b=c0V0H7LIWNCVSYQy6uzCNl2nmbikjp0PI1IAv1eiiHisI9cfB4XXJtcX1oXc5kAFkmI7JZxXhQfTsnQ9d019mn8aVVRKT5hCjnOLCW3VGAD6nu8tPKq4r5Njv4hBaOusaTAoS86Z9HOVGUSkkc9C/nRNT9QYrfNQmXu5FupRpjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780415032; c=relaxed/simple;
	bh=wXY3JHCv6WVWyktazaGl8uTj7QXsYOjBRJS0aMMVHPw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oFzPTzv3pz70vQeT85rC20SGYxURgtcGIXwATov1Tx4C6cIbvCYlT9aNNguv1uxbyiJ2OgqHSzT19C7HFVOULkNvjaL+J2S48FmWrzNkTS/2vpVMWOv4Uo0Vsp60b+Up7pO8ahWeGWEfrmDeUhtEkTUEJYZ+vmGhsvf3vJ7ObB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJ79aWsU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJ79aWsU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2709F1F00893;
	Tue,  2 Jun 2026 15:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780415031;
	bh=b9FKlanO/dOf4U3OHpNzLW9VWsjDnldAgdLIw26xQIk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CJ79aWsUrs7ZWGH9snglBFB3vot1Ze6yqBC4WpRS1BAufoRCAkFfmy7CZySAjxy0U
	 6t0o0wrH6Do+t6bryitMCrw8eGjW/aW6YHZZB5BDz63IgRR1/OrmI6ElQesctC/U1k
	 q9fZHzPcWC9yck/8ROOxMMdXjUocCm0dxVkikUhA6XziIU+MAtoeWFM1v70zaaVCPA
	 HjinVHwNS87UalwM9Kj7bIXt6sob59dD0Zrf0i3J2/0E0XjWVzz7cv27imwFXeO0Wi
	 TOyf4mRorxez18lFMAJXJBfXgD2k3yK2UR5JadAlJhCoJeiEiPHWgHbTaAEXKSOX/n
	 Xbi8ziHqWlzMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 01/19] perf env: Add perf_env__e_machine helper and
 use in perf_env__arch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602152516.2831152-2-irogers@google.com>
References: <20260602152516.2831152-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 15:43:50 +0000
Message-Id: <20260602154351.2709F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] write_arch() writes a normalized architecture string missing b=
itness information, causing 64-bit architectures to be misclassified as 32-=
bit.
- [High] Premature caching of arch-derived `e_machine` disables dynamic thr=
ead-based `e_machine` scanning for older `perf.data` files.
- [High] Unsynchronized access to static struct utsname buffer causes data =
race and potential misclassification of host architecture.
--

commit db9bef861f1ee88707f9b3fa27ee30444f0ff977
Author: Ian Rogers <irogers@google.com>

perf env: Add perf_env__e_machine helper and use in perf_env__arch

This commit adds a helper to lazily compute the e_machine and fallback to
EM_HOST. It updates perf_env__arch to use this helper and modifies the
session header logic to record e_machine without forcing premature thread
scanning.

> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
[ ... ]
> @@ -309,15 +311,27 @@ void perf_env__init(struct perf_env *env)
> =20
>  static void perf_env__init_kernel_mode(struct perf_env *env)
>  {
> -	const char *arch =3D perf_env__raw_arch(env);
> +	const char *arch =3D env->arch;
> =20
> -	if (!strncmp(arch, "x86_64", 6) || !strncmp(arch, "aarch64", 7) ||
> -	    !strncmp(arch, "arm64", 5) || !strncmp(arch, "mips64", 6) ||
> -	    !strncmp(arch, "parisc64", 8) || !strncmp(arch, "riscv64", 7) ||
> -	    !strncmp(arch, "s390x", 5) || !strncmp(arch, "sparc64", 7))
> -		env->kernel_is_64_bit =3D 1;
> -	else
> -		env->kernel_is_64_bit =3D 0;
> +	if (!arch) {
> +		static struct utsname uts =3D { .machine[0] =3D '\0', };
> +
> +		if (uts.machine[0] =3D=3D '\0')
> +			uname(&uts);
> +		if (uts.machine[0] !=3D '\0')
> +			arch =3D uts.machine;
> +	}

[Severity: High]
Is it safe to use a lockless check for this static buffer here, as well as =
in
perf_env__e_machine_nocache() and perf_env__arch()?

If multiple threads concurrently trigger uname(&uts), could one thread obse=
rve
uts.machine[0] !=3D '\0' immediately after the kernel writes the first byte?

Since uname copies data sequentially, might a thread read a partially writt=
en
string (e.g., 'x8' instead of 'x86_64'), leading to a misclassified host
architecture during multi-threaded profiling?

It appears that while a subsequent commit ("perf env: Add mutex to protect
lazy environment initialization") adds env->lock to perf_env for os_release,
it might not protect these local static buffers.

[ ... ]
> @@ -588,51 +602,237 @@ void cpu_cache_level__free(struct cpu_cache_level =
*cache)
[ ... ]
> +uint16_t perf_env__e_machine(struct perf_env *env, uint32_t *e_flags)
> +{
> +	uint16_t e_machine;
> +	uint32_t local_e_flags =3D 0;
> +
> +	if (env && env->e_machine !=3D EM_NONE) {
> +		if (e_flags)
> +			*e_flags =3D env->e_flags;
> +
> +		return env->e_machine;
> +	}
> +	e_machine =3D perf_env__e_machine_nocache(env, &local_e_flags);
> +	/*
> +	 * Only cache the e_machine in perf_env if env->arch is not NULL.
> +	 * If env->arch is NULL, the e_machine is just a fallback to EM_HOST.
> +	 * Caching it permanently would prevent dynamic, more accurate
> +	 * thread-based session e_machine scanning later in
> +	 * perf_session__e_machine().
> +	 */
> +	if (env && env->arch) {
> +		env->e_machine =3D e_machine;
> +		env->e_flags =3D local_e_flags;
> +	}

[Severity: High]
Could this cache the arch-derived value into env->e_machine simply because
env->arch is present?

If this caches the value prematurely, might older perf.data files that lack
HEADER_E_MACHINE have env->e_machine populated before the threads are scann=
ed?

When functions like thread__insert_map() invoke thread__e_machine_endian(),
they fall back to perf_env__e_machine() and perf_env__arch() if a DSO is not
yet loaded. Does this lock in the arch-derived host value prematurely?

> +	if (e_flags)
> +		*e_flags =3D local_e_flags;
> +
> +	return e_machine;
>  }
[ ... ]
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -441,21 +441,25 @@ static int write_osrelease(struct feat_fd *ff,
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
> +	if (evlist->session)
> +		arch =3D perf_env__arch(perf_session__env(evlist->session));
> +
> +	if (!arch) {
> +		int ret =3D uname(&uts);
> =20
> -	return do_write_string(ff, uts.machine);
> +		if (ret < 0)
> +			return -1;
> +		arch =3D uts.machine;
> +	}
> +	return do_write_string(ff, arch);
>  }

[Severity: Critical]
Does this code write the normalized architecture string lacking bitness
information to the perf.data header instead of the full uts.machine string?

If perf_env__arch() normalizes the architecture name (e.g., 'x86_64' to 'x8=
6'),
the resulting string will miss the '64' substring.

Later in perf_env__init_kernel_mode():

	if (arch) {
		if (strstr(arch, "64") || strstr(arch, "s390x"))
			env->kernel_is_64_bit =3D 1;
		else
			env->kernel_is_64_bit =3D 0;
		return;
	}

Could this cause kernel_is_64_bit to incorrectly evaluate to 0 for 64-bit
architectures like x86, powerpc, and sparc, leading to broken kernel symbol
resolution, broken dynamic architecture fallbacks, and loss of backwards
compatibility for older perf versions reading newly recorded files?

[ ... ]
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -4080,14 +4080,19 @@ uint16_t perf_session__e_machine(struct perf_sess=
ion *session, uint32_t *e_flags
[ ... ]
> +	/*
> +	 * Is the env caching an e_machine? If not we want to compute from the
> +	 * more accurate threads.
> +	 */
>  	env =3D perf_session__env(session);
> -	if (env && env->e_machine !=3D EM_NONE) {
> -		if (e_flags)
> -			*e_flags =3D env->e_flags;
> -
> -		return env->e_machine;
> -	}
> +	if (env && env->e_machine !=3D EM_NONE)
> +		return perf_env__e_machine(env, e_flags);

[Severity: High]
Does this early return consume the prematurely cached value from
perf_env__e_machine()?

If env->e_machine was populated early because env->arch was present, would
this bypass the machines__for_each_thread() scan entirely, preventing the
dynamic detection of 32-bit compat tasks on a 64-bit host for older perf.da=
ta
files?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602152516.2831=
152-1-irogers@google.com?part=3D1
