Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CA2342507
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932497; cv=none; b=VfLaTGjXZzWVJFUHRNQdmfcp+LACuq/k0oUUoi9ECFfQN6A8NDlK76Tm4wL1TVXZjJhVySyGsLIR/X8KkcEj7t/mx9AUdrG5iapgghgO0l2vVGJLm8N/VFn+HpDRunZEZhfkgPolvcaRlyGVt/O+abU4w5cET8GQLo/1EtlReNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932497; c=relaxed/simple;
	bh=nJjAbdaSHaSt9ZuY9lCmH6uf74kUC/FyvqJ/W/VVSks=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H0/iWiXJ1bK9uk44UWN8vKZnvYaEIP0HJJaivvFRRGV/Nwhi1RqlvmzCPCPNG8wJCyZjmDlnKRtPoRRQMIfpXhiBjduQfBgRsrDg/yjn+5tpJKzrLoWI2JX6Rnn+nV0R8jWc3urIz41Ex/2a8WoNFmkwPUpVSlUV3h73RV+/Qkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xih0LXWB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xih0LXWB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCB01F00893;
	Mon,  8 Jun 2026 15:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780932496;
	bh=95cZi3DGxYHK8f604GZOTScyE10UoZOwrnmrHE8zZg8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xih0LXWBVSb9IjYTDzLUxN0d7u3n43c8i8Bk4LYfzq1FqKZh48Jntdcb5z4hlEPGh
	 e3NW//IHn7NfdJPzD8dtvc4q72e53LsmoNgubQgTYUmcl39jw2o4wYJPWP2DUANrwX
	 Jyrr8e3202Ql/XPY9rGJMuKZ4ssbJMaIXrOpQStVCzfKpy8Ro1VFkdzE8oLyH+FMzy
	 Y2UiOxF19/ZXDbw54s9mBInQrxpk9Lz6+PqHpOlFeoxBw63UeG53UZIve1ZB3bmOyO
	 BsHfNTEMIzro3YL3unlggn4WLhBwrtxaridvuk+7GtLofq1TXPxjU6GeiFt5WxZOL1
	 aRra8eiU1BGAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf build: Respect V=1 for Python extension builds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260608151525.2358438-1-jremus@linux.ibm.com>
References: <20260608151525.2358438-1-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 15:28:15 +0000
Message-Id: <20260608152816.7FCB01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `setup_quiet` variable is not initialized before its conditiona=
l assignment, allowing it to inherit arbitrary values from the user's envir=
onment when `V=3D1` is used.
--

commit 8926935922228db2605e3a9cb12821c9b36a4337
Author: Jens Remus <jremus@linux.ibm.com>

perf build: Respect V=3D1 for Python extension builds

This commit modifies the perf build system to conditionally pass the --quiet
flag to setup.py. It aims to respect the V=3D1 verbose build flag to ease
debugging of Python extension compilation issues.

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 76b35ac19acbf..5fd6044680df5 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -401,6 +401,10 @@ export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
> =20
>  python-clean :=3D $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD=
) $(OUTPUT)python/perf*.so
> =20
> +ifneq ($(quiet),)
> +setup_quiet=3D--quiet
> +endif
> +

[Severity: Low]
Does this leave setup_quiet uninitialized when V=3D1 is used?

Because make imports environment variables automatically, if a user happens
to have an environment variable named setup_quiet, it could be unintentiona=
lly
passed directly to util/setup.py when the quiet variable evaluates to empty.

Would it be safer to explicitly initialize setup_quiet to an empty string
before the conditional block to prevent environment variable contamination?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608151525.2358=
438-1-jremus@linux.ibm.com?part=3D1
