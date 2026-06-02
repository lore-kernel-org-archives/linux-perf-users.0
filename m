Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2DE37B028
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 06:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780382711; cv=none; b=b5C7HeSaYZHdtJ+pommTEHrLqsQeoAeO/tF3gET1Y8nqo9a3ANQAOnOOLTusolCZSWB/DMfZOOqiHFsb7K9dJzh/kopr5sIGBAkhQhYfj0BWVyMde9KdbDq8D6mbkTZhRu5YyIboYDsuUa0G12fJcYmj/pnn5CYFwroM/QPIlKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780382711; c=relaxed/simple;
	bh=K6gjKqyQjVe8G6GvsE+7UHLD9pnH1cKqZTk84r2UCCo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JH1IvwkiiuW0liFW7nRBuF1QF+eUwO3M3P6QGTEU05hb3M2+21Lo+SYLFKiNrvxYs3OvEzhv/e3ZI10T5IaVTU6sXP5X6Wjm/z1ZaVFOE8uXWCBhXSkvKt92iGqtCfOw770Fhu7Qp5zCDyStG4iHVOTKPsl7ey0e/+hK5XkDVRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaXzosoH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaXzosoH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44591F00893;
	Tue,  2 Jun 2026 06:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780382709;
	bh=YRvj+2ESqE/Net+zTTDp2fugkhOZ2Nji0SCWIApT/yY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CaXzosoHiWA76vAqIqibMVNo+52zZR0lNj3/z2vtJZhlRSyLdX7iJ0D8HFDCNrevp
	 FaYPky6RpSWeb3PAeWjgFVLMYw4llFasW8QPTDQ5emsgtqOfHPoVlRts6eLdrV1DF4
	 W7mjqBbxwhM+dQP6Cb1D/Bl9eWLJ7nSYfTUK7cSsnTYTyGeoUIulFy/Yh7H88jY/HC
	 8QHbZ2py6RCLahHWsIvyBfNPX+j1IIaXySiI+fxUOCqSgQkduBImHHKJftIrXsirSJ
	 2A0Jmo0XWbTV8hEDV1cjwNi38pRIRqVJTT6wYtkrVN2WEyno1kDKyXV4MzpBCkX37J
	 HBpsrkZn1DKTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 16/19] perf env: Add mutex to protect lazy
 environment initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602062452.2583619-17-irogers@google.com>
References: <20260602062452.2583619-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 06:45:09 +0000
Message-Id: <20260602064509.B44591F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Calling `mutex_destroy()` on an uninitialized mutex in `perf_env=
__exit()` causes undefined behavior, as stack-allocated `struct perf_env` i=
nstances in helper functions bypass `perf_env__init()`.
--

commit 08389321a4c748339a57c5404995d5a975c79c1e
Author: Ian Rogers <irogers@google.com>

    perf env: Add mutex to protect lazy environment initialization
   =20
    Introduce a mutex to 'struct perf_env' to safely protect lazy
    metadata setup, such as os_release or e_machine resolution,
    preventing concurrent initialization data races and memory leaks
    during multi-threaded profiling or symbol loading.

> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 28c54c58193e4..4de07cc7ef5da 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -250,6 +250,8 @@ void perf_env__exit(struct perf_env *env)
>  {
>  	int i, j;
> =20
> +	mutex_destroy(&env->lock);
> +

[Severity: Medium]
Could this trigger undefined behavior when perf_env__exit() is called on
stack-allocated environments that bypassed perf_env__init()?

For example, in x86__is_amd_cpu():

tools/perf/util/env.c:x86__is_amd_cpu() {
	struct perf_env env =3D { .total_mem =3D 0, };
	bool is_amd;

	perf_env__cpuid(&env);
	is_amd =3D perf_env__is_x86_amd_cpu(&env);
	perf_env__exit(&env);

	return is_amd;
}

The local env variable is zero-initialized but perf_env__init() is never
called, leaving env.lock uninitialized. Calling mutex_destroy() on an
uninitialized mutex triggers undefined behavior and may cause crashes under
sanitizers.=20

This same pattern also exists in x86__is_intel_cpu().

>  	perf_env__purge_bpf(env);
>  	perf_env__purge_cgroups(env);
>  	zfree(&env->hostname);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602062452.2583=
619-1-irogers@google.com?part=3D16
