Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB21381A3;
	Wed, 15 Jan 2025 02:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736907550; cv=none; b=IYHfRwR3Ni3OdbA5Fg59truCKVFmes+RZWNBHjW/B0IeMBvxwDStEVGristDEofO8v/4ecDlQToeVvp+zaBQVcHPjlW/Hw/bzCD3xSyrU4iS0fFquQFn1l3H2lPKqTTCOqO5GOlfpewZ/qKOIy1s6+lyUWWa+XMsWEwOWvIMPVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736907550; c=relaxed/simple;
	bh=WIIUjouQ6nBvflIgq3GnLzV1PjQVL1WznCE2bm8fme0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnkXcJ6hstOKUhbBhJ/yZJK7t3ak9oJXf707rEb42JjNID/+Lp0ZPLf0vFInLmWGdDCgtsbaliMwt+3QTaG6QTUM0Qx9pn6cyHUFLXLoBeqlrAjHqQfnymHnOXDdnidmKFQZ2xi7cJKqw1YFL3dEzt8/nwawgew2hWnI5m0QBQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZR2a4cED; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZR2a4cED"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0FDC4CEDF;
	Wed, 15 Jan 2025 02:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736907549;
	bh=WIIUjouQ6nBvflIgq3GnLzV1PjQVL1WznCE2bm8fme0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZR2a4cEDRcURNMwlEzO7KbJGeVr69OsW7Zul0+muaLwGmxBdOWl5i/Wi8c+VzlmV+
	 i3K1JqKNz79/5jnwU8GeAatXwUWfwx2O1a2DhxHPyYhzqVE+KSU+n6BV9Djgq6AZR4
	 130O1S2kMSL4EpLIRaVQuMyZyKNBHHX/8Com0zxlVQmBYrSPbLagDPsnSTrg/lXO7Z
	 SB4LEwvcQWYETcVuzv5H+NyKwIssYAgbxQae1yG5/EPcTH/rISmNlk/70fucmbciyw
	 OTU5NpPs7YLnCit/ENPD44f8X+ZqBa9a1O+b6oArL35a+CW/1St8sR7RoldtdMsQ0O
	 cHennqqvYYHRQ==
Date: Tue, 14 Jan 2025 23:19:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH RFC] lib perf: Select syscall table at runtime
Message-ID: <Z4cbGQzbnbVIipmR@x1>
References: <20250114-perf_syscall_arch_runtime-v1-1-5b304e408e11@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114-perf_syscall_arch_runtime-v1-1-5b304e408e11@rivosinc.com>

On Tue, Jan 14, 2025 at 06:08:21PM -0800, Charlie Jenkins wrote:
> Instead of compiling a single architecture's syscall table into libperf,
> build all of them and dynamically select the correct one. This helps
> move perf.data files around.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> Arnaldo mentioned that it would be useful to have syscalls all compile
> together for testing purposes and to allow perf.data info to be moved
> around with syscall info [1]. I am less familiar with perf trace so this is
> an RFC.

Thanks for working on it! I'm going to be on vacation from tomorrow to
February, 4, so I'll be mostly unresponsive, but will probably not
resist and look a bit here and there and provide some comments :-)

- Arnaldo
 
> [1] https://lore.kernel.org/lkml/Z4EoUoxSYPnS_Hul@x1/
> ---
>  tools/build/Build.include                          | 11 ++--
>  tools/perf/Makefile.config                         |  2 +-
>  tools/perf/Makefile.perf                           |  8 +++
>  tools/perf/arch/alpha/entry/syscalls/Kbuild        |  2 +-
>  .../arch/alpha/entry/syscalls/Makefile.syscalls    |  4 +-
>  tools/perf/arch/alpha/include/syscall_table.h      |  2 +-
>  tools/perf/arch/arc/entry/syscalls/Kbuild          |  2 +-
>  .../perf/arch/arc/entry/syscalls/Makefile.syscalls |  2 +-
>  tools/perf/arch/arc/include/syscall_table.h        |  2 +-
>  tools/perf/arch/arm/entry/syscalls/Kbuild          |  4 +-
>  .../perf/arch/arm/entry/syscalls/Makefile.syscalls |  2 +-
>  tools/perf/arch/arm/include/syscall_table.h        |  2 +-
>  tools/perf/arch/arm64/entry/syscalls/Kbuild        |  4 +-
>  .../arch/arm64/entry/syscalls/Makefile.syscalls    |  6 +-
>  tools/perf/arch/arm64/include/syscall_table.h      |  9 +--
>  tools/perf/arch/csky/entry/syscalls/Kbuild         |  2 +-
>  .../arch/csky/entry/syscalls/Makefile.syscalls     |  2 +-
>  tools/perf/arch/csky/include/syscall_table.h       |  2 +-
>  tools/perf/arch/loongarch/entry/syscalls/Kbuild    |  2 +-
>  .../loongarch/entry/syscalls/Makefile.syscalls     |  2 +-
>  tools/perf/arch/loongarch/include/syscall_table.h  |  2 +-
>  tools/perf/arch/mips/entry/syscalls/Kbuild         |  2 +-
>  .../arch/mips/entry/syscalls/Makefile.syscalls     |  4 +-
>  tools/perf/arch/mips/include/syscall_table.h       |  2 +-
>  tools/perf/arch/parisc/entry/syscalls/Kbuild       |  4 +-
>  .../arch/parisc/entry/syscalls/Makefile.syscalls   |  6 +-
>  tools/perf/arch/parisc/include/syscall_table.h     |  9 +--
>  tools/perf/arch/powerpc/entry/syscalls/Kbuild      |  4 +-
>  .../arch/powerpc/entry/syscalls/Makefile.syscalls  |  6 +-
>  tools/perf/arch/powerpc/include/syscall_table.h    |  9 +--
>  tools/perf/arch/riscv/entry/syscalls/Kbuild        |  3 +-
>  .../arch/riscv/entry/syscalls/Makefile.syscalls    |  4 +-
>  tools/perf/arch/riscv/include/syscall_table.h      |  9 +--
>  tools/perf/arch/s390/entry/syscalls/Kbuild         |  2 +-
>  .../arch/s390/entry/syscalls/Makefile.syscalls     |  4 +-
>  tools/perf/arch/s390/include/syscall_table.h       |  2 +-
>  tools/perf/arch/sh/entry/syscalls/Kbuild           |  2 +-
>  .../perf/arch/sh/entry/syscalls/Makefile.syscalls  |  4 +-
>  tools/perf/arch/sh/include/syscall_table.h         |  2 +-
>  tools/perf/arch/sparc/entry/syscalls/Kbuild        |  4 +-
>  .../arch/sparc/entry/syscalls/Makefile.syscalls    |  6 +-
>  tools/perf/arch/sparc/include/syscall_table.h      |  9 +--
>  tools/perf/arch/x86/entry/syscalls/Kbuild          |  4 +-
>  .../perf/arch/x86/entry/syscalls/Makefile.syscalls |  6 +-
>  tools/perf/arch/x86/include/syscall_table.h        |  9 +--
>  tools/perf/arch/xtensa/entry/syscalls/Kbuild       |  2 +-
>  .../arch/xtensa/entry/syscalls/Makefile.syscalls   |  4 +-
>  tools/perf/arch/xtensa/include/syscall_table.h     |  2 +-
>  tools/perf/builtin-trace.c                         |  7 ++-
>  tools/perf/scripts/Makefile.syscalls               | 20 +++++--
>  tools/perf/scripts/syscalltbl.sh                   | 17 ++++--
>  tools/perf/trace/beauty/arch_syscall_names.c       |  1 +
>  tools/perf/trace/beauty/arch_syscall_names.sh      | 49 ++++++++++++++++
>  tools/perf/util/env.c                              | 66 +++++++++++++++++++++-
>  tools/perf/util/env.h                              |  1 +
>  tools/perf/util/syscalltbl.c                       | 26 ++++++---
>  tools/perf/util/syscalltbl.h                       |  9 ++-
>  57 files changed, 261 insertions(+), 133 deletions(-)
> 
> diff --git a/tools/build/Build.include b/tools/build/Build.include
> index e45b2eb0d24aff45bbec9cd430c5e83e73e1a918..373f48d6a9e70041b0e2314789a60ffdd6e5f68e 100644
> --- a/tools/build/Build.include
> +++ b/tools/build/Build.include
> @@ -10,11 +10,12 @@
>  
>  ###
>  # Convenient variables
> -comma   := ,
> -squote  := '
> -pound   := \#
> -empty   :=
> -space   := $(empty) $(empty)
> +comma           := ,
> +squote          := '
> +pound           := \#
> +empty           :=
> +space           := $(empty) $(empty)
> +underscore      := _
>  
>  ###
>  # Name of target with a '.' as filename prefix. foo/bar.o => foo/.bar.o
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index a148ca9efca912c588d470335a5a13afeb758206..a5ffa0cb414164fc03fe760019ab65ec400afe06 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -28,7 +28,7 @@ include $(srctree)/tools/scripts/Makefile.arch
>  
>  $(call detected_var,SRCARCH)
>  
> -CFLAGS += -I$(OUTPUT)arch/$(SRCARCH)/include/generated
> +CFLAGS += -I$(OUTPUT)arch/syscalls/include/generated
>  
>  # Additional ARCH settings for ppc
>  ifeq ($(SRCARCH),powerpc)
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index a449d0015536442273a9268b37be34e4757f577a..62b094c280e36d227b6f16c4a54a87c252c01c36 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -707,6 +707,13 @@ arch_errno_tbl := $(srctree)/tools/perf/trace/beauty/arch_errno_names.sh
>  $(arch_errno_name_array): $(arch_errno_tbl)
>  	$(Q)$(SHELL) '$(arch_errno_tbl)' '$(patsubst -%,,$(CC))' $(arch_errno_hdr_dir) > $@
>  
> +arch_syscall_name_array := $(beauty_outdir)/arch_syscall_name_array.c
> +arch_syscall_hdr_dir := $(srctree)/tools
> +arch_syscall_tbl := $(srctree)/tools/perf/trace/beauty/arch_syscall_names.sh
> +
> +$(arch_syscall_name_array): $(arch_syscall_tbl)
> +	$(Q)$(SHELL) '$(arch_syscall_tbl)' $(OUTPUT) > $@
> +
>  statx_mask_array := $(beauty_outdir)/statx_mask_array.c
>  statx_mask_tbl := $(srctree)/tools/perf/trace/beauty/statx_mask.sh
>  
> @@ -872,6 +879,7 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders \
>  	$(x86_arch_prctl_code_array) \
>  	$(rename_flags_array) \
>  	$(arch_errno_name_array) \
> +	$(arch_syscall_name_array) \
>  	$(statx_mask_array) \
>  	$(sync_file_range_arrays) \
>  	$(LIBAPI) \
> diff --git a/tools/perf/arch/alpha/entry/syscalls/Kbuild b/tools/perf/arch/alpha/entry/syscalls/Kbuild
> index 9a41e3572c3afd4f202321fd9e492714540e8fd3..d3f00e3e85b202b20f102223276b96fa9241a600 100644
> --- a/tools/perf/arch/alpha/entry/syscalls/Kbuild
> +++ b/tools/perf/arch/alpha/entry/syscalls/Kbuild
> @@ -1,2 +1,2 @@
>  # SPDX-License-Identifier: GPL-2.0
> -syscall-y += syscalls_64.h
> +syscall-y += syscalls_64_alpha.h
> diff --git a/tools/perf/arch/alpha/entry/syscalls/Makefile.syscalls b/tools/perf/arch/alpha/entry/syscalls/Makefile.syscalls
> index 690168aac34db9f1b96346210993675defcfc300..bbbad99a3e06485291f9894e69553059f7415d9a 100644
> --- a/tools/perf/arch/alpha/entry/syscalls/Makefile.syscalls
> +++ b/tools/perf/arch/alpha/entry/syscalls/Makefile.syscalls
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -syscall_abis_64  +=
> +syscall_abis_64_alpha := $(syscall_abis_64)
>  
> -syscalltbl = $(srctree)/tools/perf/arch/alpha/entry/syscalls/syscall.tbl
> +syscalltbl_alpha = $(srctree)/tools/perf/arch/alpha/entry/syscalls/syscall.tbl
> diff --git a/tools/perf/arch/alpha/include/syscall_table.h b/tools/perf/arch/alpha/include/syscall_table.h
> index b53e31c15805319a01719c22d489c4037378b02b..cf13a5539999966a5ecc9bf83fe2de8889fcd459 100644
> --- a/tools/perf/arch/alpha/include/syscall_table.h
> +++ b/tools/perf/arch/alpha/include/syscall_table.h
> @@ -1,2 +1,2 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/syscalls_64.h>
> +#include <asm/syscalls_64_alpha.h>
> diff --git a/tools/perf/arch/arc/entry/syscalls/Kbuild b/tools/perf/arch/arc/entry/syscalls/Kbuild
> index 11707c481a24ecf4e220e51eb1aca890fe929a13..51a060f853008bc60f7b0c3586cacb856fe6ee02 100644
> --- a/tools/perf/arch/arc/entry/syscalls/Kbuild
> +++ b/tools/perf/arch/arc/entry/syscalls/Kbuild
> @@ -1,2 +1,2 @@
>  # SPDX-License-Identifier: GPL-2.0
> -syscall-y += syscalls_32.h
> +syscall-y += syscalls_32_arc.h
> diff --git a/tools/perf/arch/arc/entry/syscalls/Makefile.syscalls b/tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
> index 391d30ab7a831b72d2ed3f2e7966fdbf558a9ed7..26ed0cfe7f5751c6d31e24b9cc301769b0df5751 100644
> --- a/tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
> +++ b/tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
> @@ -1,3 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -syscall_abis_32 += arc time32 renameat stat64 rlimit
> +syscall_abis_32_arc := $(syscall_abis_32) arc time32 renameat stat64 rlimit
> diff --git a/tools/perf/arch/arc/include/syscall_table.h b/tools/perf/arch/arc/include/syscall_table.h
> index 4c942821662d95216765b176a84d5fc7974e1064..0363e6e7a02cf201f8407f907fc9814a9d472243 100644
> --- a/tools/perf/arch/arc/include/syscall_table.h
> +++ b/tools/perf/arch/arc/include/syscall_table.h
> @@ -1,2 +1,2 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/syscalls_32.h>
> +#include <asm/syscalls_32_arc.h>
> diff --git a/tools/perf/arch/arm/entry/syscalls/Kbuild b/tools/perf/arch/arm/entry/syscalls/Kbuild
> index 9d777540f08987908a6532c5ece66553dffc52df..d619bfe458884db933e308d7a8509adc780be77f 100644
> --- a/tools/perf/arch/arm/entry/syscalls/Kbuild
> +++ b/tools/perf/arch/arm/entry/syscalls/Kbuild
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -syscall_abis_32 += oabi
> -syscalltbl = $(srctree)/tools/perf/arch/arm/entry/syscalls/syscall.tbl
> +syscall_abis_32_arm := $(syscall_abis_32) oabi
> +syscalltbl_arm = $(srctree)/tools/perf/arch/arm/entry/syscalls/syscall.tbl
> diff --git a/tools/perf/arch/arm/entry/syscalls/Makefile.syscalls b/tools/perf/arch/arm/entry/syscalls/Makefile.syscalls
> index 11707c481a24ecf4e220e51eb1aca890fe929a13..5bc7fe68a33a1f76abcae1af3fb1d887a53dd4a3 100644
> --- a/tools/perf/arch/arm/entry/syscalls/Makefile.syscalls
> +++ b/tools/perf/arch/arm/entry/syscalls/Makefile.syscalls
> @@ -1,2 +1,2 @@
>  # SPDX-License-Identifier: GPL-2.0
> -syscall-y += syscalls_32.h
> +syscall-y += syscalls_32_arm.h
> diff --git a/tools/perf/arch/arm/include/syscall_table.h b/tools/perf/arch/arm/include/syscall_table.h
> index 4c942821662d95216765b176a84d5fc7974e1064..ebd70e82cf6ae5118d0e515cd5483ae3f1c231e7 100644
> --- a/tools/perf/arch/arm/include/syscall_table.h
> +++ b/tools/perf/arch/arm/include/syscall_table.h
> @@ -1,2 +1,2 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/syscalls_32.h>
> +#include <asm/syscalls_32_arm.h>
> diff --git a/tools/perf/arch/arm64/entry/syscalls/Kbuild b/tools/perf/arch/arm64/entry/syscalls/Kbuild
> index 84c6599b4ea6a160217a3496449b205f2263f0fb..266e9fef9305596118e65efbb3501fd974d7b1c3 100644
> --- a/tools/perf/arch/arm64/entry/syscalls/Kbuild
> +++ b/tools/perf/arch/arm64/entry/syscalls/Kbuild
> @@ -1,3 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
> -syscall-y += syscalls_32.h
> -syscall-y += syscalls_64.h
> +syscall-y += syscalls_32_arm64.h
> +syscall-y += syscalls_64_arm64.h
> diff --git a/tools/perf/arch/arm64/entry/syscalls/Makefile.syscalls b/tools/perf/arch/arm64/entry/syscalls/Makefile.syscalls
> index e7e78c2d1c025b6954a1a22d44a744012e1ca3d4..2c46d208771674621c3c4f756a6148d8ab1b9723 100644
> --- a/tools/perf/arch/arm64/entry/syscalls/Makefile.syscalls
> +++ b/tools/perf/arch/arm64/entry/syscalls/Makefile.syscalls
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -syscall_abis_32 +=
> -syscall_abis_64 += renameat rlimit memfd_secret
> +syscall_abis_32_arm64 := $(syscall_abis_32)
> +syscall_abis_64_arm64 := $(syscall_abis_64) renameat rlimit memfd_secret
>  
> -syscalltbl = $(srctree)/tools/perf/arch/arm64/entry/syscalls/syscall_%.tbl
> +syscalltbl_arm64 = $(srctree)/tools/perf/arch/arm64/entry/syscalls/syscall_%.tbl
> diff --git a/tools/perf/arch/arm64/include/syscall_table.h b/tools/perf/arch/arm64/include/syscall_table.h
> index 7ff51b783000d727ec48be960730b81ecdb05575..ffe076d315006fc664a5b757eeac6f8c1785cde2 100644
> --- a/tools/perf/arch/arm64/include/syscall_table.h
> +++ b/tools/perf/arch/arm64/include/syscall_table.h
> @@ -1,8 +1,3 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/bitsperlong.h>
> -
> -#if __BITS_PER_LONG == 64
> -#include <asm/syscalls_64.h>
> -#else
> -#include <asm/syscalls_32.h>
> -#endif
> +#include <asm/syscalls_64_arm64.h>
> +#include <asm/syscalls_32_arm64.h>
> diff --git a/tools/perf/arch/csky/entry/syscalls/Kbuild b/tools/perf/arch/csky/entry/syscalls/Kbuild
> index 11707c481a24ecf4e220e51eb1aca890fe929a13..207de9817679105b7ad1600d4a18e376649ba0a4 100644
> --- a/tools/perf/arch/csky/entry/syscalls/Kbuild
> +++ b/tools/perf/arch/csky/entry/syscalls/Kbuild
> @@ -1,2 +1,2 @@
>  # SPDX-License-Identifier: GPL-2.0
> -syscall-y += syscalls_32.h
> +syscall-y += syscalls_32_csky.h
> diff --git a/tools/perf/arch/csky/entry/syscalls/Makefile.syscalls b/tools/perf/arch/csky/entry/syscalls/Makefile.syscalls
> index ea2dd10d0571df464574a9c0232ada0ac1f79a3f..ecb6cefe29a69336c8ce26a4830d30da6966036d 100644
> --- a/tools/perf/arch/csky/entry/syscalls/Makefile.syscalls
> +++ b/tools/perf/arch/csky/entry/syscalls/Makefile.syscalls
> @@ -1,3 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -syscall_abis_32 += csky time32 stat64 rlimit
> +syscall_abis_32_csky := $(syscall_abis_32) csky time32 stat64 rlimit
> diff --git a/tools/perf/arch/csky/include/syscall_table.h b/tools/perf/arch/csky/include/syscall_table.h
> index 4c942821662d95216765b176a84d5fc7974e1064..01078c717218f95b812135c200b6f9ad92ce522f 100644
> --- a/tools/perf/arch/csky/include/syscall_table.h
> +++ b/tools/perf/arch/csky/include/syscall_table.h
> @@ -1,2 +1,2 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/syscalls_32.h>
> +#include <asm/syscalls_32_csky.h>
> diff --git a/tools/perf/arch/loongarch/entry/syscalls/Kbuild b/tools/perf/arch/loongarch/entry/syscalls/Kbuild
> index 9a41e3572c3afd4f202321fd9e492714540e8fd3..40b3ea3f04b989382027cac69092bca40f1575d9 100644
> --- a/tools/perf/arch/loongarch/entry/syscalls/Kbuild
> +++ b/tools/perf/arch/loongarch/entry/syscalls/Kbuild
> @@ -1,2 +1,2 @@
>  # SPDX-License-Identifier: GPL-2.0
> -syscall-y += syscalls_64.h
> +syscall-y += syscalls_64_loongarch.h
> diff --git a/tools/perf/arch/loongarch/entry/syscalls/Makefile.syscalls b/tools/perf/arch/loongarch/entry/syscalls/Makefile.syscalls
> index 47d32da2aed8d67a7ac026271600e84723031a6b..58f0324adc8121911ea1734d59b3a36c96c513b6 100644
> --- a/tools/perf/arch/loongarch/entry/syscalls/Makefile.syscalls
> +++ b/tools/perf/arch/loongarch/entry/syscalls/Makefile.syscalls
> @@ -1,3 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -syscall_abis_64 +=
> +syscall_abis_64_loongarch := $(syscall_abis_64)
> diff --git a/tools/perf/arch/loongarch/include/syscall_table.h b/tools/perf/arch/loongarch/include/syscall_table.h
> index 9d0646d3455cdaf1a3db8c8565af8eba9a8df8c6..8bb3114abade37d09e52ae8734bc187a2127f6dd 100644
> --- a/tools/perf/arch/loongarch/include/syscall_table.h
> +++ b/tools/perf/arch/loongarch/include/syscall_table.h
> @@ -1,2 +1,2 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/syscall_table_64.h>
> +#include <asm/syscall_table_64_loongarch.h>
> diff --git a/tools/perf/arch/mips/entry/syscalls/Kbuild b/tools/perf/arch/mips/entry/syscalls/Kbuild
> index 9a41e3572c3afd4f202321fd9e492714540e8fd3..eb22646551ee127232592b30ee9b336ff91a2f1e 100644
> --- a/tools/perf/arch/mips/entry/syscalls/Kbuild
> +++ b/tools/perf/arch/mips/entry/syscalls/Kbuild
> @@ -1,2 +1,2 @@
>  # SPDX-License-Identifier: GPL-2.0
> -syscall-y += syscalls_64.h
> +syscall-y += syscalls_64_mips.h
> diff --git a/tools/perf/arch/mips/entry/syscalls/Makefile.syscalls b/tools/perf/arch/mips/entry/syscalls/Makefile.syscalls
> index 9ee914bdfb05860fdd37a49f1ced03fcf2c9ed78..9e900cee9326b13769b8f2be0de0b5b9a4814ad1 100644
> --- a/tools/perf/arch/mips/entry/syscalls/Makefile.syscalls
> +++ b/tools/perf/arch/mips/entry/syscalls/Makefile.syscalls
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -syscall_abis_64 += n64
> +syscall_abis_64_mips := $(syscall_abis_64) n64
>  
> -syscalltbl = $(srctree)/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
> +syscalltbl_mips = $(srctree)/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
> diff --git a/tools/perf/arch/mips/include/syscall_table.h b/tools/perf/arch/mips/include/syscall_table.h
> index b53e31c15805319a01719c22d489c4037378b02b..070fa78a07d7efaf759ebb933783cbc0b913c9e4 100644
> --- a/tools/perf/arch/mips/include/syscall_table.h
> +++ b/tools/perf/arch/mips/include/syscall_table.h
> @@ -1,2 +1,2 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/syscalls_64.h>
> +#include <asm/syscalls_64_mips.h>
> diff --git a/tools/perf/arch/parisc/entry/syscalls/Kbuild b/tools/perf/arch/parisc/entry/syscalls/Kbuild
> index 84c6599b4ea6a160217a3496449b205f2263f0fb..16efa42283fa7715a750172313bf25b485c2ce23 100644
> --- a/tools/perf/arch/parisc/entry/syscalls/Kbuild
> +++ b/tools/perf/arch/parisc/entry/syscalls/Kbuild
> @@ -1,3 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
> -syscall-y += syscalls_32.h
> -syscall-y += syscalls_64.h
> +syscall-y += syscalls_32_parisc.h
> +syscall-y += syscalls_64_parisc.h
> diff --git a/tools/perf/arch/parisc/entry/syscalls/Makefile.syscalls b/tools/perf/arch/parisc/entry/syscalls/Makefile.syscalls
> index ae326fecb83b307fb5b0a885ae109480aafd586f..ead42cc7642c54d82ca38b18293931452a828ea2 100644
> --- a/tools/perf/arch/parisc/entry/syscalls/Makefile.syscalls
> +++ b/tools/perf/arch/parisc/entry/syscalls/Makefile.syscalls
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -syscall_abis_32  +=
> -syscall_abis_64  +=
> +syscall_abis_32_parisc := $(syscall_abis_32)
> +syscall_abis_64_parisc := $(syscall_abis_64)
>  
> -syscalltbl = $(srctree)/tools/perf/arch/parisc/entry/syscalls/syscall.tbl
> +syscalltbl_parisc = $(srctree)/tools/perf/arch/parisc/entry/syscalls/syscall.tbl
> diff --git a/tools/perf/arch/parisc/include/syscall_table.h b/tools/perf/arch/parisc/include/syscall_table.h
> index 7ff51b783000d727ec48be960730b81ecdb05575..4392772cea24d6d6a27438fbc57723f7c59e2776 100644
> --- a/tools/perf/arch/parisc/include/syscall_table.h
> +++ b/tools/perf/arch/parisc/include/syscall_table.h
> @@ -1,8 +1,3 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/bitsperlong.h>
> -
> -#if __BITS_PER_LONG == 64
> -#include <asm/syscalls_64.h>
> -#else
> -#include <asm/syscalls_32.h>
> -#endif
> +#include <asm/syscalls_64_parisc.h>
> +#include <asm/syscalls_32_parisc.h>
> diff --git a/tools/perf/arch/powerpc/entry/syscalls/Kbuild b/tools/perf/arch/powerpc/entry/syscalls/Kbuild
> index 84c6599b4ea6a160217a3496449b205f2263f0fb..8b2a46c5a4ab4776283d42919a58b7af9292f31a 100644
> --- a/tools/perf/arch/powerpc/entry/syscalls/Kbuild
> +++ b/tools/perf/arch/powerpc/entry/syscalls/Kbuild
> @@ -1,3 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
> -syscall-y += syscalls_32.h
> -syscall-y += syscalls_64.h
> +syscall-y += syscalls_32_powerpc.h
> +syscall-y += syscalls_64_powerpc.h
> diff --git a/tools/perf/arch/powerpc/entry/syscalls/Makefile.syscalls b/tools/perf/arch/powerpc/entry/syscalls/Makefile.syscalls
> index e35afbc57c796cbe5bc765852daac5b3f5bf8433..de5ad3f1761ce1d6501fc737a089566bde239854 100644
> --- a/tools/perf/arch/powerpc/entry/syscalls/Makefile.syscalls
> +++ b/tools/perf/arch/powerpc/entry/syscalls/Makefile.syscalls
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -syscall_abis_32 += nospu
> -syscall_abis_64 += nospu
> +syscall_abis_32_powerpc += nospu
> +syscall_abis_64_powerpc += nospu
>  
> -syscalltbl = $(srctree)/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> +syscalltbl_powerpc = $(srctree)/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> diff --git a/tools/perf/arch/powerpc/include/syscall_table.h b/tools/perf/arch/powerpc/include/syscall_table.h
> index 7ff51b783000d727ec48be960730b81ecdb05575..4f76baa89859aef27c823c4fb237675a31977892 100644
> --- a/tools/perf/arch/powerpc/include/syscall_table.h
> +++ b/tools/perf/arch/powerpc/include/syscall_table.h
> @@ -1,8 +1,3 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/bitsperlong.h>
> -
> -#if __BITS_PER_LONG == 64
> -#include <asm/syscalls_64.h>
> -#else
> -#include <asm/syscalls_32.h>
> -#endif
> +#include <asm/syscalls_64_powerpc.h>
> +#include <asm/syscalls_32_powerpc.h>
> diff --git a/tools/perf/arch/riscv/entry/syscalls/Kbuild b/tools/perf/arch/riscv/entry/syscalls/Kbuild
> index 9a41e3572c3afd4f202321fd9e492714540e8fd3..2ed98c2ec95d1e78adf8b17425d6ff2440b70fe8 100644
> --- a/tools/perf/arch/riscv/entry/syscalls/Kbuild
> +++ b/tools/perf/arch/riscv/entry/syscalls/Kbuild
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
> -syscall-y += syscalls_64.h
> +syscall-y += syscalls_32_riscv.h
> +syscall-y += syscalls_64_riscv.h
> diff --git a/tools/perf/arch/riscv/entry/syscalls/Makefile.syscalls b/tools/perf/arch/riscv/entry/syscalls/Makefile.syscalls
> index 9668fd1faf60e828ed2786c2ee84739ac1f153fc..a2ec422be22f648db3751983b568df83651bfa8c 100644
> --- a/tools/perf/arch/riscv/entry/syscalls/Makefile.syscalls
> +++ b/tools/perf/arch/riscv/entry/syscalls/Makefile.syscalls
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -syscall_abis_32 += riscv memfd_secret
> -syscall_abis_64 += riscv rlimit memfd_secret
> +syscall_abis_32_riscv := $(syscall_abis_32) riscv memfd_secret
> +syscall_abis_64_riscv := $(syscall_abis_64) riscv rlimit memfd_secret
> diff --git a/tools/perf/arch/riscv/include/syscall_table.h b/tools/perf/arch/riscv/include/syscall_table.h
> index 7ff51b783000d727ec48be960730b81ecdb05575..12cc4439016667f12ca59a259ac7b73b7f90c82d 100644
> --- a/tools/perf/arch/riscv/include/syscall_table.h
> +++ b/tools/perf/arch/riscv/include/syscall_table.h
> @@ -1,8 +1,3 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/bitsperlong.h>
> -
> -#if __BITS_PER_LONG == 64
> -#include <asm/syscalls_64.h>
> -#else
> -#include <asm/syscalls_32.h>
> -#endif
> +#include <asm/syscalls_64_riscv.h>
> +#include <asm/syscalls_32_riscv.h>
> diff --git a/tools/perf/arch/s390/entry/syscalls/Kbuild b/tools/perf/arch/s390/entry/syscalls/Kbuild
> index 9a41e3572c3afd4f202321fd9e492714540e8fd3..ded58e7c89a8bc40c9b387a4d81d1c51f2441eda 100644
> --- a/tools/perf/arch/s390/entry/syscalls/Kbuild
> +++ b/tools/perf/arch/s390/entry/syscalls/Kbuild
> @@ -1,2 +1,2 @@
>  # SPDX-License-Identifier: GPL-2.0
> -syscall-y += syscalls_64.h
> +syscall-y += syscalls_64_s390.h
> diff --git a/tools/perf/arch/s390/entry/syscalls/Makefile.syscalls b/tools/perf/arch/s390/entry/syscalls/Makefile.syscalls
> index 9762d7abf17c3f79a6213e7306a5f7b56e833a78..0d44c5cc3f8558cde0d5d1ed5d5f37f72a09ae15 100644
> --- a/tools/perf/arch/s390/entry/syscalls/Makefile.syscalls
> +++ b/tools/perf/arch/s390/entry/syscalls/Makefile.syscalls
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -syscall_abis_64 += renameat rlimit memfd_secret
> +syscall_abis_64_s390 := $(syscall_abis_64) renameat rlimit memfd_secret
>  
> -syscalltbl = $(srctree)/tools/perf/arch/s390/entry/syscalls/syscall.tbl
> +syscalltbl_s390 = $(srctree)/tools/perf/arch/s390/entry/syscalls/syscall.tbl
> diff --git a/tools/perf/arch/s390/include/syscall_table.h b/tools/perf/arch/s390/include/syscall_table.h
> index b53e31c15805319a01719c22d489c4037378b02b..37f108e0d17c19ad262e172d1105f75f75a106e7 100644
> --- a/tools/perf/arch/s390/include/syscall_table.h
> +++ b/tools/perf/arch/s390/include/syscall_table.h
> @@ -1,2 +1,2 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/syscalls_64.h>
> +#include <asm/syscalls_64_s390.h>
> diff --git a/tools/perf/arch/sh/entry/syscalls/Kbuild b/tools/perf/arch/sh/entry/syscalls/Kbuild
> index 11707c481a24ecf4e220e51eb1aca890fe929a13..c4bf22c4c8e89e2dc6e80d6c65dce8681dee612f 100644
> --- a/tools/perf/arch/sh/entry/syscalls/Kbuild
> +++ b/tools/perf/arch/sh/entry/syscalls/Kbuild
> @@ -1,2 +1,2 @@
>  # SPDX-License-Identifier: GPL-2.0
> -syscall-y += syscalls_32.h
> +syscall-y += syscalls_32_sh.h
> diff --git a/tools/perf/arch/sh/entry/syscalls/Makefile.syscalls b/tools/perf/arch/sh/entry/syscalls/Makefile.syscalls
> index 25080390e4ed49ae56f314ad712007e674a9168e..3b3988ccdaf4fb21757b2f36b6c0d55eb11bb534 100644
> --- a/tools/perf/arch/sh/entry/syscalls/Makefile.syscalls
> +++ b/tools/perf/arch/sh/entry/syscalls/Makefile.syscalls
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -syscall_abis_32 +=
> -syscalltbl = $(srctree)/tools/perf/arch/sh/entry/syscalls/syscall.tbl
> +syscall_abis_32_sh := $(syscall_abis_32)
> +syscalltbl_sh = $(srctree)/tools/perf/arch/sh/entry/syscalls/syscall.tbl
> diff --git a/tools/perf/arch/sh/include/syscall_table.h b/tools/perf/arch/sh/include/syscall_table.h
> index 4c942821662d95216765b176a84d5fc7974e1064..d6edaae178aff127b6c9efe3f51df3c9103983af 100644
> --- a/tools/perf/arch/sh/include/syscall_table.h
> +++ b/tools/perf/arch/sh/include/syscall_table.h
> @@ -1,2 +1,2 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/syscalls_32.h>
> +#include <asm/syscalls_32_sh.h>
> diff --git a/tools/perf/arch/sparc/entry/syscalls/Kbuild b/tools/perf/arch/sparc/entry/syscalls/Kbuild
> index 84c6599b4ea6a160217a3496449b205f2263f0fb..db1934ab210b40a83ab6e656fd4dd90e0d463d34 100644
> --- a/tools/perf/arch/sparc/entry/syscalls/Kbuild
> +++ b/tools/perf/arch/sparc/entry/syscalls/Kbuild
> @@ -1,3 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
> -syscall-y += syscalls_32.h
> -syscall-y += syscalls_64.h
> +syscall-y += syscalls_32_sparc.h
> +syscall-y += syscalls_64_sparc.h
> diff --git a/tools/perf/arch/sparc/entry/syscalls/Makefile.syscalls b/tools/perf/arch/sparc/entry/syscalls/Makefile.syscalls
> index 212c1800b64477c615b8963176d873db5ccabe0c..014461a4ce79b41823a4a4485b6ed753de18044d 100644
> --- a/tools/perf/arch/sparc/entry/syscalls/Makefile.syscalls
> +++ b/tools/perf/arch/sparc/entry/syscalls/Makefile.syscalls
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -syscall_abis_32  +=
> -syscall_abis_64  +=
> -syscalltbl = $(srctree)/tools/perf/arch/sparc/entry/syscalls/syscall.tbl
> +syscall_abis_32_sparc := $(syscall_abis_32)
> +syscall_abis_64_sparc := $(syscall_abis_64)
> +syscalltbl_sparc = $(srctree)/tools/perf/arch/sparc/entry/syscalls/syscall.tbl
> diff --git a/tools/perf/arch/sparc/include/syscall_table.h b/tools/perf/arch/sparc/include/syscall_table.h
> index 7ff51b783000d727ec48be960730b81ecdb05575..ab02afde9ec0925f31a5e1203e10a229a410ca7f 100644
> --- a/tools/perf/arch/sparc/include/syscall_table.h
> +++ b/tools/perf/arch/sparc/include/syscall_table.h
> @@ -1,8 +1,3 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/bitsperlong.h>
> -
> -#if __BITS_PER_LONG == 64
> -#include <asm/syscalls_64.h>
> -#else
> -#include <asm/syscalls_32.h>
> -#endif
> +#include <asm/syscalls_64_sparc.h>
> +#include <asm/syscalls_32_sparc.h>
> diff --git a/tools/perf/arch/x86/entry/syscalls/Kbuild b/tools/perf/arch/x86/entry/syscalls/Kbuild
> index 84c6599b4ea6a160217a3496449b205f2263f0fb..6e21b98481d3da086b596979c0fad6ad3c2ea315 100644
> --- a/tools/perf/arch/x86/entry/syscalls/Kbuild
> +++ b/tools/perf/arch/x86/entry/syscalls/Kbuild
> @@ -1,3 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
> -syscall-y += syscalls_32.h
> -syscall-y += syscalls_64.h
> +syscall-y += syscalls_32_x86.h
> +syscall-y += syscalls_64_x86.h
> diff --git a/tools/perf/arch/x86/entry/syscalls/Makefile.syscalls b/tools/perf/arch/x86/entry/syscalls/Makefile.syscalls
> index db3d5d6d4e5699d338afc55f6415612ef924d985..4c070223f985f075a1a215e99da2520c2c57561c 100644
> --- a/tools/perf/arch/x86/entry/syscalls/Makefile.syscalls
> +++ b/tools/perf/arch/x86/entry/syscalls/Makefile.syscalls
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -syscall_abis_32 += i386
> -syscall_abis_64 +=
> +syscall_abis_32_x86 := $(syscall_abis_32) i386
> +syscall_abis_64_x86 := $(syscall_abis_64)
>  
> -syscalltbl = $(srctree)/tools/perf/arch/x86/entry/syscalls/syscall_%.tbl
> +syscalltbl_x86 = $(srctree)/tools/perf/arch/x86/entry/syscalls/syscall_%.tbl
> diff --git a/tools/perf/arch/x86/include/syscall_table.h b/tools/perf/arch/x86/include/syscall_table.h
> index 7ff51b783000d727ec48be960730b81ecdb05575..98ada5aaf0a13ef82dabda4080832fd590b3951d 100644
> --- a/tools/perf/arch/x86/include/syscall_table.h
> +++ b/tools/perf/arch/x86/include/syscall_table.h
> @@ -1,8 +1,3 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/bitsperlong.h>
> -
> -#if __BITS_PER_LONG == 64
> -#include <asm/syscalls_64.h>
> -#else
> -#include <asm/syscalls_32.h>
> -#endif
> +#include <asm/syscalls_64_x86.h>
> +#include <asm/syscalls_32_x86.h>
> diff --git a/tools/perf/arch/xtensa/entry/syscalls/Kbuild b/tools/perf/arch/xtensa/entry/syscalls/Kbuild
> index 11707c481a24ecf4e220e51eb1aca890fe929a13..6648d5ff584981e538fbf164a287e6201564b0b7 100644
> --- a/tools/perf/arch/xtensa/entry/syscalls/Kbuild
> +++ b/tools/perf/arch/xtensa/entry/syscalls/Kbuild
> @@ -1,2 +1,2 @@
>  # SPDX-License-Identifier: GPL-2.0
> -syscall-y += syscalls_32.h
> +syscall-y += syscalls_32_xtensa.h
> diff --git a/tools/perf/arch/xtensa/entry/syscalls/Makefile.syscalls b/tools/perf/arch/xtensa/entry/syscalls/Makefile.syscalls
> index d4aa2358460c13945a8299b6513c93d35a5c5ea4..c6fc83aba2442cecfe918fb61d57bddf115b219a 100644
> --- a/tools/perf/arch/xtensa/entry/syscalls/Makefile.syscalls
> +++ b/tools/perf/arch/xtensa/entry/syscalls/Makefile.syscalls
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -syscall_abis_32  +=
> -syscalltbl = $(srctree)/tools/perf/arch/xtensa/entry/syscalls/syscall.tbl
> +syscall_abis_32_xtensa := $(syscall_abis_32)
> +syscalltbl_xtensa = $(srctree)/tools/perf/arch/xtensa/entry/syscalls/syscall.tbl
> diff --git a/tools/perf/arch/xtensa/include/syscall_table.h b/tools/perf/arch/xtensa/include/syscall_table.h
> index 4c942821662d95216765b176a84d5fc7974e1064..d43781b3ff523556fc208d6df9b041b50199453d 100644
> --- a/tools/perf/arch/xtensa/include/syscall_table.h
> +++ b/tools/perf/arch/xtensa/include/syscall_table.h
> @@ -1,2 +1,2 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#include <asm/syscalls_32.h>
> +#include <asm/syscalls_32_xtensa.h>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index d7c7d29291fbfe872d3ebaa888f3591addf39c31..fb3845c75db49e5d41c4b84d8bed5675442a6f88 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4292,6 +4292,8 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  		goto out_delete_evlist;
>  	}
>  
> +	trace->sctbl = syscalltbl__new(trace->host->env);
> +
>  	evlist__config(evlist, &trace->opts, &callchain_param);
>  
>  	if (forks) {
> @@ -5212,6 +5214,8 @@ int cmd_trace(int argc, const char **argv)
>  	char bf[BUFSIZ];
>  	struct sigaction sigchld_act;
>  
> +	printf("STARTING\n");
> +
>  	signal(SIGSEGV, sighandler_dump_stack);
>  	signal(SIGFPE, sighandler_dump_stack);
>  	signal(SIGINT, sighandler_interrupt);
> @@ -5222,9 +5226,8 @@ int cmd_trace(int argc, const char **argv)
>  	sigaction(SIGCHLD, &sigchld_act, NULL);
>  
>  	trace.evlist = evlist__new();
> -	trace.sctbl = syscalltbl__new();
>  
> -	if (trace.evlist == NULL || trace.sctbl == NULL) {
> +	if (trace.evlist == NULL) {
>  		pr_err("Not enough memory to run!\n");
>  		err = -ENOMEM;
>  		goto out;
> diff --git a/tools/perf/scripts/Makefile.syscalls b/tools/perf/scripts/Makefile.syscalls
> index 8bf55333262e400c2dc6a96ef59219d383b88dfe..789a237679ed28e830d7055acccd82e4b901a4d9 100644
> --- a/tools/perf/scripts/Makefile.syscalls
> +++ b/tools/perf/scripts/Makefile.syscalls
> @@ -7,16 +7,16 @@
>  PHONY := all
>  all:
>  
> -obj := $(OUTPUT)arch/$(SRCARCH)/include/generated/asm
> +obj := $(OUTPUT)arch/syscalls/include/generated/asm
>  
>  syscall_abis_32  := common,32
>  syscall_abis_64  := common,64
>  syscalltbl := $(srctree)/tools/scripts/syscall.tbl
>  
> -# let architectures override $(syscall_abis_%) and $(syscalltbl)
> --include $(srctree)/tools/perf/arch/$(SRCARCH)/entry/syscalls/Makefile.syscalls
> +# let architectures override $(syscall_abis_%) and $(syscalltbl_%)
> +-include $(srctree)/tools/perf/arch/*/entry/syscalls/Makefile.syscalls
>  include $(srctree)/tools/build/Build.include
> --include $(srctree)/tools/perf/arch/$(SRCARCH)/entry/syscalls/Kbuild
> +-include $(srctree)/tools/perf/arch/*/entry/syscalls/Kbuild
>  
>  systbl := $(srctree)/tools/perf/scripts/syscalltbl.sh
>  
> @@ -33,13 +33,21 @@ quiet_cmd_systbl = SYSTBL  $@
>        cmd_systbl = $(CONFIG_SHELL) $(systbl) \
>  		   $(if $(systbl-args-$*),$(systbl-args-$*),$(systbl-args)) \
>  		   --abis $(subst $(space),$(comma),$(strip $(syscall_abis_$*))) \
> -		   $< $@
> +		   $* $< $@
>  
> +# .SECONDEXPANSION here allows to correctly expand syscalltbl variables as
> +# prerequisites
> +.SECONDEXPANSION:
>  all: $(syscall-y)
>  	$(if $(unwanted),$(call cmd,remove))
>  	@:
>  
> -$(obj)/syscalls_%.h: $(syscalltbl) $(systbl) FORCE
> +get-arch = $(word 2,$(subst $(underscore),$(space),$1))
> +get-arch-syscalltbl = $(if $(syscalltbl_$(call get-arch,$1)),$(syscalltbl_$(call get-arch,$1)),$(syscalltbl))
> +
> +# .SECONDEXPANSION here allows to correctly expand syscalltbl variables as prerequisites
> +.SECONDEXPANSION:
> +$(obj)/syscalls_%.h: $$(call get-arch-syscalltbl,$*) $(systbl) FORCE
>  	$(call if_changed,systbl)
>  
>  targets := $(syscall-y)
> diff --git a/tools/perf/scripts/syscalltbl.sh b/tools/perf/scripts/syscalltbl.sh
> index 1ce0d5aa8b506427a66be50f0f441cf6e9705b33..bea35d717f96029fa001fb6a36fa2e9014992c90 100755
> --- a/tools/perf/scripts/syscalltbl.sh
> +++ b/tools/perf/scripts/syscalltbl.sh
> @@ -16,8 +16,9 @@
>  set -e
>  
>  usage() {
> -	echo >&2 "usage: $0 [--abis ABIS] INFILE OUTFILE" >&2
> +	echo >&2 "usage: $0 [--abis ABIS] ARCH INFILE OUTFILE" >&2
>  	echo >&2
> +	echo >&2 "  ARCH      arch syscall table belongs to"
>  	echo >&2 "  INFILE    input syscall table"
>  	echo >&2 "  OUTFILE   output header file"
>  	echo >&2
> @@ -43,12 +44,16 @@ do
>  	esac
>  done
>  
> -if [ $# -ne 2 ]; then
> +if [ $# -ne 3 ]; then
> +	echo $#
>  	usage
>  fi
>  
> -infile="$1"
> -outfile="$2"
> +arch="$1"
> +infile="$2"
> +outfile="$3"
> +
> +arch_upper=$(echo ${arch} | tr '[:lower:]' '[:upper:]')
>  
>  nxt=0
>  
> @@ -66,7 +71,7 @@ emit() {
>      syscall_macro "$nr" "$entry"
>  }
>  
> -echo "static const char *const syscalltbl[] = {" > $outfile
> +echo "static const char *const syscalltbl__${arch}[] = {" > $outfile
>  
>  sorted_table=$(mktemp /tmp/syscalltbl.XXXXXX)
>  grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | sort -n > $sorted_table
> @@ -83,4 +88,4 @@ rm -f $sorted_table
>  
>  echo "};" >> $outfile
>  
> -echo "#define SYSCALLTBL_MAX_ID ${max_nr}" >> $outfile
> +echo "#define SYSCALLTBL_MAX_ID__${arch_upper} ${max_nr}" >> $outfile
> diff --git a/tools/perf/trace/beauty/arch_syscall_names.c b/tools/perf/trace/beauty/arch_syscall_names.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..c72eba650f00036bf2558b5e8dc9ce60a68e9694
> --- /dev/null
> +++ b/tools/perf/trace/beauty/arch_syscall_names.c
> @@ -0,0 +1 @@
> +#include "trace/beauty/generated/arch_syscall_name_array.c"
> diff --git a/tools/perf/trace/beauty/arch_syscall_names.sh b/tools/perf/trace/beauty/arch_syscall_names.sh
> new file mode 100644
> index 0000000000000000000000000000000000000000..16bcdf87168ccc2b04fc8cfc85d452bcb9339f07
> --- /dev/null
> +++ b/tools/perf/trace/beauty/arch_syscall_names.sh
> @@ -0,0 +1,49 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Generate C file mapping syscalls numbers to syscall names.
> +#
> +# Copyright Rivos Inc. 2025
> +# Influenced by tools/perf/trace/beauty/arch_errno_names.sh
> +
> +outputdir="$1"
> +
> +create_arch_syscall_table_func()
> +{
> +	archlist="$1"
> +
> +	printf 'static struct syscalltbl_entry\n'
> +	printf 'arch_syscalls__names_function(const char *arch)\n'
> +	printf '{\n'
> +	for arch in $archlist; do
> +		printf '\tif (!strcmp(arch, "%s"))\n' "$arch"
> +		printf '\t\treturn (struct syscalltbl_entry){ SYSCALLTBL_MAX_ID__'
> +		printf '%s' "$arch" | tr '[:lower:]' '[:upper:]'
> +		printf ', syscalltbl__%s };\n' "$arch"
> +	done
> +	printf '\treturn (struct syscalltbl_entry){ 0 };\n'
> +	printf '}\n'
> +}
> +
> +cat <<EoHEADER
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include "syscalltbl.h"
> +
> +#include <string.h>
> +
> +EoHEADER
> +
> +# Create list of architectures that use a syscall table
> +archlist=""
> +for f in ${outputdir}arch/syscalls/include/generated/asm/syscalls_*; do
> +	d="${f##*/syscalls_}"
> +	arch=${d%.h}
> +	test -f ${outputdir}arch/syscalls/include/generated/asm/syscalls_${arch}.h && archlist="$archlist $arch"
> +done
> +
> +for arch in $archlist; do
> +	printf '#include <asm/syscalls_%s.h>\n' "$arch"
> +done
> +printf '\n'
> +create_arch_syscall_table_func "$archlist"
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index cae4f6d63318f365609c9f6d2b5b9b15d13d234e..067f6b020252771d870aedcd34606c481d27a3c7 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -465,7 +465,7 @@ static const char *normalize_arch(char *arch)
>  	return arch;
>  }
>  
> -const char *perf_env__arch(struct perf_env *env)
> +static char *perf_env__arch_helper(struct perf_env *env)
>  {
>  	char *arch_name;
>  
> @@ -477,7 +477,69 @@ const char *perf_env__arch(struct perf_env *env)
>  	} else
>  		arch_name = env->arch;
>  
> -	return normalize_arch(arch_name);
> +	return arch_name;
> +}
> +
> +const char *perf_env__arch(struct perf_env *env)
> +{
> +	return normalize_arch(perf_env__arch_helper(env));
> +}
> +
> +/*
> + * Return architecture with number of bits in a normalized form.
> + */
> +static const char *normalize_arch_bits(char *arch)
> +{
> +	if (!strcmp(arch, "alpha"))
> +		return "64_alpha";
> +	if (!strncmp(arch, "arc", 3))
> +		return "32_arc";
> +	if (!strncmp(arch, "aarch64", 7) || !strncmp(arch, "arm64", 5))
> +		return "64_arm64";
> +	if (!strcmp(arch, "arm"))
> +		return "32_arm";
> +	if (!strcmp(arch, "csky"))
> +		return "32_csky";
> +	if (!strncmp(arch, "loongarch", 9))
> +		return "64_loongarch";
> +	if (!strncmp(arch, "mips", 4))
> +		return "64_mips";
> +	if (!strcmp(arch, "parisc64"))
> +		return "64_parisc";
> +	if (!strcmp(arch, "parisc"))
> +		return "32_parisc";
> +	if (!strncmp(arch, "powerpc64", 9) || !strncmp(arch, "ppc64", 5))
> +		return "64_powerpc";
> +	if (!strncmp(arch, "powerpc", 7) || !strncmp(arch, "ppc", 3))
> +		return "32_powerpc";
> +	if (!strncmp(arch, "riscv64", 7))
> +		return "64_riscv";
> +	if (!strncmp(arch, "riscv32", 7))
> +		return "32_riscv";
> +	if (!strncmp(arch, "s390", 4))
> +		return "32_s390";
> +	if (!strncmp(arch, "sh", 2) && isdigit(arch[2]))
> +		return "32_sh";
> +	if (!strcmp(arch, "sun4u") || !strncmp(arch, "sparc64", 7))
> +		return "64_sparc";
> +	if (!strncmp(arch, "sparc", 5))
> +		return "32_sparc";
> +	if (!strcmp(arch, "x86_64"))
> +		return "64_x86";
> +	if (arch[0] == 'i' && arch[2] == '8' && arch[3] == '6')
> +		return "32_x86";
> +	if (!strncmp(arch, "xtensa", 6))
> +		return "32_xtensa";
> +
> +	return "";
> +}
> +
> +/*
> + * Get arch prefixed with 32_ or 64_ depending on what is appropriate
> + */
> +const char *perf_env__arch_bits(struct perf_env *env)
> +{
> +	return normalize_arch_bits(perf_env__arch_helper(env));
>  }
>  
>  #if defined(HAVE_LIBTRACEEVENT)
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index d90e343cf1fa5a661fdae651f24e02345371a2aa..37b3c83b4c6a8d3d01173df6bdbb687096c8be60 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -168,6 +168,7 @@ int perf_env__read_cpu_topology_map(struct perf_env *env);
>  void cpu_cache_level__free(struct cpu_cache_level *cache);
>  
>  const char *perf_env__arch(struct perf_env *env);
> +const char *perf_env__arch_bits(struct perf_env *env);
>  const char *perf_env__arch_strerrno(struct perf_env *env, int err);
>  const char *perf_env__cpuid(struct perf_env *env);
>  const char *perf_env__raw_arch(struct perf_env *env);
> diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
> index 928aca4cd6e9f2f26c5c4fd825b4538c064a4cc3..326eeea4585a6bd40c2bbce6cc968757114def52 100644
> --- a/tools/perf/util/syscalltbl.c
> +++ b/tools/perf/util/syscalltbl.c
> @@ -5,7 +5,9 @@
>   * (C) 2016 Arnaldo Carvalho de Melo <acme@redhat.com>
>   */
>  
> +
>  #include "syscalltbl.h"
> +#include "trace/beauty/arch_syscall_names.c"
>  #include <stdlib.h>
>  #include <linux/compiler.h>
>  #include <linux/zalloc.h>
> @@ -13,9 +15,9 @@
>  #include <string.h>
>  #include "string2.h"
>  
> -#include <syscall_table.h>
> -const int syscalltbl_native_max_id = SYSCALLTBL_MAX_ID;
> -static const char *const *syscalltbl_native = syscalltbl;
> +bool initialized;
> +int syscalltbl_native_max_id;
> +static const char *const *syscalltbl_native;
>  
>  struct syscall {
>  	int id;
> @@ -64,22 +66,32 @@ static int syscalltbl__init_native(struct syscalltbl *tbl)
>  	return 0;
>  }
>  
> -struct syscalltbl *syscalltbl__new(void)
> +struct syscalltbl *syscalltbl__new(struct perf_env *env)
>  {
>  	struct syscalltbl *tbl = malloc(sizeof(*tbl));
> -	if (tbl) {
> +	struct syscalltbl_entry arch_syscalls__names;
> +
> +	arch_syscalls__names = arch_syscalls__names_function(perf_env__arch_bits(env));
> +
> +	if (tbl && arch_syscalls__names.max_id > 0) {
> +		syscalltbl_native_max_id = arch_syscalls__names.max_id;
> +		syscalltbl_native = arch_syscalls__names.entries;
>  		if (syscalltbl__init_native(tbl)) {
>  			free(tbl);
>  			return NULL;
>  		}
> +
> +		initialized = true;
>  	}
>  	return tbl;
>  }
>  
>  void syscalltbl__delete(struct syscalltbl *tbl)
>  {
> -	zfree(&tbl->syscalls.entries);
> -	free(tbl);
> +	if (initialized) {
> +		zfree(&tbl->syscalls.entries);
> +		free(tbl);
> +	}
>  }
>  
>  const char *syscalltbl__name(const struct syscalltbl *tbl __maybe_unused, int id)
> diff --git a/tools/perf/util/syscalltbl.h b/tools/perf/util/syscalltbl.h
> index 362411a6d849b1f67ec54b34345364c04ad90f89..80a2b28b5e94b8ff3e0111495f54b9c88372efbe 100644
> --- a/tools/perf/util/syscalltbl.h
> +++ b/tools/perf/util/syscalltbl.h
> @@ -2,6 +2,8 @@
>  #ifndef __PERF_SYSCALLTBL_H
>  #define __PERF_SYSCALLTBL_H
>  
> +#include "env.h"
> +
>  struct syscalltbl {
>  	struct {
>  		int max_id;
> @@ -10,7 +12,12 @@ struct syscalltbl {
>  	} syscalls;
>  };
>  
> -struct syscalltbl *syscalltbl__new(void);
> +struct syscalltbl_entry {
> +	int max_id;
> +	const char *const *entries;
> +};
> +
> +struct syscalltbl *syscalltbl__new(struct perf_env *env);
>  void syscalltbl__delete(struct syscalltbl *tbl);
>  
>  const char *syscalltbl__name(const struct syscalltbl *tbl, int id);
> 
> ---
> base-commit: ac0ac75189a4d6a29a2765a7adbb62bc6cc650c7
> change-id: 20250110-perf_syscall_arch_runtime-ffe669595a18
> -- 
> - Charlie
> 
