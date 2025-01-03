Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00EFBE4F;
	Fri,  3 Jan 2025 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735928740; cv=none; b=GoEBRo/9BweyiCgdT+IjQBodt49WJPQLwpAAz53+GBsh70x9GbPcku7b2kpBzmGJSb+haRJl+dZuG8Y10GWCKNSkhEB08LjjeW3chs+JLynFEW4hMI/xVl0uJsAH3Eht5zf++GFYsz4js+kOfiBdunBk+1jXAa+6Pg74o8NJ+10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735928740; c=relaxed/simple;
	bh=yhYop0t7zIXcq046uMbJILigP7MWDipnkAanX7dug5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0RqsQ54zvGkEwnH3DzqZsuE60atBXlk6xSthDvcoK4nm5YONA2zdSRwZmivh/gLDUgwmgq0/N6u28L3OaTb1BrtnjYwSxPhxwEUIRfvYnirmO7SOkaajKlEWy+pqP27AUiz5AZ5b/rn93lqbS4t1H90iYXAORMrZna1qLwfxGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 558951480;
	Fri,  3 Jan 2025 10:26:06 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A63A33F673;
	Fri,  3 Jan 2025 10:25:37 -0800 (PST)
Date: Fri, 3 Jan 2025 18:25:32 +0000
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
	Tim Chen <tim.c.chen@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kyle Meyer <kyle.meyer@hpe.com>
Subject: Re: [PATCH v2] perf cpumap: Reduce cpu size from int to int16_t
Message-ID: <20250103182532.GB781381@e132581.arm.com>
References: <20241220185207.106161-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220185207.106161-1-irogers@google.com>

On Fri, Dec 20, 2024 at 10:52:07AM -0800, Ian Rogers wrote:
> 
> Fewer than 32k logical CPUs are currently supported by perf. A cpumap
> is indexed by an integer (see perf_cpu_map__cpu) yielding a perf_cpu
> that wraps a 4-byte int for the logical CPU - the wrapping is done
> deliberately to avoid confusing a logical CPU with an index into a
> cpumap. Using a 4-byte int within the perf_cpu is larger than required
> so this patch reduces it to the 2-byte int16_t. For a cpumap
> containing 16 entries this will reduce the array size from 64 to 32
> bytes. For very large servers with lots of logical CPUs the size
> savings will be greater.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
> v2. Rebase and tweak commit message.
> ---
>  tools/lib/perf/include/perf/cpumap.h |  3 ++-
>  tools/perf/util/cpumap.c             | 13 ++++++++-----
>  tools/perf/util/env.c                |  2 +-
>  3 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
> index 188a667babc6..8c1ab0f9194e 100644
> --- a/tools/lib/perf/include/perf/cpumap.h
> +++ b/tools/lib/perf/include/perf/cpumap.h
> @@ -4,10 +4,11 @@
> 
>  #include <perf/core.h>
>  #include <stdbool.h>
> +#include <stdint.h>
> 
>  /** A wrapper around a CPU to avoid confusion with the perf_cpu_map's map's indices. */
>  struct perf_cpu {
> -       int cpu;
> +       int16_t cpu;
>  };
> 
>  struct perf_cache {
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 27094211edd8..85e224d8631b 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -427,7 +427,7 @@ static void set_max_cpu_num(void)
>  {
>         const char *mnt;
>         char path[PATH_MAX];
> -       int ret = -1;
> +       int max, ret = -1;
> 
>         /* set up default */
>         max_cpu_num.cpu = 4096;
> @@ -444,10 +444,12 @@ static void set_max_cpu_num(void)
>                 goto out;
>         }
> 
> -       ret = get_max_num(path, &max_cpu_num.cpu);
> +       ret = get_max_num(path, &max);
>         if (ret)
>                 goto out;
> 
> +       max_cpu_num.cpu = max;

I am concerned for the data conversion from int type to int16_t type.

The GCC option "-Wconversion" is not enabled in perf Makefile, unsafe
data conversion is allowed.  A better way is to update argument type for
get_max_num() for reading CPU number with int16_t type.

Thanks,
Leo

> +
>         /* get the highest present cpu number for a sparse allocation */
>         ret = snprintf(path, PATH_MAX, "%s/devices/system/cpu/present", mnt);
>         if (ret >= PATH_MAX) {
> @@ -455,8 +457,9 @@ static void set_max_cpu_num(void)
>                 goto out;
>         }
> 
> -       ret = get_max_num(path, &max_present_cpu_num.cpu);
> -
> +       ret = get_max_num(path, &max);
> +       if (!ret)
> +               max_present_cpu_num.cpu = max;
>  out:
>         if (ret)
>                 pr_err("Failed to read max cpus, using default of %d\n", max_cpu_num.cpu);
> @@ -606,7 +609,7 @@ size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size)
>  #define COMMA first ? "" : ","
> 
>         for (i = 0; i < perf_cpu_map__nr(map) + 1; i++) {
> -               struct perf_cpu cpu = { .cpu = INT_MAX };
> +               struct perf_cpu cpu = { .cpu = INT16_MAX };
>                 bool last = i == perf_cpu_map__nr(map);
> 
>                 if (!last)
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 610c57da5b37..961a92545039 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -543,7 +543,7 @@ int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu)
> 
>                 for (i = 0; i < env->nr_numa_nodes; i++) {
>                         nn = &env->numa_nodes[i];
> -                       nr = max(nr, perf_cpu_map__max(nn->map).cpu);
> +                       nr = max(nr, (int)perf_cpu_map__max(nn->map).cpu);
>                 }
> 
>                 nr++;
> --
> 2.47.1.613.gc27f4b7a9f-goog
> 
