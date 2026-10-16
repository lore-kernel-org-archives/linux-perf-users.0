Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE71A515897
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792165308; cv=pass; b=CBWEmX3rntkCi9947fg2zlGNU097Ns0uEgoN8FH2ochnTkGur90dauz7NECT9f0dctEqqE9A/UgJxDgBjp+91PpuDd+seqPYWLvB3xZdyGDGfWFIotM6mwf0v4WFxdyMzkTFZ30FbW/nf+wvlL5aGD/o9/akUyZASkJAW6Fw+4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792165308; c=relaxed/simple;
	bh=EdkSpCj7hNZcxLPGAmr5Svs9uzq/yo5MUONBoId45GE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNwhbuxM3su1lgaVrlBiyu+dNlppx2ltNygUSMk8D3eiTdcD6XEw+zTfJyOborRDN991r7qOusOCY6QVUzXsKg3yXi3h4mM1C+QPC5/I6QnVtDnaXCqirW+s9cdY+dUz309yev7XFp0S+Mp5uC05ZqtoN3b0imPOmd1+lBcYggU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fcuB+tzJ; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fcuB+tzJ"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-535f598d126so296521cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 08:41:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792165303; cv=none;
        d=google.com; s=arc-20260327;
        b=qG+UwWQ+Mwr35CsotPgWZUdb/g1TvaHPTn5CPmAx5tk2OlGr9tmRx9I54mMGyupTpS
         eqc6N3nvWISTgoEUNGCRQJ85QQCsuzM7XqwWga8SqrKhdTtpLIwTGW7cOTjUthSI0Ol3
         9YRu34rN/8oG43I6N1a+QGPwrYk+wemK16EISfatqVBuVvxUA1bqe4sdoUgXkUqRWYoj
         UuW8Oq3s1j8djXcyWqV0/8O+rb+qwnOBkZcV4ESRpjQn2zhQI4C/zu9pWQjM8Z6//+LO
         Pifsh2ydYzFTEmInlrcBQBA2RA0ZOhbl4bYo4uJ2hy5rQJGlRlTYXTCzlMpnT3QQyehu
         cVNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w/6QFU6AYA8TWsY/UeVE0scsevyNdyU2Km01Cay74S0=;
        fh=QO9/hYKXZAXHmHz7kKaHKRBTCCnFDuik9+c/t4pI3zI=;
        b=DE8U0jpxbfb4PypdsHWBw4QCTu27c3zpWNuweboHuVzZEOqqPf+5AYxZPX8Ei8b/PK
         rF9k3YC7AzY6NWUM38KP5VztqdyvCCmNVGmRWmChfR5dnRm4If2OaCJcnd8bzCVknCLk
         HgT+4jlmTWWFaKUzwuy6uaDJDcVSePvLgVOsn+Ls6v8mBm4sgvYsgrc8YhV9D3lSdPQB
         9V9Fie0rTxi38liJs9Ecak+K6xxfWL1w3HvKxOJFnwnjBd4zU9ATHiRXD/LWUM6i/WkA
         ip5hfp34m6Flga5uKALcbbleGeoFBDZ7rU4UFBJfbvVVZr12wWrEKCUZA7mirNPP4/Tr
         c1oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792165303; x=1792770103; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w/6QFU6AYA8TWsY/UeVE0scsevyNdyU2Km01Cay74S0=;
        b=fcuB+tzJnYytJac4HoIiRbSAjE9yqoRWKn5zccuHwRy0CUwI1ImsTyTvwxH8BcdtPN
         cr6Ve3HDb1XX7yXISeWNMU3U2MlDEscP4h+e834317QQ1yUfLoIQJ1CnWa0ede68tUC/
         rz7Izm6kOS9aXB6NcSY+63ITDyjdwnI/hiJho14YTOzfk+rCDftosOaoI4s68nH8B3II
         dLz+WIY28QYmDR4gxvO2CdAp6AIw5exXyikCXUxumdU+G0PS0aJXJsnq41kdfA61Hshw
         huI0K67cCau+y+gl8t5dGsyJEIQIGUzvuzSnKmUoZU8FKfIpDrODbvHkIY4qSGxEwzPj
         pcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792165303; x=1792770103;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w/6QFU6AYA8TWsY/UeVE0scsevyNdyU2Km01Cay74S0=;
        b=u9USVMHTACwBKB9+tiKmMjC3NGL5fczhyQnZ+hN8GY4tS3CdnGxWUm4K9RSw5nDQiU
         gvY8vAGWjasfUH1FplT1edm2Fr8nMu4f3DDAUaFNL4DjLt3n2GZtlee2XvKUGTp/lRSy
         wMpT/wRqaS8xmmXovy86fbJFYEgD+0xJ6B1JonwZWk7scS+wNPhAV/Qr/DHYMCgXKoB5
         bqLlGPQqiaYj+bU3VeIuFvlC9GUrYVjQFJsYO+Xmm+LOdtcTC9AA/OZBBf+SLCDLNnU8
         MMORqLv+AZvp4S9OoiLcuI9ev6RUBjDcaqYvENehwjqce1LNXxi4ZFIdpQ21DqAL6Zx2
         7yxQ==
X-Forwarded-Encrypted: i=1; AKwUvByf47SUzV1i8w1l0wWQxp4raqXNof5jd4ra6hJ9K4eJipf5F7eAi4qCr26BlozJ11ZgUiRtlRh5RlIQMrm4jDDw@vger.kernel.org
X-Gm-Message-State: AFq9FYJf/cwVTwdxOa+YLSmcNaXpa6UlX/j0h4RyV0Xt8iquFlEFvBhS
	wqQcBRRbTgwfPuJVLXFCIXuX/nDets6Llixl+nvceeAcO5NrL+sfrFJ9Kv2pvC6pNyW8Z6Cpd9s
	1DFpLl35y88w4VnPMMBeY8QfS5nnSwDlZvFMXn7xZ
X-Gm-Gg: AYBFou2PSJtb1yDBKsPqW92yjqNVjVz/Pf5g72E14AotX6fZnVs0vhPaDQaZFNcROOl
	94MIpGzP2dbEz0Z0+3PD2NkFDIO9m0Zt7epkZfs6fh+Q1+9l9BpBIvaS5iWF4a6Amc6zuh0ut2I
	DhTaN1w31a1kbdnFuV40V8W0fYLHCQOq8PK0ixXi93PQq1SwlmEK4qSLuUqN6GF+PXBPYXBdiJy
	6fHKNjbde7Ja45bYyBiy4RdQ12/C0v7hsf2rtWR+Aop6VFxJKi+7u8PUfzF1PvdcjbGFwdpBea5
	mVYSca19G738bbZmRbmgQhG27y9ABt+TkyGbwQPwDGbXQKqVFWbocdKodyeBQEare8I1fV+Xs48
	Jq/o+dtNN+QY=
X-Received: by 2002:a05:622a:4886:b0:533:9731:f0f1 with SMTP id
 d75a77b69052e-5362b3e7881mr20460851cf.10.1792165302889; Fri, 16 Oct 2026
 08:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016143143.3613501-1-sashal@kernel.org> <20261016143143.3613501-4-sashal@kernel.org>
In-Reply-To: <20261016143143.3613501-4-sashal@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 16 Oct 2026 08:41:29 -0700
X-Gm-Features: AclHuK9Nw6uxiW7Jt1G3pjd76v05weMuSMdw0gbbOHi_Cx8XoClXGbI2Vr90vjg
Message-ID: <CAP-5=fV_A+k-_g683q7n897YMudBwwvQPkS_cKRSdOxkEYFa0Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/7] perf build: Add MINIMAL=1 to build without
 optional features
To: Sasha Levin <sashal@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, linux-kbuild@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 7:31=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> Turning off every optional feature takes a long list of NO_* variables,
> and the list has to follow features as they are added and renamed. The
> one in tests/make for make_minimal has fallen behind: it leaves
> libtraceevent, jevents, slang, AIO, LZMA, zlib, libLLVM and Rust to be
> detected, so a make_minimal build still needs libtraceevent and python.
>
> Add MINIMAL=3D1, which turns off every optional feature, the BPF skeleton=
s
> and the shellcheck run. perf then builds, natively or cross, with no
> library beyond the C library and without python, pkg-config, clang or
> rustc, and the result does not depend on what is installed on the build
> machine.
>
> A MINIMAL=3D1 build also leaves out the notices that post unwind and
> python support are disabled, which it asked for, and the one about the
> pkg-config search path for cross builds, as pkg-config is not needed
> then.
>
> It is handled in Makefile.perf rather than Makefile.config, as
> Makefile.config is included after the pkg-config and shellcheck setup.
>
> Use it for make_minimal in tests/make.
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Link: https://lore.kernel.org/r/CAP-5=3DfWFY-tpJz2vcBZvurwdZY5gwd8cuTemE9=
q1rtZ0Vi0dng@mail.gmail.com
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  tools/perf/Makefile.config |  8 ++++++--
>  tools/perf/Makefile.perf   | 40 ++++++++++++++++++++++++++++++++++++--
>  tools/perf/tests/make      |  8 +-------
>  3 files changed, 45 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 4d5993da9f945..137c9e120670b 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -742,7 +742,9 @@ dwarf-post-unwind-text :=3D BUG
>  # setup DWARF post unwinder
>  ifdef NO_LIBUNWIND
>    ifdef NO_LIBDW
> -    $(warning Disabling post unwind, no support found.)
> +    ifneq ($(MINIMAL),1)
> +      $(warning Disabling post unwind, no support found.)
> +    endif
>      dwarf-post-unwind :=3D 0
>    else
>      dwarf-post-unwind-text :=3D libdw
> @@ -828,7 +830,9 @@ endef
>
>  PYTHON_EXTENSION_SUFFIX :=3D '.so'
>  ifdef NO_LIBPYTHON
> -  $(call disable-python,Python support disabled by user)
> +  ifneq ($(MINIMAL),1)
> +    $(call disable-python,Python support disabled by user)
> +  endif

Thanks for the clean up!

In perf-tools-next/linux-next both LIBPYTHON and LIBPERL are gone
(context in https://lore.kernel.org/linux-perf-users/20260926062029.800743-=
47-irogers@google.com/#t
).

>  else
>
>    ifndef PYTHON
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 29cfd44c427f3..c770077e7d392 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -129,6 +129,9 @@ include ../scripts/utilities.mak
>  # Define GEN_VMLINUX_H to generate vmlinux.h from the BTF.
>  #
>  # Define NO_SHELLCHECK if you do not want to run shellcheck during build
> +#
> +# Define MINIMAL=3D1 to build without any optional feature, needing only=
 a C
> +# compiler and library, flex and bison
>
>  # As per kernel Makefile, avoid funny character set dependencies
>  unexport LC_ALL
> @@ -174,6 +177,37 @@ endef
>
>  LD +=3D $(EXTRA_LDFLAGS)
>
> +# MINIMAL=3D1 is handled here rather than in Makefile.config, which is i=
ncluded
> +# after the pkg-config and shellcheck setup below
> +ifeq ($(MINIMAL),1)
> +  NO_LIBELF :=3D 1
> +  NO_LIBDW :=3D 1
> +  NO_LIBTRACEEVENT :=3D 1
> +  NO_JEVENTS :=3D 1
> +  NO_LIBPYTHON :=3D 1
> +  NO_LIBBPF :=3D 1
> +  BUILD_BPF_SKEL :=3D 0
> +  NO_SLANG :=3D 1
> +  NO_DEMANGLE :=3D 1
> +  NO_BACKTRACE :=3D 1
> +  NO_AIO :=3D 1
> +  NO_ZLIB :=3D 1
> +  NO_LZMA :=3D 1
> +  NO_LIBZSTD :=3D 1
> +  NO_LIBNUMA :=3D 1
> +  NO_LIBLLVM :=3D 1
> +  NO_CAPSTONE :=3D 1
> +  NO_LIBPFM4 :=3D 1
> +  NO_LIBDEBUGINFOD :=3D 1
> +  NO_BABELTRACE2 :=3D 1
> +  NO_SDT :=3D 1
> +  NO_JVMTI :=3D 1
> +  NO_RUST :=3D 1
> +  NO_PERF_READ_VDSO32 :=3D 1
> +  NO_PERF_READ_VDSOX32 :=3D 1
> +  NO_SHELLCHECK :=3D 1

We should expand this with NO_MYPY and NO_PYLINT for the
perf-tools-next version.

Thanks,
Ian

> +endif
> +
>  # Some distros provide the command $(CROSS_COMPILE)pkg-config for
>  # searching packges installed with Multiarch. Use it for cross
>  # compilation if it is existed.
> @@ -195,8 +229,10 @@ else
>        PKG_CONFIG_LIBDIR :=3D $(PKG_CONFIG_LIBDIR):/usr/local/share/pkgco=
nfig/
>        PKG_CONFIG_LIBDIR :=3D $(PKG_CONFIG_LIBDIR):/usr/share/pkgconfig/
>        export PKG_CONFIG_LIBDIR
> -      $(warning Missing PKG_CONFIG_LIBDIR, PKG_CONFIG_PATH and PKG_CONFI=
G_SYSROOT_DIR for cross compilation,)
> -      $(warning set PKG_CONFIG_LIBDIR for using Multiarch libs.)
> +      ifneq ($(MINIMAL),1)
> +        $(warning Missing PKG_CONFIG_LIBDIR, PKG_CONFIG_PATH and PKG_CON=
FIG_SYSROOT_DIR for cross compilation,)
> +        $(warning set PKG_CONFIG_LIBDIR for using Multiarch libs.)
> +      endif
>      endif
>    endif
>  endif
> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index d2c2f526e1db0..dbbc971a144b2 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -115,13 +115,7 @@ make_install_prefix       :=3D install prefix=3D/tmp=
/krava
>  make_install_prefix_slash :=3D install prefix=3D/tmp/krava/
>  make_static         :=3D LDFLAGS=3D-static NO_PERF_READ_VDSO32=3D1 NO_PE=
RF_READ_VDSOX32=3D1 NO_JVMTI=3D1 NO_LIBTRACEEVENT=3D1 NO_LIBELF=3D1
>
> -# all the NO_* variable combined
> -make_minimal        :=3D NO_LIBPYTHON=3D1
> -make_minimal        +=3D NO_DEMANGLE=3D1 NO_LIBELF=3D1 NO_BACKTRACE=3D1
> -make_minimal        +=3D NO_LIBNUMA=3D1 NO_LIBBIONIC=3D1 NO_LIBDW=3D1
> -make_minimal        +=3D NO_LIBBPF=3D1
> -make_minimal        +=3D NO_SDT=3D1 NO_JVMTI=3D1 NO_LIBZSTD=3D1
> -make_minimal        +=3D NO_CAPSTONE=3D1
> +make_minimal        :=3D MINIMAL=3D1
>
>  # binutils 2_42 and newer have bfd_thread_init()
>  new_libbfd :=3D $(shell echo '#include <bfd.h>' | $(CC) -E -x c - | grep=
 bfd_thread_init)
> --
> 2.53.0
>
