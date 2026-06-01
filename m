Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CDF384CE6
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780298245; cv=none; b=tP4zq8VEuS2EOdZiZd901E4SscyTyMV7s5lDeKpJX7FQG5wmSEpr4EG5C5Q4Hw2fSV/UgdxbrK2rhUcxmrFzYBbt1Qv/WnJeVjIFyZ4TbA3SHxTdJonAIkUxU8LjVW5sSM9Fr0v6+J0p7dmiNsK3fYDjbQDXevBSoh95mqViDds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780298245; c=relaxed/simple;
	bh=bxFcd8ste8IwctFo9/05P4wK8XgT/BlYcgBuDOsFF2Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LEUdFXhzj1KqM7gBWV6ijwdvr3vUVry318Y3T/Oc7yF0EXXkUbCqpm3XuEzYNk9rBvqbn7FV+TjWVFi8clAGQ8gnlSk66nNGk5ds4IKTIEoho4/5G4bzUQC+wy4pS7Z1KoZsP8DQTYt9MOd/UlNTnwWs1yx3hTPgrIUGtAgTw+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CH9S0YRF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CH9S0YRF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D722B1F00893;
	Mon,  1 Jun 2026 07:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780298244;
	bh=tMLWy/m6xbyj8XOF77hmB1vBt/6pAfsmPAW4Lr9ddmA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CH9S0YRFe8OckP7tLb5t+ZhIy/WnwR3k+5fj9FIZblKV2NONjQJ4NEdHd069p/ifW
	 0aSLIxvborLSxdzkbKf0lyqMiDCTuZ9a7sdcrtHskBFezmfZsm2+RidR24VvpS87Ly
	 9Tu7A4aJ6YpmO2etn5h5NzUUuVb7629YhidJp6Qp6RCVwhiEh0tTfzGaDxgVkz35xe
	 6TKfXXrkhYlUDASpI4wcwGQNHz7uWKwDLSqX7sWoqmbQJztrjsisDLxqhlOdfs1Hhi
	 aSgo9UoGV35oDwzY7Smmtfz7CPH0xEv4XcOf2bIZzHznlcqjORKRsb/RDMcBnhLDam
	 wI818gLIF8jkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 16/18] perf env: Add helper to lazily compute the
 os_release
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260601065407.1597927-17-irogers@google.com>
References: <20260601065407.1597927-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 07:17:23 +0000
Message-Id: <20260601071723.D722B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `perf_env__os_release()` helper incorrectly assumes an unini=
tialized `os_release` implies 'live mode' and populates the target environm=
ent with the host's OS release. This breaks cross-platform analysis of olde=
r `perf.data` files or pipe-mode streams.
- [Medium] Lockless lazy initialization of `env->os_release` creates a TOCT=
OU race condition, leading to potential memory leaks and unprotected data r=
aces in multi-threaded scenarios.
--

commit 3468e6592e2930724952882eef7d315b977f7343
Author: Ian Rogers <irogers@google.com>

perf env: Add helper to lazily compute the os_release

This commit introduces a helper to lazily initialize the os_release in
perf_env. When the os_release is uninitialized, the helper assumes the tool
is running in live mode and populates the field using the host's uname.

> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index f61e108646133..b4fb7420b604b 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
[ ... ]
> @@ -358,6 +358,27 @@ bool perf_arch_is_big_endian(const char *arch)
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

[Severity: Medium]
Is this safe from concurrent execution in multi-threaded scenarios?

If multiple threads find env->os_release as NULL simultaneously, could they
independently call uname(), allocate strings via strdup(), and unconditiona=
lly
overwrite the shared pointer, leaking the memory allocated by the other
racing threads?

> +
> +	/*
> +	 * The os_release is being accessed but wasn't initialized from a data
> +	 * file, assume this is 'live' mode and use the release from uname. If
> +	 * uname or strdup fails then use the current perf tool version.
> +	 */
> +	ret =3D uname(&uts);
> +	env->os_release =3D strdup(ret < 0 ? perf_version_string : uts.release);

[Severity: Medium]
Does this break cross-platform and offline analysis for older data files?

When processing a perf.data file from an older tool version that lacks an
os_release header, this helper assumes live mode and mutates the target
environment with the current host's OS release.

Could this cause offline data converters, like output_headers() in
tools/perf/util/data-convert-json.c, to incorrectly export the analysis
host's kernel version instead of the target system's version?

> +	return env->os_release ?: perf_version_string;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601065407.1597=
927-1-irogers@google.com?part=3D16
