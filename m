Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792624652;
	b=x5Wjm1MhkJbxhqPVwJnevy+/mOvL11m1gk0+NrGr8YnknM/Ir77tFNE6q1yh52VFcHG8
	 EUfWvJsSwCyry1hxrG8yx2KEbOxmilSjEnmbfBiL2odwSePyT2r9wYXlG/V+x/BJc8fEA
	 vlp6V+qjD0jStP4xv8uwzTZi3eCrDyxNbJq7fJjl1K/XmCqX3vIoB0Gxmc8GJAaBltY+b
	 Fedjbd070Yr7pNNWD26o5koXqrwljDtoWjgxf2j2WuhLeETPy3be5AsB7B1fV6XQVoVJ4
	 xvZSYJVz7Mia7P1FH8CUqxffNQjpcCFxnOCe/8u8UD9zdvyE9iAUQiaHgOTAwnjvIQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792624652;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=JKqDIMaO3UKeyh5L6ed+1xZhl6XUpDzaQeagYHZqSxE=;
	b=WD3jss5h3H60xDUS6Q3pfiN/HKzLmdmX0NSWenGUIs8wK8Bj45QbQbahnXuVWRZ0hmpX
	 qdRA7DreF8aMeLzo6qNAeTj3eAkpT0Kr+lKHdd0Saq7y19LSkwTF274wRro/T60mZh2vi
	 AfcQquBjbt3iC426XPbzV/Ur57L8OA98aoZIfMwkGoplLlcS25iICBg9coeLA/oEsZdRu
	 b5BRIxZSAuTkMvqCTuPBeZdvgrM9lGmFpCO57GwD/zZtMs3NcQuvgukoQCy1MLpmhwCGB
	 uC2P73jN6nydX37IN5F0dBbi6k0BVcu98aYZrugCI1cMlqwf8yrHz39xw3aJuDiCjSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fah9WwvN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B93606A320;
	Wed, 21 Oct 2026 23:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fah9WwvN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E461F000C5;
	Wed, 21 Oct 2026 23:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792624651;
	bh=JKqDIMaO3UKeyh5L6ed+1xZhl6XUpDzaQeagYHZqSxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fah9WwvNb1KzSyxzvYuxt8hf9zjJJHqm5sT1jyLw9CNEfnmfH8aNpQIqS36GzUqSO
	 NZr5o9FeYO8TFWKOvTvY24S0+84w8J825GiQG3FKWQEBx6LWY+uNsPBqpYCQAWGNuR
	 qfJTeZM2tSlSmhwYlJbGPhydpq9g6i/Hpixen7klOHLLj68vROyG4zkXVp6zNKdfPN
	 xhf5bi7Cu8E26RfBkl9QB9Uk0X1MWRM12b5Y2/p/oA80PwEfWq/xN1RklyC/kuRQro
	 TpW6otpv22sPGSnnG2rSceuyeDZDJp6uAYJtAi8m8mRb1RHMQKO/+Hw/G9giZ/mVNe
	 tsWegLYQCxTXg==
Date: Wed, 21 Oct 2026 16:17:29 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf build: Add MINIMAL=1 to build without optional
 features
Message-ID: <atlICVt3ItifkPZb@google.com>
References: <20261018135321.3986899-1-sashal@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261018135321.3986899-1-sashal@kernel.org>

On Sun, Oct 18, 2026 at 09:53:21AM -0400, Sasha Levin wrote:
> Turning off every optional feature takes a long list of NO_* variables,
> and the list has to follow features as they are added and renamed. The
> one in tests/make for make_minimal has fallen behind: it leaves
> libtraceevent, jevents, slang, AIO, LZMA, zlib, libLLVM and Rust to be
> detected, so a make_minimal build still needs libtraceevent and python.
> 
> Add MINIMAL=1, which turns off every optional feature, the BPF
> skeletons, and the shellcheck, mypy and pylint runs. perf then builds,
> natively or cross, with no library beyond the C library and without
> python, pkg-config, clang or rustc, and the result does not depend on
> what is installed on the build machine.
> 
> A MINIMAL=1 build also leaves out the notices that post unwind and
> python support are disabled, which it asked for, and the one about the
> pkg-config search path for cross builds, as pkg-config is not needed
> then.
> 
> It is handled in Makefile.perf rather than Makefile.config, as
> Makefile.config is included after the pkg-config, shellcheck, mypy and
> pylint setup.
> 
> Use it for make_minimal in tests/make.
> 
> Suggested-by: Ian Rogers <irogers@google.com>
> Link: https://lore.kernel.org/r/CAP-5=fWFY-tpJz2vcBZvurwdZY5gwd8cuTemE9q1rtZ0Vi0dng@mail.gmail.com
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
> The kbuild series that builds perf with MINIMAL=1 carries the mainline
> version of this patch:
> https://lore.kernel.org/r/20261016143143.3613501-1-sashal@kernel.org
> 
>  tools/perf/Makefile.config |  8 ++++++--
>  tools/perf/Makefile.perf   | 42 ++++++++++++++++++++++++++++++++++++--
>  tools/perf/tests/make      |  8 +-------
>  3 files changed, 47 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index b4764f69f47f4..4af7934887539 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -753,7 +753,9 @@ dwarf-post-unwind-text := BUG
>  # setup DWARF post unwinder
>  ifdef NO_LIBUNWIND
>    ifdef NO_LIBDW
> -    $(warning Disabling post unwind, no support found.)
> +    ifneq ($(MINIMAL),1)
> +      $(warning Disabling post unwind, no support found.)
> +    endif
>      dwarf-post-unwind := 0
>    else
>      dwarf-post-unwind-text := libdw
> @@ -828,7 +830,9 @@ endif
>  
>  PYTHON_EXTENSION_SUFFIX := '.so'
>  ifdef NO_PYTHON_MODULE
> -  $(call disable-python,Python support disabled by user)
> +  ifneq ($(MINIMAL),1)
> +    $(call disable-python,Python support disabled by user)
> +  endif
>  else
>  
>    ifndef PYTHON
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 2d9379fea2672..5297fc15a3c9e 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -129,6 +129,9 @@ include ../scripts/utilities.mak
>  # Define NO_MYPY if you do not want to run mypy during build
>  #
>  # Define NO_PYLINT if you do not want to run pylint during build
> +#
> +# Define MINIMAL=1 to build without any optional feature, needing only a C
> +# compiler and library, flex and bison
>  
>  # As per kernel Makefile, avoid funny character set dependencies
>  unexport LC_ALL
> @@ -174,6 +177,39 @@ endef
>  
>  LD += $(EXTRA_LDFLAGS)
>  
> +# MINIMAL=1 is handled here rather than in Makefile.config, which is included
> +# after the pkg-config, shellcheck, mypy and pylint setup below
> +ifeq ($(MINIMAL),1)
> +  NO_LIBELF := 1
> +  NO_LIBDW := 1
> +  NO_LIBTRACEEVENT := 1
> +  NO_JEVENTS := 1
> +  NO_PYTHON_MODULE := 1
> +  NO_LIBBPF := 1
> +  BUILD_BPF_SKEL := 0
> +  NO_SLANG := 1
> +  NO_DEMANGLE := 1
> +  NO_BACKTRACE := 1
> +  NO_AIO := 1
> +  NO_ZLIB := 1
> +  NO_LZMA := 1
> +  NO_LIBZSTD := 1
> +  NO_LIBNUMA := 1
> +  NO_LIBLLVM := 1
> +  NO_CAPSTONE := 1
> +  NO_LIBPFM4 := 1
> +  NO_LIBDEBUGINFOD := 1
> +  NO_BABELTRACE2 := 1
> +  NO_SDT := 1
> +  NO_JVMTI := 1
> +  NO_RUST := 1
> +  NO_PERF_READ_VDSO32 := 1
> +  NO_PERF_READ_VDSOX32 := 1
> +  NO_SHELLCHECK := 1
> +  NO_MYPY := 1
> +  NO_PYLINT := 1
> +endif
> +
>  # Some distros provide the command $(CROSS_COMPILE)pkg-config for
>  # searching packges installed with Multiarch. Use it for cross
>  # compilation if it is existed.
> @@ -195,8 +231,10 @@ else
>        PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/local/share/pkgconfig/
>        PKG_CONFIG_LIBDIR := $(PKG_CONFIG_LIBDIR):/usr/share/pkgconfig/
>        export PKG_CONFIG_LIBDIR
> -      $(warning Missing PKG_CONFIG_LIBDIR, PKG_CONFIG_PATH and PKG_CONFIG_SYSROOT_DIR for cross compilation,)
> -      $(warning set PKG_CONFIG_LIBDIR for using Multiarch libs.)
> +      ifneq ($(MINIMAL),1)
> +        $(warning Missing PKG_CONFIG_LIBDIR, PKG_CONFIG_PATH and PKG_CONFIG_SYSROOT_DIR for cross compilation,)
> +        $(warning set PKG_CONFIG_LIBDIR for using Multiarch libs.)
> +      endif
>      endif
>    endif
>  endif
> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index 7524de5228029..bef5599b95d6f 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -119,13 +119,7 @@ make_install_prefix       := install prefix=/tmp/krava
>  make_install_prefix_slash := install prefix=/tmp/krava/
>  make_static         := LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 NO_LIBTRACEEVENT=1 NO_LIBELF=1
>  
> -# all the NO_* variable combined
> -make_minimal        := NO_PYTHON_MODULE=1
> -make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_BACKTRACE=1
> -make_minimal        += NO_LIBNUMA=1 NO_LIBBIONIC=1 NO_LIBDW=1
> -make_minimal        += NO_LIBBPF=1
> -make_minimal        += NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
> -make_minimal        += NO_CAPSTONE=1
> +make_minimal        := MINIMAL=1
>  
>  # binutils 2_42 and newer have bfd_thread_init()
>  new_libbfd := $(shell echo '#include <bfd.h>' | $(CC) -E -x c - | grep bfd_thread_init)
> 
> base-commit: 1c90f0a3c8a1c4e38f9edd97af9e20848805a7fb
> -- 
> 2.53.0
> 
