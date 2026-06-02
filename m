Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D483264E3
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412061; cv=none; b=JLojprEa7fP2VLfXAlvM4C70e4UJP2ijG+oLFSy+J3NiX4IYyFdDoKjRyDuYnVHZt5R5qV3SJQwFtVhFS4YwO6oJKGOxdoJmxcoasNHRBwfNpcbHubleLF5LP/LhYa7vRIvBBgHY09SRC9HfpI92mHUmXzsZIXyp8yPUTXMaSzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412061; c=relaxed/simple;
	bh=jXHEGOCBeHdd9/Ip7sE2dGeuWqwOHu+U1umxoBs/Fic=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GWjfDfbLs1f1T6+Gxzbu5hMrvVLe65exxc6s7/AV7lpxC5a/Uaan6b4tkadOKMlZ0eg1crx1yZRhhYiC6RJ+m6t6yf+imgyaeDkLAqmDdNkCIB4jfxGc4sgrAwMBLLCouOibQtq8jziwlsCgivYn/BOi9yvWbV520yW6uzjNdXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuTuaSGq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuTuaSGq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388A31F00893;
	Tue,  2 Jun 2026 14:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780412060;
	bh=PHR6aSjsyRQqgKdBnZ+hm9/9ASOkVExT+PPcUdo1KbQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EuTuaSGqLqJyEobkvrdnZh3fPGaSmBWsIfF8yEYhYPCt7JGpCjagE9ntpotRbzNAz
	 hOOjhdHpv0ixFdJJrgMHFViminx6hCVU60y1mP0u7ueYlacK2oyI6X6qzKdqbJdWxW
	 hR1cMb6Lz+pc3epCw87u1xvG3whz5H8sWwnFOkzL3tj15LGNCiNqt7VOxhNvq7P27u
	 NSS4CdtR39RfEqL8Quzgljn61p5pL4vEPB2Gzp3MJNE5VQt5nQElf2PmXpBJztlj+D
	 zk4t5H6/0b8/iQHS4OhJuWlpAQE6u/Su8a6ZSMSCusfHV97RnI+r9OgMzAypyIiPff
	 MpPM1Gqig/gag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/23] tools: lib: thermal: Fix typo
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602-tools_build_fix_zero_init-v7-1-631baf679fe7@arm.com>
References: <20260602-tools_build_fix_zero_init-v7-1-631baf679fe7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 14:54:19 +0000
Message-Id: <20260602145420.388A31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Fixing the 'CFGLAS' typo activates logically incorrect linker flags=
 inside the compiler flags (CFLAGS), injecting them into the object compila=
tion step.
--

commit 783a6df50ce2cf932c85a46af96705ee016835e4
Author: Leo Yan <leo.yan@arm.com>

tools: lib: thermal: Fix typo

This commit fixes a typo in tools/lib/thermal/Makefile by replacing
CFGLAS with CFLAGS for the linker flags.

> diff --git a/tools/lib/thermal/Makefile b/tools/lib/thermal/Makefile
> --- a/tools/lib/thermal/Makefile
> +++ b/tools/lib/thermal/Makefile
> @@ -66,8 +66,8 @@ override CFLAGS +=3D -fPIC
>  override CFLAGS +=3D $(NL3_CFLAGS)
>  override CFLAGS +=3D $(INCLUDES)
>  override CFLAGS +=3D -fvisibility=3Dhidden
> -override CFGLAS +=3D -Wl,-L.
> -override CFGLAS +=3D -Wl,-lthermal
> +override CFLAGS +=3D -Wl,-L.
> +override CFLAGS +=3D -Wl,-lthermal

[Severity: Low]
Does this activate logically incorrect linker flags?

By fixing the typo, the linker flags -Wl,-L. and -Wl,-lthermal are now inje=
cted
into CFLAGS. Linker flags do not belong in CFLAGS, which is used for compil=
ing
object files. Furthermore, instructing libthermal to link against itself wh=
ile
it is being built is conceptually a circular dependency.

While GCC silently ignores these flags during object compilation, their
presence in CFLAGS causes Clang to emit -Wunused-command-line-argument
warnings. Because the Makefile enforces -Werror, this newly introduced logi=
cal
error breaks the build for Clang users.

Should these two lines be deleted entirely instead of renaming the variable?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602-tools_buil=
d_fix_zero_init-v7-0-631baf679fe7@arm.com?part=3D1
