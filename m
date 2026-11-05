Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903456;
	b=xPSeb+DdYPo0XekIS3ONJ90ssOC3DgSi8T1307nICRBwJcmpiOt9L9qraYikGdE8CTuS
	 9QZdcPmWyJAi3sSqQ9dpLAt/p6f0fmvVdPbbcsAFPegeFey4JdwPNBc+wEjnJ0qwZCGO0
	 LUb5xj63vkkUkYYcHSL/ZaUz/iaU6ElmSkIuoMEl1SvJtwilKZcwDdFcEF3zqdDgdzAtB
	 /TtOeDe8uFXzHrSG69AbAg+1vJs6lu0HApeBO4agf0eYtXv6XHuhIdKyQhrrCmlkjItR7
	 DKPpZgp1zJxIllF7kgrc8Si9m9TQevB+5g1+1o0sUDpXGIIpJO6ZMc9SXYXyDfOtqtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903456;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vVhpqikISQXl5pJb/RMvkCOgXacVq/CG6zfA+mX4EdI=;
	b=MKfR6z6DPxlbxLdMRh7+SJS4uNyxQMrD2veYT49P/DPqZvOqsOdY5prq7k0lMYlQKlWb
	 HVIeMXRTixexpn/pWvaDuXV8WRp+7a89EcxiGazcT28ak3WfvnYlaVQDJ38WeSf67Eg2O
	 kXKR7XwzIkLFNRLdT/e13bgRtplK61BtJHcDerFhANqj4BvXu7F0ZwsFnDc4j/0l7TRni
	 ZP92RBganh+pRQuX+Flk7fLBpWW3wQNGLRurYl/X9kM+XWYoQleweCJzlrWUbKzSdHCeY
	 BG5hnzvh3DqKEGw4kj/DWzl1pB4irA+/tTp8vya2/fuvMI0cpUx3AnlHgGg8GelVgsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OHgocqGD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF29606A31B;
	Thu,  5 Nov 2026 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OHgocqGD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE131F00919;
	Thu,  5 Nov 2026 18:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793903455;
	bh=vVhpqikISQXl5pJb/RMvkCOgXacVq/CG6zfA+mX4EdI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OHgocqGDGRb8X8llMMX+/obt5mn+TIQkaootouwpOT8AKwsOqREQhF5evvxrJJxkg
	 cMVjipvlZRKT3M7qHBghFvP7BKkVLQN/PrXfdyH8608AR0HIufxgwv5R/byPRC6HRF
	 wxGFWoaXyESbrtU3YucIdyjj+NxCnN0JVrn4L65pCl5gD819bMcCgfRayulppq9q2J
	 HD1Z/+iKPjh8kV0TkTiZViaDEJgm8RgUsmk8TlYSpMtAwjpkrrTnxRanqcaaSs+rtB
	 osNnKpyaUYzekrI4xrBzf/qj8NaI4B/1MAVR0mLFHGD0nhN/AddKJpKRJmiuhmaaBS
	 317arvw1Mddag==
Message-ID: <sashiko-outbox-199770@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 1/3] tools build: Add Rust library build
 infrastructure and zlib-rs feature test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Namhyung
 Kim" <namhyung@kernel.org>, "Jiri Olsa" <jolsa@kernel.org>, "Adrian Hunter" <adrian.hunter@intel.com>, "Quentin
 Monnet" <qmo@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Nathan
 Chancellor" <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>
Cc: "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?b?QmrDtnJuIFJveSBCYXJvbg==?= <bjorn3_gh@protonmail.com>, "Benno
 Lossin" <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Nick Desaulniers" <ndesaulniers@google.com>, "Bill
 Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>, linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, linux-kbuild@vger.kernel.org
In-Reply-To: <20261105180923.3441359-2-irogers@google.com>
References: <20261105180923.3441359-1-irogers@google.com>
 <20261105180923.3441359-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 18:30:53 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] tools build: feature_check_code passes CLANG_CROSS_FLAGS to g++ =
in CXXFLAGS
--

commit b53b88b2adbac2b7788068d159976b5144e79923
Author: Ian Rogers <irogers@google.com>

tools build: Add Rust library build infrastructure and zlib-rs feature test

This commit adds shared Rust library build and feature detection rules under
tools/build/Makefile.rust, along with cross-compilation target mappings and=
 a
feature test for zlib-rs.

> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 4d37d11f674c5..ecf27626d493e 100644
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
PUT=3D"$(RUST_OUTPUT)" CC=3D"$(CC)" CXX=3D"$(CXX)" CARGO=3D"$(CARGO)" RUSTC=
=3D"$(RUSTC)" $(if $(PKG_CONFIG),PKG_CONFIG=3D"$(PKG_CONFIG)") CFLAGS=3D"$(=
CLANG_CROSS_FLAGS) $(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))" CXXFLAGS=
=3D"$(CLANG_CROSS_FLAGS) $(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))" =
RUST_FLAGS=3D"$(RUST_FLAGS)" LDFLAGS=3D"$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-=
$(1))" -C $(feature_dir) $(OUTPUT_FEATURES)test-$1.bin >/dev/null 2>/dev/nu=
ll && echo 1 || echo 0)
>  endef

[Severity: Medium]
Does prepending $(CLANG_CROSS_FLAGS) to CXXFLAGS in feature_check_code break
C++ feature detection (such as cxa-demangle, llvm, and llvm-perf) when
cross-compiling with CC=3Dclang and the default CXX=3D$(CROSS_COMPILE)g++?

In tools/scripts/Makefile.include, CLANG_CROSS_FLAGS is populated whenever
CC_NO_CLANG is 0 and CROSS_COMPILE is set, and is only appended to CFLAGS a=
nd
AFLAGS while CXX defaults to $(CROSS_COMPILE)g++ (unless LLVM is set or CXX=
 is
explicitly overridden):

tools/scripts/Makefile.include:
    $(call allow-override,CC,$(CROSS_COMPILE)gcc)
    ...
    $(call allow-override,CXX,$(CROSS_COMPILE)g++)
    ...
    CLANG_CROSS_FLAGS :=3D --target=3D$(CLANG_TARGET)
    GCC_TOOLCHAIN_DIR :=3D $(dir $(shell which $(CROSS_COMPILE)gcc 2>/dev/n=
ull))
    ifneq ($(GCC_TOOLCHAIN_DIR),)
    CLANG_CROSS_FLAGS +=3D --prefix=3D$(GCC_TOOLCHAIN_DIR)$(notdir $(CROSS_=
COMPILE))
    CLANG_CROSS_FLAGS +=3D --sysroot=3D$(shell $(CROSS_COMPILE)gcc -print-s=
ysroot)
    CLANG_CROSS_FLAGS +=3D --gcc-toolchain=3D$(realpath $(GCC_TOOLCHAIN_DIR=
)/..)
    endif # GCC_TOOLCHAIN_DIR
    endif # CLANG_CROSS_FLAGS
    CFLAGS +=3D $(CLANG_CROSS_FLAGS)
    AFLAGS +=3D $(CLANG_CROSS_FLAGS)

As noted in tools/perf/Makefile.config (commit c8592f8da838 ("perf build: F=
ix
CXX clang flag injection when only CC=3Dclang is set")), CC being clang doe=
s not
imply CXX is clang++. When $(CROSS_COMPILE)g++ is invoked for a C++ feature
check via $(BUILDXX), it rejects Clang-only flags in CLANG_CROSS_FLAGS such=
 as
--target=3D... and --gcc-toolchain=3D..., causing the feature check to fail.

Also, this change to CFLAGS and CXXFLAGS in tools/build/Makefile.feature is
not mentioned in the commit message. Should CLANG_CROSS_FLAGS only be passed
in CXXFLAGS when CXX is actually clang++, or is this change intended for a
separate patch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105180923.3441=
359-1-irogers@google.com?part=3D1
