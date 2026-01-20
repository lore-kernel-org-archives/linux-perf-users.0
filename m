Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245ED3271E8;
	Tue, 20 Jan 2026 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924949; cv=none; b=eN6U609rbbGBaKG/dL3EnaFwW3dnoEKH8YPXSbAT9/csEovTDMALdJlf5piOUiKU7EZ/+3v98Uc2mwA1vfW/MiPdHCCZuHl9V8fyRHk2Pxu/Q7DBKUgeJ76m3A7BBqWv9QWXzKrkOQoOjV2QshM6flsefqOvBvKJj5+eq+rCXd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924949; c=relaxed/simple;
	bh=POp9Br/GjY16pFxIky7ybA0oF8vk9z23j4qQDzK/ZPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rbvkq+otn8mULog/58PYlTdeuUCbTTsF8weGxlELMex7eTpu/+dQXY9TKOZ6somWaUl4DOgwDvqRIoo11u45u+ZLYVAumSAN3ZROn5q3JCKBgpNK7ucnO7PlFKnX17mI7keuEjIa6P2ITLiMQESxMCNCdXndpqc10FxSLIm+GW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myzua1S2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myzua1S2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B2FC16AAE;
	Tue, 20 Jan 2026 16:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768924948;
	bh=POp9Br/GjY16pFxIky7ybA0oF8vk9z23j4qQDzK/ZPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=myzua1S23JzBeptV8QD4lcLJ/dk9AOp8TFuoFlSmMhHmHuo6iwvgdlymAJ3du2hup
	 dxfQS1AJ9c59OAHn5NDY/LM69XT7OeljnQgiVi7D7SzIkLB0W4rRDANmBPzw2JfaTH
	 x+VNQ5l6MauRD0lJBzwghDKg4EDh9P341gBR27B9m0iniX/4H57IKQ6H9m4M1XDO0H
	 Df8kquc3rdTbugqtMIHDwA9VlRtjrBBBrd3N/gNM6dgODNMkjur4MwaeCZLdfCQFqS
	 SuKgITKW1Z/84qrJj67UFH1ijJA78dRteRtACWK7BS0UfhLun4f+v//xeikRxzfLzi
	 9nXJeIyumG7AA==
Date: Tue, 20 Jan 2026 13:02:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Shimin Guo <shimin.guo@skydio.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Howard Chu <howardchu95@gmail.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Aditya Bodkhe <aditya.b1@linux.ibm.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-riscv@lists.infradead.org, Mark Wielaard <mark@klomp.org>
Subject: Re: [PATCH v1 04/23] perf unwind-libdw: fix a cross-arch unwinding
 bug
Message-ID: <aW-nEbT9iPF06CwY@x1>
References: <20260117052849.2205545-1-irogers@google.com>
 <20260117052849.2205545-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260117052849.2205545-5-irogers@google.com>

On Fri, Jan 16, 2026 at 09:28:30PM -0800, Ian Rogers wrote:
> From: Shimin Guo <shimin.guo@skydio.com>
> 
> The set_initial_registers field of Dwfl_Thread_Callbacks needs to be set
> according to the arch of the stack samples being analyzed, not the arch
> that perf itself is built for. Currently perf fails to unwind stack samples
> collected from archs different from that of the host perf is running on.
> This patch moves the arch-specific implementations of set_initial_registers
> from tools/perf/arch to tools/perf/utli/unwind-libdw-arch, similar to the
> way the perf-regs-arch folder contains arch-specific functions related to
> registers, and chooses the implementation based on the arch of the data
> being processed.

Since this one is coming thru you, we need your:

Signed-off-by: Ian Rogers <irogers@google.com>

Ok?

I'm adding it here, please ack.

- Arnaldo
 
> Signed-off-by: Shimin Guo <shimin.guo@skydio.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/arch/arm/util/Build                |  1 -
>  tools/perf/arch/arm64/util/Build              |  1 -
>  tools/perf/arch/csky/util/Build               |  2 -
>  tools/perf/arch/powerpc/util/Build            |  1 -
>  tools/perf/arch/riscv/util/Build              |  1 -
>  tools/perf/arch/s390/util/Build               |  2 -
>  tools/perf/arch/x86/util/Build                |  1 -
>  tools/perf/util/Build                         |  1 +
>  tools/perf/util/unwind-libdw-arch/Build       |  8 +++
>  .../unwind-libdw-arch/unwind-libdw-arm.c}     | 10 ++--
>  .../unwind-libdw-arch/unwind-libdw-arm64.c}   | 10 ++--
>  .../unwind-libdw-arch/unwind-libdw-csky.c}    | 10 ++--
>  .../unwind-libdw-loongarch.c}                 | 10 ++--
>  .../unwind-libdw-arch/unwind-libdw-powerpc.c} | 10 ++--
>  .../unwind-libdw-arch/unwind-libdw-riscv.c}   | 10 ++--
>  .../unwind-libdw-arch/unwind-libdw-s390.c}    | 14 ++---
>  .../unwind-libdw-arch/unwind-libdw-x86.c}     |  8 +--
>  tools/perf/util/unwind-libdw.c                | 51 ++++++++++++++++---
>  tools/perf/util/unwind-libdw.h                | 10 +++-
>  19 files changed, 104 insertions(+), 57 deletions(-)
>  create mode 100644 tools/perf/util/unwind-libdw-arch/Build
>  rename tools/perf/{arch/arm/util/unwind-libdw.c => util/unwind-libdw-arch/unwind-libdw-arm.c} (80%)
>  rename tools/perf/{arch/arm64/util/unwind-libdw.c => util/unwind-libdw-arch/unwind-libdw-arm64.c} (87%)
>  rename tools/perf/{arch/csky/util/unwind-libdw.c => util/unwind-libdw-arch/unwind-libdw-csky.c} (90%)
>  rename tools/perf/{arch/loongarch/util/unwind-libdw.c => util/unwind-libdw-arch/unwind-libdw-loongarch.c} (86%)
>  rename tools/perf/{arch/powerpc/util/unwind-libdw.c => util/unwind-libdw-arch/unwind-libdw-powerpc.c} (89%)
>  rename tools/perf/{arch/riscv/util/unwind-libdw.c => util/unwind-libdw-arch/unwind-libdw-riscv.c} (87%)
>  rename tools/perf/{arch/s390/util/unwind-libdw.c => util/unwind-libdw-arch/unwind-libdw-s390.c} (84%)
>  rename tools/perf/{arch/x86/util/unwind-libdw.c => util/unwind-libdw-arch/unwind-libdw-x86.c} (87%)
> 
> diff --git a/tools/perf/arch/arm/util/Build b/tools/perf/arch/arm/util/Build
> index fd695e1fdaee..3291f893b943 100644
> --- a/tools/perf/arch/arm/util/Build
> +++ b/tools/perf/arch/arm/util/Build
> @@ -1,6 +1,5 @@
>  perf-util-y += perf_regs.o
>  
>  perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
> -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
>  
>  perf-util-y += pmu.o auxtrace.o cs-etm.o
> diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
> index d63881081d2e..0177af19cc00 100644
> --- a/tools/perf/arch/arm64/util/Build
> +++ b/tools/perf/arch/arm64/util/Build
> @@ -1,4 +1,3 @@
> -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
>  perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
>  perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
>  perf-util-y += ../../arm/util/auxtrace.o
> diff --git a/tools/perf/arch/csky/util/Build b/tools/perf/arch/csky/util/Build
> index 5e6ea82c4202..6b2d0e021b11 100644
> --- a/tools/perf/arch/csky/util/Build
> +++ b/tools/perf/arch/csky/util/Build
> @@ -1,3 +1 @@
>  perf-util-y += perf_regs.o
> -
> -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
> diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
> index 3d0d5427aef7..5fd28ec713a4 100644
> --- a/tools/perf/arch/powerpc/util/Build
> +++ b/tools/perf/arch/powerpc/util/Build
> @@ -9,5 +9,4 @@ perf-util-y += evsel.o
>  perf-util-$(CONFIG_LIBDW) += skip-callchain-idx.o
>  
>  perf-util-$(CONFIG_LIBUNWIND) += unwind-libunwind.o
> -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
>  perf-util-y += auxtrace.o
> diff --git a/tools/perf/arch/riscv/util/Build b/tools/perf/arch/riscv/util/Build
> index 58a672246024..628b9ebd418b 100644
> --- a/tools/perf/arch/riscv/util/Build
> +++ b/tools/perf/arch/riscv/util/Build
> @@ -2,4 +2,3 @@ perf-util-y += perf_regs.o
>  perf-util-y += header.o
>  
>  perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
> -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
> diff --git a/tools/perf/arch/s390/util/Build b/tools/perf/arch/s390/util/Build
> index c64eb18dbdae..5391d26fedd4 100644
> --- a/tools/perf/arch/s390/util/Build
> +++ b/tools/perf/arch/s390/util/Build
> @@ -2,8 +2,6 @@ perf-util-y += header.o
>  perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
>  perf-util-y += perf_regs.o
>  
> -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
> -
>  perf-util-y += machine.o
>  perf-util-y += pmu.o
>  
> diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
> index c0dc5965f362..fad256252bb9 100644
> --- a/tools/perf/arch/x86/util/Build
> +++ b/tools/perf/arch/x86/util/Build
> @@ -12,7 +12,6 @@ perf-util-y += evsel.o
>  perf-util-y += iostat.o
>  
>  perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
> -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
>  
>  perf-util-y += auxtrace.o
>  perf-util-y += archinsn.o
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 4915f237ba9e..5efec73be474 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -227,6 +227,7 @@ perf-util-$(CONFIG_LIBDW) += annotate-data.o
>  perf-util-$(CONFIG_LIBDW) += libdw.o
>  
>  perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
> +perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw-arch/
>  perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind-local.o
>  perf-util-$(CONFIG_LIBUNWIND)          += unwind-libunwind.o
>  perf-util-$(CONFIG_LIBUNWIND_X86)      += libunwind/x86_32.o
> diff --git a/tools/perf/util/unwind-libdw-arch/Build b/tools/perf/util/unwind-libdw-arch/Build
> new file mode 100644
> index 000000000000..ef17a83a7813
> --- /dev/null
> +++ b/tools/perf/util/unwind-libdw-arch/Build
> @@ -0,0 +1,8 @@
> +perf-util-y += unwind-libdw-x86.o
> +perf-util-y += unwind-libdw-arm.o
> +perf-util-y += unwind-libdw-arm64.o
> +perf-util-y += unwind-libdw-csky.o
> +perf-util-y += unwind-libdw-loongarch.o
> +perf-util-y += unwind-libdw-powerpc.o
> +perf-util-y += unwind-libdw-riscv.o
> +perf-util-y += unwind-libdw-s390.o
> diff --git a/tools/perf/arch/arm/util/unwind-libdw.c b/tools/perf/util/unwind-libdw-arch/unwind-libdw-arm.c
> similarity index 80%
> rename from tools/perf/arch/arm/util/unwind-libdw.c
> rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-arm.c
> index fbb643f224ec..56e9b5975bcc 100644
> --- a/tools/perf/arch/arm/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-arm.c
> @@ -1,11 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <elfutils/libdwfl.h>
> -#include "perf_regs.h"
> -#include "../../../util/unwind-libdw.h"
> -#include "../../../util/perf_regs.h"
> -#include "../../../util/sample.h"
> +#include "../arch/arm/include/uapi/asm/perf_regs.h"
> +#include "util/unwind-libdw.h"
> +#include "util/perf_regs.h"
> +#include "util/sample.h"
>  
> -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> +bool libdw_set_initial_registers_arm(Dwfl_Thread *thread, void *arg)
>  {
>  	struct unwind_info *ui = arg;
>  	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
> diff --git a/tools/perf/arch/arm64/util/unwind-libdw.c b/tools/perf/util/unwind-libdw-arch/unwind-libdw-arm64.c
> similarity index 87%
> rename from tools/perf/arch/arm64/util/unwind-libdw.c
> rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-arm64.c
> index b89b0a7e5ad9..29b6833e036c 100644
> --- a/tools/perf/arch/arm64/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-arm64.c
> @@ -1,11 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <elfutils/libdwfl.h>
> -#include "perf_regs.h"
> -#include "../../../util/unwind-libdw.h"
> -#include "../../../util/perf_regs.h"
> -#include "../../../util/sample.h"
> +#include "../arch/arm64/include/uapi/asm/perf_regs.h"
> +#include "util/unwind-libdw.h"
> +#include "util/perf_regs.h"
> +#include "util/sample.h"
>  
> -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> +bool libdw_set_initial_registers_arm64(Dwfl_Thread *thread, void *arg)
>  {
>  	struct unwind_info *ui = arg;
>  	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
> diff --git a/tools/perf/arch/csky/util/unwind-libdw.c b/tools/perf/util/unwind-libdw-arch/unwind-libdw-csky.c
> similarity index 90%
> rename from tools/perf/arch/csky/util/unwind-libdw.c
> rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-csky.c
> index b20b1569783d..2556d034c32a 100644
> --- a/tools/perf/arch/csky/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-csky.c
> @@ -2,12 +2,12 @@
>  // Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
>  
>  #include <elfutils/libdwfl.h>
> -#include "perf_regs.h"
> -#include "../../util/unwind-libdw.h"
> -#include "../../util/perf_regs.h"
> -#include "../../util/event.h"
> +#include "../arch/csky/include/uapi/asm/perf_regs.h"
> +#include "util/unwind-libdw.h"
> +#include "util/perf_regs.h"
> +#include "util/sample.h"
>  
> -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> +bool libdw_set_initial_registers_csky(Dwfl_Thread *thread, void *arg)
>  {
>  	struct unwind_info *ui = arg;
>  	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
> diff --git a/tools/perf/arch/loongarch/util/unwind-libdw.c b/tools/perf/util/unwind-libdw-arch/unwind-libdw-loongarch.c
> similarity index 86%
> rename from tools/perf/arch/loongarch/util/unwind-libdw.c
> rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-loongarch.c
> index 60b1144bedd5..5fca673508be 100644
> --- a/tools/perf/arch/loongarch/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-loongarch.c
> @@ -2,12 +2,12 @@
>  /* Copyright (C) 2020-2023 Loongson Technology Corporation Limited */
>  
>  #include <elfutils/libdwfl.h>
> -#include "perf_regs.h"
> -#include "../../util/unwind-libdw.h"
> -#include "../../util/perf_regs.h"
> -#include "../../util/sample.h"
> +#include "../arch/loongarch/include/uapi/asm/perf_regs.h"
> +#include "util/unwind-libdw.h"
> +#include "util/perf_regs.h"
> +#include "util/sample.h"
>  
> -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> +bool libdw_set_initial_registers_loongarch(Dwfl_Thread *thread, void *arg)
>  {
>  	struct unwind_info *ui = arg;
>  	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
> diff --git a/tools/perf/arch/powerpc/util/unwind-libdw.c b/tools/perf/util/unwind-libdw-arch/unwind-libdw-powerpc.c
> similarity index 89%
> rename from tools/perf/arch/powerpc/util/unwind-libdw.c
> rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-powerpc.c
> index 82d0c28ae345..1560db45e7b4 100644
> --- a/tools/perf/arch/powerpc/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-powerpc.c
> @@ -1,10 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <elfutils/libdwfl.h>
>  #include <linux/kernel.h>
> -#include "perf_regs.h"
> -#include "../../../util/unwind-libdw.h"
> -#include "../../../util/perf_regs.h"
> -#include "../../../util/sample.h"
> +#include "../arch/powerpc/include/uapi/asm/perf_regs.h"
> +#include "util/unwind-libdw.h"
> +#include "util/perf_regs.h"
> +#include "util/sample.h"
>  
>  /* See backends/ppc_initreg.c and backends/ppc_regs.c in elfutils.  */
>  static const int special_regs[3][2] = {
> @@ -13,7 +13,7 @@ static const int special_regs[3][2] = {
>  	{ 109, PERF_REG_POWERPC_CTR },
>  };
>  
> -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> +bool libdw_set_initial_registers_powerpc(Dwfl_Thread *thread, void *arg)
>  {
>  	struct unwind_info *ui = arg;
>  	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
> diff --git a/tools/perf/arch/riscv/util/unwind-libdw.c b/tools/perf/util/unwind-libdw-arch/unwind-libdw-riscv.c
> similarity index 87%
> rename from tools/perf/arch/riscv/util/unwind-libdw.c
> rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-riscv.c
> index dc1476e16321..c2e2c4b6b2e0 100644
> --- a/tools/perf/arch/riscv/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-riscv.c
> @@ -2,12 +2,12 @@
>  /* Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd. */
>  
>  #include <elfutils/libdwfl.h>
> -#include "perf_regs.h"
> -#include "../../util/unwind-libdw.h"
> -#include "../../util/perf_regs.h"
> -#include "../../util/sample.h"
> +#include "../arch/riscv/include/uapi/asm/perf_regs.h"
> +#include "util/unwind-libdw.h"
> +#include "util/perf_regs.h"
> +#include "util/sample.h"
>  
> -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> +bool libdw_set_initial_registers_riscv(Dwfl_Thread *thread, void *arg)
>  {
>  	struct unwind_info *ui = arg;
>  	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
> diff --git a/tools/perf/arch/s390/util/unwind-libdw.c b/tools/perf/util/unwind-libdw-arch/unwind-libdw-s390.c
> similarity index 84%
> rename from tools/perf/arch/s390/util/unwind-libdw.c
> rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-s390.c
> index c27c7a0d1076..1e05e9d9d95f 100644
> --- a/tools/perf/arch/s390/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-s390.c
> @@ -1,14 +1,14 @@
>  #include <linux/kernel.h>
>  #include <elfutils/libdwfl.h>
> -#include "../../util/unwind-libdw.h"
> -#include "../../util/perf_regs.h"
> -#include "../../util/event.h"
> -#include "../../util/sample.h"
> -#include "dwarf-regs-table.h"
> -#include "perf_regs.h"
> +#include "util/unwind-libdw.h"
> +#include "util/perf_regs.h"
> +#include "util/event.h"
> +#include "util/sample.h"
> +#include "../arch/s390/include/dwarf-regs-table.h"
> +#include "../arch/s390/include/uapi/asm/perf_regs.h"
>  
>  
> -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> +bool libdw_set_initial_registers_s390(Dwfl_Thread *thread, void *arg)
>  {
>  	struct unwind_info *ui = arg;
>  	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
> diff --git a/tools/perf/arch/x86/util/unwind-libdw.c b/tools/perf/util/unwind-libdw-arch/unwind-libdw-x86.c
> similarity index 87%
> rename from tools/perf/arch/x86/util/unwind-libdw.c
> rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-x86.c
> index 798493e887d7..dd27545a4a68 100644
> --- a/tools/perf/arch/x86/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-x86.c
> @@ -1,11 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <elfutils/libdwfl.h>
> -#include "perf_regs.h"
> -#include "../../../util/unwind-libdw.h"
> -#include "../../../util/perf_regs.h"
> +#include "../arch/x86/include/uapi/asm/perf_regs.h"
> +#include "util/unwind-libdw.h"
> +#include "util/perf_regs.h"
>  #include "util/sample.h"
>  
> -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> +bool libdw_set_initial_registers_x86(Dwfl_Thread *thread, void *arg)
>  {
>  	struct unwind_info *ui = arg;
>  	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
> index 3ff427a49e4c..b2e194a8be39 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
> @@ -225,11 +225,45 @@ static bool memory_read(Dwfl *dwfl __maybe_unused, Dwarf_Addr addr, Dwarf_Word *
>  	return true;
>  }
>  
> -static const Dwfl_Thread_Callbacks callbacks = {
> -	.next_thread		= next_thread,
> -	.memory_read		= memory_read,
> -	.set_initial_registers	= libdw__arch_set_initial_registers,
> -};
> +#define DEFINE_DWFL_THREAD_CALLBACKS(arch)                           \
> +static const Dwfl_Thread_Callbacks callbacks_##arch = {              \
> +	.next_thread           = next_thread,                        \
> +	.memory_read           = memory_read,                        \
> +	.set_initial_registers = libdw_set_initial_registers_##arch, \
> +}
> +
> +DEFINE_DWFL_THREAD_CALLBACKS(x86);
> +DEFINE_DWFL_THREAD_CALLBACKS(arm);
> +DEFINE_DWFL_THREAD_CALLBACKS(arm64);
> +DEFINE_DWFL_THREAD_CALLBACKS(csky);
> +DEFINE_DWFL_THREAD_CALLBACKS(loongarch);
> +DEFINE_DWFL_THREAD_CALLBACKS(powerpc);
> +DEFINE_DWFL_THREAD_CALLBACKS(riscv);
> +DEFINE_DWFL_THREAD_CALLBACKS(s390);
> +
> +static const Dwfl_Thread_Callbacks *get_thread_callbacks(const char *arch)
> +{
> +	if (!strcmp(arch, "arm"))
> +		return &callbacks_arm;
> +	else if (!strcmp(arch, "arm64"))
> +		return &callbacks_arm64;
> +	else if (!strcmp(arch, "csky"))
> +		return &callbacks_csky;
> +	else if (!strcmp(arch, "loongarch"))
> +		return &callbacks_loongarch;
> +	else if (!strcmp(arch, "powerpc"))
> +		return &callbacks_powerpc;
> +	else if (!strcmp(arch, "riscv"))
> +		return &callbacks_riscv;
> +	else if (!strcmp(arch, "s390"))
> +		return &callbacks_s390;
> +	else if (!strcmp(arch, "x86"))
> +		return &callbacks_x86;
> +
> +	pr_err("Fail to get thread callbacks for arch %s, returns NULL\n",
> +	       arch);
> +	return NULL;
> +}
>  
>  static int
>  frame_callback(Dwfl_Frame *state, void *arg)
> @@ -278,6 +312,7 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
>  	const char *arch = perf_env__arch(ui_buf.machine->env);
>  	Dwarf_Word ip;
>  	int err = -EINVAL, i;
> +	const Dwfl_Thread_Callbacks *callbacks;
>  
>  	if (!data->user_regs || !data->user_regs->regs)
>  		return -EINVAL;
> @@ -300,7 +335,11 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
>  	if (err)
>  		goto out;
>  
> -	err = !dwfl_attach_state(ui->dwfl, EM_NONE, thread__tid(thread), &callbacks, ui);
> +	callbacks = get_thread_callbacks(arch);
> +	if (!callbacks)
> +		goto out;
> +
> +	err = !dwfl_attach_state(ui->dwfl, EM_NONE, thread__tid(thread), callbacks, ui);
>  	if (err)
>  		goto out;
>  
> diff --git a/tools/perf/util/unwind-libdw.h b/tools/perf/util/unwind-libdw.h
> index 8c88bc4f2304..574b29848cce 100644
> --- a/tools/perf/util/unwind-libdw.h
> +++ b/tools/perf/util/unwind-libdw.h
> @@ -9,7 +9,15 @@ struct machine;
>  struct perf_sample;
>  struct thread;
>  
> -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg);
> +bool libdw_set_initial_registers_x86(Dwfl_Thread *thread, void *arg);
> +bool libdw_set_initial_registers_arm(Dwfl_Thread *thread, void *arg);
> +bool libdw_set_initial_registers_arm64(Dwfl_Thread *thread, void *arg);
> +bool libdw_set_initial_registers_csky(Dwfl_Thread *thread, void *arg);
> +bool libdw_set_initial_registers_loongarch(Dwfl_Thread *thread, void *arg);
> +bool libdw_set_initial_registers_mips(Dwfl_Thread *thread, void *arg);
> +bool libdw_set_initial_registers_powerpc(Dwfl_Thread *thread, void *arg);
> +bool libdw_set_initial_registers_riscv(Dwfl_Thread *thread, void *arg);
> +bool libdw_set_initial_registers_s390(Dwfl_Thread *thread, void *arg);
>  
>  struct unwind_info {
>  	Dwfl			*dwfl;
> -- 
> 2.52.0.457.g6b5491de43-goog
> 
