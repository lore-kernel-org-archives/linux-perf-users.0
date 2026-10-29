Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293585;
	b=1eiVwwTUuilCtDi0tP4pmwCWIycmhDMO+UJO7uyAGMYsEBdsvAkFTP3j5l4ui1oFnZIA
	 nT5zsENMeBJsBM4DOdSsYZNxmbwatsO1PSFgnUT/jWSaxJPnDXTsyPa2+omc128m9hpW7
	 ajNEpM9KWNwxDdBoA9kq2Nbil0vqe2wRRCtkTW9qgGagl6hVDlP7z7KjL/ESwwEsLW2sv
	 js9MKgt6qTTKFCmxhnhRrsd6kDFKKJP+6NkBYkVwKMcU5MLi6FnUvw0W95M8tBhqWzayW
	 1PWZYvxTHIKBhMHqBn9EmZwkeetYTST6YvlxDNd8GT01kDhJzUpg+x0C6JnkTMRl+2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293585;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uhinfOj6G0C6Rx9NfglgMVhwpPTi8kNJ5VV2avR4jbY=;
	b=0srMFZIaAZP/YDYqR1P9EjcCERmXOyErsAfRZaYWTbG7IdWB1hF3BXgn7pH3lusbDefa
	 TOF+nqsCWTmtENiXIy34bZNfsGeYnRqUmg0manL1yQ4fR/oeJgERKTggzzi4/sFRNXtNT
	 I1blhX9mWAPQNsVrFG/1WhSRP9zMDiNJTKmy8ZLB62kLWZ2FsKtXQMjDDoSigaGKIilXD
	 kIazDFVIQ1EUHKBSKI2cavTpthT+ide7fC5VrPg00jYXYhnsozSK8Rrravx1swCMF9nqG
	 IwysbO9luGgxpx2J4iuIkuFYY9o5TQPHwfmBK3eHM6GbpYgPYhjKMvg4tyKhik+EdBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iNP6ULfQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D7F606A31C;
	Thu, 29 Oct 2026 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iNP6ULfQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DC71F01816;
	Thu, 29 Oct 2026 17:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793293584;
	bh=uhinfOj6G0C6Rx9NfglgMVhwpPTi8kNJ5VV2avR4jbY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iNP6ULfQMAMTf2a8z3iLOeDYZtoddpbgLuEX1NWLLZm4BGmB5RPccw24M2xwJazN7
	 8KH3UjRaZ6Nx6SN07UVhMQNBeqvd+zGS8izhvcNMAzzEH3dxTxgRw4B/q0azFypsWB
	 cGHNt6zMgbCEy6cu91V6a/rcuY22Z9rTwTDeYQDniTPI8AiJjxUZ5T1virZbs/m1mL
	 zrsoq5qIhLUIvQHIjhXPjGOBemuwP08JXMvRQBIHPkFc1aHydowqsrf5T5Kl/eDULT
	 UdlvJXqMfJCPSi/TlY+sPLLFMbmzaBHAcvpPbEQ9AXHzCpKZTZTECSvTbLSjfe24Ho
	 UMlIKZeclMUJw==
Message-ID: <sashiko-outbox-189716@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 3/3] bpftool: Prefer zlib-rs over zlib when
 available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Namhyung
 Kim" <namhyung@kernel.org>, "Quentin Monnet" <qmo@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>, "Nicolas
 Schier" <nsc@kernel.org>, "Nick Desaulniers" <ndesaulniers@google.com>, "Bill
 Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, linux-kbuild@vger.kernel.org, gary@garyguo.net
In-Reply-To: <20261029162958.3224280-4-irogers@google.com>
References: <20261029162958.3224280-1-irogers@google.com>
 <20261029162958.3224280-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 17:06:23 +0000
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
- [Medium] bpftool: link failure with pre-built libbpf.a when zlib-rs is us=
ed
--

commit 7a2cb794e37f624ded57767492091a08919fa52c
Author: Ian Rogers <irogers@google.com>

bpftool: Prefer zlib-rs over zlib when available

This commit updates the bpftool Makefile to detect and prefer zlib-rs over
C zlib, configuring ZLIB_CFLAGS and ZLIB_LIBS via feature_rust_lib and
falling back to -lz when zlib-rs is unavailable or when cross-compiling
bootstrap bpftool.

> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index b0f7168e79432..a193cf89a0346 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
[ ... ]
> @@ -38,7 +41,9 @@ $(LIBBPF_OUTPUT) $(BOOTSTRAP_OUTPUT) $(LIBBPF_BOOTSTRAP=
_OUTPUT) $(LIBBPF_HDRS_DI
> =20
>  $(LIBBPF): $(wildcard $(BPF_DIR)/*.[ch] $(BPF_DIR)/Makefile) | $(LIBBPF_=
OUTPUT)
>  	$(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=3D$(LIBBPF_OUTPUT) \
> -		DESTDIR=3D$(LIBBPF_DESTDIR:/=3D) prefix=3D $(LIBBPF) install_headers
> +		DESTDIR=3D$(LIBBPF_DESTDIR:/=3D) prefix=3D \
> +		$(if $(ZLIB_CFLAGS),EXTRA_CFLAGS=3D"$(or $(EXTRA_CFLAGS),-g -O2) $(ZLI=
B_CFLAGS)") \
> +		$(LIBBPF) install_headers
[ ... ]
> @@ -153,8 +178,27 @@ include $(FEATURES_DUMP)
>  endif
>  endif
> =20
> -LIBS =3D $(LIBBPF) -lelf $(CRYPTO_LIBS) -lz
> -LIBS_BOOTSTRAP =3D $(LIBBPF_BOOTSTRAP) -lelf $(CRYPTO_LIBS) -lz
> +# Prefer zlib-rs over C zlib when detected. When cross-compiling, the ho=
st
> +# bootstrap bpftool still links against the host's -lz.
> +ifeq ($(feature-zlib-rs),1)
> +  $(call feature_rust_lib,zlib-rs)
> +  ZLIB_CFLAGS :=3D $(FEATURE_CFLAGS-zlib-rs)
> +  ZLIB_LIBS :=3D $(FEATURE_LIBS-zlib-rs)
> +  CFLAGS +=3D $(ZLIB_CFLAGS)
> +  ifeq ($(CROSS_COMPILE),)
> +    HOST_CFLAGS +=3D $(ZLIB_CFLAGS)
> +    LIBBPF_BOOTSTRAP_CFLAGS +=3D $(ZLIB_CFLAGS)
> +    ZLIB_BOOTSTRAP_LIBS :=3D $(ZLIB_LIBS)
> +  else
> +    ZLIB_BOOTSTRAP_LIBS :=3D -lz
> +  endif
> +else
> +  ZLIB_LIBS :=3D -lz
> +  ZLIB_BOOTSTRAP_LIBS :=3D -lz
> +endif
> +
> +LIBS =3D $(LIBBPF) -lelf $(CRYPTO_LIBS) $(ZLIB_LIBS)
> +LIBS_BOOTSTRAP =3D $(LIBBPF_BOOTSTRAP) -lelf $(CRYPTO_LIBS) $(ZLIB_BOOTS=
TRAP_LIBS)

[Severity: Medium]
Can this cause a link failure with an undefined reference to gzopen64 when
bpftool is built using a pre-built libbpf.a on a host where zlib-rs is
detected?

In tools/lib/bpf/Makefile, libbpf is compiled with:

    override CFLAGS +=3D -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64

When tools/lib/bpf/libbpf.c is compiled without ZLIB_CFLAGS, bpf_object__re=
ad_kconfig_file()
includes the system zlib.h with those macros defined, which remaps gzopen()
to gzopen64() and leaves an undefined reference to gzopen64 in libbpf.a.
In contrast, libz-rs-sys only exports gzopen and not gzopen64, which is why
the $(LIBBPF) and $(LIBBPF_BOOTSTRAP) rules here pass $(ZLIB_CFLAGS) so that
libbpf uses the bundled zlib.h from libz-rs-sys.

However, several Makefiles build libbpf.a directly via tools/lib/bpf/Makefi=
le
without ZLIB_CFLAGS and then pass that pre-built archive directory to
bpftool via LIBBPF_OUTPUT or LIBBPF_BOOTSTRAP_OUTPUT, such as
tools/testing/selftests/bpf/Makefile:

    $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makef=
ile)    \
                        $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
            $(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)                =
        \
                        ARCH=3D CROSS_COMPILE=3D CC=3D"$(HOSTCC)" LD=3D"$(H=
OSTLD)"         \
                        EXTRA_CFLAGS=3D'-g $(OPT_FLAGS) $(SAN_CFLAGS) $(EXT=
RA_CFLAGS)' \
                        EXTRA_LDFLAGS=3D'$(SAN_LDFLAGS) $(EXTRA_LDFLAGS)'  =
          \
                        OUTPUT=3D$(HOST_BUILD_DIR)/bpftool/                =
          \
                        LIBBPF_OUTPUT=3D$(HOST_BUILD_DIR)/libbpf/

Similar patterns exist in tools/sched_ext/Makefile,
tools/testing/selftests/sched_ext/Makefile,
tools/testing/selftests/hid/Makefile, and drivers/hid/bpf/progs/Makefile.

Because $(LIBBPF) or $(LIBBPF_BOOTSTRAP) already exists and is up to date w=
hen
bpftool's Makefile runs, the $(LIBBPF) recipe with $(ZLIB_CFLAGS) is skippe=
d,
while LIBS and LIBS_BOOTSTRAP replace -lz with $(ZLIB_LIBS) (libz_rs.a).
Wouldn't linking bpftool then fail with an unresolved gzopen64 symbol from =
the
pre-built libbpf.a?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029162958.3224=
280-1-irogers@google.com?part=3D3
