Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793393185;
	b=BKQLQ9QLmaE7urZmscKliRgmMKUC2quXrZFIKEZQswcLpEI5a7mTfWms5Up0T7BreFwL
	 ETBAiudF8AQL+ImeVxji1TGf7uNh5TwC8rtqUquaw09CTKUTI7ru+0XdNS90GTQFsXXO7
	 mlWUe6RJpJ2VJZRwy3gAVdM92bb4T5ABAENiXJecYpCteze29cPv37Ca7jCEal/WJiigW
	 xSNeesG5xgw+SBspkxE17FaIN7oDA/SezpwMj1qGAjuBimoeKPEjqJFrlsoxajy8M+l2a
	 3F7CLdw1LK4Xkl9J1tRQ1str9XPT3MxeZrHbIw1iYSXHR8glAJxkz9yLft+Y9gSKebA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793393185;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WH27+khOQ7m7iea+ADvh40kQbuUdu+lR02JYiMic7Hw=;
	b=UZIHBjqsEOtYPrXe7D1nPfu8jb4sM4CA1i8q5ZOt3JqzEUtoug5wPfSO9eEPUkmqNaBg
	 Myy7nqmq1VGzBco/IsXzyFUZ7Zmu6dORDsOzsvzKXsh4mMaHvEreBzrzx+Iae0BajG3VT
	 Sa0CMkmi++i/gggnUc3sCDSdW2urrC7ULw/SerxjSzs803fNAm4ug1ZUMk+GiL6ncuY1y
	 rbRXPuQjz0ZOC+XevX/P7/ROkkBj6r/9noXx56AHEVYlPWLNz4pdYYKhEBHX6PHmGqbtn
	 xR9+LJoEZUXUI5Z6gR2pRdvkWz7yaIRQDhNh9XeVAiIx6IpIAS4wJ9PQ84phoUYG9JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gfJDrkhV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BAE606A31C;
	Fri, 30 Oct 2026 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gfJDrkhV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0311F000C1;
	Fri, 30 Oct 2026 20:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793393185;
	bh=WH27+khOQ7m7iea+ADvh40kQbuUdu+lR02JYiMic7Hw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gfJDrkhVDCWcuBN97blp7leKTakBTA7M/Tjh8BU9HRjL/oKcHYb8WHU1JiLZlInQa
	 17wykmbGfJaBsqYS8IeSptmaODl2vwzerh6dtT0zX4eQCrjSJ0UCs8tpc+cJRpIA0d
	 AMJ8xRooaJHeR9vKKzg8P5p8RBYAvLtZbG6ZqnelZOVh9RnAr4av4vAeqnJ5oklWFi
	 igvOoKSSfUG10S0UJf4ZGtCAv2p7uqZctag4f+nr8uP7YB1LnBu5iKapn3lwWH3acV
	 OIqqn6Dt/F5jlIhE1gUJjMWkFXDxOjtldh0krk1Xm1j0g1ZGXkLHda6+evmN3HIopO
	 ySJvfKTqLzEFA==
Message-ID: <sashiko-outbox-191493@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/3] perf build: Prefer zlib-rs over zlib when
 available
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
In-Reply-To: <20261030202710.3863806-3-irogers@google.com>
References: <20261030202710.3863806-1-irogers@google.com>
 <20261030202710.3863806-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 20:46:23 +0000
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
- [Low] perf build: missing -lz in BUILD_NONDISTRO when NO_ZLIB=3D1
--

commit db3abd69d02d2d4c46341fce54f1b1da8d6457de
Author: Ian Rogers <irogers@google.com>

perf build: Prefer zlib-rs over zlib when available

This commit detects and prefers zlib-rs over C zlib in the perf build unless
disabled with NO_ZLIB_RS=3D1, NO_ZLIB=3D1, or NO_RUST=3D1. It also integrat=
es
libz_rs.a into the perf and bootstrap bpftool build rules and exposes zlib-=
rs
in perf check feature and build tests.

> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index b4764f69f47f4..d447f4bd8f5b1 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config

[ ... ]

> @@ -532,13 +538,54 @@ ifdef CORESIGHT
>    endif
>  endif
> =20
> +ifndef NO_RUST
> +  $(call feature_check,rust)
> +  ifneq ($(feature-rust), 1)
> +    $(warning Rust is not found. Test workloads with rust are disabled.)
> +    NO_RUST :=3D 1
> +  else
> +    NO_RUST :=3D 0
> +    CFLAGS +=3D -DHAVE_RUST_SUPPORT
> +    $(call detected,CONFIG_RUST_SUPPORT)
> +  endif
> +
> +  ifneq ($(CROSS_COMPILE),)
> +    ifeq ($(RUST_TARGET_FLAGS_$(ARCH)),)
> +      $(error Unknown rust cross compilation architecture $(ARCH))
> +    endif
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
>  ifndef NO_ZLIB
> -  ifeq ($(feature-zlib), 1)
> +  ifndef NO_ZLIB_RS
> +    $(call feature_check,zlib-rs)
> +    ifeq ($(feature-zlib-rs), 1)
> +      $(call feature_rust_lib,zlib-rs)
> +      ZLIB_CFLAGS :=3D $(FEATURE_CFLAGS-zlib-rs)
> +      ZLIB_LIBS :=3D $(FEATURE_LIBS-zlib-rs)
> +      CFLAGS +=3D -DHAVE_ZLIB_RS_SUPPORT $(ZLIB_CFLAGS)
> +      $(call detected,CONFIG_ZLIB_RS)
> +    endif
> +  endif
> +  ifeq ($(ZLIB_LIBS),)
> +    ifeq ($(feature-zlib), 1)
> +      ZLIB_LIBS :=3D -lz
> +    else
> +      NO_ZLIB :=3D 1
> +    endif
> +  endif
> +  ifneq ($(ZLIB_LIBS),)
>      CFLAGS +=3D -DHAVE_ZLIB_SUPPORT
> -    EXTLIBS +=3D -lz
> +    EXTLIBS +=3D $(ZLIB_LIBS)
>      $(call detected,CONFIG_ZLIB)
> -  else
> -    NO_ZLIB :=3D 1
>    endif
>  endif
> =20
> @@ -908,7 +955,7 @@ ifdef BUILD_NONDISTRO
>    else ifeq ($(feature-libbfd-liberty), 1)
>      EXTLIBS +=3D -lbfd -lopcodes -liberty
>    else ifeq ($(feature-libbfd-liberty-z), 1)
> -    EXTLIBS +=3D -lbfd -lopcodes -liberty -lz
> +    EXTLIBS +=3D -lbfd -lopcodes -liberty $(ZLIB_LIBS)
>    endif

[Severity: Low]
In the BUILD_NONDISTRO block of tools/perf/Makefile.config, ZLIB_LIBS is on=
ly
populated inside the ifndef NO_ZLIB block above, where it is already append=
ed
to EXTLIBS.

When building with BUILD_NONDISTRO=3D1 and NO_ZLIB=3D1 on a system where li=
bbfd
requires -liberty and -lz (so feature-libbfd-liberty-z is 1), ZLIB_LIBS is
empty.

Will replacing -lz with $(ZLIB_LIBS) here cause the link against libbfd to
fail with unresolved zlib symbols when NO_ZLIB=3D1, and duplicate $(ZLIB_LI=
BS)
in EXTLIBS when NO_ZLIB is not set?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030202710.3863=
806-1-irogers@google.com?part=3D2
