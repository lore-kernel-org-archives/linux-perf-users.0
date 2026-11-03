Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672008;
	b=lvziGcbes2yB+my6zPbHdJvV/xUuFb728RudI36k/LHjTzwoRIfu5Y9ORptZezd1rBje
	 Blappb4IZc412wnYLvYb68Nj+ZzfdDXwujFObMA2PKUYDPN8LRbz2fLIY7/Rb4q99wF/G
	 1QUUVx5hC4hZ314nBB0I5ZJLr7avjdi0oe2F9KINxJHWLsmA2o7a8amq65JeGx4zl5gya
	 ipZ/4s3jH2KRyfJthFRzy/659KJvFXKTJ0zk43edPR3OSPftS3C/hWeRIFJF+g2hbvwMm
	 7NgZ+Ia+ybECmSNH2bFezUy6rayglv+UA/tvNtY0sFTz6Q07YHAyJYZTiG7+dT3toAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672008;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GVKQ7CtsW0Niu+fZVe2lFLN48mO4m++1J11KiLMH9Cw=;
	b=libGntVYLEyweRRoSfyrWbTrSk1tiZ9JcI0qwqHa9JLUNI46AiHwsi+bLiHi4PiYOaij
	 xnCfELekgAXYJCBiA2v4kpfcK9TBeJ6D4egY67Xwq3UimZC/WdXVf0mMSil+L8FKRwTym
	 PnduabGmwciKibfIQe5IeBzm1UvZ173Ed9f2LSeqCtIay3hPAtXhLwaGTj4VgaKwZRoVH
	 aeaRDjVqpqr0Sjo73IkFG4v0lx0BfF8j4OX/W9KqzGH8Ry9gkL4rAIdn01luPiePtK2KD
	 ud+J/vYc3/nojBfGl4JwLnzHFsiXOwngrOODGFkJvdFc19N7pWpe3Kd5lSmX/HGrCmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B9rYcscb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C11606A326;
	Tue,  3 Nov 2026 02:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B9rYcscb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984F81F0093A;
	Tue,  3 Nov 2026 02:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793672007;
	bh=GVKQ7CtsW0Niu+fZVe2lFLN48mO4m++1J11KiLMH9Cw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B9rYcscbO9eEVRJ2m7EYAMlNlCKHYxf/7z9vT7iXsD/EJQdd/+4PMeqWq6e3x0W7I
	 chYnMGArzbWNc8q7H92qopYcjFKD9GWKOf91mDwa5RYL0izAvIYCn/4XSrSMQuy3I6
	 CZ9JAB1BG3pypQJuygJnb5z+Kv5CJ6gFsfLH2DAOyZ8XKNLWL0cI2MaPVDCGBb/gOc
	 sF6I8C9WNB8qT/ODkFb/IFV6GjgHC0E5yO66kHkX2EpXoee6w4NpG0NE5wCPOWDXuW
	 /dIF8F67pVd+F9cmVRmGeWE8wrAotiVFqmDQCH3e4EFHmErAMG+LE0pGwYlg9p4vPb
	 qNZ6REDIdeu2Q==
Message-ID: <sashiko-outbox-194454@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/7] kbuild: build the tools selected in
 tools/Kconfig as part of "make all"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, "Nicolas
 Schier" <nsc@kernel.org>, linux-kbuild@vger.kernel.org
Cc: "Shuah Khan" <shuah@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Namhyung
 Kim" <namhyung@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, "Jiri Olsa" <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, "Adrian Hunter" <adrian.hunter@intel.com>, "James
 Clark" <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>, "Andrew Morton" <akpm@linux-foundation.org>, "Thorsten
 Leemhuis" <linux@leemhuis.info>
In-Reply-To: <20261102021253.2545235-7-sashal@kernel.org>
References: <20261102021253.2545235-1-sashal@kernel.org>
 <20261102021253.2545235-7-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 02:13:25 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] kbuild: selftest-vDSO spawns recursive make headers during paral=
lel make all
- [Medium] kbuild: unfiltered find in tools_build wipes selftest-vDSO on in=
-tree make all
- [Medium] kbuild: make -n all fails in tools_build when CONFIG_TOOLS_BUILD=
_PERF is set
--

commit 77668b75cf4c2802e979bfdc034af230364fe4c5
Author: Sasha Levin <sashal@kernel.org>

kbuild: build the tools selected in tools/Kconfig as part of "make all"

This commit makes the top-level all target depend on tools_build when
CONFIG_TOOLS_BUILD is enabled so that selected tools in tools/Kconfig are
built during standard kernel builds.

> diff --git a/Makefile b/Makefile
> index 7919263484f0a..2a69f4c73a641 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1650,6 +1650,10 @@ PHONY +=3D tools_build
>  tools_build: headers
>  	$(Q)$(MAKE) -f $(srctree)/tools/Makefile.kbuild
> =20
> +ifdef CONFIG_TOOLS_BUILD
> +all: tools_build
> +endif

[Severity: Medium]
When running a parallel make all on x86_64 with CONFIG_TOOLS_BUILD=3Dy,
CONFIG_TOOLS_BUILD_SELFTESTS_VDSO=3Dy, and CONFIG_WERROR=3Dy (as in allmodc=
onfig
and allyesconfig), can this trigger an uncoordinated recursive make headers
pass in the kernel object tree that races with the main build and repeatedly
recompiles scripts/unifdef?

Once headers completes, tools_build runs tools/Makefile.kbuild in parallel
with the rest of the kernel build after unexporting sub_make_done, and invo=
kes
each enabled selftest via:

tools/Makefile.kbuild:
$(selftest-targets): selftest-%: $(selftest-shared) FORCE
	$(call build,$(outdir)/selftests/$*,-C $(toolsdir)/testing/selftests/$* OU=
TPUT=3D$(outdir)/selftests/$* $(selftest-flags),...)

On x86, tools/testing/selftests/vDSO/Makefile declares an order-only
prerequisite on headers:

$(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c=
 | headers

Because tools/testing/selftests/lib.mk marks headers as .PHONY and no file
named headers exists on disk, GNU Make unconditionally runs the recipe in
lib.mk:

headers:
	$(Q)$(MAKE) -f $(top_srcdir)/Makefile -C $(khdr_output) headers

That spawns a second top-level make headers pass inside the kernel object t=
ree
while the outer make all and other selftests are running. Because headers is
in no-dot-config-targets in the top-level Makefile, include/config/auto.conf
is not loaded in that sub-make, leaving CONFIG_WERROR unset. When
CONFIG_WERROR=3Dy, the outer make all builds scripts/unifdef with -Werror a=
nd
-Wl,--fatal-warnings, whereas the inner make headers sees a command-line
mismatch in scripts/.unifdef.cmd and rebuilds scripts/unifdef concurrently
with the main build (and recompiles it twice on every subsequent incremental
make all or make tools_build).

[Severity: Medium]
On an in-tree make all build (without O=3D) with CONFIG_TOOLS_BUILD=3Dy and
CONFIG_TOOLS_BUILD_SELFTESTS_VDSO=3Dy or CONFIG_TOOLS_BUILD_SELFTESTS_X86=
=3Dy,
will the unfiltered find in tools/Makefile.kbuild cause selftest-vDSO and
selftest-x86 to be wiped and rebuilt from scratch on the next incremental m=
ake
invocation?

In tools/Makefile.kbuild, the extra dependency directories for those targets
point into the kernel source tree:

selftest-extra-vDSO :=3D $(abs_srctree)/arch/$(SRCARCH) $(abs_srctree)/incl=
ude
selftest-extra-x86 :=3D $(abs_srctree)/arch/x86/include

And the build macro checks for newer files across those directories without
filtering out build artifacts:

define build
	+$(Q)$(if $(dry-run),,if [ "$$(cat $(1)/.tools_build 2>/dev/null)" !=3D '$=
(build-key)' ] $(if $(3),|| \
	   [ -n "$$(find $(3) -newer $(1)/.tools_build -print -quit 2>/dev/null)" =
]); then \
		rm -rf $(1); \
	fi;) \

Because all: tools_build only orders tools_build after headers, the main
in-tree kernel build continues writing object files, .cmd files, generated
headers (such as include/generated/compile.h), and boot images (such as
arch/x86/boot/bzImage) under arch/$(SRCARCH) and include after
tools-build/selftests/vDSO/.tools_build is written. On the following make
invocation, find matches those newer kernel build artifacts and runs rm -rf=
 on
the selftest output directory even when no sources or headers changed.

[Severity: Medium]
Does adding tools_build to all break make -n all on a clean tree when
CONFIG_TOOLS_BUILD=3Dy and CONFIG_TOOLS_BUILD_PERF=3Dy?

In tools/Makefile.kbuild, the build macro uses a leading + prefix and runs
mkdir -p before invoking the sub-make:

define build
	...
	mkdir -p $(1) && $(MAKE) $(2) && \
	$(if $(dry-run),:,printf '%s' '$(build-key)' > $(1)/.tools_build) || \

Under make -n, this creates tools-build/<target> directories on disk and
invokes tools/perf/Makefile.perf with -n in MAKEFLAGS. In
tools/perf/Makefile.perf, the sub-make pass for FIXDEP_BUILT=3D1 runs under
make -n (writing detection files into tools-build/perf) and evaluates the
prepare prerequisite $(LIBAPI):

$(LIBAPI): FORCE | $(LIBAPI_OUTPUT)
	$(Q)$(MAKE) -C $(LIBAPI_DIR) O=3D$(LIBAPI_OUTPUT) \
		DESTDIR=3D$(LIBAPI_DESTDIR) prefix=3D subdir=3D \
		$@ install_headers

However, the rule that creates $(LIBAPI_OUTPUT) in tools/perf/Makefile.perf:

$(LIBAPI_OUTPUT):
	$(Q)$(MKDIR) -p $@

has neither a + prefix nor $(MAKE) in its recipe, so GNU Make skips it duri=
ng
make -n and never creates tools-build/perf/libapi. When the $(LIBAPI) recipe
then runs its sub-make, tools/scripts/Makefile.include checks whether $(O)
exists at parse time:

$(if $(shell cd $(PWD); test -d $(O) || echo $(O)),$(error O=3D$(O) does no=
t exist),)

which aborts make -n all with an error that tools-build/perf/libapi does not
exist.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102021253.2545=
235-1-sashal@kernel.org?part=3D6
