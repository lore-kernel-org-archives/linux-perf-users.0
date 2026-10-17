Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AF147F77F;
	Sat, 17 Oct 2026 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792247534; cv=none; b=p+hhroizWZ5omNhU0SPSJ+c12A9hyJeg6fnhkG2/urzjexR5SJujZErepT1+DzBosd2AvftWYk+60vU7uD3WNNTjwetrdBBUSWqMlzom4xGWZkqWjyck+xUVN7EXM9gqeWCQYfAYf7BIHiJbjsuzYEMsPL0x37n2ide6HdSkrjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792247534; c=relaxed/simple;
	bh=6xAxQCDcVYHX1OLGy8y2M3FM51A2OEf7oeCvt6EWmoY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=E91nl4E3EwXE87ZBc4V+fIy8uoheEyufnldP9nei4SFWSUMHoleMjkDFNC8OcCI3Gm2g5c7Aa1T46TQFkdicbthUdLpOvK7GQPTQSuOBpStrNj8HOnioDANWlCjqmA3hJrztzaHWD0bGsEMu1Mw9hUax9XVT75VtPzEm40vK4yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dH/qRPll; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dH/qRPll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE6E1F000C5;
	Sat, 17 Oct 2026 14:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792247533;
	bh=vKuMA66jFmYv1RgHfXBuLpmnX1U5qXzIZ3cUC6H1csE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dH/qRPllrOxMN8UJT5btNrvOaAZBiWeqSJWKYiorZHGYjD23xdeCCzpY8zbzixvhM
	 djH4vJSX9g4HWvgPKPb+aiBW5kcOGx4ZMclo29IdTfo+Yf/6uufZ87QhbaidUzwTQW
	 DtBPxdNklUL9ifxf3wwpg553pE3F53pKbVMMFlgODBqAaN4IqByi1aRM6JJacIq0pQ
	 iaabksYX+9pek4X1VcpoqsBpWTW39HSc229g8jkZgHWHR4RHNk/5L7qgYwhnRWvcTL
	 PVpaPWsclTJueX0cp0UDu3O8xSQThLDkBZsIvO3/V6wwBkiS9m/AaZZO0rjATU+OJW
	 dWwWuYshOf0iA==
Message-ID: <sashiko-outbox-175556@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 5/7] tools: build kernel selftests in tools_build
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, "Nicolas
 Schier" <nsc@kernel.org>, linux-kbuild@vger.kernel.org
Cc: "Shuah Khan" <shuah@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Namhyung
 Kim" <namhyung@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, "Jiri Olsa" <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, "Adrian Hunter" <adrian.hunter@intel.com>, "James
 Clark" <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>, "Andrew Morton" <akpm@linux-foundation.org>
In-Reply-To: <20261016143143.3613501-6-sashal@kernel.org>
References: <20261016143143.3613501-1-sashal@kernel.org>
 <20261016143143.3613501-6-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 14:32:12 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] build: Fatal Make syntax error on empty target variables in static=
 pattern rules
- [Medium] selftests: kexec Kconfig unnecessarily restricted to X86_64
- [Medium] kbuild: missing dependencies on scripts/ Makefiles for selftests=
 rebuilds
--

commit f8d06182dd0adbe69406863fbe53894162f78089
Author: Sasha Levin <sashal@kernel.org>
Subject: tools: build kernel selftests in tools_build

This commit adds a "Kernel selftests" sub-menu to the tools build framework,
allowing selftests to be built without writing to the source tree. Each
selftest runs under its own make instance, enabling parallel builds using a
pre-installed C library and UAPI headers. Rebuild dependencies are handled =
by
tracking timestamps of shared files and headers since selftests do not
natively track header dependencies.

> diff --git a/tools/Kconfig b/tools/Kconfig
> --- a/tools/Kconfig
> +++ b/tools/Kconfig

[ ... ]

> +config TOOLS_BUILD_SELFTESTS_KEXEC
> +	bool "kexec"
> +	depends on X86_64

[Severity: Medium]
Does this unnecessarily restrict the kexec selftest to X86_64?

Looking at tools/testing/selftests/kexec/Makefile, it explicitly supports b=
oth
x86 (32-bit and 64-bit) and ppc64le:

    ifeq ($(ARCH_PROCESSED),$(filter $(ARCH_PROCESSED),x86 ppc64le))
    TEST_PROGS :=3D test_kexec_load.sh test_kexec_file_load.sh
    TEST_FILES :=3D kexec_common_lib.sh

Configuring the tools build on ppc64le or 32-bit x86 will not expose this
option, silently excluding the test from being built and installed on these
platforms.

[ ... ]

> diff --git a/tools/Makefile.kbuild b/tools/Makefile.kbuild
> --- a/tools/Makefile.kbuild
> +++ b/tools/Makefile.kbuild

[ ... ]

> +$(selftest-shared): FORCE
> +	$(Q)mkdir -p $(@D); \
> +	newest=3D$$(find $(CURDIR)/usr/include $(toolsdir)/include $(toolsdir)/=
arch $(toolsdir)/testing/selftests \
> +		-type f \( -name '*.h' -o -name '*.mk' -o -name Makefile \) -printf '%=
T@\n' | \
> +		sort -n | tail -n 1); \
> +	touch -d "@$${newest:-0}" $@

[Severity: Medium]
Will this miss rebuild dependencies on shared build scripts?

The find command omits the tools/scripts/ and scripts/ directories, and its
filters exclude files named Makefile.* or *.include.

Modifying core shared files like tools/scripts/Makefile.include,
tools/scripts/Makefile.arch, or scripts/subarch.include will not trigger a
rebuild of selftests that include them, which can lead to stale builds.

> +
> +# As with "make kselftest-all", a selftest that fails to build does not =
fail
> +# the build unless FORCE_TARGETS is set. kselftest_deps.sh lists the lib=
raries
> +# it needs that the compiler cannot link with. It leaves files behind in
> +# TMPDIR, so it gets one of its own.
> +selftest-failed =3D (cd $(toolsdir)/testing/selftests && tmp=3D$$(mktemp=
 -d) && \
> +	TMPDIR=3D$$tmp ./kselftest_deps.sh '$(call escsq,$(tools-cc))' $(1) | g=
rep '^FAIL' >&2; \
> +	rm -rf "$$tmp"); $(if $(FORCE_TARGETS),false,:)
> +
> +selftest-targets :=3D $(addprefix selftest-,$(selftests-y))
> +
> +__tools_build: $(selftest-targets)
> +
> +PHONY +=3D $(selftest-targets)
> +$(selftest-targets): selftest-%: $(selftest-shared) FORCE
> +	$(call build,$(outdir)/selftests/$*,-C $(toolsdir)/testing/selftests/$*=
 OUTPUT=3D$(outdir)/selftests/$* $(selftest-flags),$(selftest-shared) $(too=
lsdir)/testing/selftests/$* $(selftest-extra-$*),TOOLS_BUILD_SELFTESTS_$(sh=
ell echo $* | tr a-z/- A-Z__),$(call selftest-failed,$*))

[Severity: High]
Can this trigger a fatal Make syntax error if no selftests are selected?

If a user enables the tools build selftests option but disables all individ=
ual
selftests, $(selftests-y) and $(selftest-targets) will be empty.

Since this rule uses two colons, it is a static pattern rule. While GNU Make
ignores empty targets for single-colon rules, an empty target list in a
double-colon static pattern rule evaluates to : selftest-%: ... and
triggers a fatal missing target pattern. Stop. build error.

The same issue would apply to the $(tool-targets): tool-%: FORCE rule if
the tools build is enabled but no individual tools are selected.

Should these static pattern rules be guarded with an ifneq check
(e.g., ifneq ($(selftest-targets),)) to prevent breaking the build on
minimal configurations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016143143.3613=
501-1-sashal@kernel.org?part=3D5
