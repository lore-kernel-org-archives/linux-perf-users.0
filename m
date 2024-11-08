Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F701AA1CD;
	Fri,  8 Nov 2024 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087231; cv=none; b=YN6Vzyi2iNSj6f7gKvbyDmclV0Q1jx92FLZz+IPelouF19lDYGpFvz8BQbLIsJKPsd1Co0khCH7+woFMubbz2pF3OL2NlLlwit0HyacDQFJpftsFqoL+GyO+MTSSCbUr3kf4lFyUMg1/uBBPPKyl7KTBo1V9OwVTJnzqrpLsHq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087231; c=relaxed/simple;
	bh=U5J1HmfJsWmud23RBXlyYA8mRtwKa7CaZ254KKiPaio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pwdx4wjNxBHWZdmdW4acTBE+RQHsFAVfCOU14H6YqU8bg9KBZdDLIzltku5du409+zRaoBJ6Nx2X8w8saRRReDrKR8lXXNsDvb7lI6pPI3vz7jMd6N1vg4ydVrw31598ByHYxUdI8RGzNdzc97fsOGkgdbik2nX6SN8T8UgeNLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYhI/IQi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYhI/IQi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8A1C4CED9;
	Fri,  8 Nov 2024 17:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731087231;
	bh=U5J1HmfJsWmud23RBXlyYA8mRtwKa7CaZ254KKiPaio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XYhI/IQiTwP+svRp9j6ppeDtUjiZbL+XIVA8SFmxzZXTL+6Y8I9WcltJCTbN8MBM6
	 TdJI0vR4tRR2cRB98Hvw2ep5PeJ9YhwQHJS+Aak9JpZRypAWFDR8xeLuZOSbxLVQAx
	 GZQKtIdJzyJHT7THgFXN1JvGtT/td339FW18Vz8P39l10RXarGv1vy3RYVQWP9r3XM
	 WgQ8PVfxU6h8SrnVDvHRU9EaUciHhPkQTOzxIMzT7Oo7mrBYnzgLAl0Wrk+UD9eCEI
	 +OXS79c/n9QJYzfw8aiWs5Nv5tgva46uSpuu/YUgcfAf9zoVZ4a+pcs+A6nXuCHPTp
	 a4HSaA3Ko9SBg==
Date: Fri, 8 Nov 2024 09:33:47 -0800
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
Subject: Re: [PATCH v3 04/20] perf disasm: Add e_machine/e_flags to struct
 arch
Message-ID: <Zy5Le-xn4gzQ2WLo@google.com>
References: <20241017002520.59124-1-irogers@google.com>
 <20241017002520.59124-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017002520.59124-5-irogers@google.com>

On Wed, Oct 16, 2024 at 05:25:04PM -0700, Ian Rogers wrote:
> Currently functions like get_dwarf_regnum only work with the host
> architecture. Carry the elf machine and flags in struct arch so that
> in disassembly these can be used to allow cross platform disassembly.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/arc/annotate/instructions.c       | 2 ++
>  tools/perf/arch/arm/annotate/instructions.c       | 2 ++
>  tools/perf/arch/arm64/annotate/instructions.c     | 2 ++
>  tools/perf/arch/csky/annotate/instructions.c      | 7 ++++++-
>  tools/perf/arch/loongarch/annotate/instructions.c | 2 ++
>  tools/perf/arch/mips/annotate/instructions.c      | 2 ++
>  tools/perf/arch/powerpc/annotate/instructions.c   | 2 ++
>  tools/perf/arch/riscv64/annotate/instructions.c   | 2 ++
>  tools/perf/arch/s390/annotate/instructions.c      | 2 ++
>  tools/perf/arch/sparc/annotate/instructions.c     | 2 ++
>  tools/perf/arch/x86/annotate/instructions.c       | 3 ++-
>  tools/perf/util/disasm.h                          | 4 ++++
>  12 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/arch/arc/annotate/instructions.c b/tools/perf/arch/arc/annotate/instructions.c
> index 2f00e995c7e3..e5619770a1af 100644
> --- a/tools/perf/arch/arc/annotate/instructions.c
> +++ b/tools/perf/arch/arc/annotate/instructions.c
> @@ -5,5 +5,7 @@ static int arc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
>  {
>  	arch->initialized = true;
>  	arch->objdump.comment_char = ';';
> +	arch->e_machine = EM_ARC;
> +	arch->e_flags = 0;
>  	return 0;
>  }
> diff --git a/tools/perf/arch/arm/annotate/instructions.c b/tools/perf/arch/arm/annotate/instructions.c
> index 2ff6cedeb9c5..cf91a43362b0 100644
> --- a/tools/perf/arch/arm/annotate/instructions.c
> +++ b/tools/perf/arch/arm/annotate/instructions.c
> @@ -53,6 +53,8 @@ static int arm__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
>  	arch->associate_instruction_ops   = arm__associate_instruction_ops;
>  	arch->objdump.comment_char	  = ';';
>  	arch->objdump.skip_functions_char = '+';
> +	arch->e_machine = EM_ARM;
> +	arch->e_flags = 0;
>  	return 0;
>  
>  out_free_call:
> diff --git a/tools/perf/arch/arm64/annotate/instructions.c b/tools/perf/arch/arm64/annotate/instructions.c
> index f86d9f4798bd..d465d093e7eb 100644
> --- a/tools/perf/arch/arm64/annotate/instructions.c
> +++ b/tools/perf/arch/arm64/annotate/instructions.c
> @@ -113,6 +113,8 @@ static int arm64__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
>  	arch->associate_instruction_ops   = arm64__associate_instruction_ops;
>  	arch->objdump.comment_char	  = '/';
>  	arch->objdump.skip_functions_char = '+';
> +	arch->e_machine = EM_AARCH64;
> +	arch->e_flags = 0;
>  	return 0;
>  
>  out_free_call:
> diff --git a/tools/perf/arch/csky/annotate/instructions.c b/tools/perf/arch/csky/annotate/instructions.c
> index 5337bfb7d5fc..14270311d215 100644
> --- a/tools/perf/arch/csky/annotate/instructions.c
> +++ b/tools/perf/arch/csky/annotate/instructions.c
> @@ -43,6 +43,11 @@ static int csky__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
>  	arch->initialized = true;
>  	arch->objdump.comment_char = '/';
>  	arch->associate_instruction_ops = csky__associate_ins_ops;
> -
> +	arch->e_machine = EM_CSKY;
> +#if defined(__CSKYABIV2__)
> +	arch->e_flags = EF_CSKY_ABIV2;
> +#else
> +	arch->e_flags = EF_CSKY_ABIV1;
> +#endif

By moving this into the general code, it should take care of old systems
that doesn't have the macro.

  In file included from util/disasm.c:109:                                        
  /linux/tools/perf/arch/csky/annotate/instructions.c: In function 'csky__annotate_init':
  /linux/tools/perf/arch/csky/annotate/instructions.c:50:25: error: 'EF_CSKY_ABIV1' undeclared (first use in this function)
     50 |         arch->e_flags = EF_CSKY_ABIV1;                                  
        |                         ^~~~~~~~~~~~~                                   
  /linux/tools/perf/arch/csky/annotate/instructions.c:50:25: note: each undeclared identifier is reported only once for each function it appears in

Also, I think __CSKYABIV2__ is defined only when the host is csky.  So
it'll use ABI v1 on cross env.  I'm not sure if it's a problem.  We may
need to save the ABI somewhere in the metadata later.

Thanks,
Namhyung


>  	return 0;
>  }
> diff --git a/tools/perf/arch/loongarch/annotate/instructions.c b/tools/perf/arch/loongarch/annotate/instructions.c
> index ab43b1ab51e3..70262d5f1444 100644
> --- a/tools/perf/arch/loongarch/annotate/instructions.c
> +++ b/tools/perf/arch/loongarch/annotate/instructions.c
> @@ -131,6 +131,8 @@ int loongarch__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
>  		arch->associate_instruction_ops = loongarch__associate_ins_ops;
>  		arch->initialized = true;
>  		arch->objdump.comment_char = '#';
> +		arch->e_machine = EM_LOONGARCH;
> +		arch->e_flags = 0;
>  	}
>  
>  	return 0;
> diff --git a/tools/perf/arch/mips/annotate/instructions.c b/tools/perf/arch/mips/annotate/instructions.c
> index 340993f2a897..b50b46c613d6 100644
> --- a/tools/perf/arch/mips/annotate/instructions.c
> +++ b/tools/perf/arch/mips/annotate/instructions.c
> @@ -40,6 +40,8 @@ int mips__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
>  		arch->associate_instruction_ops = mips__associate_ins_ops;
>  		arch->initialized = true;
>  		arch->objdump.comment_char = '#';
> +		arch->e_machine = EM_MIPS;
> +		arch->e_flags = 0;
>  	}
>  
>  	return 0;
> diff --git a/tools/perf/arch/powerpc/annotate/instructions.c b/tools/perf/arch/powerpc/annotate/instructions.c
> index 54478cf5cccc..ca567cfdcbdb 100644
> --- a/tools/perf/arch/powerpc/annotate/instructions.c
> +++ b/tools/perf/arch/powerpc/annotate/instructions.c
> @@ -309,6 +309,8 @@ static int powerpc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
>  		arch->associate_instruction_ops = powerpc__associate_instruction_ops;
>  		arch->objdump.comment_char      = '#';
>  		annotate_opts.show_asm_raw = true;
> +		arch->e_machine = EM_PPC;
> +		arch->e_flags = 0;
>  	}
>  
>  	return 0;
> diff --git a/tools/perf/arch/riscv64/annotate/instructions.c b/tools/perf/arch/riscv64/annotate/instructions.c
> index 869a0eb28953..55cf911633f8 100644
> --- a/tools/perf/arch/riscv64/annotate/instructions.c
> +++ b/tools/perf/arch/riscv64/annotate/instructions.c
> @@ -28,6 +28,8 @@ int riscv64__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
>  		arch->associate_instruction_ops = riscv64__associate_ins_ops;
>  		arch->initialized = true;
>  		arch->objdump.comment_char = '#';
> +		arch->e_machine = EM_RISCV;
> +		arch->e_flags = 0;
>  	}
>  
>  	return 0;
> diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
> index eeac25cca699..c61193f1e096 100644
> --- a/tools/perf/arch/s390/annotate/instructions.c
> +++ b/tools/perf/arch/s390/annotate/instructions.c
> @@ -166,6 +166,8 @@ static int s390__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
>  			if (s390__cpuid_parse(arch, cpuid))
>  				err = SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_CPUID_PARSING;
>  		}
> +		arch->e_machine = EM_S390;
> +		arch->e_flags = 0;
>  	}
>  
>  	return err;
> diff --git a/tools/perf/arch/sparc/annotate/instructions.c b/tools/perf/arch/sparc/annotate/instructions.c
> index 2614c010c235..68c31580ccfc 100644
> --- a/tools/perf/arch/sparc/annotate/instructions.c
> +++ b/tools/perf/arch/sparc/annotate/instructions.c
> @@ -163,6 +163,8 @@ static int sparc__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
>  		arch->initialized = true;
>  		arch->associate_instruction_ops = sparc__associate_instruction_ops;
>  		arch->objdump.comment_char = '#';
> +		arch->e_machine = EM_SPARC;
> +		arch->e_flags = 0;
>  	}
>  
>  	return 0;
> diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
> index c869abe3c31d..ae94b1f0b9cc 100644
> --- a/tools/perf/arch/x86/annotate/instructions.c
> +++ b/tools/perf/arch/x86/annotate/instructions.c
> @@ -202,7 +202,8 @@ static int x86__annotate_init(struct arch *arch, char *cpuid)
>  		if (x86__cpuid_parse(arch, cpuid))
>  			err = SYMBOL_ANNOTATE_ERRNO__ARCH_INIT_CPUID_PARSING;
>  	}
> -
> +	arch->e_machine = EM_X86_64;
> +	arch->e_flags = 0;
>  	arch->initialized = true;
>  	return err;
>  }
> diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
> index 486c269b29ba..c135db2416b5 100644
> --- a/tools/perf/util/disasm.h
> +++ b/tools/perf/util/disasm.h
> @@ -44,6 +44,10 @@ struct arch {
>  				struct data_loc_info *dloc, Dwarf_Die *cu_die,
>  				struct disasm_line *dl);
>  #endif
> +	/** @e_machine: ELF machine associated with arch. */
> +	unsigned int e_machine;
> +	/** @e_flags: Optional ELF flags associated with arch. */
> +	unsigned int e_flags;
>  };
>  
>  struct ins {
> -- 
> 2.47.0.105.g07ac214952-goog
> 
