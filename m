Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293026;
	b=nPLWuvz8x/pmReb1N4D2hnILOFpfjzdqzUlSk3KvgTqYG3NSybJK9XxdmZ8kDFgYmBoV
	 KN20U1LDcu/S2xRfqV4HGGtHHSPyIbU50bmZtDJW+JThoN6NJ+8nVRiA1AvIlHI+x8Jri
	 Fh3lRJjrP8YdiVUSbihiBC+WhPFtV95oxsDTNAm+EBT5I/DwIBoVzmipFGaVGBTf9bJiT
	 4JRqy0MuTnrFonL/dzeIqatVZyYd177bX3QxmUhG8YHryqfGbpg1NmIfXKEOn2QJKHNJ3
	 TXYXTVx9YW76t18/rUvsagLB0ge19LAQRxT8iMITz3BPn8KpYKfnMsfu5RTNVOPyaXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293026;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3YMGJT4pTkEsEKwWB46LfYjpDcUnYVe1X3rwCQXzAqI=;
	b=W2ck81K9zDtwP9Ey2aspC6Kf9NC3bnPWbmIBi91s1rw/3OqIojYRjHrTnwGJ/SfaL5rL
	 5ZghncngbSs+G+T5RfqPs+x1pNayqlB+SGLIChLcu3rXFQBL4sYzXsKoe/ez4sDYafjXc
	 PKkZsIHwffCPx3+5sa8SinhqJsIGSLvG/d+1CGFvU95wfN2f0sElug99yT1t+dWgGi+BK
	 P4uhLcgVqPWm+o2KTjgsILoPDzar7ryG5qK341X77JAw3DNLG+nUhnMCCt6N2VydE2uC7
	 Q5B/88IpRl8/HU3rLbDpATIyVJ2QMdTfD12TlYAVkt6Z56ig1XY5b5dxNDslcwYmwAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eYrfMnSi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EB8606A31C;
	Thu, 29 Oct 2026 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eYrfMnSi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B0E1F01816;
	Thu, 29 Oct 2026 16:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793293025;
	bh=3YMGJT4pTkEsEKwWB46LfYjpDcUnYVe1X3rwCQXzAqI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eYrfMnSifep1QDuQP2NxmzU4emaUV6HXxr4z5831C1pto+08/y8MD989X1Jm4YeFA
	 zsm2CROrsEwHQgabZyLkz885MNOaC2vipkhyLgp9w8qpqdDzvPHUiXZTV7CG78dQI4
	 HufkHDMFGmSt0K18QO8A+SH7mBs2leBDfjG6pxr+LtudFTW7agTH4RdQLT9Hjs+beZ
	 4Cdt94/w+P7WWksRzcErdvxZbf+iNAkCQUiWr+QiCidPfpcO/vN5Jqrct2uxssGisL
	 PhlUqcqJvjKEBHRBJqm1W0jehFytwxSk/3w3fJ+ODKFMuU4Hufu/QxaGmCwp3MPA8C
	 yNdL2dLRy00tw==
Message-ID: <sashiko-outbox-189694@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 1/3] tools build: Add Rust library build
 infrastructure and zlib-rs feature test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Namhyung
 Kim" <namhyung@kernel.org>, "Quentin Monnet" <qmo@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, "Nicolas
 Schier" <nsc@kernel.org>, "Nick Desaulniers" <ndesaulniers@google.com>, "Bill
 Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, linux-kbuild@vger.kernel.org, gary@garyguo.net
In-Reply-To: <20261029162958.3224280-2-irogers@google.com>
References: <20261029162958.3224280-1-irogers@google.com>
 <20261029162958.3224280-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 16:57:04 +0000
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
- [Medium] tools build: sub-make PKG_CONFIG override blocks --static append
- [Medium] tools build: lib%.rlib pattern rule fails for subdirectory targe=
ts
- [Medium] tools build: missing rustc --target in Makefile.rust and early f=
eature check
--

commit 15e2b90d3792008ff59190071c3b1973f7ab8c0b
Author: Ian Rogers <irogers@google.com>

tools build: Add Rust library build infrastructure and zlib-rs feature test

This patch adds shared Rust library build and feature detection infrastruct=
ure
under tools/build/ and tools/scripts/, along with a feature test for zlib-r=
s.
It supports locating Cargo crate sources or pkg-config packages, compiling
.rlib and .a targets with rustc, and resolving C compiler and linker flags.

> diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
> index ad69efdd4e85c..50c3eb57d34b8 100644
> --- a/tools/build/Makefile.build
> +++ b/tools/build/Makefile.build
[ ... ]
> @@ -117,6 +120,10 @@ $(OUTPUT)%.s: %.c FORCE
> =20
>  # it's recommended to build a static rust library, when a foreight (to r=
ust)
>  # linker is used.
> +$(OUTPUT)lib%.rlib: %.rs FORCE
> +	$(call rule_mkdir)
> +	$(call if_changed_dep,rustc_rlib_rs)

[Severity: Medium]
Will this pattern rule match .rlib targets located in subdirectories?

Later in tools/build/Makefile.build, targets in obj-y are prefixed with both
$(OUTPUT) and $(dir)/:

    objprefix    :=3D $(subst ./,,$(OUTPUT)$(dir)/)
    obj-y        :=3D $(addprefix $(objprefix),$(obj-y))

Other pattern rules in tools/build/Makefile.build place % immediately after
$(OUTPUT), such as $(OUTPUT)%.o: %.c FORCE and $(OUTPUT)%.a: %.rs FORCE, wh=
ich
allows the stem % to match <subdir>/<name>.

Because $(OUTPUT)lib%.rlib places the literal prefix lib immediately after
$(OUTPUT), a target in a subdirectory expands to
$(OUTPUT)<subdir>/lib<name>.rlib. When $(OUTPUT) is non-empty, the pattern
contains a slash, so GNU Make matches against the full path and fails to ma=
tch
$(OUTPUT)lib%.rlib whenever <subdir> is present. When $(OUTPUT) is empty,
directory-stripped matching sets the stem % to <name> without <subdir>/, so
the prerequisite %.rs looks for <name>.rs in the current directory rather t=
han
in <subdir>/.

> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 4d37d11f674c5..c372600ae9e44 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -5,10 +5,11 @@ ifneq ($(OUTPUT),)
>    OUTPUT_FEATURES =3D $(OUTPUT)feature/
>    $(shell mkdir -p $(OUTPUT_FEATURES))
>  endif
> +RUST_OUTPUT ?=3D $(abspath $(or $(OUTPUT),$(CURDIR)))/
> =20
>  feature_check =3D $(eval $(feature_check_code))
>  define feature_check_code
> -  feature-$(1) :=3D $(shell $(MAKE) OUTPUT=3D$(OUTPUT_FEATURES) CC=3D"$(=
CC)" CXX=3D"$(CXX)" CFLAGS=3D"$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))"=
 CXXFLAGS=3D"$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" LDFLAGS=3D"$=
(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" -C $(feature_dir) $(OUTPUT_FEATURE=
S)test-$1.bin >/dev/null 2>/dev/null && echo 1 || echo 0)
> +  feature-$(1) :=3D $(shell $(MAKE) OUTPUT=3D$(OUTPUT_FEATURES) RUST_OUT=
PUT=3D"$(RUST_OUTPUT)" CC=3D"$(CC)" CXX=3D"$(CXX)" RUSTC=3D"$(RUSTC)" $(if =
$(PKG_CONFIG),PKG_CONFIG=3D"$(PKG_CONFIG)") CFLAGS=3D"$(CLANG_CROSS_FLAGS) =
$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))" CXXFLAGS=3D"$(CLANG_CROSS_FLA=
GS) $(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" RUST_FLAGS=3D"$(RUST_=
FLAGS)" LDFLAGS=3D"$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" -C $(feature_d=
ir) $(OUTPUT_FEATURES)test-$1.bin >/dev/null 2>/dev/null && echo 1 || echo =
0)
>  endef
[ ... ]
> diff --git a/tools/build/Makefile.rust b/tools/build/Makefile.rust
> new file mode 100644
> index 0000000000000..cd9e0915b9298
> --- /dev/null
> +++ b/tools/build/Makefile.rust
> @@ -0,0 +1,149 @@
[ ... ]
> +ifeq ($(findstring -static,${LDFLAGS}),-static)
> +  ifeq ($(findstring --static,$(PKG_CONFIG)),)
> +    PKG_CONFIG +=3D --static
> +  endif
> +endif

[Severity: Medium]
When LDFLAGS contains -static, does PKG_CONFIG +=3D --static take effect if=
 the
caller passes PKG_CONFIG on the sub-make command line?

Both feature_check_code in tools/build/Makefile.feature and
feature_rust_lib_code in tools/scripts/Makefile.include pass
$(if $(PKG_CONFIG),PKG_CONFIG=3D"$(PKG_CONFIG)") as a command-line argument=
 to
$(MAKE). When invoked from Makefiles that initialize PKG_CONFIG (such as
tools/perf/Makefile.perf or tools/tracing/rtla/Makefile.rtla), PKG_CONFIG h=
as
command-line origin in the sub-make.

In GNU Make, ordinary non-override +=3D appends to a command-line variable =
are
ignored, so PKG_CONFIG +=3D --static in both tools/build/Makefile.rust and
tools/build/feature/Makefile:

    ifeq ($(findstring -static,${LDFLAGS}),-static)
      PKG_CONFIG +=3D --static
    endif

is skipped during static builds, omitting transitive static libraries from
pkg-config queries. Should these use override PKG_CONFIG +=3D --static?

[ ... ]
> +cmd_rustc_rlib =3D \
> +	$(rustc_target_envs) $(RUSTC) $(RUST_FLAGS) $(rustc_common_flags) $(rus=
tc_target_flags) \
> +	$(call rlibs-to-externs,$^) --crate-type rlib --crate-name $(patsubst l=
ib%.rlib,%,$(notdir $@)) \
> +	-o $@ $(filter %.rs,$^) > $(@:.rlib=3D.make.output) 2>&1
> +
> +cmd_rustc_staticlib =3D \
> +	$(rustc_target_envs) $(RUSTC) $(RUST_FLAGS) $(rustc_common_flags) $(rus=
tc_target_flags) \
> +	$(call rlibs-to-externs,$^) --crate-type staticlib --crate-name $(patsu=
bst lib%.a,%,$(notdir $@)) \
> +	-o $@ $(filter %.rs,$^) > $(@:.a=3D.make.output) 2>&1
[ ... ]
> diff --git a/tools/scripts/Makefile.arch b/tools/scripts/Makefile.arch
> index ed5f008d400ed..d5f25f3be555f 100644
> --- a/tools/scripts/Makefile.arch
> +++ b/tools/scripts/Makefile.arch
> @@ -50,3 +50,17 @@ ifeq ($(LP64), 1)
>  else
>    IS_64_BIT :=3D 0
>  endif
> +
> +# Map kernel ARCH to rustc --target triples when cross-compiling tools/.
> +ifneq ($(CROSS_COMPILE),)
> +  RUST_TARGET_FLAGS_arm		:=3D arm-unknown-linux-gnueabi
> +  RUST_TARGET_FLAGS_arm64	:=3D aarch64-unknown-linux-gnu
> +  RUST_TARGET_FLAGS_loongarch	:=3D loongarch64-unknown-linux-gnu
> +  RUST_TARGET_FLAGS_m68k	:=3D m68k-unknown-linux-gnu
> +  RUST_TARGET_FLAGS_mips	:=3D mipsel-unknown-linux-gnu
> +  RUST_TARGET_FLAGS_powerpc	:=3D powerpc64le-unknown-linux-gnu
> +  RUST_TARGET_FLAGS_riscv	:=3D riscv64gc-unknown-linux-gnu
> +  RUST_TARGET_FLAGS_s390	:=3D s390x-unknown-linux-gnu
> +  RUST_TARGET_FLAGS_x86		:=3D x86_64-unknown-linux-gnu
> +  RUST_TARGET_FLAGS_x86_64	:=3D x86_64-unknown-linux-gnu
> +endif

[Severity: Medium]
How does RUST_TARGET_FLAGS_$(ARCH) get passed to rustc when tools/build/fea=
ture
or tools/build/Makefile.rust builds libz_rs.a during cross-compilation?

tools/scripts/Makefile.arch defines RUST_TARGET_FLAGS_<arch> when CROSS_COM=
PILE
is set, but neither Makefile.arch, Makefile.include, Makefile.feature, nor
Makefile.rust adds --target=3D$(RUST_TARGET_FLAGS_$(ARCH)) to RUST_FLAGS or
rustc_common_flags.

When feature_check runs for zlib-rs without --target in RUST_FLAGS (for
example, in tools/build/Makefile.feature when FEATURE_TESTS=3Dall is evalua=
ted
before a caller sets RUST_FLAGS, or in standalone feature checks),
cmd_rustc_rlib and cmd_rustc_staticlib in tools/build/Makefile.rust compile
liblibc.rlib, libzlib_rs.rlib, and libz_rs.a for the host architecture. Lin=
king
test-zlib-rs.bin with the cross-compiler $(CC) then fails, and because the
rules in tools/build/Makefile.rust do not rebuild when RUST_FLAGS changes, =
the
host-architecture archives remain cached in $(LIBZ_RS_OUTPUT) for subsequent
invocations in the same build directory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029162958.3224=
280-1-irogers@google.com?part=3D1
