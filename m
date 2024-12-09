Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E680215713;
	Mon,  9 Dec 2024 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734533; cv=none; b=G30N9iiMgW9WSZXIKDy1wrzG9gImLIctktOgItTam2+DwzXO4+8jC9QcC3M/Cca2IfyFpbGJRlVVc2/i3+XZeA8EwOySS4HpuEG8zhEEpM0PC5zPa3yEuveFd/+RKktvazMtiCEkA6naZ8SBKLwSz3SmDQDff6MIiCgqLW1MM5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734533; c=relaxed/simple;
	bh=j7yWxgVjzEYt+riuTqPpXYEMgNrJHkMXMCMnYcC0HLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qgmn3wCudXXSFXsq3tnHjudvT/ubZVrAnYb7ecYbmJPy4V4QqrSImfasIKCuxNuDris8nxshxxxnLEvHw2FjFnGBsOdRoS7kDuD92B22XsU2gKQ41H424LPI7nlx8D+VuMz44hRsu3F7eggCD1JWPGpAUvDJFjvWoS2qdKsbSPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31B00113E;
	Mon,  9 Dec 2024 00:55:58 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9C263F720;
	Mon,  9 Dec 2024 00:55:29 -0800 (PST)
Date: Mon, 9 Dec 2024 08:55:24 +0000
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
Subject: Re: [PATCH v1] perf cpumap: Reduce cpu size from int to int16_t
Message-ID: <20241209085524.GC5430@e132581.arm.com>
References: <20241207052133.102829-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207052133.102829-1-irogers@google.com>

Hi Ian,

On Fri, Dec 06, 2024 at 09:21:33PM -0800, Ian Rogers wrote:
> 
> Fewer than 32k CPUs are currently supported by perf. A cpumap stores
> an int per CPU, so its size is 4 times the number of CPUs in the
> cpumap.

Maybe I have a stupid question.  An int value has 4 bytes, on the other
hand, we needs 2 bytes to store a 32k value (even 4096 needs 2 bytes
for storing the value).

How can conclude "its size is 4 times the number of CPUs"?

> We can reduce the size of the int to an int16_t, saving 2
> bytes per CPU in the map.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/include/perf/cpumap.h |  3 ++-
>  tools/perf/util/cpumap.c             | 13 ++++++++-----
>  tools/perf/util/env.c                |  2 +-
>  3 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
> index cbb65e55fc67..760a9aae9884 100644
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

This is an improvement for max CPU number, but it is irrevelant to
changing the CPU type to int16_t.  It is better to split it into a new
patch.

If get an error for max present CPU number, should we rollback to 4096
for both max_cpu_num and max_present_cpu_num?

Thanks,
Leo

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
> index e2843ca2edd9..f1d7d22e7e98 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -531,7 +531,7 @@ int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu)
> 
>                 for (i = 0; i < env->nr_numa_nodes; i++) {
>                         nn = &env->numa_nodes[i];
> -                       nr = max(nr, perf_cpu_map__max(nn->map).cpu);
> +                       nr = max(nr, (int)perf_cpu_map__max(nn->map).cpu);
>                 }
> 
>                 nr++;
> --
> 2.47.0.338.g60cca15819-goog
> 
