Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198493A75A3
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 06:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780382471; cv=none; b=hNHW81NEEK1Svp6eoGB1/JV4+2MRLNz18CqoXcOa0dO6OF4RMbNcg2mNWm8gHZ3efau81hIodVJKgUngoAXRs/rHKd8XhPeV1mIffo8B8qxbl6n8sOwRDB50F1qeaSq85G8XB/ahg8GUTzwpTU35wRbxfzPXtONNlfnE1rNzlSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780382471; c=relaxed/simple;
	bh=aVTQg2WN6YrdcvmLEDEOjW7v0RgoHy1FAANWW9L8BYc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tcrlNb18VJ1bf/AHoVGAFN1bPDkYNL8nVTB8nkpgavaV6+3ucQ8K2dkb51vvt4u++IZ6zDVQbQcMYdqjn1TBrwx6K6NHCOD0TFMuNLJUn5QorBwMNYeVi1z1UsqyMKOVv2pYDeDOjCQ26Wy2A1oV4QbWphXQHrMyQgpaMN3BLA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmFiTA8v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmFiTA8v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C855D1F00893;
	Tue,  2 Jun 2026 06:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780382469;
	bh=Nn56kxL6bXKs75Y3nCNZ76wyfjJIKY2l1XrQeV2VI4o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MmFiTA8vHoyJAmLRzV/XRMeZmblfcuFz50i8rTDNfsc9jm7vs85GclhXAoLAl32Qh
	 SA7ZmbpmTXAaBvUV9rfxdtSKlyJoOwb74JwNwL0UQ0u8TbAkF/0PHxZRKoeiyHLuwR
	 65IpUJzO3crKqcQM4dYPpr3yV/veXwIsQ3EBmdlOLWv2T4E92ohzvD6IHTyFecD5aS
	 jh+YqTYGe77x0wOfpAOBOtj27euDGYdYyj9JtvhqnUD5tDR+tHVquFdYAz34Hg/Cky
	 sLPWcVGpKYh8xRj74j4tC479YyhZoN2vkZimyW1YDmuItVdp1PD7/dF4/LxCoru66F
	 O5aTDTa2uEgzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 01/19] perf env: Add perf_env__e_machine helper and
 use in perf_env__arch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602062452.2583619-2-irogers@google.com>
References: <20260602062452.2583619-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 06:41:09 +0000
Message-Id: <20260602064109.C855D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Writing the normalized architecture string instead of the raw host=
 string to HEADER_ARCH breaks 64-bit kernel detection.
- [High] Lockless reads and writes of `env->e_machine` and `env->e_flags` c=
an cause data tearing and incorrect flag values.
--

commit c84846b53351380843f7a9f4a25aa8273e1fb3a5
Author: Ian Rogers <irogers@google.com>

perf env: Add perf_env__e_machine helper and use in perf_env__arch

Add a helper that lazily computes the e_machine and falls back to EM_HOST.
Use the perf_env's arch to compute the e_machine if available, using a
binary search for efficiency while handling duplicate rules.

> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 20953ef7b9d8f..0cd23b5fc6515 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
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
Can concurrent lockless updates to env->e_machine and env->e_flags cause a
race condition?

If Thread A sets env->e_machine and is about to set env->e_flags, and Threa=
d B
concurrently observes env->e_machine !=3D EM_NONE in this function, Thread B
might read a stale or zero value for env->e_flags before Thread A finishes
writing it.

A similar unprotected update happens in perf_session__e_machine().

This appears to be fixed later in the series by the commit "perf env: Add m=
utex
to protect lazy environment initialization", but could this intermediate st=
ate
cause problems with per-thread event parsing?

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 5b1fa1653d2a4..220e7720fbdbc 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -441,21 +441,25 @@ static int write_osrelease(struct feat_fd *ff,
>  	return do_write_string(ff, uts.release);
>  }
> =20
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

[Severity: High]
Does this code inadvertently break 64-bit kernel detection?

Since write_arch() now uses perf_env__arch() which returns a normalized arch
string (e.g., "x86" or "s390"), it writes that normalized string to HEADER_=
ARCH
in the perf.data file.

Later, process_arch() reads this back into env->arch. Then,
perf_env__init_kernel_mode() checks if env->arch contains "64" or "s390x":

tools/perf/util/env.c:perf_env__init_kernel_mode() {
...
	if (arch) {
		if (strstr(arch, "64") || strstr(arch, "s390x"))
			env->kernel_is_64_bit =3D 1;
...

Because "x86" and "s390" lack these substrings, won't this misclassify 64-b=
it
kernels as 32-bit and break things like VDSO unwinding or BPF contexts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602062452.2583=
619-1-irogers@google.com?part=3D1
