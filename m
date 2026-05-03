Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF951A267
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 01:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777770046; cv=none; b=ZdZQODbewxVQq6JX4xeFpnRez6WQiFGX4JCODunsoHXrMGIvkfeDr77gLjl66m1oAa43Vxwg/WM++X440FqBe+88yrx0hP/FQgIoIliJn69p+SJHP8d1sdj279AmGIRfv1UfK/bLNCvdn4e2K4VZQcm995eCcbb4cVqzkXrk584=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777770046; c=relaxed/simple;
	bh=umluHtWiGlt8tDv1lCoHRUxKwBAIVRRZ+/+9LOkj9YI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=boJd+kXBt1OMHvEV66TTdCdNdODdGJ1s25oXJa5bY7BEVxnmbBu0aS4xaGIMochYYKfPCf/j5ZOBWBYc0rkMjOR9kIJT434KAITxXy79+QDNy8aylOdoS23gDimsf4fPecr7gwvR63q9f9d/jG8ynArYYZ8LyCI6j5Qp3Vs7RS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9vIreaK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9vIreaK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83461C19425;
	Sun,  3 May 2026 01:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777770045;
	bh=umluHtWiGlt8tDv1lCoHRUxKwBAIVRRZ+/+9LOkj9YI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=u9vIreaK8yjlVjjsqsuPl4TY9OGUNDpDRDZKz9mM37ABh+9APot9rVAUOM+XP82K+
	 v/daqlEwHckH3Z0KaWLkifuFxhbe/ksdTsNEBLKwm/jkKx8EHajepMjBTB7kebgSAc
	 qH1t5jTwTpVl2weDrD1C7caJeQqj68T50+K1W0FbcpMCe5FOzvR63IaoSwxDKotT/P
	 Vxa9irQYVdXNWvZVMdmWd/EJNB/2qriH3K0HVYERoyMhZl83y35Ezebx5orfVcQMkS
	 coAIYzvBgdcUHpJ60B1nBYZnBqyMrVd+KKRx2Wot5YtD1s2HLYosTuMgQHVYoJFqne
	 gYfp/HLxRg77A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 16/18] perf env: Add helper to lazily compute the
 os_release
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260503002248.1040791-17-irogers@google.com>
References: <20260503002248.1040791-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 01:00:44 +0000
Message-Id: <20260503010045.83461C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Lazy initialization in `perf_env__os_release` assumes a NULL `os_r=
elease` implies 'live mode', permanently polluting offline trace environmen=
ts with the analysis host's kernel version.
--

commit d62418e881e036f2b1905f5ed81dd67b105e5fb8
Author: Ian Rogers <irogers@google.com>

perf env: Add helper to lazily compute the os_release

This commit introduces a lazy initialization helper for os_release. It
assumes that if os_release is uninitialized, the tool is running in live
mode, and populates it using uname().

[ ... ]

> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 29d5fe37528b..45dde40042b5 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -351,6 +351,27 @@ bool perf_arch_is_big_endian(const char *arch)
>  	return false;
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
> +	env->os_release =3D strdup(ret < 0 ? perf_version_string : uts.release);

If an offline perf.data file was recorded without the HEADER_OSRELEASE feat=
ure
(for example, using --no-feature osrelease), won't env->os_release be NULL?

If so, does this permanently overwrite the target's environment metadata wi=
th
the analysis host's kernel version?

If this occurs, it seems vmlinux_path__init() will search for the analysis
host's kernel path instead of the target's. If the offline trace also lacks
build-ids, could perf silently load the host's kernel symbol table and apply
it to the target's profile, corrupting symbol resolution?

Similarly, could tools like perf data convert silently export the host's OS
release into the new trace data as if it belonged to the target system?

> +	return env->os_release ?: perf_version_string;
> +}
> +
>  int perf_env__set_cmdline(struct perf_env *env, int argc, const char *ar=
gv[])
>  {
>  	int i;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503002248.1040=
791-1-irogers@google.com?part=3D16
