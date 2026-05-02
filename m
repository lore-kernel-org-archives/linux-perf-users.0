Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DDB275870
	for <linux-perf-users@vger.kernel.org>; Sat,  2 May 2026 07:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777708576; cv=none; b=iUtV1qW2MRZV4sxHGEhOeW0aRHIjZk5teAkhu3iFwGcLDrTIuX1MNIo8ZIMTPZHRDCfma00hINbe8v0KIq/2Xvv6jAK/sctMj4LXhR42N1sYWa5eWWwQhVTQ9e9HrogITju1Bj02enqozwCrWUUDMuB5riGU+98QoPQzQBIKZ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777708576; c=relaxed/simple;
	bh=TRqXGIIGfBdanaGOR0pTMmMuOOTSfxqshMoazjSvtB4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ckkn0Y8ASQfroMMjxoF0IrlrV0ciFScTiXn+76iK3NVM/klAtdI095XxHu2pWqQve4HHV5cUVPScvCOXhIfuowxxUcLoVRRWUxpU+dyT3JlVc4akPWcseu/GNbQgwgghHt0JlALeM3eLP3luxt0PTXeKsqkQeFhVp6K3sp1Aptg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFnxc3TY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFnxc3TY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4492CC19425;
	Sat,  2 May 2026 07:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777708576;
	bh=TRqXGIIGfBdanaGOR0pTMmMuOOTSfxqshMoazjSvtB4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=vFnxc3TYjssWFQMEIJchQZyDnelC0nbgdn1dmkZIWHgd/ClXLt/v1TTSGc8cTCndp
	 laGlfsyUtCrTGGGAHxCD3a1LAN6nDJ3f2Lt82XRSC5J/U0oaf1XLP98XUDkDT2IuXH
	 Cr6FjsxwrX/1YoMlZkHga7Q1S2x0MGxFjkGzwB9CPGHOrbMFwHJI4NdUhyszjexJ2a
	 Q7qrvRTt3bLk+qMsvuJTr7YcJwFsTX9dWRS7W6R+AKoclmnslYtKluI98ek2SPVKj8
	 N8MMbH/2P3I/smCi0Ovf0wwa7ceadOcDEs/TNbdlsDiuaZvgJ+mSHmnGjvtX2TTDpQ
	 HgpU4dp/BMI3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 01/17] perf env: Add perf_env__e_machine helper and
 use in perf_env__arch
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260502065935.291960-2-irogers@google.com>
References: <20260502065935.291960-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 02 May 2026 07:56:15 +0000
Message-Id: <20260502075616.4492CC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Uninitialized stack memory is leaked to the perf.data file and cac=
hed in the environment.
- [High] Lossy canonicalization of the architecture string breaks 64-bit de=
tection for old and new perf.data files.
- [Medium] If strdup() fails during process_arch(), env->arch is silently l=
eft as NULL.
--

commit 8073d9a9766717469f9a62174c92bb53c77a0df4
Author: Ian Rogers <irogers@google.com>

perf env: Add perf_env__e_machine helper and use in perf_env__arch

This commit introduces a helper to lazily compute the e_machine and update =
the
perf_env's arch calculation. It updates the session to use the new helper a=
nd
modifies how the perf data file header extracts the e_machine and e_flags.

> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 1e54e2c86360..4ff4caab3b32 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
[ ... ]
> +uint16_t perf_env__e_machine_nocache(struct perf_env *env, uint32_t *e_f=
lags)
> +{
> +	uint16_t e_machine =3D EM_HOST;
> +
> +	if (env)
> +		e_machine =3D perf_arch_to_e_machine(env->arch, env->kernel_is_64_bit);
> +
> +	if (e_flags && e_machine =3D=3D EM_HOST)
> +		*e_flags =3D EF_HOST;
> +
> +	return e_machine;
> +}
> +
> +uint16_t perf_env__e_machine(struct perf_env *env, uint32_t *e_flags)
> +{
> +	uint16_t e_machine;
> +	uint32_t local_e_flags;

Could local_e_flags be used uninitialized here?

If e_machine !=3D EM_HOST in perf_env__e_machine_nocache(), *e_flags is not
written to, which leaves local_e_flags uninitialized.

> +
> +	if (env && env->e_machine !=3D EM_NONE) {
> +		if (e_flags)
> +			*e_flags =3D env->e_flags;
> +
> +		return env->e_machine;
> +	}
> +	e_machine =3D perf_env__e_machine_nocache(env, &local_e_flags);
> +	if (env) {
> +		env->e_machine =3D e_machine;
> +		env->e_flags =3D local_e_flags;

If local_e_flags is uninitialized, does this leak stack memory into the
environment?

> +	}
> +	if (e_flags)
> +		*e_flags =3D local_e_flags;
> +
> +	return e_machine;
>  }
[ ... ]
>  const char *perf_env__arch(struct perf_env *env)
>  {
[ ... ]
> +	/*
> +	 * Lazily compute/allocate arch. The e_machine may have been
> +	 * read from a data file and so may not be EM_HOST.
> +	 */
> +	e_machine =3D perf_env__e_machine(env, /*e_flags=3D*/NULL);
> +	arch =3D e_machine_to_perf_arch(e_machine);
> +	env->arch =3D strdup(arch);

If strdup() fails due to memory exhaustion, could env->arch be left as NULL?

> +	/*
> +	 * Avoid potential crashes on the arch string if memory allocation in
> +	 * strdup fails and NULL were to be returned.
> +	 */
> +	return env->arch ?: arch;
>  }
> =20
>  #if defined(HAVE_LIBTRACEEVENT)
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index f30e48eb3fc3..8d5152bde25d 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
[ ... ]
> -static int write_e_machine(struct feat_fd *ff,
> -			   struct evlist *evlist __maybe_unused)
> +static int write_e_machine(struct feat_fd *ff, struct evlist *evlist)
>  {
>  	/* e_machine expanded from 16 to 32-bits for alignment. */
>  	uint32_t e_flags;

Could e_flags be leaked to the perf.data file here?

If no threads supply a valid ELF machine and the fallback logic invokes
perf_env__e_machine_nocache() returning e_machine !=3D EM_HOST, e_flags
may remain uninitialized stack garbage.

> -	uint32_t e_machine =3D EM_HOST;
> +	uint32_t e_machine =3D perf_session__e_machine(evlist->session, &e_flag=
s);
>  	int ret;
> =20
>  	ret =3D do_write(ff, &e_machine, sizeof(e_machine));
>  	if (ret)
>  		return ret;
> =20
> -	return do_write(ff, &e_machine, sizeof(e_machine));
> +	return do_write(ff, &e_flags, sizeof(e_flags));

Does this write the potentially uninitialized stack memory to the file head=
er?

>  }
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

If strdup() failed inside perf_env__arch(), could ff->ph->env.arch be left
as NULL, while this function incorrectly returns 0 (success) leading to
later NULL pointer dereferences?

Additionally, does this canonicalization strip architecture suffixes like "=
64"?

For legacy perf.data files lacking the HEADER_E_MACHINE feature,
saved_e_machine would be restored to EM_NONE. If the string is canonicalized
from "x86_64" to "x86" (based on e_machine_to_perf_arch()), subsequent call=
s to
perf_env__init_kernel_mode() will check str_ends_with(env->arch, "64"). Bec=
ause
it's now "x86", the kernel_is_64_bit flag will be set to 0.

Does this break 64-bit detection and parsing for 64-bit recordings?

> +	}
> +	ff->ph->env.e_machine =3D saved_e_machine;
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260502065935.2919=
60-1-irogers@google.com?part=3D1
