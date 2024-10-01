Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ABA19CC39;
	Tue,  1 Oct 2024 22:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727822351; cv=none; b=JQZYmLiKWcvPCDLroHxrPe9yhgmuQjXOLgadKAkLayTzn78ovlnylJNNsJkv/8ABRGlBAPcfZQNEyXnG7iOzShJBsm/tnR6sMrNRnhA+UGBFkdumCY4IR2CTwbNOLK6apZijc8/xYArmVB4/deWZlCfNBOwjaHV4X/Gft9achyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727822351; c=relaxed/simple;
	bh=AuF3Q5Q3aFrmwZkQzMiLFY883MDDaBi/bB8CTk4XWdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuVb/RcNTrQEo4i2Z99te2oBJeVrC++kVmYkr37WuzNN8acatY9jaSbvWi7ga7b4hGNsH2ibRNBT6hZn81OEWNig76pB3JqEWdb5smQdIhs/yjbaggigxeONWBaqm4qMUDjKEMJDLLBZkai4jEI3TWXPV5pCEc0UCfd/aUWSoLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeJMeJRj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeJMeJRj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC61C4CEC6;
	Tue,  1 Oct 2024 22:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727822350;
	bh=AuF3Q5Q3aFrmwZkQzMiLFY883MDDaBi/bB8CTk4XWdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FeJMeJRjaaWDHaFTpBcVNnuD+Ru4WQCusli39GJKM33FxS5JqXHoG7zFd525zBMZ+
	 y+Yvwp68HbM9jwqn0pQqbK/dfHAjC7uZilD8/CRFmtXK08hdXmk6lnqTO5RTADHT1b
	 Jl9eu9vl/pjijiciJGVsfdZyIOgf3LcSkQVKyWq+DfOCpop3Nv4BogwSfP56YR9zdg
	 d6yT5eyetKevVWb5k1vx2Ml73SezAqWAm4uULbeDduxifNv/8PlBpUCEl84QEUaiJK
	 ASZgDr6jqB8Tzigc8XyHLUQ/DKae6u16ZLRSTEbQb0Ha/IyN68cU6YpqAt3oy6iYy1
	 KooKDTkGgsICg==
Date: Tue, 1 Oct 2024 15:39:08 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCH 6/8] perf tools: Move x86__is_amd_cpu() to util/env.c
Message-ID: <Zvx6DA9w6tI__QQU@google.com>
References: <20241001002027.1272889-1-namhyung@kernel.org>
 <20241001002027.1272889-7-namhyung@kernel.org>
 <489f89cd-ce61-4d40-84b0-755a1da4249c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <489f89cd-ce61-4d40-84b0-755a1da4249c@linux.intel.com>

On Tue, Oct 01, 2024 at 12:03:29PM -0400, Liang, Kan wrote:
> 
> 
> On 2024-09-30 8:20 p.m., Namhyung Kim wrote:
> > It can be called from non-x86 platform so let's move it to the general
> > util directory.  Also add a new helper perf_env__is_x86_amd_cpu() so
> > that it can be called with an existing perf_env as well.
> > 
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/arch/x86/util/Build |  1 -
> >  tools/perf/arch/x86/util/env.c | 19 -------------------
> >  tools/perf/arch/x86/util/env.h |  7 -------
> >  tools/perf/arch/x86/util/pmu.c |  2 +-
> >  tools/perf/util/env.c          | 24 ++++++++++++++++++++++++
> >  tools/perf/util/env.h          |  4 ++++
> >  6 files changed, 29 insertions(+), 28 deletions(-)
> >  delete mode 100644 tools/perf/arch/x86/util/env.c
> >  delete mode 100644 tools/perf/arch/x86/util/env.h
> > 
> > diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
> > index 2607ed5c42966543..ce6d802a1381c5ab 100644
> > --- a/tools/perf/arch/x86/util/Build
> > +++ b/tools/perf/arch/x86/util/Build
> > @@ -10,7 +10,6 @@ perf-util-y += evlist.o
> >  perf-util-y += mem-events.o
> >  perf-util-y += evsel.o
> >  perf-util-y += iostat.o
> > -perf-util-y += env.o
> >  
> >  perf-util-$(CONFIG_DWARF) += dwarf-regs.o
> >  perf-util-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
> > diff --git a/tools/perf/arch/x86/util/env.c b/tools/perf/arch/x86/util/env.c
> > deleted file mode 100644
> > index 3e537ffb1353aab2..0000000000000000
> > --- a/tools/perf/arch/x86/util/env.c
> > +++ /dev/null
> > @@ -1,19 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -#include "linux/string.h"
> > -#include "util/env.h"
> > -#include "env.h"
> > -
> > -bool x86__is_amd_cpu(void)
> > -{
> > -	struct perf_env env = { .total_mem = 0, };
> > -	static int is_amd; /* 0: Uninitialized, 1: Yes, -1: No */
> > -
> > -	if (is_amd)
> > -		goto ret;
> > -
> > -	perf_env__cpuid(&env);
> > -	is_amd = env.cpuid && strstarts(env.cpuid, "AuthenticAMD") ? 1 : -1;
> > -	perf_env__exit(&env);
> > -ret:
> > -	return is_amd >= 1 ? true : false;
> > -}
> > diff --git a/tools/perf/arch/x86/util/env.h b/tools/perf/arch/x86/util/env.h
> > deleted file mode 100644
> > index d78f080b6b3f889a..0000000000000000
> > --- a/tools/perf/arch/x86/util/env.h
> > +++ /dev/null
> > @@ -1,7 +0,0 @@
> > -/* SPDX-License-Identifier: GPL-2.0 */
> > -#ifndef _X86_ENV_H
> > -#define _X86_ENV_H
> > -
> > -bool x86__is_amd_cpu(void);
> > -
> > -#endif /* _X86_ENV_H */
> > diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
> > index c3d89d6ba1bf03ad..e0060dac2a9f9242 100644
> > --- a/tools/perf/arch/x86/util/pmu.c
> > +++ b/tools/perf/arch/x86/util/pmu.c
> > @@ -16,7 +16,7 @@
> >  #include "../../../util/fncache.h"
> >  #include "../../../util/pmus.h"
> >  #include "mem-events.h"
> > -#include "env.h"
> > +#include "util/env.h"
> >  
> >  void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
> >  {
> > diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> > index 1edbccfc3281d2b1..470a0156e0722e4e 100644
> > --- a/tools/perf/util/env.c
> > +++ b/tools/perf/util/env.c
> > @@ -5,6 +5,7 @@
> >  #include "util/header.h"
> >  #include "linux/compiler.h"
> >  #include <linux/ctype.h>
> > +#include <linux/string.h>
> >  #include <linux/zalloc.h>
> >  #include "cgroup.h"
> >  #include <errno.h>
> > @@ -625,6 +626,7 @@ char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
> >  	return NULL;
> >  }
> >  
> > +
> 
> Useless empty line.

Ugh, will remove.

Thanks,
Namhyung

