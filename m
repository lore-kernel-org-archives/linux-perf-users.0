Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156A417B50F
	for <linux-perf-users@vger.kernel.org>; Sun, 11 Oct 2026 23:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791762391; cv=none; b=HiD5IXsP+Uy6QhtQapeNlnzvlqVZC3T/G3g02OAKpLN3/ZWUqD06pHsVQkiMZI2OljF4tvJxH3kbnfAmmI/03yakuHW+zrK0/jLvxg3twv1r0pTm9U1nxqGYqeOily4nGEox/cEUVGLrTqkzFmVq2CQtQm9cFR+2z3oUWcI84DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791762391; c=relaxed/simple;
	bh=knUj2Xd2X8BJ1mlCpUyiHdFUXFFi9x1DyjM7fiRwJGA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=WGesjm1BBSuFYL9GVBgCqwOKy89GFZO6B+7xGLKPtlIDl5fRXlrBRWzS1yy3vPUO4lYrlIaCf2SpAtL/lOQFH//Kn3tY5uyacVG03+aF7nIW20er5IroPJCeR5tLGAAa8OsYFuiCIx72uIfbP9iauHdJSukdPvjnME+BJe8cQRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YILJMCFx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YILJMCFx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBE71F0089B;
	Sun, 11 Oct 2026 23:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791762389;
	bh=ghLW6dSU41KaU+poK0S/1u8u3ENatcimLNlMtDAzgEA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YILJMCFxWacofWNwq0x3ReSr7/rzT7UZiG9QglhrLXI1Kl2v828+qPE8puoGEgrz2
	 T7qb6hlee0PFQ+Xui51DxgyrLQ72nvLCN12nA4uSgZmwU86STtXFkSY3+LX+S54jd1
	 SB9qiSfK/GARa6HbAl0z+bGu6QFDG3fZpE3e3LAWA8yaTAKTd09H5ZdQNcQnq5aLvK
	 NQXvYWjY08bMzKSdI15S+41FXFYnN2gOLVVz/Qr2IpG3F73LgMLtjHNAAaxEZScw1t
	 sFAKtvuvYh5FFst6BQZm0jlpPbRJvLS/YnC/2F3cLKmqEn42vYWkK6qCOlkCRNhrNa
	 iEJzdpAK6/yTg==
Message-ID: <sashiko-outbox-167522@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/6] tools: build kernel selftests in tools_build
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261011233647.2454648-5-sashal@kernel.org>
References: <20261011233647.2454648-1-sashal@kernel.org>
 <20261011233647.2454648-5-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 23:46:29 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] build: static pattern rule fails on targets containing slashes
- [Medium] selftests: kexec tests excluded on supported architectures
--

commit 52a33182ba4feee21276ad02270b7c707e405a85
Author: Sasha Levin <sashal@kernel.org>

tools: build kernel selftests in tools_build

This commit adds a "Kernel selftests" sub-menu to tools_build. It allows
building selected targets under tools/testing/selftests in parallel without
running them.

> diff --git a/tools/Kconfig b/tools/Kconfig
> index 488f439592150..d713741782e22 100644
> --- a/tools/Kconfig
> +++ b/tools/Kconfig
[ ... ]
> +config TOOLS_BUILD_SELFTESTS_KEXEC
> +	bool "kexec"
> +	depends on X86_64

[Severity: Medium]
Does restricting this to X86_64 exclude kexec tests on other supported
architectures?

Looking at tools/testing/selftests/kexec/Makefile:

ifeq ($(ARCH_PROCESSED),$(filter $(ARCH_PROCESSED),x86 ppc64le))
TEST_PROGS :=3D test_kexec_load.sh test_kexec_file_load.sh
TEST_FILES :=3D kexec_common_lib.sh

The selftest natively supports building and installing scripts for both
x86 (including 32-bit) and ppc64le. Setting the Kconfig dependency
exclusively to X86_64 prevents these tests from being built or selected via
the new tools build infrastructure on architectures that fully support them,
which reduces test coverage.

> diff --git a/tools/Makefile.kbuild b/tools/Makefile.kbuild
> index 62fd494253eca..c31347258d0a9 100644
> --- a/tools/Makefile.kbuild
> +++ b/tools/Makefile.kbuild
[ ... ]
> +selftests-$(CONFIG_TOOLS_BUILD_SELFTESTS_FILESYSTEMS_MOUNT_CYCLE)	+=3D f=
ilesystems/mount_cycle

[ ... ]

> +selftest-targets :=3D $(addprefix selftest-,$(selftests-y))
> +
> +__tools_build: $(selftest-targets)
> +
> +PHONY +=3D $(selftest-targets)
> +$(selftest-targets): selftest-%: $(selftest-shared) FORCE
> +	$(call build,$(outdir)/selftests/$*,-C $(toolsdir)/testing/selftests/$*=
 OUTPUT=3D$(outdir)/selftests/$* $(selftest-flags),$(selftest-shared) $(too=
lsdir)/testing/selftests/$* $(selftest-extra-$*),TOOLS_BUILD_SELFTESTS_$(sh=
ell echo $* | tr a-z/- A-Z__))

[Severity: High]
Does this static pattern rule fail and abort the build when the target
contains a slash?

When matching a target containing a slash, such as
selftest-filesystems/mount_cycle when
CONFIG_TOOLS_BUILD_SELFTESTS_FILESYSTEMS_MOUNT_CYCLE is enabled, against a
slash-less pattern like selftest-%, GNU Make semantics state that the
directory part is temporarily stripped.

Make then compares only the base name (mount_cycle) against the target
pattern (selftest-%). Since mount_cycle does not start with selftest-, the
match fails, and Make throws a fatal syntax error indicating the target does
not match the target pattern.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011233647.2454=
648-1-sashal@kernel.org?part=3D4
