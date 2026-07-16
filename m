Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BA734403A;
	Thu, 16 Jul 2026 22:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784240544; cv=none; b=HMnsI9nvVrTDnobmC0o4baEvCFEiq8pjq9G29QlbZKwPal6MMNu6/SiuFGylsyII+EUcd71nmPjJD9SctdkUDzlW/r6AhuNKQgEiCTmJ8SX89Zm1vdAaLBR5d8DDYJ3iVQe3nOWLWAROQ2oJcwcf3vLfcGa7p8sPd0KH0z29wsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784240544; c=relaxed/simple;
	bh=Uh/r1H3X8nv1Napm9MrM7ovT6kO3EbvJkqc4PLzmjvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaA1imKTVlABGuma+l1wsOy8taN/4nXHiGX1lNU53K2zORW6ASsKaO/a3moggM2poj3RIymRD9s11n83s95FVBj+e0vBBp6ghOcaR3R4+1HAdpWtBTpxxdnj2c8TuVzPU03thoG7PXEJt4taWsmKSgtitvgM3fypWFhxkU5Dd7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjgVPPfo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjgVPPfo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EDC1F000E9;
	Thu, 16 Jul 2026 22:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784240543;
	bh=iaVi/DS6BKBzfMT18TbCcybrZLGAcEckATGNN26nTLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OjgVPPfo5yip6j27i9EqEBfeF/l/3luRtBFus52Q71F+hbZC19LfgFWDx8zJsh2Mi
	 k/bWbzODiCX8tdpxG4O/skq4qgFOin9avF3oNMi2wne46T4nO2jflj2PbC6CgxITYq
	 Z3LmEQBDFx17i1fx3Yv0ct4wjiCW/47CDLN8Mu0LmQ/lg5RyuPpuxJZN3NGvkkLtag
	 12VIkdBqMUFFbJQU6jjIFWZhZktaV3+d7xh1JlzlPQEEyEAbrdoVlHoZWZDn5OIRGx
	 KtfyMu54mfMwZMik39Lp27H1kvBncbWwhCeciBbLKS5rERcaYPqZBTYhWUhNgqJs7d
	 zDnJyhum9UhAg==
Date: Thu, 16 Jul 2026 15:22:21 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, ctshao@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v4 01/14] perf stat: Introduce core generic print
 traversal engine and header stubs
Message-ID: <allZnbHwHtZhfn9Y@google.com>
References: <20260716043223.388233-1-irogers@google.com>
 <20260716070303.507066-1-irogers@google.com>
 <20260716070303.507066-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260716070303.507066-2-irogers@google.com>

On Thu, Jul 16, 2026 at 12:02:50AM -0700, Ian Rogers wrote:
> This patch introduces the initial infrastructure for decoupling the perf
> stat printing API. It declares the struct perf_stat_print_callbacks
> interface and the core traversal driver perf_stat__print_cb() inside the
> newly created util/stat-print.h and util/stat-print.c files.
> 
> The generic traversal driver perf_stat__print_cb() drive traversing the
> event lists across all supported cpu aggregation modes (global, die,
> socket, cache, cluster, core, thread, none). It implements the clean
> display filtering checks (perf_stat__skip_metric_event(), hybrid
> wildcard merges) and the basic metrics allowlist filter
> (is_basic_shadow_metric()) to keep formatting callbacks decoupled.
> 
> This also introduces two format-agnostic shared helpers to centralize
> aggregation prefix formatting:
> - perf_stat__get_aggr_key(): resolves JSON key names.
> - perf_stat__get_aggr_id_char(): formats unified aggregation identifiers.
> 
> Adds empty format-specific stubs (perf_stat__print_std, _csv, _json) to
> ensure that the new print files link and compile cleanly under
> util/Build, without affecting the legacy print path.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Assisted-by: Antigravity:gemini-3.5-flash
> Acked-by: Chun-Tse Shao <ctshao@google.com>
> ---
>  tools/perf/builtin-stat.c         |  96 +++---
>  tools/perf/util/Build             |   4 +
>  tools/perf/util/stat-display.c    |  12 +-
>  tools/perf/util/stat-print-csv.c  |  13 +
>  tools/perf/util/stat-print-json.c |  13 +
>  tools/perf/util/stat-print-std.c  |  13 +
>  tools/perf/util/stat-print.c      | 500 ++++++++++++++++++++++++++++++
>  tools/perf/util/stat-print.h      | 137 ++++++++
>  tools/perf/util/stat.h            |   6 +
>  9 files changed, 744 insertions(+), 50 deletions(-)
>  create mode 100644 tools/perf/util/stat-print-csv.c
>  create mode 100644 tools/perf/util/stat-print-json.c
>  create mode 100644 tools/perf/util/stat-print-std.c
>  create mode 100644 tools/perf/util/stat-print.c
>  create mode 100644 tools/perf/util/stat-print.h
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 3f685beba384..532856f8be90 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -40,62 +40,64 @@
>   *   Jaswinder Singh Rajput <jaswinder@kernel.org>
>   */
>  
> +#include <errno.h>
> +#include <inttypes.h>
> +#include <locale.h>
> +#include <math.h>
> +#include <signal.h>
> +#include <stdlib.h>
> +
> +#include <linux/ctype.h>
> +#include <linux/err.h>
> +#include <linux/list_sort.h>
> +#include <linux/time64.h>
> +#include <linux/zalloc.h>
> +#include <sys/prctl.h>
> +#include <sys/resource.h>
> +#include <sys/stat.h>
> +#include <sys/time.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +
> +#include <api/fs/fs.h>
> +#include <internal/threadmap.h>
> +#include <perf/evlist.h>
> +#include <subcmd/parse-options.h>
> +
> +#include "asm/bug.h"
>  #include "builtin.h"
> +#include "util/affinity.h"
> +#include "util/bpf_counter.h"
>  #include "util/cgroup.h"
> -#include <subcmd/parse-options.h>
> -#include "util/parse-events.h"
> -#include "util/pmus.h"
> -#include "util/pmu.h"
> -#include "util/tool_pmu.h"
> +#include "util/color.h"
> +#include "util/counts.h"
> +#include "util/cpumap.h"
> +#include "util/debug.h"
>  #include "util/event.h"
>  #include "util/evlist.h"
>  #include "util/evsel.h"
> -#include "util/debug.h"
> -#include "util/color.h"
> -#include "util/stat.h"
>  #include "util/header.h"
> -#include "util/cpumap.h"
> -#include "util/thread_map.h"
> -#include "util/counts.h"
> -#include "util/topdown.h"
> +#include "util/intel-tpebs.h"
> +#include "util/iostat.h"
> +#include "util/metricgroup.h"
> +#include "util/parse-events.h"
> +#include "util/pfm.h"
> +#include "util/pmu.h"
> +#include "util/pmus.h"
>  #include "util/session.h"
> -#include "util/tool.h"
> +#include "util/stat-print.h"
> +#include "util/stat.h"
>  #include "util/string2.h"
> -#include "util/metricgroup.h"
>  #include "util/synthetic-events.h"
>  #include "util/target.h"
> +#include "util/thread_map.h"
>  #include "util/time-utils.h"
> +#include "util/tool.h"
> +#include "util/tool_pmu.h"
>  #include "util/top.h"
> -#include "util/affinity.h"
> -#include "util/pfm.h"
> -#include "util/bpf_counter.h"
> -#include "util/iostat.h"
> +#include "util/topdown.h"
>  #include "util/util.h"
> -#include "util/intel-tpebs.h"
> -#include "asm/bug.h"
> -
> -#include <linux/list_sort.h>
> -#include <linux/time64.h>
> -#include <linux/zalloc.h>
> -#include <api/fs/fs.h>
> -#include <errno.h>
> -#include <signal.h>
> -#include <stdlib.h>
> -#include <sys/prctl.h>
> -#include <inttypes.h>
> -#include <locale.h>
> -#include <math.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <sys/wait.h>
> -#include <unistd.h>
> -#include <sys/time.h>
> -#include <sys/resource.h>
> -#include <linux/err.h>
> -
> -#include <linux/ctype.h>
> -#include <perf/evlist.h>
> -#include <internal/threadmap.h>
>  
>  #ifdef HAVE_BPF_SKEL
>  #include "util/bpf_skel/bperf_cgroup.h"
> @@ -123,6 +125,7 @@ static struct target target;
>  static volatile sig_atomic_t	child_pid			= -1;
>  static int			detailed_run			=  0;
>  static bool			transaction_run;
> +static bool use_perf_stat_print;

Please align.

Thanks,
Namhyung

