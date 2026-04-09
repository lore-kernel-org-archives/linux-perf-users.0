Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4C33A2553
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Apr 2026 23:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775778659; cv=none; b=tt0G1HISdeJKoeszpXoieS05ZKp/0wN7NdCWRYP1ERsb96rePTEFa4VyOKjiP1omYOr8psrkxo9zxDdmmn6yd08440X6qwhJCLIY9WjHsbrhPTYi/xlVcOgiP34iwq2jLHBST1wR1a3Gg3DGlh1+Eyz6P6dE5/ROWgOXU7JJI30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775778659; c=relaxed/simple;
	bh=fbUMyXJzH/afvAvb/qsDKdi8XMLNkvGhM73ehv2bxNo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CeAcBMaPWOAL0EXCpGfB1o1wvysRyxlQ930Awpe/Vrz3LbIEzrA2PEwuesMBrAWrYJawSE+I02kvNS+jAOb5PAopkdsLbdT6W8jxsQVakWomcKZhvM46xxIPME6hbn4pfwKteoM3vlwJu/QwWkWe+XKa2y8MC7XUp5r/xX5rWVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjG+mlbD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjG+mlbD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB942C4CEF7;
	Thu,  9 Apr 2026 23:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775778658;
	bh=fbUMyXJzH/afvAvb/qsDKdi8XMLNkvGhM73ehv2bxNo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=VjG+mlbDAcO2O1E+vnPNkUCOxbSvk1UdAZtHIyLnZ7EhxnnuaVVEBKy+H0JpymUsq
	 R/atBj5KnplVUBCtHQm1IsYJK2SQzfyoULu7qmyRA2F21fY7PDUNPtcObBB3BkAPgz
	 EUnPZ4WV8ZIzZeR82XWR/YwnmDBu2SjzBopLe+Z3oXLzqjGqFnQZKUQA9CU6+VsHYA
	 LKPTa193M1O9HZZ9pI/8G8ZdX2SPRjnSFOPqqrdTurDk+gBAFn7vxvWB6JTZpo9ORY
	 jidLgqOdR7KXpL2Upa8mGRWaRwHOpIqOPQhtWWcGINYw6HNN8DWP8/OFHBS/yI6g/D
	 UEhNzrfTF6m5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/3] perf env: Add helper to lazily compute the
 os_release
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260409230620.4176210-3-irogers@google.com>
References: <20260409230620.4176210-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Apr 2026 23:50:58 +0000
Message-Id: <20260409235058.AB942C4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Offline traces missing the OS_RELEASE header are polluted with t=
he host's kernel version.
- [Medium] Unhandled `strdup()` memory allocation failure leads to NULL poi=
nter dereference in `snprintf()`.
--

commit 291bf2cc1c91c985c162c953f24ca34e304792c1
Author: Ian Rogers <irogers@google.com>

perf env: Add helper to lazily compute the os_release

This commit adds a lazy initialization helper for the os_release string in
the perf environment, falling back to uname if it is not initialized.

> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
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
> +	 * uname fails then use the current perf tool version.
> +	 */
> +	ret =3D uname(&uts);
> +	env->os_release =3D strdup(ret < 0 ? perf_version_string : uts.release);
> +	return env->os_release;
> +}

If we are processing an offline perf.data file with a tool like perf report
or perf data convert, and the file is missing the HEADER_OSRELEASE feature,
env->os_release will legitimately be NULL.

Does this unconditional fallback to uname risk polluting the offline
trace's metadata with the local analysis host's kernel version?

This could potentially cause tools to incorrectly search for the target
vmlinux using the host's kernel version, or embed the host's release into
exported traces as the target's release.

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
[ ... ]
> @@ -2226,7 +2226,7 @@ static int vmlinux_path__init(struct perf_env *env)
>  		return 0;
> =20
>  	if (env) {
> -		kernel_version =3D env->os_release;
> +		kernel_version =3D perf_env__os_release(env);

If the strdup call in perf_env__os_release fails, it will return NULL.

Since kernel_version is assigned the result directly, could this result in
passing a NULL pointer to snprintf slightly further down in this function:

	snprintf(bf, sizeof(bf), vmlinux_paths_upd[i], kernel_version);

Passing NULL to a %s format specifier can lead to undefined behavior and
potential segmentation faults on certain C libraries like musl.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260409230620.4176=
210-1-irogers@google.com?part=3D2
