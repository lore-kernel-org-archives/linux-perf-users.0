Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FC71D5AB1;
	Thu, 26 Sep 2024 00:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727310393; cv=none; b=ZP9VDaMn473CLhuZvf6apQxoj9ckSI4HMY/rqt2l8u+PAwgixDPhqyn+94CRwGPIoqJ30NmMz6sY1f5D265wggc0x6iILXqVP3v2djxj639pUTwLZX6Iq+AlSuXPQfkh0a0yWnUs88uyrjZ/QhVuBV+DWLFUPfCPVEI9zpnBJ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727310393; c=relaxed/simple;
	bh=f3tS1U6dBvSCMNObFPyBViscoCK1jULQw/fp/P//qew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8iRxsr7RurZMc7uhGB+aTnEQKos2d8idMMJsI/sUiMY0v63d69TwtuFryJwRbiBcZlbygDm7r2Hf0cqM1J/HR/sXxVlNqalf6gR3qTDwWOWL+mRo+fm/BG24iV4P0oNhDTmRaVA7COHmtgdb10awYeNOIN+bPNZqMahNWjh3g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFI/lJDl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFI/lJDl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4D9C4CEC3;
	Thu, 26 Sep 2024 00:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727310393;
	bh=f3tS1U6dBvSCMNObFPyBViscoCK1jULQw/fp/P//qew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZFI/lJDlvQUF4gMACagO3d2jiEsdPQDgayPBW3NSlx8uevjxaJMPa40v3QczSww4M
	 7Jt73HhBInXjyJPO+7Q84q3SlRXwk+EWnBaJwfPVKBjQyB9TXNmi7M/uX83pmfmsRe
	 1OEu3k4gy8io5SCGn/OVwBShoLBsaGwp4VHt8hs0btYaTMaZahWu++sXakpdrwPE8n
	 QD1nY7kHiFfIgS6pXk1Dc3gR7jvdWlgNtaNmVJBzPYIXv4Vq2r0cG8S3VaOAh5bAxY
	 +HtGYRzI6HT+93D5p46zzeCPxLTCQBzKR7+C7wzItDgrThdBp1ndTqq7hkfIW1ctwc
	 LcUsG4v+XryVg==
Date: Wed, 25 Sep 2024 17:26:30 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>,
	Guilherme Amadio <amadio@gentoo.org>,
	Changbin Du <changbin.du@huawei.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>,
	Kajol Jain <kjain@linux.ibm.com>, Anup Patel <anup@brainfault.org>,
	Shenlin Liang <liangshenlin@eswincomputing.com>,
	Atish Patra <atishp@rivosinc.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Chen Pei <cp0613@linux.alibaba.com>,
	Dima Kogan <dima@secretsauce.net>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Yang Jihong <yangjihong@bytedance.com>
Subject: Re: [PATCH v1 01/11] perf build: Rename NO_DWARF to NO_LIBDW
Message-ID: <ZvSqNqNKKysw_309@google.com>
References: <20240924160418.1391100-1-irogers@google.com>
 <20240924160418.1391100-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924160418.1391100-2-irogers@google.com>

On Tue, Sep 24, 2024 at 09:04:08AM -0700, Ian Rogers wrote:
> NO_DWARF could mean more than NO_LIBDW support, in particular no
> libunwind support. Rename to be more intention revealing.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Makefile.config         | 16 ++++++++--------
>  tools/perf/Makefile.perf           |  2 +-
>  tools/perf/arch/arm/Makefile       |  2 +-
>  tools/perf/arch/arm64/Makefile     |  2 +-
>  tools/perf/arch/csky/Makefile      |  2 +-
>  tools/perf/arch/loongarch/Makefile |  2 +-
>  tools/perf/arch/mips/Makefile      |  2 +-
>  tools/perf/arch/powerpc/Makefile   |  2 +-
>  tools/perf/arch/riscv/Makefile     |  2 +-
>  tools/perf/arch/s390/Makefile      |  2 +-
>  tools/perf/arch/sh/Makefile        |  2 +-
>  tools/perf/arch/sparc/Makefile     |  2 +-
>  tools/perf/arch/x86/Makefile       |  2 +-
>  tools/perf/arch/xtensa/Makefile    |  2 +-
>  tools/perf/builtin-probe.c         |  2 +-
>  15 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 5e26d3a91b36..55a39211496d 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -429,7 +429,7 @@ ifeq ($(feature-file-handle), 1)
>  endif
>  
>  ifdef NO_LIBELF
> -  NO_DWARF := 1
> +  NO_LIBDW := 1
>    NO_LIBUNWIND := 1
>    NO_LIBDW_DWARF_UNWIND := 1
>    NO_LIBBPF := 1
> @@ -471,9 +471,9 @@ else
>        endif
>      endif
>      ifneq ($(feature-dwarf), 1)
> -      ifndef NO_DWARF
> +      ifndef NO_LIBDW
>          $(warning No libdw.h found or old libdw.h found or elfutils is older than 0.138, disables dwarf support. Please install new elfutils-devel/libdw-dev)
> -        NO_DWARF := 1
> +        NO_LIBDW := 1
>        endif
>      else
>        ifneq ($(feature-dwarf_getlocations), 1)
> @@ -496,7 +496,7 @@ ifeq ($(feature-libaio), 1)
>    endif
>  endif
>  
> -ifdef NO_DWARF
> +ifdef NO_LIBDW
>    NO_LIBDW_DWARF_UNWIND := 1
>  endif
>  
> @@ -574,17 +574,17 @@ ifndef NO_LIBELF
>      endif
>    endif
>  
> -  ifndef NO_DWARF
> +  ifndef NO_LIBDW
>      ifeq ($(origin PERF_HAVE_DWARF_REGS), undefined)
>        $(warning DWARF register mappings have not been defined for architecture $(SRCARCH), DWARF support disabled)
> -      NO_DWARF := 1
> +      NO_LIBDW := 1
>      else
>        CFLAGS += -DHAVE_DWARF_SUPPORT $(LIBDW_CFLAGS)
>        LDFLAGS += $(LIBDW_LDFLAGS)
>        EXTLIBS += ${DWARFLIBS}
>        $(call detected,CONFIG_DWARF)
>      endif # PERF_HAVE_DWARF_REGS
> -  endif # NO_DWARF
> +  endif # NO_LIBDW
>  
>    ifndef NO_LIBBPF
>      ifeq ($(feature-bpf), 1)
> @@ -633,7 +633,7 @@ ifdef PERF_HAVE_JITDUMP
>  endif
>  
>  ifeq ($(SRCARCH),powerpc)
> -  ifndef NO_DWARF
> +  ifndef NO_LIBDW
>      CFLAGS += -DHAVE_SKIP_CALLCHAIN_IDX
>    endif
>  endif
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 9dd2e8d3f3c9..a144bfaf8aeb 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -40,7 +40,7 @@ include ../scripts/utilities.mak
>  #
>  # Define EXTRA_PERFLIBS to pass extra libraries to PERFLIBS.
>  #
> -# Define NO_DWARF if you do not want debug-info analysis feature at all.
> +# Define NO_LIBDW if you do not want debug-info analysis feature at all.

Can we keep NO_DWARF for compatibility and set NO_LIBDW=1 internally?
I think it's fine to change it here to advertise NO_LIBDW over NO_DWARF
but still want to support NO_DWARF as well.

Also it seem we don't have an entry in the tests/make for no-dwarf
build.  Can you please add one too?

Thanks,
Namhyung


>  #
>  # Define WERROR=0 to disable treating any warnings as errors.
>  #
> diff --git a/tools/perf/arch/arm/Makefile b/tools/perf/arch/arm/Makefile
> index 1d88fdab13bf..9b164d379548 100644
> --- a/tools/perf/arch/arm/Makefile
> +++ b/tools/perf/arch/arm/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -ifndef NO_DWARF
> +ifndef NO_LIBDW
>  PERF_HAVE_DWARF_REGS := 1
>  endif
>  PERF_HAVE_JITDUMP := 1
> diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
> index 5735ed4479bb..8a5ffbfe809f 100644
> --- a/tools/perf/arch/arm64/Makefile
> +++ b/tools/perf/arch/arm64/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -ifndef NO_DWARF
> +ifndef NO_LIBDW
>  PERF_HAVE_DWARF_REGS := 1
>  endif
>  PERF_HAVE_JITDUMP := 1
> diff --git a/tools/perf/arch/csky/Makefile b/tools/perf/arch/csky/Makefile
> index 88c08eed9c7b..119b06a64bed 100644
> --- a/tools/perf/arch/csky/Makefile
> +++ b/tools/perf/arch/csky/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -ifndef NO_DWARF
> +ifndef NO_LIBDW
>  PERF_HAVE_DWARF_REGS := 1
>  endif
> diff --git a/tools/perf/arch/loongarch/Makefile b/tools/perf/arch/loongarch/Makefile
> index c89d6bb6b184..1cc5eb01f32b 100644
> --- a/tools/perf/arch/loongarch/Makefile
> +++ b/tools/perf/arch/loongarch/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -ifndef NO_DWARF
> +ifndef NO_LIBDW
>  PERF_HAVE_DWARF_REGS := 1
>  endif
>  PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
> diff --git a/tools/perf/arch/mips/Makefile b/tools/perf/arch/mips/Makefile
> index cd0b011b3be5..733f7b76f52d 100644
> --- a/tools/perf/arch/mips/Makefile
> +++ b/tools/perf/arch/mips/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -ifndef NO_DWARF
> +ifndef NO_LIBDW
>  PERF_HAVE_DWARF_REGS := 1
>  endif
>  
> diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
> index bf6d323574f6..7672d555f6cd 100644
> --- a/tools/perf/arch/powerpc/Makefile
> +++ b/tools/perf/arch/powerpc/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -ifndef NO_DWARF
> +ifndef NO_LIBDW
>  PERF_HAVE_DWARF_REGS := 1
>  endif
>  
> diff --git a/tools/perf/arch/riscv/Makefile b/tools/perf/arch/riscv/Makefile
> index 90c3c476a242..4664a78a1afd 100644
> --- a/tools/perf/arch/riscv/Makefile
> +++ b/tools/perf/arch/riscv/Makefile
> @@ -1,4 +1,4 @@
> -ifndef NO_DWARF
> +ifndef NO_LIBDW
>  PERF_HAVE_DWARF_REGS := 1
>  endif
>  PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
> diff --git a/tools/perf/arch/s390/Makefile b/tools/perf/arch/s390/Makefile
> index 56994e63b43a..3f66e2ede3f7 100644
> --- a/tools/perf/arch/s390/Makefile
> +++ b/tools/perf/arch/s390/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -ifndef NO_DWARF
> +ifndef NO_LIBDW
>  PERF_HAVE_DWARF_REGS := 1
>  endif
>  HAVE_KVM_STAT_SUPPORT := 1
> diff --git a/tools/perf/arch/sh/Makefile b/tools/perf/arch/sh/Makefile
> index 88c08eed9c7b..119b06a64bed 100644
> --- a/tools/perf/arch/sh/Makefile
> +++ b/tools/perf/arch/sh/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -ifndef NO_DWARF
> +ifndef NO_LIBDW
>  PERF_HAVE_DWARF_REGS := 1
>  endif
> diff --git a/tools/perf/arch/sparc/Makefile b/tools/perf/arch/sparc/Makefile
> index 4031db72ba71..7741184894c8 100644
> --- a/tools/perf/arch/sparc/Makefile
> +++ b/tools/perf/arch/sparc/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -ifndef NO_DWARF
> +ifndef NO_LIBDW
>  PERF_HAVE_DWARF_REGS := 1
>  endif
>  
> diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefile
> index 67b4969a6738..9aa58acb5564 100644
> --- a/tools/perf/arch/x86/Makefile
> +++ b/tools/perf/arch/x86/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -ifndef NO_DWARF
> +ifndef NO_LIBDW
>  PERF_HAVE_DWARF_REGS := 1
>  endif
>  HAVE_KVM_STAT_SUPPORT := 1
> diff --git a/tools/perf/arch/xtensa/Makefile b/tools/perf/arch/xtensa/Makefile
> index 88c08eed9c7b..119b06a64bed 100644
> --- a/tools/perf/arch/xtensa/Makefile
> +++ b/tools/perf/arch/xtensa/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -ifndef NO_DWARF
> +ifndef NO_LIBDW
>  PERF_HAVE_DWARF_REGS := 1
>  endif
> diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
> index 003a3bcebfdf..91672bb3047c 100644
> --- a/tools/perf/builtin-probe.c
> +++ b/tools/perf/builtin-probe.c
> @@ -616,7 +616,7 @@ __cmd_probe(int argc, const char **argv)
>  	set_option_flag(options, 'L', "line", PARSE_OPT_EXCLUSIVE);
>  	set_option_flag(options, 'V', "vars", PARSE_OPT_EXCLUSIVE);
>  #else
> -# define set_nobuild(s, l, c) set_option_nobuild(options, s, l, "NO_DWARF=1", c)
> +# define set_nobuild(s, l, c) set_option_nobuild(options, s, l, "NO_LIBDW=1", c)
>  	set_nobuild('L', "line", false);
>  	set_nobuild('V', "vars", false);
>  	set_nobuild('\0', "externs", false);
> -- 
> 2.46.0.792.g87dc391469-goog
> 
