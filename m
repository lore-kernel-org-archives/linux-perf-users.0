Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2FD23D7;
	Wed, 30 Oct 2024 00:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730248645; cv=none; b=JgjFwd4aEY8BOhADPdstUA++MLz+ZTo4Q4JmjpZhBXIwBubPk+Y2qxFeXPTEtAo7GwPomzRNIHjGBe+h8XJBeC6eweNZrVJUFDCzqp6MsvMWhNF1rnuDGWlJ4SqL61AXM0ws6yBCdiezYEcCXS9vgWoYOihZ29LI2QZVZtHBmpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730248645; c=relaxed/simple;
	bh=dURTOXL4P+eY/enOSnmceDVRo9KrseqCoeA8XcVElsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAeFPuOdulHYx5N6VyewoOH2xdhcoUORzU1HhBEgVmJzFWEuvBXUDtj5/qPUaUIGx5eX+dVk8bhMcRkev18NLx+Q0g3EnKBsbLJtV56zCg8+WlLXVe74kNNYcS5o0okjjk2+5tOn1r+RhZHW5AhznNM4zLmDEjxgabart3NrbXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRYqBTHJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRYqBTHJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15805C4CECD;
	Wed, 30 Oct 2024 00:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730248644;
	bh=dURTOXL4P+eY/enOSnmceDVRo9KrseqCoeA8XcVElsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DRYqBTHJDng3XM4VBRR//2H+o0boZztE1JfVhqL9YY4GKxjDx/nWR6KWvIIUERLeZ
	 sRW6yI7bY8det+O1IYT5KkWYqOwBQLovqgvgcFTIDd3GfbjYwjKldfq9IKnw4psTpC
	 YMMk9wuQQuEhSj8v2ODLbRFCPsE4juPq6vSCk4wdPIlIykUuV6eBpa1caMlYMUXkfC
	 7g8FV7oWRgekYKhcRW0h4FN7m5nFd+ZXlHhUTdetgBZYtM9SCGd2eGGLteTVwFAd1W
	 q2sXlUERkwzIVZqeL55dyGZDao2P75xQfVw+eVXm1LS6aeWEtRiuR6FNAiSVlN6wPL
	 WGIxx/cxxIYXg==
Date: Tue, 29 Oct 2024 17:37:22 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH] perf, riscv: Wire up perf trace support for RISC-V
Message-ID: <ZyF_whZ4Ez-jwd-W@google.com>
References: <20241024190353.46737-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241024190353.46737-1-bjorn@kernel.org>

Hello,

On Thu, Oct 24, 2024 at 12:03:51PM -0700, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> RISC-V does not currently support perf trace, since the system call
> table is not generated.
> 
> Perform the copy/paste exercise, wiring up RISC-V system call table
> generation.

Can anybody with RISC-V please test this?

Thanks,
Namhyung

> 
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>  tools/perf/Makefile.config                    |  6 ++-
>  tools/perf/arch/riscv/Makefile                | 22 +++++++++
>  .../arch/riscv/entry/syscalls/mksyscalltbl    | 47 +++++++++++++++++++
>  tools/perf/util/syscalltbl.c                  |  4 ++
>  4 files changed, 78 insertions(+), 1 deletion(-)
>  create mode 100755 tools/perf/arch/riscv/entry/syscalls/mksyscalltbl
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 4ddb27a48eed..1d388e71e0cc 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -31,7 +31,7 @@ $(call detected_var,SRCARCH)
>  ifneq ($(NO_SYSCALL_TABLE),1)
>    NO_SYSCALL_TABLE := 1
>  
> -  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 powerpc arm64 s390 mips loongarch))
> +  ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 powerpc arm64 s390 mips loongarch riscv))
>      NO_SYSCALL_TABLE := 0
>    endif
>  
> @@ -83,6 +83,10 @@ ifeq ($(ARCH),mips)
>    LIBUNWIND_LIBS = -lunwind -lunwind-mips
>  endif
>  
> +ifeq ($(ARCH),riscv)
> +  CFLAGS += -I$(OUTPUT)arch/riscv/include/generated
> +endif
> +
>  # So far there's only x86 and arm libdw unwind support merged in perf.
>  # Disable it on all other architectures in case libdw unwind
>  # support is detected in system. Add supported architectures
> diff --git a/tools/perf/arch/riscv/Makefile b/tools/perf/arch/riscv/Makefile
> index 90c3c476a242..481da4518695 100644
> --- a/tools/perf/arch/riscv/Makefile
> +++ b/tools/perf/arch/riscv/Makefile
> @@ -4,3 +4,25 @@ endif
>  PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
>  PERF_HAVE_JITDUMP := 1
>  HAVE_KVM_STAT_SUPPORT := 1
> +
> +#
> +# Syscall table generation for perf
> +#
> +
> +out    := $(OUTPUT)arch/riscv/include/generated/asm
> +header := $(out)/syscalls.c
> +incpath := $(srctree)/tools
> +sysdef := $(srctree)/tools/arch/riscv/include/uapi/asm/unistd.h
> +sysprf := $(srctree)/tools/perf/arch/riscv/entry/syscalls/
> +systbl := $(sysprf)/mksyscalltbl
> +
> +# Create output directory if not already present
> +$(shell [ -d '$(out)' ] || mkdir -p '$(out)')
> +
> +$(header): $(sysdef) $(systbl)
> +	$(Q)$(SHELL) '$(systbl)' '$(CC)' '$(HOSTCC)' $(incpath) $(sysdef) > $@
> +
> +clean::
> +	$(call QUIET_CLEAN, riscv) $(RM) $(header)
> +
> +archheaders: $(header)
> diff --git a/tools/perf/arch/riscv/entry/syscalls/mksyscalltbl b/tools/perf/arch/riscv/entry/syscalls/mksyscalltbl
> new file mode 100755
> index 000000000000..c59f5e852b97
> --- /dev/null
> +++ b/tools/perf/arch/riscv/entry/syscalls/mksyscalltbl
> @@ -0,0 +1,47 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Generate system call table for perf. Derived from
> +# powerpc script.
> +#
> +# Copyright IBM Corp. 2017
> +# Author(s):  Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> +# Changed by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> +# Changed by: Kim Phillips <kim.phillips@arm.com>
> +# Changed by: Björn Töpel <bjorn@rivosinc.com>
> +
> +gcc=$1
> +hostcc=$2
> +incpath=$3
> +input=$4
> +
> +if ! test -r $input; then
> +	echo "Could not read input file" >&2
> +	exit 1
> +fi
> +
> +create_sc_table()
> +{
> +	local sc nr max_nr
> +
> +	while read sc nr; do
> +		printf "%s\n" "	[$nr] = \"$sc\","
> +		max_nr=$nr
> +	done
> +
> +	echo "#define SYSCALLTBL_RISCV_MAX_ID $max_nr"
> +}
> +
> +create_table()
> +{
> +	echo "#include \"$input\""
> +	echo "static const char *const syscalltbl_riscv[] = {"
> +	create_sc_table
> +	echo "};"
> +}
> +
> +$gcc -E -dM -x c -I $incpath/include/uapi $input \
> +	|awk '$2 ~ "__NR" && $3 !~ "__NR3264_" {
> +		sub("^#define __NR(3264)?_", "");
> +		print | "sort -k2 -n"}' \
> +	|create_table
> diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
> index 7c15dec6900d..349986f6e5f5 100644
> --- a/tools/perf/util/syscalltbl.c
> +++ b/tools/perf/util/syscalltbl.c
> @@ -46,6 +46,10 @@ static const char *const *syscalltbl_native = syscalltbl_mips_n64;
>  #include <asm/syscalls.c>
>  const int syscalltbl_native_max_id = SYSCALLTBL_LOONGARCH_MAX_ID;
>  static const char *const *syscalltbl_native = syscalltbl_loongarch;
> +#elif defined(__riscv)
> +#include <asm/syscalls.c>
> +const int syscalltbl_native_max_id = SYSCALLTBL_RISCV_MAX_ID;
> +static const char *const *syscalltbl_native = syscalltbl_riscv;
>  #endif
>  
>  struct syscall {
> 
> base-commit: c2ee9f594da826bea183ed14f2cc029c719bf4da
> -- 
> 2.45.2
> 
