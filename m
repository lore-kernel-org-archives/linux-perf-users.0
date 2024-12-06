Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A371DB362;
	Fri,  6 Dec 2024 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480698; cv=none; b=jS3s/uMknW5zCXfK52dY7056GbOQDxSrle1SKVHYdm8yfATkZpWSChSBQRBNfz3nKcUgAm5TLJ794Ybgt7iTurFoSZZmxTYqEi+/LvfoblR/ng36RTEVhLVWo4y0Cw3f2BIdhcJOzmcMM0WDXN5OXz5bFtp04NxqoTJ8OhKW1L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480698; c=relaxed/simple;
	bh=l4NtP/6y6k1AuGVIIpc/iwXAw0Bag9yy/ilwixE8YZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dY9iq94UXbNctNbqtB9ljdkFcGVnGBdMCrrAjG2xjWZwkGeKKb6fY4cJPrYzHNSmk3YYOOowEvb6UnC7qCaZQycIbUxzwwiCwUe29hx+q73HzKFB6Rhj7swxRbp9oD7tzadFgmDvB4ybpLgQ8TMVNcrPdFpkLNWAWVdlKBCmzc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64ED212FC;
	Fri,  6 Dec 2024 02:25:24 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 023DD3F71E;
	Fri,  6 Dec 2024 02:24:55 -0800 (PST)
Date: Fri, 6 Dec 2024 10:24:51 +0000
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Kyle Meyer <kyle.meyer@hpe.com>, Ben Gainey <ben.gainey@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/8] perf: Increase MAX_NR_CPUS to 4096
Message-ID: <20241206102451.GA3418674@e132581.arm.com>
References: <20241206044035.1062032-1-irogers@google.com>
 <20241206044035.1062032-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206044035.1062032-2-irogers@google.com>

Hi Ian,

On Thu, Dec 05, 2024 at 08:40:28PM -0800, Ian Rogers wrote:
> 
> From: Kyle Meyer <kyle.meyer@hpe.com>
> 
> Systems have surpassed 2048 CPUs. Increase MAX_NR_CPUS to 4096.
> 
> Bitmaps declared with MAX_NR_CPUS bits will increase from 256B to 512B,
> cpus_runtime will increase from 81960B to 163880B, and max_entries will
> increase from 8192B to 16384B.
> 
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/include/internal/cpumap.h | 2 +-
>  tools/perf/perf.h                        | 2 +-
>  tools/perf/util/bpf_skel/kwork_top.bpf.c | 4 +++-
>  3 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
> index 49649eb51ce4..3cf28522004e 100644
> --- a/tools/lib/perf/include/internal/cpumap.h
> +++ b/tools/lib/perf/include/internal/cpumap.h
> @@ -22,7 +22,7 @@ DECLARE_RC_STRUCT(perf_cpu_map) {
>  };
> 
>  #ifndef MAX_NR_CPUS
> -#define MAX_NR_CPUS    2048
> +#define MAX_NR_CPUS    4096
>  #endif

This series is fine for me.  Just wandering if we can use a central
place to maintain the macro, e.g. lib/perf/include/perf/cpumap.h.  It
is pointless to define exactly same macros in different headers.  As
least, I think we can unify this except the kwork bpf program?

P.s. for dynamically allocating per CPU maps in eBPF program, we can
refer to the code samples/bpf/xdp_sample_user.c, but this is another
topic.

Thanks,
Leo

>  struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus);
> diff --git a/tools/perf/perf.h b/tools/perf/perf.h
> index c004dd4e65a3..3cb40965549f 100644
> --- a/tools/perf/perf.h
> +++ b/tools/perf/perf.h
> @@ -3,7 +3,7 @@
>  #define _PERF_PERF_H
> 
>  #ifndef MAX_NR_CPUS
> -#define MAX_NR_CPUS                    2048
> +#define MAX_NR_CPUS                    4096
>  #endif
> 
>  enum perf_affinity {
> diff --git a/tools/perf/util/bpf_skel/kwork_top.bpf.c b/tools/perf/util/bpf_skel/kwork_top.bpf.c
> index 594da91965a2..73e32e063030 100644
> --- a/tools/perf/util/bpf_skel/kwork_top.bpf.c
> +++ b/tools/perf/util/bpf_skel/kwork_top.bpf.c
> @@ -18,7 +18,9 @@ enum kwork_class_type {
>  };
> 
>  #define MAX_ENTRIES     102400
> -#define MAX_NR_CPUS     2048
> +#ifndef MAX_NR_CPUS
> +#define MAX_NR_CPUS     4096
> +#endif
>  #define PF_KTHREAD      0x00200000
>  #define MAX_COMMAND_LEN 16
> 
> --
> 2.47.0.338.g60cca15819-goog
> 
> 
