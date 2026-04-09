Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C83139A818
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Apr 2026 23:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775777853; cv=none; b=ZELVs4jXrYpyhiKGgq3QtzBxmqR6K+oGBLGRpCDtaAvPjReImeedr2EIGcBV1N6Vkqn3ST6Qf5K+GNBzIs7ADaVP+Coi9/cJ5fWlUN4Wkx+tlxlmbBVLZcB6hHFROPnBCAcFG+3YAJdf4rOCpVXKcNO33OmxXwHuDavESqYb5XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775777853; c=relaxed/simple;
	bh=f/yTPiGv/ChF9oagGG1MbhcjjwuSgDA/WygG5hGCuxY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tLNSrPdrkRIXhtX4uGmkc1oCG/DGAMjk8OkgQvoGVhqQVYcPhqXnqMAvCtBi/xERCJmFQkvJQjqRQzmJSJAL9Hjxj4q6TUBFqtHeMYHmkrVh/fLOic0cWmus5tXtJC7i61qY3lrliKuZZMzXCC2r6BGug/p8YRbdINpN2IZhLzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjQ1neZn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjQ1neZn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3D6C4CEF7;
	Thu,  9 Apr 2026 23:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775777852;
	bh=f/yTPiGv/ChF9oagGG1MbhcjjwuSgDA/WygG5hGCuxY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JjQ1neZncw6/wGpMfHEbk+s9UAgMkk1Ps2JTkFOKqZwRUMgyJtmABnJ1KAlTexByZ
	 XX48t/fEJIiZxCv3qIP4R3nWlqNMXEjyTwm0qdFc0b4iJg4Fq8C0jQbTgVocfe5uAu
	 HUPhhkM4r7PAsn6mG6E8okhq+9DgPAHMT4Mhkej+uSeUaPZ/hbFarN2UPdoSbip4cu
	 UL4JhNvvQLOsDlNZtIhA6oSxx9gBhm0uwP96ztsw7dG4PWaeTq5yenKVZgiW6wbCU9
	 2zFkGtWo2X24011jvQa2jqaw0v+Q6HUjgISna772R6UMCmfnoEyU9GfSo165by0Pja
	 y+jBrjttInYvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/3] perf env: Add perf_env__e_machine helper and use
 in perf_env__arch
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260409230620.4176210-2-irogers@google.com>
References: <20260409230620.4176210-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Apr 2026 23:37:32 +0000
Message-Id: <20260409233732.8F3D6C4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] perf_session__e_machine() bypasses lazy evaluation of e_machine fr=
om env->arch when env->e_machine is EM_NONE, breaking cross-architecture an=
alysis of legacy perf.data files.
- [High] Uninitialized env->kernel_is_64_bit coerces to true, causing 32-bi=
t architectures to be parsed as 64-bit.
- [High] write_arch() silently caches EM_HOST, permanently bypassing accura=
te thread-based architecture detection during perf record.
- [Medium] Unhandled OOM in process_arch() leaves env->arch as NULL, leadin=
g to a subsequent NULL pointer dereference.
--

commit a2ed4a04364ee664047eec1e47e4e540e458eff9
Author: Ian Rogers <irogers@google.com>

perf env: Add perf_env__e_machine helper and use in perf_env__arch

Add a helper that lazily computes the e_machine and falls back of
EM_HOST. Use the perf_env's arch to compute the e_machine if
available. Use a binary search for some efficiency in this, but handle
somewhat complex duplicate rules.

> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 1e54e2c863605..339d62ca37bb8 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
[ ... ]
> @@ -588,51 +590,160 @@ void cpu_cache_level__free(struct cpu_cache_level =
*cache)
[ ... ]
> +uint16_t perf_env__e_machine(struct perf_env *env, uint32_t *e_flags)
> +{
> +	if (!env) {
> +		if (e_flags)
> +			*e_flags =3D EF_HOST;
> +
> +		return EM_HOST;
> +	}
> +	if (env->e_machine =3D=3D EM_NONE) {
> +		env->e_machine =3D perf_arch_to_e_machine(env->arch, env->kernel_is_64=
_bit);

Is env->kernel_is_64_bit guaranteed to be a boolean here?

If env->kernel_is_64_bit is uninitialized, it defaults to -1 in
perf_env__init(). In C, -1 evaluates as true, which would cause 32-bit
architectures to be parsed as 64-bit (e.g., returning EM_X86_64 instead
of EM_386).

Should this use the lazy evaluator perf_env__kernel_is_64_bit(env) instead?

[ ... ]
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index c6efddb70aee2..9bb4a271b4f8a 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -370,21 +370,25 @@ static int write_osrelease(struct feat_fd *ff,
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

When write_arch() is called during perf record, it invokes perf_env__arch().
Since env->arch is NULL and env->e_machine is EM_NONE, this falls back to
perf_arch_to_e_machine(NULL, ...), locking env->e_machine to EM_HOST.

Later, when write_e_machine() calls perf_session__e_machine(), the check for
env->e_machine !=3D EM_NONE will evaluate to true.

Will this permanently bypass the accurate thread-based architecture detecti=
on
(machines__for_each_thread) designed to handle mixed 32/64-bit threads?

[ ... ]
> @@ -2675,10 +2679,30 @@ static int process_##__feat(struct feat_fd *ff, v=
oid *data __maybe_unused) \
[ ... ]
> +static int process_arch(struct feat_fd *ff, void *data __maybe_unused)
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

If the strdup() inside perf_env__arch() fails due to memory constraints,
it returns NULL and env->arch remains NULL.

Since process_arch() unconditionally returns 0 here, could this lead to a
NULL pointer dereference later if strncmp() is called on the architecture
string?

> +	}
> +	ff->ph->env.e_machine =3D saved_e_machine;
> +	return 0;
> +}
> +
>  static int process_e_machine(struct feat_fd *ff, void *data __maybe_unus=
ed)
>  {
>  	int ret;
[ ... ]
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index fe0de2a0277f0..726568b888039 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -3023,14 +3023,16 @@ uint16_t perf_session__e_machine(struct perf_sess=
ion *session, uint32_t *e_flags
>  		return EM_HOST;
>  	}
> =20
> +	/* Is the env caching an e_machine? */
>  	env =3D perf_session__env(session);
> -	if (env && env->e_machine !=3D EM_NONE) {
> -		if (e_flags)
> -			*e_flags =3D env->e_flags;
> -
> -		return env->e_machine;
> -	}
> +	if (env && env->e_machine !=3D EM_NONE)
> +		return perf_env__e_machine(env, e_flags);

For legacy perf.data files without HEADER_E_MACHINE, process_arch() restores
env->e_machine to EM_NONE.

Since the condition here explicitly requires env->e_machine !=3D EM_NONE, w=
on't
this completely bypass the new lazy evaluator and fall back to EM_HOST,
potentially breaking cross-architecture analysis for legacy files?

> =20
> +	/*
> +	 * Compute from threads, note this is more accurate than
> +	 * perf_env__e_machine that falls back on EM_HOST and doesn't consider
> +	 * mixed 32-bit and 64-bit threads.
> +	 */
>  	machines__for_each_thread(&session->machines,
>  				  perf_session__e_machine_cb,
>  				  &args);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260409230620.4176=
210-1-irogers@google.com?part=3D1
