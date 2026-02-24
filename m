Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2403A63EB
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Feb 2026 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771951333; cv=pass; b=au6efcGqM4VLC/h4w2X03wEzlxqcPOjL1DB5VHE1EnroUjf+MYp3LySBenEF4uevsHNfYGaCT8FffThmH5cCflSXNe+EgEfc7NU0bP5m8+ed+zrEX2DTsTG/XOkv5o7WUSZiivg/zLYtKebAHT3vN2njAOMtoDe51BLowdXqo8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771951333; c=relaxed/simple;
	bh=NcSXw2HJsJraWVfV0B2TsfnQhljzimFsSoywmgza1gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=biU/gH+HtVGuqgkUHhy58UvLuYVyRPWREqY2QBSw0eoGAebP7oQbaZoiift6/HNr1C1LS9ZO4ci2n9+G9w90wf+d2C7/GRYcA/wFjgFtHScm3oOUo3m/nLkeZlAd1hLPzVVLFMhHiUxT+OIDKkjOlBQKryIHx81La+uxOeo7pNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0R+JxOSh; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0R+JxOSh"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-126ea4e9697so1117c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Feb 2026 08:42:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771951331; cv=none;
        d=google.com; s=arc-20240605;
        b=B9NAmhJQTYS264lipYVnsP/g0hk4kj6R3/pb5alqzKjAqR7uY8RzaLgmIrTV1+K1+F
         pVy2StefuANMPtROBz+mZe1TRdomO3PufGf+/6zGm+ZhfXg5pzndF4XvdDGcUESLyxx3
         7ICcH5PtEGNrjUXuyxGfVRZsTicQmaDr0c7Jut6ZiYPyb/b7G5aYdH9zliG9bf+pQ4hw
         s/r20sQwOThrxnN7RyhSNsyImK+oIN8P08c1kEhPLgBHiOfC0SwCNp35xcCTxJQ3lDtr
         1VON0PDQQOluk+zJoen8e4X/lzFrka08+xPjUMxSX3ewOBFrjEPKA6xJpJz6O4uouC6S
         QPLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kgwg6ZY+UwlSzzQ1IYs4ifU8gB4nY+Z3oaeaPRk66as=;
        fh=0GySQAcmjERnn5lfkQjah8ALybDk2nQcMLUuPHqGAk0=;
        b=RziHiVlhpcFpQ8jZEO6x+zHaMXsOoPHRgA/stPGYSl/D2xq/LTCRHRDo1BEnNXY6wZ
         QzwHv6WKu5L1zW2TWFtwm3JGBjUJ2xwd10i4vuB3lXRf2+0CQ1Xk2KPmw4MnsH5R4eAd
         ER0kKSDRaJVrL3WIPEdRyPzraK6ZLkwYFUmC6lolI4tlF8n7GWK8vYfiu5uJWGXuXngJ
         hfTDHvSDMehDjH8AbQgcmC1C6GZF59LNTFZfdMmrEwFM0FtW6v8UP0tOFyqpZC9w4ldG
         2gOnF8has3EZHfMk5B3rPRcKakuFQU9aTsB+DHaETUi0NDNSnnOhRzW4f/ZBFOdAT45Q
         ISGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771951331; x=1772556131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kgwg6ZY+UwlSzzQ1IYs4ifU8gB4nY+Z3oaeaPRk66as=;
        b=0R+JxOShw4GlFbZkmUvJX5R0JviYF+CIDxWTK3iU95wXV5uxBOdTxCbdPoGYjBwIZF
         EgvEoGZZyfMLU0c3ntChn2dEwpjYGgdn4MRITHU1i8TA/AUg5ImzOVAhSUTxwy3dNYBF
         rwwjKNpcuYzoKLkxmQaoPQqEzisAh2+XwQJs39RMabB0MFnxJVct/RtKoYTOL1dXfc2K
         /4xNX1ufQnIGKX4SWezhgpQuCRyZgZo/GDGiT+FP4tSsMGgtjpycENturKlRlcV4ohru
         1fhhzkA0ZxghJ1GyG4H0kndWwA0c7z4oeoEqiS5tAhe9DXPrqtkiEs6RdIaT4rGEDPQG
         OZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771951331; x=1772556131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kgwg6ZY+UwlSzzQ1IYs4ifU8gB4nY+Z3oaeaPRk66as=;
        b=aJKEpNIGVn8wj5Pjh0sTPtIf5+dObZVRv17a1rI05v1Qq2qLWt5f4zRZwvEc4QSKFm
         qD8FTfBp490VNx2KzjbPUfTcwrUPBiawaHneFWQCnUT2sXpLtgnb12cq2X2gyuvafDuO
         ayv2qi6sDJEC0fSi1u7sYWNm4xGaBwVGilrOpj6PhNV4F/hj8VM89NObGOmixelSAbif
         UiDx7iUewIdAL1ImJJR+T60CsDctJR2vjvOGLNMH/bkP6jKqHhtWrOlxj22GqveXti2v
         aeXi85tUxUoQzDtGe+hAd/5JgbnftR6AFIQ61DvSxtGiGBDKrL6Elnerl7hoWar8DxkF
         RQUQ==
X-Gm-Message-State: AOJu0YzF3U7weOhhc+XW+YCTmYzsfwCp2pfE6fd3OI7GZZuq/ev2EMVw
	dZkEgcVAXkUHW4+s7ID3O2MyTyUFiTXAM18Ednun7aD15aRSNlCkw5t2Jhne3iPKsI8IXhC93M/
	fISarn2Y3S46l0qEQbQ7h853BMxzj1BCvmLLHYC0i
X-Gm-Gg: AZuq6aI53FZRvMyV32gg0S6o6ZRdNndFWeEwBF2JXCrA0fURL/TzJ+xGDrKGONivi8n
	QJWGznc0ACqj8tH59DAMgw+4xM+VCxlinpGkcHD3W/Z43wMxbKr2b6F9AE0shALwsr5sc69TjGC
	KlD489Xdwz5hZJix0JIeOT4ccRITdFA1r5ZApeeS2jkTl9iXrDe6bnPzsn+hG0zv1Jl0hJR/7P4
	5rvRF8LveMQ9pnOVqSS+FuODZGU/ki4+xVqYRAtfvQ5h+oogVDBuSj30S8b+N7VmXDPsYCp/20Q
	ontRVayZmkUeBz6wTCIx5mGECBLfjyaQjDMY
X-Received: by 2002:a05:7022:1e10:b0:119:e55a:8087 with SMTP id
 a92af1059eb24-12779ca1e66mr162200c88.4.1771951329849; Tue, 24 Feb 2026
 08:42:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218154800.367720-1-9erthalion6@gmail.com>
In-Reply-To: <20260218154800.367720-1-9erthalion6@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 24 Feb 2026 08:41:57 -0800
X-Gm-Features: AaiRm51usgiRE1d1KtF1udatehmVlkbDM9zzDjPMxJJwgnnXlY4zfmGsIkXNl18
Message-ID: <CAP-5=fXLNybYv08dDfAqAsDBzbOPzQY4EZQvdY0WZsfrMu9Yyg@mail.gmail.com>
Subject: Re: [PATCH v4] tools build: Fix rust cross compilation
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

On Wed, Feb 18, 2026 at 7:48=E2=80=AFAM Dmitrii Dolgov <9erthalion6@gmail.c=
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
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> ---
> Changes in v4
> - Fixed incorrect target name for riscv
>
> Changes in v3
> - Improved commit message, add an example of the compilation failure
>
> Changes in v2:
> - Map supported CROSS_COMPILE values to corresponding Rust targets
>
>
>  tools/build/Build.include  |  9 +++++++++
>  tools/perf/Makefile.config | 14 ++++++++++++++
>  tools/perf/Makefile.perf   |  2 +-
>  3 files changed, 24 insertions(+), 1 deletion(-)
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
> index a8dc72cfe48..214d8f6d9b8 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -1163,6 +1163,20 @@ ifndef NO_RUST
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
> +    RUST_FLAGS +=3D --target=3D$(RUST_TARGET_FLAGS_$(ARCH))

I'm wondering about lesser tested platforms like loongarch, csky,
xtensa but I don't know how to concoct a triple for these. I wonder if
there should be a test for a missing string like:

  ifeq($(RUST_TARGET_FLAGS_$(ARCH)),)
    $(error Unknown rust cross compilation architecture $(ARCH))
  endif

other than this:

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

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
> base-commit: dbf0108347bdb5d4ccef8910555b16c1f1a505f8
> --
> 2.52.0
>
