Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3B33A8723
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 06:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780383030; cv=none; b=mdZhNIyD1luNtXE87ZktswAs9b1l7QEumiGx9qKsk+Wvjoz8oKP7u4CfZEsR8VwheVWKlA5c5s9VuyBZgL1dvU6PMBofHLExv6FqIf2iwM2ew4eM1HfxuOvu94rocrZjwB/bVcCSX9SzLbhJCeTO9wRuxToXr51f1SJDYOb5La8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780383030; c=relaxed/simple;
	bh=8cZyZJeFK27Lio4PB44oDyt/EoSdjMsd13C0TcwsdPs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nCVzZLYCk8BKH3zrD6tGpYS8HADoATocrxWfOJfFmn91UPekME8aRFg54J7TffBKOcWvGVtUxYMheflr/ATnOnmBJKBkUYrv4DZTkaEHRZFSWFKU4HI3d6g5HO420AdXZk6tM7hz/5wh+DazgJQKMII99oIPnKAenusqGVBR/i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdF1oMs6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdF1oMs6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79BE1F00893;
	Tue,  2 Jun 2026 06:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780383029;
	bh=DdYEyxbfAjgS7uuyGf3oxT2WJIM4Te+oko2pS8UscF4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DdF1oMs63Xa2svFqlH5uAAwD7XLT0Uqxz/5S4xnJL2vEjoMiTguJqWUg5RivlyeYS
	 PMsRdh1jIh7DBrWV+V8lvwxifBnkydbzWPkyS2BBJJ3d61xDpzdn58oW8VRxkRMnMd
	 v5wqQc7cHgoH3R4SjIDPmm6thwSSXGVkxtcnPoDlSFAlijVIxEFEspIqEwx6gpZLW3
	 bRyoGH9VkN98eY4Q7hQkG3G7WQeY7Rmbkz7SJlFl4Ibs6kPTaM7ZPKC+4b3aohAKIB
	 77D/gRJNHU9CIqlUJ58PeuNZx97y4w+0oOuzLrPWqVHDDgTA/KjP4G0dSgpLQd2C0f
	 KGVz/YosoJMfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 17/19] perf env: Add helper to lazily compute the
 os_release
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602062452.2583619-18-irogers@google.com>
References: <20260602062452.2583619-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 06:50:28 +0000
Message-Id: <20260602065028.D79BE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The `perf_env__os_release` helper incorrectly identifies pipe mode=
 as live mode due to uninitialized `env->arch`, prematurely poisoning the e=
nvironment with the host's OS release.

Pre-existing issues:
- [High] Passing a NULL pointer to `snprintf` with a `%s` format specifier =
causes Undefined Behavior and crashes.
- [High] Destroying and locking uninitialized synchronization primitives (m=
utex and rwlock).
--

commit 18f3f0f76a0f321e841ef41fc691a35a33c63e31
Author: Ian Rogers <irogers@google.com>

perf env: Add helper to lazily compute the os_release

In live mode the os_release isn't being initialized, make a lazy
initialization helper that assumes when the os_release isn't
initialized this is live mode.

[ ... ]

> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 4de07cc7ef5da..61b30f08493ae 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
[ ... ]
> @@ -361,6 +361,44 @@ bool perf_arch_is_big_endian(const char *arch)
>  	return false;
>  }
> =20
> +const char *perf_env__os_release(struct perf_env *env)
> +{
> +	struct utsname uts;
> +	int ret;
> +	const char *release;
> +
> +	if (!env)
> +		return perf_version_string;
> +
> +	mutex_lock(&env->lock);
> +	if (env->os_release) {
> +		release =3D env->os_release;
> +		goto out;
> +	}
> +
> +	/*
> +	 * If env->arch is set, this is an offline target environment.
> +	 * If the os_release is not populated in the file, we do not want
> +	 * to poison it with the host's release which would break guest checks.
> +	 */
> +	if (env->arch) {
> +		release =3D NULL;
> +		goto out;
> +	}

[Severity: High]
Does this correctly handle pipe mode?

In pipe mode, feature events are synthesized and embedded in the event
stream, so they are not parsed during perf_session__new(). When tools like
perf report invoke symbol__init() and vmlinux_path__init() before
processing the event stream, env->arch is strictly NULL.

This causes the helper to erroneously assume live mode and permanently
populate env->os_release with the host's release, which can break guest
checks and cross-platform symbol resolution.

[Severity: High]
This is a pre-existing issue, but looking at perf_env__exit() in
tools/perf/util/env.c, is it safe to destroy and lock uninitialized
synchronization primitives?

In functions like x86__is_amd_cpu(), a stack-allocated struct perf_env is
zero-initialized and never properly set up. When perf_env__exit(&env) is
called later, it blindly calls mutex_destroy(&env->lock) and invokes
perf_env__purge_bpf(env), which performs down_write(&env->bpf_progs.lock).

Operating on completely zero-filled mutexes and rwlocks can lead to
undefined behavior and immediate aborts on strict libc implementations.

[ ... ]
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 2ce512f08a1d6..077d19af52408 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
[ ... ]
> @@ -2242,7 +2242,7 @@ static int vmlinux_path__init(struct perf_env *env)
>  		return 0;
> =20
>  	if (env) {
> -		kernel_version =3D env->os_release;
> +		kernel_version =3D perf_env__os_release(env);

[Severity: High]
This isn't a bug introduced by this patch, but if
perf_env__os_release(env) returns NULL (which happens intentionally for
offline targets lacking the HEADER_OSRELEASE feature), kernel_version
becomes NULL.

Shortly after this assignment, kernel_version is unconditionally passed
into snprintf via the %s format specifier:

    snprintf(bf, sizeof(bf), vmlinux_paths_upd[i], kernel_version);

Could passing a NULL pointer to %s cause undefined behavior and potential
crashes in hardened builds or on strict libc implementations?

>  	} else {
>  		if (uname(&uts) < 0)
>  			goto out_fail;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602062452.2583=
619-1-irogers@google.com?part=3D17
