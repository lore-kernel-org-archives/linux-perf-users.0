Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB32625F984;
	Tue, 26 May 2026 00:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779755743; cv=none; b=g0PFLVR2nl+R7aRzB+c3CS79Xd1Z2HvvdGuE2hwPRMb+xLOTBK/Km4Uy8PvB6L4QWDAG1svvKGIgdjgL3aaJhHYqyeFAV+KQotfWL57kx1WvCpF/eIN9PVi2kWBBBhjaaKwaOH3HAyXtOaXGCnyCvaj1luu6fdju4faVv2fEPBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779755743; c=relaxed/simple;
	bh=TxQB+Ae+Qj/dRzcEQi+SeFJ8hBOgm/twYo67h2c8xuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbwy8wJOK9meC9uSjuwluTzWMGgx1y8HYcFoEVeOXYsHqGtINJ85VBaIDRhFT42p1tTdy/ceHTtyo7NLlSgCPJNnrVfXIBOaPLkcxhhqb7KY25odF32YP1Igx5zaNqRIFwifzM8oDZ8GW6DOnABXRsSVccQ9f+YSd2bnidMoncU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/CIr9hc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/CIr9hc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A4A1F000E9;
	Tue, 26 May 2026 00:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779755741;
	bh=I9A8i+I9Q0bd0mGRKrzkm/GeP+5Z2xtv0wmuEj11NpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g/CIr9hchYDPByx01oAi2qwrhquu1yMYI0OBzFT8K/Y4jCs4W7L7pOMpFwQwdaRLc
	 N9K/DBBBJsqoUi/BY1IMTBe1YS5ssFoGdCXld80FDOsUujiiq6USR3rz2ggq5bHrFr
	 4V++hfA6pmAN9MVCXBeoaM9j+e+WYCEIqCPgFpSx3Gmj+SDx4yLC7uKQS0UWxZygBm
	 hzmG9Si9RnowhBEMKNL/gX6IZMxYxq/E/Xdq9JGboK4oYJ4m4jj4b+NmaYSKBTbPi7
	 8Nzw8mDj+furFu2XMBhng8XhVNQcs+fr34y+ylM0dQrxEJF/AZlj6j/dlxi18GMRlt
	 lI3l5Txc3AWMA==
Date: Mon, 25 May 2026 19:35:38 -0500
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, alice.mei.rogers@gmail.com,
	dapeng1.mi@linux.intel.com, james.clark@linaro.org,
	leo.yan@linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Subject: Re: [PATCH v9 04/23] perf script: Sort includes and add missed
 explicit dependencies
Message-ID: <ahTq2mVUy61AkJN9@google.com>
References: <20260428071903.1886173-1-irogers@google.com>
 <20260522220435.2378363-1-irogers@google.com>
 <20260522220435.2378363-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260522220435.2378363-5-irogers@google.com>

On Fri, May 22, 2026 at 03:04:15PM -0700, Ian Rogers wrote:
> Fix missing #include of pmu.h found while cleaning the evsel/evlist
> header files. Sort the remaining header files for consistency with the
> rest of the code. Doing this exposed a missing forward declaration of
> addr_location in print_insn.h, add this and sort the forward
> declarations.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/builtin-script.c  | 111 ++++++++++++++++++-----------------
>  tools/perf/util/print_insn.h |   5 +-
>  2 files changed, 60 insertions(+), 56 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index c0918006e0ab..e330ae7f725e 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1,75 +1,78 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include "builtin.h"
> +#include <errno.h>
> +#include <inttypes.h>
> +#include <signal.h>
> +#include <stdio.h>
> +
> +#include <dirent.h>
> +#include <fcntl.h>
> +#include <linux/bitmap.h>
> +#include <linux/compiler.h>
> +#include <linux/ctype.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/stringify.h>
> +#include <linux/time64.h>
> +#include <linux/unaligned.h>
> +#include <linux/zalloc.h>
> +#include <sys/param.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <sys/utsname.h>
> +#include <unistd.h>
>  
> +#include <perf/evlist.h>
> +#include <subcmd/exec-cmd.h>
> +#include <subcmd/pager.h>
> +#include <subcmd/parse-options.h>
> +
> +#include "asm/bug.h"
> +#include "builtin.h"
> +#include "perf.h"
> +#include "print_binary.h"
> +#include "print_insn.h"
> +#include "ui/ui.h"
> +#include "util/annotate.h"
> +#include "util/auxtrace.h"
> +#include "util/cgroup.h"
> +#include "util/color.h"
>  #include "util/counts.h"
> +#include "util/cpumap.h"
> +#include "util/data.h"
>  #include "util/debug.h"
> +#include "util/dlfilter.h"
>  #include "util/dso.h"
> -#include <subcmd/exec-cmd.h>
> -#include "util/header.h"
> -#include <subcmd/parse-options.h>
> -#include "util/perf_regs.h"
> -#include "util/session.h"
> -#include "util/tool.h"
> -#include "util/map.h"
> -#include "util/srcline.h"
> -#include "util/symbol.h"
> -#include "util/thread.h"
> -#include "util/trace-event.h"
> +#include "util/dump-insn.h"
>  #include "util/env.h"
> +#include "util/event.h"
>  #include "util/evlist.h"
>  #include "util/evsel.h"
>  #include "util/evsel_fprintf.h"
>  #include "util/evswitch.h"
> +#include "util/header.h"
> +#include "util/map.h"
> +#include "util/mem-events.h"
> +#include "util/mem-info.h"
> +#include "util/metricgroup.h"
> +#include "util/path.h"
> +#include "util/perf_regs.h"
> +#include "util/pmu.h"
> +#include "util/record.h"
> +#include "util/session.h"
>  #include "util/sort.h"
> -#include "util/data.h"
> -#include "util/auxtrace.h"
> -#include "util/cpumap.h"
> -#include "util/thread_map.h"
> +#include "util/srcline.h"
>  #include "util/stat.h"
> -#include "util/color.h"
>  #include "util/string2.h"
> +#include "util/symbol.h"
>  #include "util/thread-stack.h"
> +#include "util/thread.h"
> +#include "util/thread_map.h"
>  #include "util/time-utils.h"
> -#include "util/path.h"
> -#include "util/event.h"
> -#include "util/mem-info.h"
> -#include "util/metricgroup.h"
> -#include "ui/ui.h"
> -#include "print_binary.h"
> -#include "print_insn.h"
> -#include <linux/bitmap.h>
> -#include <linux/compiler.h>
> -#include <linux/kernel.h>
> -#include <linux/stringify.h>
> -#include <linux/time64.h>
> -#include <linux/zalloc.h>
> -#include <linux/unaligned.h>
> -#include <sys/utsname.h>
> -#include "asm/bug.h"
> -#include "util/mem-events.h"
> -#include "util/dump-insn.h"
> -#include <dirent.h>
> -#include <errno.h>
> -#include <inttypes.h>
> -#include <signal.h>
> -#include <stdio.h>
> -#include <sys/param.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <fcntl.h>
> -#include <unistd.h>
> -#include <subcmd/pager.h>
> -#include <perf/evlist.h>
> -#include <linux/err.h>
> -#include "util/dlfilter.h"
> -#include "util/record.h"
> +#include "util/tool.h"
> +#include "util/trace-event.h"
>  #include "util/unwind.h"
>  #include "util/util.h"
> -#include "util/cgroup.h"
> -#include "util/annotate.h"
> -#include "perf.h"
>  
> -#include <linux/ctype.h>
>  #ifdef HAVE_LIBTRACEEVENT
>  #include <event-parse.h>
>  #endif
> diff --git a/tools/perf/util/print_insn.h b/tools/perf/util/print_insn.h
> index 07d11af3fc1c..a54f7e858e49 100644
> --- a/tools/perf/util/print_insn.h
> +++ b/tools/perf/util/print_insn.h
> @@ -5,10 +5,11 @@
>  #include <stddef.h>
>  #include <stdio.h>
>  
> -struct perf_sample;
> -struct thread;
> +struct addr_location;
>  struct machine;
>  struct perf_insn;
> +struct perf_sample;
> +struct thread;
>  
>  #define PRINT_INSN_IMM_HEX		(1<<0)
>  
> -- 
> 2.54.0.794.g4f17f83d09-goog
> 
