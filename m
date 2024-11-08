Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1451A9B3C;
	Fri,  8 Nov 2024 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731096186; cv=none; b=tXWmcFb4L+/UT5Rrp0fXQMYSn7O8+L/K5WnF0hEaqN1U9566Bt18UFzgpyR91UbiWhH2D6S3ucBPxVu+89KCgoRTc3A+4vxiZsQl+VWGALR/2E0x7FDI2erUpq6X9sU1dZSr/fcF4EUHq6jnx77fSuFvV3oEfr1D862KkP1wrFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731096186; c=relaxed/simple;
	bh=xX7Im2UhKNKgBE416PaOdSNPECSfPWPArQu7YbQODCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvX6FG3neJ6KmFBDfTH3yWRvPKS+ZaG4G/zfOk8iuKKpSF2hdfHINhCaxYSiluc4a3Y+bLGZIoVmlgCfymv+MRvlCJrTjNyyJmuutUx2x0BpMqfYrj7T1YDoh/lIAO5AqpAeb2p868bhYEEry2bTJzLZ08KXjYOwgSVq/T75+d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epU1fQiN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epU1fQiN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430B3C4CECD;
	Fri,  8 Nov 2024 20:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731096185;
	bh=xX7Im2UhKNKgBE416PaOdSNPECSfPWPArQu7YbQODCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=epU1fQiNqfeFZdEM00F7vtSpMYwYfot9P71+GYdehpaxaLPDaCOqbKUsUO44+7y7Q
	 o3eR0G3nwWjdXG/LjOV4dfBN0fpiBTfQjkBTXyhZBNO+yusM5c1u7BaRCniZhMJtUc
	 q0LQVTzSXkt/xN//agdroW9fr4YtNwoqFZiNjQEOxO7G8ZsMBpZAqrwC/td1X3yVI6
	 ZSmmdmmc6CZDt6uatgD6LkqCfjjGv9p4sNMU/5ZgXRHd74jD11SoWcSVHFWVmpVipt
	 dxHX0hnw/IAilCJN1DmkNfFpwQXnl86vrupoNsuxdPy9xI7tSKuBpkU6HsTpd7/E8B
	 18HgSp7ZPgyRw==
Date: Fri, 8 Nov 2024 12:03:02 -0800
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
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Changbin Du <changbin.du@huawei.com>,
	Guilherme Amadio <amadio@gentoo.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
	Kajol Jain <kjain@linux.ibm.com>, Atish Patra <atishp@rivosinc.com>,
	Shenlin Liang <liangshenlin@eswincomputing.com>,
	Anup Patel <anup@brainfault.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	"Steinar H. Gunderson" <sesse@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Chen Pei <cp0613@linux.alibaba.com>,
	Dima Kogan <dima@secretsauce.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 10/20] perf dwarf-regs: Move csky dwarf-regs out of
 arch
Message-ID: <Zy5udmX6gZAg0wkS@google.com>
References: <20241017002520.59124-1-irogers@google.com>
 <20241017002520.59124-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017002520.59124-11-irogers@google.com>

On Wed, Oct 16, 2024 at 05:25:10PM -0700, Ian Rogers wrote:
> Move arch/csky/util/dwarf-regs.c to util/dwarf-regs-csky.c and compile
> in unconditionally. To avoid get_arch_regstr being duplicated, rename
> to get_csky_regstr and add to get_dwarf_regstr switch.
> 
> Update #ifdefs to allow ABI V1 and V2 tables at the same
> time. Determine the table from the ELF flags.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/csky/util/Build               |  1 -
>  tools/perf/util/Build                         |  1 +
>  .../dwarf-regs.c => util/dwarf-regs-csky.c}   | 19 ++++++++++---------
>  tools/perf/util/dwarf-regs.c                  | 11 +++++++----
>  tools/perf/util/include/dwarf-regs.h          |  2 ++
>  5 files changed, 20 insertions(+), 14 deletions(-)
>  rename tools/perf/{arch/csky/util/dwarf-regs.c => util/dwarf-regs-csky.c} (74%)
> 
> diff --git a/tools/perf/arch/csky/util/Build b/tools/perf/arch/csky/util/Build
> index 1325310cab6a..5e6ea82c4202 100644
> --- a/tools/perf/arch/csky/util/Build
> +++ b/tools/perf/arch/csky/util/Build
> @@ -1,4 +1,3 @@
>  perf-util-y += perf_regs.o
>  
> -perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
>  perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 4c615611b9d7..99ae4e2802b8 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -203,6 +203,7 @@ endif
>  perf-util-$(CONFIG_LIBDW) += probe-finder.o
>  perf-util-$(CONFIG_LIBDW) += dwarf-aux.o
>  perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
> +perf-util-$(CONFIG_LIBDW) += dwarf-regs-csky.o
>  perf-util-$(CONFIG_LIBDW) += dwarf-regs-x86.o
>  perf-util-$(CONFIG_LIBDW) += debuginfo.o
>  perf-util-$(CONFIG_LIBDW) += annotate-data.o
> diff --git a/tools/perf/arch/csky/util/dwarf-regs.c b/tools/perf/util/dwarf-regs-csky.c
> similarity index 74%
> rename from tools/perf/arch/csky/util/dwarf-regs.c
> rename to tools/perf/util/dwarf-regs-csky.c
> index ca86ecaeacbb..d38ef1f07f3e 100644
> --- a/tools/perf/arch/csky/util/dwarf-regs.c
> +++ b/tools/perf/util/dwarf-regs-csky.c
> @@ -5,9 +5,8 @@
>  #include <stddef.h>
>  #include <dwarf-regs.h>
>  
> -#if defined(__CSKYABIV2__)
> -#define CSKY_MAX_REGS 73
> -const char *csky_dwarf_regs_table[CSKY_MAX_REGS] = {
> +#define CSKY_ABIV2_MAX_REGS 73
> +const char *csky_dwarf_regs_table_abiv2[CSKY_ABIV2_MAX_REGS] = {
>  	/* r0 ~ r8 */
>  	"%a0", "%a1", "%a2", "%a3", "%regs0", "%regs1", "%regs2", "%regs3",
>  	/* r9 ~ r15 */
> @@ -26,9 +25,9 @@ const char *csky_dwarf_regs_table[CSKY_MAX_REGS] = {
>  	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
>  	"%epc",
>  };
> -#else
> -#define CSKY_MAX_REGS 57
> -const char *csky_dwarf_regs_table[CSKY_MAX_REGS] = {
> +
> +#define CSKY_ABIV1_MAX_REGS 57
> +const char *csky_dwarf_regs_table_abiv1[CSKY_ABIV1_MAX_REGS] = {
>  	/* r0 ~ r8 */
>  	"%sp", "%regs9", "%a0", "%a1", "%a2", "%a3", "%regs0", "%regs1",
>  	/* r9 ~ r15 */
> @@ -41,9 +40,11 @@ const char *csky_dwarf_regs_table[CSKY_MAX_REGS] = {
>  	NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
>  	"%epc",
>  };
> -#endif
>  
> -const char *get_arch_regstr(unsigned int n)
> +const char *get_csky_regstr(unsigned int n, unsigned int flags)
>  {
> -	return (n < CSKY_MAX_REGS) ? csky_dwarf_regs_table[n] : NULL;
> +	if (flags & EF_CSKY_ABIV2)

Hmm.. you need it here as well.


> +		return (n < CSKY_ABIV2_MAX_REGS) ? csky_dwarf_regs_table_abiv2[n] : NULL;
> +
> +	return (n < CSKY_ABIV1_MAX_REGS) ? csky_dwarf_regs_table_abiv1[n] : NULL;
>  }
> diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
> index fd21f9e90e40..9a76f83af62c 100644
> --- a/tools/perf/util/dwarf-regs.c
> +++ b/tools/perf/util/dwarf-regs.c
> @@ -29,17 +29,18 @@
>  #define __get_dwarf_regstr(tbl, n) (((n) < ARRAY_SIZE(tbl)) ? (tbl)[(n)] : NULL)
>  
>  /* Return architecture dependent register string (for kprobe-tracer) */
> -const char *get_dwarf_regstr(unsigned int n, unsigned int machine,
> -			     unsigned int flags __maybe_unused)
> +const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int flags)
>  {
> -#if EM_HOST == EM_X86_64 || EM_HOST == EM_386 || EM_HOST == EM_AARCH64 || EM_HOST == EM_ARM
> +#if EM_HOST == EM_X86_64 || EM_HOST == EM_386 || EM_HOST == EM_AARCH64 || EM_HOST == EM_ARM \
> +    || EM_HOST == EM_CSKY

And here too.  It seems you also need a rebase.

At this point, I'm giving up.  Can you please refresh the series with
a fix?

Thanks,
Namhyung


>  	if (machine == EM_NONE) {
>  		/* Generic arch - use host arch */
>  		machine = EM_HOST;
>  	}
>  #endif
>  	switch (machine) {
> -#if EM_HOST != EM_X86_64 && EM_HOST != EM_386 && EM_HOST != EM_AARCH64 && EM_HOST != EM_ARM
> +#if EM_HOST != EM_X86_64 && EM_HOST != EM_386 && EM_HOST != EM_AARCH64 && EM_HOST != EM_ARM \
> +    && EM_HOST != EM_CSKY
>  	case EM_NONE:	/* Generic arch - use host arch */
>  		return get_arch_regstr(n);
>  #endif
> @@ -51,6 +52,8 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine,
>  		return __get_dwarf_regstr(arm_regstr_tbl, n);
>  	case EM_AARCH64:
>  		return __get_dwarf_regstr(aarch64_regstr_tbl, n);
> +	case EM_CSKY:
> +		return get_csky_regstr(n, flags);
>  	case EM_SH:
>  		return __get_dwarf_regstr(sh_regstr_tbl, n);
>  	case EM_S390:
> diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
> index 0b533409d82a..b72d9d308ce4 100644
> --- a/tools/perf/util/include/dwarf-regs.h
> +++ b/tools/perf/util/include/dwarf-regs.h
> @@ -83,6 +83,8 @@
>  const char *get_arch_regstr(unsigned int n);
>  #endif
>  
> +const char *get_csky_regstr(unsigned int n, unsigned int flags);
> +
>  /**
>   * get_dwarf_regstr() - Returns ftrace register string from DWARF regnum.
>   * @n: DWARF register number.
> -- 
> 2.47.0.105.g07ac214952-goog
> 
