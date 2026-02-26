Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00628368977
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772125841; cv=pass; b=bMZr1R2tY55PVVKiV6F/RAIUCSO1s9WKLgvPv3b/tg90DNGUjS4KSdE8zLjW3kySjyEoYk0TvarOVg8szTiVQ4Wwmj4XKz7k2Yqcoko1hNFbGwYzkst2/agmyRmemWXoca0Rtcf+8CKfndsUwqYVcE/5PAaqj+GR2h8mnMC+nis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772125841; c=relaxed/simple;
	bh=xmziTarInCIRwtxSSmje+LWoF/k0lGuKsOpoP5h8De4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krzZ+HTdNS+J4BIoQ7RUsj7XXQqYQycOAjFmbAQ4BS4erby+s0kMzZNg6N8oAiTufyIpHeYRDYoKLJdLKVBzXe/CQeVvY9EGcmSdshUB8BlWJPvLzzSMURVY2pCOaOCkoX2XVlKj9qUHgNPsNG124IyXx8mtkv7KqQeuYqgihYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=00I/jxEE; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="00I/jxEE"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-124a60cc9a1so12884c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 09:10:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772125839; cv=none;
        d=google.com; s=arc-20240605;
        b=PEPlDpyV/BCoeNVrlBWTY6E2KVPJ3VyuO1Qw7fOtfOBnPCIOFe58ukj7kQNs5OwK/2
         dl379Ng24hWvg4uaRNEHW30h93RyDSIPBGKhhBfAyxK4H2Jzor6+qtvSJqb6146bCv91
         zCVoLFO29lMeo/eJnZx1YZpVA+bk7hAZbT2pRdhj4F5eOLSi0BJ8mcnMq/gYKE8UCiq/
         0mQaGDcrgVM7hIQHf7z0aIDWfvqBdfgCVt5YlJJzVDt/kd+6xh7+/Sf6vztsbgmvig6Q
         fhZ+S/KgnkiNs0K7xcaL+JikEO02yeUZk1cWrcCCyB1aJuGS3znw4GVo82PwR90gwAXV
         iBoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Tkedhw7TgiRSyuuriQLlHDY6QGJT0+ZpOxRxRI4lhlk=;
        fh=0GySQAcmjERnn5lfkQjah8ALybDk2nQcMLUuPHqGAk0=;
        b=Q+cPbBNHU3KDrT17KVioXvSAjMc36326oYQRjhRag7te8XkpkGHbxNebBZt+CFjCHw
         /8wmokMznN2TgP2mOKHMp2QUOhJI4pJDrU721pbY9n9K4Zx3VnhmqwCPVLScfY1uBKH6
         5+k0Rprh8tTG3b9R4CfwxlWCp21zQwtvh5LzxjJOD2iABvcs+StElF/InZmuHtwrvetj
         V9k8ScAV+SWYPioDGL1Gh5ME3JRZSNLX5jo5xtBXtlBCWMHguDxTjIEBhOrze/9ltA0v
         44/39v660UPrPrDFjp5bAVV78taAUJSpJYrn60U/AQIoa1HvCuUH9cfLVUIMGSxzfC9l
         aprw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772125839; x=1772730639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tkedhw7TgiRSyuuriQLlHDY6QGJT0+ZpOxRxRI4lhlk=;
        b=00I/jxEEX0ocSikq83u12s7JnDH2wQX63akZIbg45lfLE/rqmltpx8EJ0wfi6LR4Xw
         140FeFbZmvIkfbyV8ftuwPqrjAIPH/DKavch1it44hzHOE7TL62myC3Vb8tMQiIOg3h5
         A/DZIsB3OFE4hU9LxifUXHZaf9sonLAgeT0Mdi0WwwBrvFvh7sGaDV0ClTeS3soUi9e1
         lTLbJUAt4DtrRlXeYxe5DEEUgdmr8znQUlDbGQ7qlnKS6l4xLaTlenfnyTHkuQsXpgIc
         W2y544hwwm0gvG1PTlvViUoKEfDsYLaZqbkUZ6c/5ElZZ4/KHy1gQKmpYWYHElo2Tnzf
         hozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772125839; x=1772730639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tkedhw7TgiRSyuuriQLlHDY6QGJT0+ZpOxRxRI4lhlk=;
        b=O02xSjtKXyAVDCAMcMvpX9cB3AsXbFAW3B6MwPR0u4qDKxavjzgPdcvKrvSRXIDi9F
         25+Wi3QUU5cZZNjTH7gq8hX2u2IddVVRVHLFWe3e2zX7oRyIK/5rzZ3FcMyhXsAqbjeS
         GIKHfL0zT3Htd1+ZkJJyfZ0vRhvSwp+If8oE07SRblXSuGwdYZLP+9YSxoizwoNczQ/r
         KiednRoeCxyd5Br1pgBT5ipOOjZetKBvYu/ruc0GL0PDz8Z5cos+AseHh/b+qq8ESsxe
         iCLOSmZNU4ItuSmlvnKlVSNJzLJSa4XaqwHWanMxvF2bdIO3EU5o+2+13Gxn6bAOF7tq
         tBGA==
X-Gm-Message-State: AOJu0Ywao5KbvI0jhadnWuyHydE6nPVoQEhMCcEIKQQwhXhnqkjJRFYR
	tqc/XeDq1VQ8kegbA6iM3LPGDs/3wE0XTCY0PoCKqlv6DYYdW8fmwQUR2L/tppgOskO7Vo2wgK5
	Q0p0J8hrLDLD22qYeO6t2DKtgzn9OIl4tjVO5QR5k
X-Gm-Gg: ATEYQzxk9Mqgbbv1tyO6j0fQnKCvnHnwMIJtyPV5EbuMup6d9PRHB2F9iX8udPaVj0D
	4Hkqr03476jTOqGVRKBCooF8LWY9vl2hQQjPyajuMHnhdlEdaF1NFeiE96XjwmkwgkZCQkHghTo
	Vak9BjSWw4EcIxiMed6AzO3wU04JVSdGIlC5dr2frdoJXxM3P5WGLOYzN9NJYiPff+qqVp/uMdZ
	89B8ZwiQEjgCnQ4IZ0u+vh6uKvHZb46g8X2zyphPiSdOSTmhGi4RsX3g4Pt6+UMGt+HECuVhhdk
	1lAuQppRrr1os06lcBt2NUv+2Kpo4q0YjKv9
X-Received: by 2002:a05:7022:12b:b0:120:5719:624e with SMTP id
 a92af1059eb24-127899a14cfmr234350c88.21.1772125838341; Thu, 26 Feb 2026
 09:10:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226170025.517743-1-9erthalion6@gmail.com>
In-Reply-To: <20260226170025.517743-1-9erthalion6@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 26 Feb 2026 09:10:24 -0800
X-Gm-Features: AaiRm510Cs64l5p7kN6EkkvMZnr3dIa5eUS-klcq5Z9h7367sJ9AsV5d4VjRgVE
Message-ID: <CAP-5=fV7OuWN9K-wnsS7zza+s0FQRSR_JCcJi5tvpgQAbh=Nnw@mail.gmail.com>
Subject: Re: [PATCH v5] tools build: Fix rust cross compilation
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Levi Zim <i@kxxt.dev>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 9:00=E2=80=AFAM Dmitrii Dolgov <9erthalion6@gmail.c=
om> wrote:
>
> Currently no target is specified to compile rust code when needed, which
> breaks cross compilation. E.g. for arm64:
>
>       LD      /tmp/build/tests/workloads/perf-test-in.o
>     aarch64-linux-gnu-ld: /tmp/build/tests/workloads/code_with_type.a(cod=
e_with_type.code_with_type.d12f4324cb53c560-cgu.0.rcgu.o): Relocations in g=
eneric ELF (EM: 62)
>     aarch64-linux-gnu-ld: /tmp/build/tests/workloads/code_with_type.a(cod=
e_with_type.code_with_type.d12f4324cb53c560-cgu.0.rcgu.o): Relocations in g=
eneric ELF (EM: 62)
>     [...repeated...]
>     aarch64-linux-gnu-ld: /tmp/build/tests/workloads/code_with_type.a(cod=
e_with_type.code_with_type.d12f4324cb53c560-cgu.0.rcgu.o): Relocations in g=
eneric ELF (EM: 62)
>     aarch64-linux-gnu-ld: /tmp/build/tests/workloads/code_with_type.a(cod=
e_with_type.code_with_type.d12f4324cb53c560-cgu.0.rcgu.o): Relocations in g=
eneric ELF (EM: 62)
>     aarch64-linux-gnu-ld: /tmp/build/tests/workloads/code_with_type.a: er=
ror adding symbols: file in wrong format
>     make[5]: *** [/perf/tools/build/Makefile.build:162: /tmp/build/tests/=
workloads/perf-test-in.o] Error 1
>     make[4]: *** [/perf/tools/build/Makefile.build:156: workloads] Error =
2
>     make[3]: *** [/perf/tools/build/Makefile.build:156: tests] Error 2
>     make[2]: *** [Makefile.perf:785: /tmp/build/perf-test-in.o] Error 2
>     make[2]: *** Waiting for unfinished jobs....
>     make[1]: *** [Makefile.perf:289: sub-make] Error 2
>     make: *** [Makefile:76: all] Error 2
>
> Detect required target and pass it via rust_flags to the compiler.
>
> Note that CROSS_COMPILE might be different from what rust compiler
> expects, since it may omit the target vendor value, e.g.
> "aarch64-linux-gnu" instead of "aarch64-unknown-linux-gnu". Thus
> explicitly map supported CROSS_COMPILE values to corresponding Rust
> versions, as suggested by Miguel Ojeda.
>
> Tested using arm64 cross-compilation example from [1].
>
> Fixes: 2e05bb52a12 ("perf test workload: Add code_with_type test workload=
")
> Link: https://perfwiki.github.io/main/arm64-cross-compilation-dockerfile/=
 [1]
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>

Not a cross-compilation problem, but is there a way to pass-through
extra flags to the rust compiler? For CFLAGS we have EXTRA_CFLAGS as a
make variable, but I don't see an EXTRA_RUSTFLAGS. I was looking for
this because I was trying to make a build passing "-m32" to CFLAGS to
create a 32-bit perf binary. The link against the rust workload was
failing due to the different object types.

Thanks,
Ian

> ---
> Changes in v5
> - Error out if the target arch is not covered
>
> Changes in v4
> - Fixed incorrect target name for riscv
>
> Changes in v3
> - Improved commit message, add an example of the compilation failure
>
> Changes in v2:
> - Map supported CROSS_COMPILE values to corresponding Rust targets
>
>  tools/build/Build.include  |  9 +++++++++
>  tools/perf/Makefile.config | 18 ++++++++++++++++++
>  tools/perf/Makefile.perf   |  2 +-
>  3 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/tools/build/Build.include b/tools/build/Build.include
> index e45b2eb0d24..cd0baa7a168 100644
> --- a/tools/build/Build.include
> +++ b/tools/build/Build.include
> @@ -98,6 +98,15 @@ c_flags_2 =3D $(filter-out $(CFLAGS_REMOVE_$(basetarge=
t).o), $(c_flags_1))
>  c_flags   =3D $(filter-out $(CFLAGS_REMOVE_$(obj)), $(c_flags_2))
>  cxx_flags =3D -Wp,-MD,$(depfile) -Wp,-MT,$@ $(CXXFLAGS) -D"BUILD_STR(s)=
=3D\#s" $(CXXFLAGS_$(basetarget).o) $(CXXFLAGS_$(obj))
>
> +###
> +# Rust flags to be used on rule definition, includes:
> +# - global $(RUST_FLAGS)
> +# - per target Rust flags
> +# - per object Rust flags
> +rust_flags_1 =3D $(RUST_FLAGS) $(RUST_FLAGS_$(basetarget).o) $(RUST_FLAG=
S_$(obj))
> +rust_flags_2 =3D $(filter-out $(RUST_FLAGS_REMOVE_$(basetarget).o), $(ru=
st_flags_1))
> +rust_flags   =3D $(filter-out $(RUST_FLAGS_REMOVE_$(obj)), $(rust_flags_=
2))
> +
>  ###
>  ## HOSTCC C flags
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index a8dc72cfe48..15fbba9f4ca 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -1163,6 +1163,24 @@ ifndef NO_RUST
>      CFLAGS +=3D -DHAVE_RUST_SUPPORT
>      $(call detected,CONFIG_RUST_SUPPORT)
>    endif
> +
> +  ifneq ($(CROSS_COMPILE),)
> +    RUST_TARGET_FLAGS_arm      :=3D arm-unknown-linux-gnueabi
> +    RUST_TARGET_FLAGS_arm64    :=3D aarch64-unknown-linux-gnu
> +    RUST_TARGET_FLAGS_m68k     :=3D m68k-unknown-linux-gnu
> +    RUST_TARGET_FLAGS_mips     :=3D mipsel-unknown-linux-gnu
> +    RUST_TARGET_FLAGS_powerpc  :=3D powerpc64le-unknown-linux-gnu
> +    RUST_TARGET_FLAGS_riscv    :=3D riscv64gc-unknown-linux-gnu
> +    RUST_TARGET_FLAGS_s390     :=3D s390x-unknown-linux-gnu
> +    RUST_TARGET_FLAGS_x86      :=3D x86_64-unknown-linux-gnu
> +    RUST_TARGET_FLAGS_x86_64   :=3D x86_64-unknown-linux-gnu
> +
> +    ifeq ($(RUST_TARGET_FLAGS_$(ARCH)),)
> +      $(error Unknown rust cross compilation architecture $(ARCH))
> +    endif
> +
> +    RUST_FLAGS +=3D --target=3D$(RUST_TARGET_FLAGS_$(ARCH))
> +  endif
>  endif
>
>  # Among the variables below, these:
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 11b63bafdb2..f7b936deeaa 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -274,7 +274,7 @@ ifeq ($(PYLINT),1)
>    PYLINT :=3D $(shell which pylint 2> /dev/null)
>  endif
>
> -export srctree OUTPUT RM CC CXX RUSTC LD AR CFLAGS CXXFLAGS V BISON FLEX=
 AWK
> +export srctree OUTPUT RM CC CXX RUSTC LD AR CFLAGS CXXFLAGS RUST_FLAGS V=
 BISON FLEX AWK
>  export HOSTCC HOSTLD HOSTAR HOSTCFLAGS SHELLCHECK MYPY PYLINT
>
>  include $(srctree)/tools/build/Makefile.include
>
> base-commit: c5a244bf17caf2de22f9e100832b75f72b31d3e6
> --
> 2.52.0
>
