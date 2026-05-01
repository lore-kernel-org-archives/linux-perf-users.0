Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D3F41C2FD
	for <linux-perf-users@vger.kernel.org>; Fri,  1 May 2026 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777663230; cv=none; b=lRxGke3jSopFM6Vi0HHW7KC5MfpEOGod7cqkw7/PlKDrBRU/kaJyH20GaEpkuBAAF/iw0fZxY6sFgPZ2KQYU+GeX6Ad3RnvZiCGQrbxSS/LLBqWAXekf7QMXXx0V9Vg9Y0KNb/xQ8HrSkrM5Dd0JhsSE7XkSID6yCF3Rn21Rlk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777663230; c=relaxed/simple;
	bh=AmtMNrXVCbXMSMeVgp5I35+YMqH7VKOmCFgLV/wXlSU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MxTxwwRo7hTpIKs7iTbb/lt9SGDVNcN08ISE8hXNI7zgPCp+2mNKnSZdHoAhJbtuo5xjxnLHhhhBw7WiUMHJWsWK3j5vUa6wMJmzi3WoajJs6+zEidj0Vs+scaAQvzdX4KsbUpcTp9K31qPhXn8CcZzz1UnDd4PHF2lMWQV7hBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTbgb8Ze; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTbgb8Ze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACA3C2BCB4;
	Fri,  1 May 2026 19:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777663230;
	bh=AmtMNrXVCbXMSMeVgp5I35+YMqH7VKOmCFgLV/wXlSU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=FTbgb8ZeYRI5C92UNrC0f9tkJ6oTbGpZWVm7JFxSWwBNC62pE68J0mi6DaXgfe8Bc
	 jTFBCB5P4jl7DmwbGo2j+xpRIDggKmfJcAISixuFGDcZElBgC6AZ7nHlhu3m6T/ldS
	 NAo7P9TZPAnu0k/9q3hFv1USh05IM7C9pTeGCs+Z6gzdCkPTPKCo1nIkPSl+iExzDT
	 wEWoMJqz4v6a6yLUV/fVyHWtks+zZ/J0HeUlkkcloT4P0aBQx/Jg3Wmd9bUCeVf5O8
	 D1wHUFiOQXw4LJLxZs2eDg2EdSm2wi9XmYJvmH//Kv/YOqtFgb2V8bjuD3SxBQIpYK
	 GwwEsG0AZqElw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/4] perf env: Add helper to lazily compute the
 os_release
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260501182021.3651851-3-irogers@google.com>
References: <20260501182021.3651851-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 May 2026 19:20:29 +0000
Message-Id: <20260501192030.4ACA3C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `perf_env__os_release()` helper corrupts offline trace metadat=
a by incorrectly assuming an uninitialized `os_release` implies 'live mode'=
, lazily populating it with the analysis host's kernel version.
- [Medium] Using `perf_version_string` as a fallback for the OS release is =
semantically incorrect and pollutes trace headers.
--

commit 9cca0f2ccb3995708fd2106d23dda3d1c07d1fd9
Author: Ian Rogers <irogers@google.com>

perf env: Add helper to lazily compute the os_release

In live mode the os_release isn't being initialized, make a lazy
initialization helper that assumes when the os_release isn't
initialized this is live mode.

> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 1671769d44411..c3e464c6de2f1 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c

[ ... ]

> @@ -330,6 +330,27 @@ int perf_env__kernel_is_64_bit(struct perf_env *env)
>  	return env->kernel_is_64_bit;
>  }
> =20
> +const char *perf_env__os_release(struct perf_env *env)
> +{
> +	struct utsname uts;
> +	int ret;
> +
> +	if (!env)
> +		return perf_version_string;
> +
> +	if (env->os_release)
> +		return env->os_release;
> +
> +	/*
> +	 * The os_release is being accessed but wasn't initialized from a data
> +	 * file, assume this is 'live' mode and use the release from uname. If
> +	 * uname or strdup fails then use the current perf tool version.
> +	 */
> +	ret =3D uname(&uts);

If we are doing offline analysis of a perf.data file that lacks the OS
release feature header, env->os_release will be NULL.

Does this helper incorrectly assume we are in live mode, and lazily
populate env->os_release with the analysis host's kernel version?

If so, it appears this causes tools to use the wrong vmlinux path for the
target profile in vmlinux_path__init() and potentially break symbol
resolution.

It also looks like this causes ctf_writer__setup_env() to export the host
kernel version into the CTF trace instead of safely skipping the missing
field as it did previously.

> +	env->os_release =3D strdup(ret < 0 ? perf_version_string : uts.release);
> +	return env->os_release ?: perf_version_string;
> +}

Is it appropriate to use the perf tool version (perf_version_string) as a
fallback for the OS release if uname() or strdup() fails?

This string could end up permanently written into the perf.data file's OS
release section, or cause bogus filesystem lookups in vmlinux_path__init()
since the tool version format differs from the kernel release.

Would it be safer to return NULL or a generic unknown string here instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260501182021.3651=
851-1-irogers@google.com?part=3D2
