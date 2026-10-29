Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292648;
	b=ELL8Kh8Bm26L3y4zgSfJmogxkhVyiYW2dcQicHoCT5Yw5k39mf7elAqGCPLd1z13Bo9T
	 RiIVwnVYJva1zETUpAoUwPsNaMkTyZEomT6DfUxBt/OF6iGsrPVLerFFqXkf5H1sMlGHt
	 YcWhsq6RRaxiE+GFj/v+w6SNEXz9Q9p0SY4tU9W86ZltBYg3/0jYfc6fm9GXE4+zDqh5f
	 ekzpPiADJ5+ICbfaWxT/v0ZTPtLpDogyheak2AAouvdIWkKQjuJOqP+6slUg2Ld4S/Amv
	 Q/OytOiLEOUtwLmxjSIo/Tz1WwZ4v/3l6EadKIr/iTc2q1xDfdlmFRDTROrhSQNqxvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292648;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MSUjr46/WEerio+UJ5mDFrT7MRqyE1zmZiJiZIWI6D0=;
	b=fGx2SEqsUmpgugrd35UNgAJyHbS9ohxkEcLul3VQfdvFKoSHnTC/l9zA0IyY3Fy1VZhw
	 yT0siTNQRx6rq+iNGNwJk7KQD7KQ5oSKAlFzkj6KypkIB7lvTaJe/OL6qimcI54DXwLwG
	 Mk6gnCvh7PrcLyNQB4SZ4MlAGu2e/YuMqgvKWr0NY6bpsp8Two1pvVQZakFcccpVsUH6U
	 P5wW7hg5n/GQn+Tf7DYBDeoceTjwb/Ftuu10un7JDtwkTmjTzp+4yAjNtDlIXWHQUgL9r
	 G6yqqncGepBJNbIaNi5LF2c4vUiltmurZC0YR81UQsh5ZBx1maiaJvWeA5jMWkaGgWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HvMzT2rD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49403606A31A;
	Thu, 29 Oct 2026 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HvMzT2rD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15881F01816;
	Thu, 29 Oct 2026 16:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793292647;
	bh=MSUjr46/WEerio+UJ5mDFrT7MRqyE1zmZiJiZIWI6D0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HvMzT2rDkXbMhslstNoQpbUKFgrAbR3ZmT/CxyKvHY7QmTVD3+t7Xp49Svk9zH4JQ
	 Lrg8OWHK7C8SXftFnxhs7AYJyDU+xDZglVooGsgwsnp0XCDLrWmhy9YRWeDYijlrxr
	 92QTxKpALyqSlpQG3KxC7OEdOC0p01JFBA46MbDOjqKhU2tOqOzL1Z8xElUvOm9iOc
	 Vk9Wlbs6yqKbqONfCq5mNhtRMZzcLk5NtsolzwPmQWeajfH9AJVZgt9RhpMkYME1mU
	 ggcIlicYtNRMhcBWVPSrnosAXpF9e2DZgzs7FFRUdh2AbZJGxFS9xwuN0PRZvgjJiE
	 CJVnJ8FDGckXA==
Message-ID: <sashiko-outbox-189684@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 2/3] perf build: Prefer zlib-rs over zlib when
 available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Namhyung
 Kim" <namhyung@kernel.org>, "Quentin Monnet" <qmo@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, "Nicolas
 Schier" <nsc@kernel.org>, "Nick Desaulniers" <ndesaulniers@google.com>, "Bill
 Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, linux-kbuild@vger.kernel.org, gary@garyguo.net
In-Reply-To: <20261029162958.3224280-3-irogers@google.com>
References: <20261029162958.3224280-1-irogers@google.com>
 <20261029162958.3224280-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 16:50:46 +0000
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
- [Medium] perf build: RUST_FLAGS set after Makefile.feature breaks cross f=
eature-dump
--

commit 71bfdd124d6b614e2d4b506eb746a963a59097da
Author: Ian Rogers <irogers@google.com>

perf build: Prefer zlib-rs over zlib when available

This commit updates the perf build system to detect and prefer zlib-rs over=
 C
zlib unless disabled via NO_ZLIB_RS=3D1, NO_ZLIB=3D1, or NO_RUST=3D1. It mo=
ves Rust
compiler detection ahead of zlib detection in Makefile.config, builds
libz_rs.a in $(OUTPUT)libz_rs/, and exposes the zlib-rs feature in perf che=
ck.

> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index b4764f69f47f4..4313fca53aa7c 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -532,13 +532,57 @@ ifdef CORESIGHT
>    endif
>  endif
> =20
> -ifndef NO_ZLIB
> -  ifeq ($(feature-zlib), 1)
> -    CFLAGS +=3D -DHAVE_ZLIB_SUPPORT
> -    EXTLIBS +=3D -lz
> -    $(call detected,CONFIG_ZLIB)
> +ifndef NO_RUST
> +  $(call feature_check,rust)
> +  ifneq ($(feature-rust), 1)
> +    $(warning Rust is not found. Test workloads with rust are disabled.)
> +    NO_RUST :=3D 1
>    else
> -    NO_ZLIB :=3D 1
> +    NO_RUST :=3D 0
> +    CFLAGS +=3D -DHAVE_RUST_SUPPORT
> +    $(call detected,CONFIG_RUST_SUPPORT)
> +  endif
> +
> +  ifneq ($(CROSS_COMPILE),)
> +    ifeq ($(RUST_TARGET_FLAGS_$(ARCH)),)
> +      $(error Unknown rust cross compilation architecture $(ARCH))
> +    endif
> +
> +    RUST_FLAGS +=3D --target=3D$(RUST_TARGET_FLAGS_$(ARCH))
> +  endif
> +endif
> +
> +# Building zlib-rs from Cargo crate sources requires a working rustc.
> +ifneq ($(NO_RUST), 0)
> +  NO_ZLIB_RS :=3D 1
> +endif
> +
> +# Prefer zlib-rs over C zlib when available, unless disabled via NO_ZLIB=
=3D1 or
> +# NO_ZLIB_RS=3D1. Both provide the standard zlib C API (HAVE_ZLIB_SUPPOR=
T), while
> +# HAVE_ZLIB_RS_SUPPORT records that zlib-rs is the implementation in use.
> +ifndef NO_ZLIB
> +  ifndef NO_ZLIB_RS
> +    $(call feature_check,zlib-rs)

[Severity: Medium]
When cross-compiling with the feature-dump target (or FEATURE_TESTS=3Dall),
does setting RUST_FLAGS here happen too late for tools/build/Makefile.featu=
re?

In tools/perf/Makefile.perf, building the feature-dump target sets
FEATURE_TESTS :=3D all before including Makefile.config:

tools/perf/Makefile.perf:
ifeq ($(config),1)
ifdef MAKECMDGOALS
ifeq ($(filter feature-dump,$(MAKECMDGOALS)),feature-dump)
FEATURE_TESTS :=3D all
endif
endif
include Makefile.config
endif

Earlier in tools/perf/Makefile.config, tools/build/Makefile.feature is
included before the NO_RUST block:

tools/perf/Makefile.config:
ifeq ($(FEATURES_DUMP),)
  FEATURE_DISPLAY_DEFERRED :=3D 1
include $(srctree)/tools/build/Makefile.feature
else
include $(FEATURES_DUMP)
endif

When FEATURE_TESTS is set to all, Makefile.feature expands FEATURE_TESTS to
include FEATURE_TESTS_EXTRA (which contains zlib-rs) and runs
$(call feature_check,zlib-rs) while RUST_FLAGS still lacks
--target=3D$(RUST_TARGET_FLAGS_$(ARCH)).

That initial feature check invokes tools/build/Makefile.rust with an empty
RUST_FLAGS, compiling $(OUTPUT)libz_rs/libz_rs.a for the host architecture.
Linking test-zlib-rs.bin with the cross-compiler $(CC) against the host
libz_rs.a then fails and records feature-zlib-rs=3D0 in $(OUTPUT)FEATURE-DU=
MP.

Furthermore, when execution reaches the second $(call feature_check,zlib-rs)
above after RUST_FLAGS is populated, $(OUTPUT)libz_rs/libz_rs.a already
exists on disk from the host build, so Make considers it up-to-date and lin=
ks
against the stale host archive again.

Should the CROSS_COMPILE configuration of RUST_FLAGS be moved above the
inclusion of tools/build/Makefile.feature alongside the CC and CLANG_FLAGS
cross-compilation setup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029162958.3224=
280-1-irogers@google.com?part=3D2
