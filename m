Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD2037A4BE;
	Fri, 27 Mar 2026 20:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774644903; cv=none; b=Gy4Wl4gvIGx8Rq46tq7BTfvaWHP2BdRX1p7mLwJ2ZPFfpd/bkVgOVMwZreNHkeDvRRnNNN+4fqSQe4ryRCX6cSHebVyTFarK1rfiLUt2KkKa6O9aFzyGh0or2iU8BDOQIIvu70q3Ay8v0nPCX1SdAyvkNvhqt0oKF5ihNw8f/zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774644903; c=relaxed/simple;
	bh=HPwFMhi93MUi4wflfDg9m9pwe7dq8NTktLK0fkvUtDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q44VFD/Rh1QN2l3P8cH7ymFWf599vaHoGZfqyqSaMuW4h5z3sY9jbVzra7i73FISGy9x2QxHA0zAKS2v8JS+hOD6Pm5QZBcYZfmM/NKsTK9smEza57ElgGZ1IvW3wRC/L5+58kLt20o9iJPgYXJgZazhEMP8BHqK/naTfjsd6Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6RaSMMX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6RaSMMX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7728DC19423;
	Fri, 27 Mar 2026 20:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774644903;
	bh=HPwFMhi93MUi4wflfDg9m9pwe7dq8NTktLK0fkvUtDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n6RaSMMXOx5IfKZV5Ujuzs2w9Ke6Y6K8JhSbfwx9HHAi/cn3M6b5O/cgmDWLkTUU7
	 uUhkUtkAbZ9Fb62up0sNrlXi/n06/sy4x3JtW3hxIRQOy2PZeKkKC7PkSFCOyWcADO
	 wMs2lPecsptti1fNrFe05bZ4k2BnXx3MLQNyUJ8iiYwMsoy4AItsTbuzId2O5b8XYY
	 3qFMw0aczL0+JPpu18kEboanfU1GGbmgtrryhteiouAI6micwagxSarZJ50J1GMmjA
	 sweCaIQ5TEKfscT8/QHHM5FC0vHNB6JP0VQox4V07AjYRM8knmrXRx4Mswjsxm8DYE
	 AMuDPN1M/Xgyw==
Date: Fri, 27 Mar 2026 13:55:00 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: liqb365@163.com, haixiao.yan.cn@windriver.com, acme@kernel.org,
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v1] libperf cpumap: Make index and nr types unsigned
Message-ID: <acbupFeqAMj0X9NU@google.com>
References: <CAP-5=fU9N_TB53NrN_gCOWoabQ9to41Hj4Wovv5n4t6=5ANHnw@mail.gmail.com>
 <20260319081843.1650640-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260319081843.1650640-1-irogers@google.com>

On Thu, Mar 19, 2026 at 01:18:43AM -0700, Ian Rogers wrote:
> The index into the cpumap array and the number of entries within the
> array can never be negative, so let's make them unsigned. This is
> prompted by reports that gcc 13 with -O6 is giving a
> alloc-size-larger-than errors. The change makes the cpumap changes and
> then updates the declaration of index variables throughout perf and
> libperf to be unsigned. The two things are hard to separate as
> compiler warnings about mixing signed and unsigned types breaks the
> build.
> 
> Reported-by: Chingbin Li <liqb365@163.com>
> Closes: https://lore.kernel.org/lkml/20260212025127.841090-1-liqb365@163.com/
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/cpumap.c                       | 49 +++++++++----------
>  tools/lib/perf/evsel.c                        | 10 ++--
>  tools/lib/perf/include/internal/cpumap.h      |  6 +--
>  tools/lib/perf/include/perf/cpumap.h          |  4 +-
>  tools/perf/arch/arm/util/cs-etm.c             |  7 +--
>  tools/perf/arch/arm64/util/arm-spe.c          |  3 +-
>  tools/perf/arch/arm64/util/header.c           |  2 +-
>  tools/perf/arch/x86/util/pmu.c                |  3 +-
>  tools/perf/builtin-c2c.c                      |  6 +--
>  tools/perf/builtin-record.c                   |  2 +-
>  tools/perf/builtin-script.c                   |  5 +-
>  tools/perf/builtin-stat.c                     |  2 +-
>  tools/perf/tests/bitmap.c                     |  2 +-
>  tools/perf/tests/cpumap.c                     |  6 ++-
>  tools/perf/tests/mem2node.c                   |  2 +-
>  tools/perf/tests/openat-syscall-all-cpus.c    |  3 +-
>  tools/perf/tests/topology.c                   |  4 +-
>  tools/perf/util/affinity.c                    |  2 +-
>  tools/perf/util/bpf_counter.c                 | 24 ++++-----
>  tools/perf/util/bpf_counter_cgroup.c          |  8 +--
>  tools/perf/util/bpf_kwork.c                   |  3 +-
>  tools/perf/util/bpf_kwork_top.c               |  3 +-
>  tools/perf/util/bpf_off_cpu.c                 |  2 +-
>  tools/perf/util/bpf_trace_augment.c           |  2 +-
>  tools/perf/util/cpumap.c                      | 10 ++--
>  tools/perf/util/cputopo.c                     |  2 +-
>  tools/perf/util/env.c                         |  2 +-
>  .../scripting-engines/trace-event-python.c    |  2 +-
>  tools/perf/util/session.c                     |  3 +-
>  tools/perf/util/stat-display.c                |  4 +-
>  tools/perf/util/stat.c                        |  8 +--
>  tools/perf/util/svghelper.c                   |  3 +-
>  tools/perf/util/symbol.c                      |  3 +-
>  tools/perf/util/synthetic-events.c            |  2 +-
>  34 files changed, 108 insertions(+), 91 deletions(-)
> 
> diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> index 4160e7d2e120..b987b7c7cee2 100644
> --- a/tools/lib/perf/cpumap.c
> +++ b/tools/lib/perf/cpumap.c
> @@ -15,12 +15,12 @@
>  
>  #define MAX_NR_CPUS 4096
>  
> -void perf_cpu_map__set_nr(struct perf_cpu_map *map, int nr_cpus)
> +void perf_cpu_map__set_nr(struct perf_cpu_map *map, unsigned int nr_cpus)
>  {
>  	RC_CHK_ACCESS(map)->nr = nr_cpus;
>  }
>  
> -struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
> +struct perf_cpu_map *perf_cpu_map__alloc(unsigned int nr_cpus)
>  {
>  	RC_STRUCT(perf_cpu_map) *cpus;
>  	struct perf_cpu_map *result;
> @@ -78,7 +78,7 @@ void perf_cpu_map__put(struct perf_cpu_map *map)
>  static struct perf_cpu_map *cpu_map__new_sysconf(void)
>  {
>  	struct perf_cpu_map *cpus;
> -	int nr_cpus, nr_cpus_conf;
> +	long nr_cpus, nr_cpus_conf;

Shouldn't it be unsigned int?

>  
>  	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
>  	if (nr_cpus < 0)
> @@ -86,15 +86,13 @@ static struct perf_cpu_map *cpu_map__new_sysconf(void)
>  
>  	nr_cpus_conf = sysconf(_SC_NPROCESSORS_CONF);
>  	if (nr_cpus != nr_cpus_conf) {
> -		pr_warning("Number of online CPUs (%d) differs from the number configured (%d) the CPU map will only cover the first %d CPUs.",
> +		pr_warning("Number of online CPUs (%ld) differs from the number configured (%ld) the CPU map will only cover the first %ld CPUs.",
>  			nr_cpus, nr_cpus_conf, nr_cpus);
>  	}
>  
>  	cpus = perf_cpu_map__alloc(nr_cpus);
>  	if (cpus != NULL) {
> -		int i;
> -
> -		for (i = 0; i < nr_cpus; ++i)
> +		for (unsigned int i = 0; i < nr_cpus; ++i)
>  			RC_CHK_ACCESS(cpus)->map[i].cpu = i;

I got this:

cpumap.c: In function 'cpu_map__new_sysconf':                                   
cpumap.c:95:44: error: comparison of integer expressions of different signedness: 'unsigned int' and 'long int' [-Werror=sign-compare]
   95 |                 for (unsigned int i = 0; i < nr_cpus; ++i)              
      |                                            ^

Thanks,
Namhyung

>  	}
>  
> @@ -132,23 +130,23 @@ static int cmp_cpu(const void *a, const void *b)
>  	return cpu_a->cpu - cpu_b->cpu;
>  }
>  
> -static struct perf_cpu __perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx)
> +static struct perf_cpu __perf_cpu_map__cpu(const struct perf_cpu_map *cpus, unsigned int idx)
>  {
>  	return RC_CHK_ACCESS(cpus)->map[idx];
>  }
>  
> -static struct perf_cpu_map *cpu_map__trim_new(int nr_cpus, const struct perf_cpu *tmp_cpus)
> +static struct perf_cpu_map *cpu_map__trim_new(unsigned int nr_cpus, const struct perf_cpu *tmp_cpus)
>  {
>  	size_t payload_size = nr_cpus * sizeof(struct perf_cpu);
>  	struct perf_cpu_map *cpus = perf_cpu_map__alloc(nr_cpus);
> -	int i, j;
>  
>  	if (cpus != NULL) {
> +		unsigned int j = 0;
> +
>  		memcpy(RC_CHK_ACCESS(cpus)->map, tmp_cpus, payload_size);
>  		qsort(RC_CHK_ACCESS(cpus)->map, nr_cpus, sizeof(struct perf_cpu), cmp_cpu);
>  		/* Remove dups */
> -		j = 0;
> -		for (i = 0; i < nr_cpus; i++) {
> +		for (unsigned int i = 0; i < nr_cpus; i++) {
>  			if (i == 0 ||
>  			    __perf_cpu_map__cpu(cpus, i).cpu !=
>  			    __perf_cpu_map__cpu(cpus, i - 1).cpu) {
> @@ -167,9 +165,8 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
>  	struct perf_cpu_map *cpus = NULL;
>  	unsigned long start_cpu, end_cpu = 0;
>  	char *p = NULL;
> -	int i, nr_cpus = 0;
> +	unsigned int nr_cpus = 0, max_entries = 0;
>  	struct perf_cpu *tmp_cpus = NULL, *tmp;
> -	int max_entries = 0;
>  
>  	if (!cpu_list)
>  		return perf_cpu_map__new_online_cpus();
> @@ -208,9 +205,10 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
>  
>  		for (; start_cpu <= end_cpu; start_cpu++) {
>  			/* check for duplicates */
> -			for (i = 0; i < nr_cpus; i++)
> +			for (unsigned int i = 0; i < nr_cpus; i++) {
>  				if (tmp_cpus[i].cpu == (int16_t)start_cpu)
>  					goto invalid;
> +			}
>  
>  			if (nr_cpus == max_entries) {
>  				max_entries += max(end_cpu - start_cpu + 1, 16UL);
> @@ -252,12 +250,12 @@ struct perf_cpu_map *perf_cpu_map__new_int(int cpu)
>  	return cpus;
>  }
>  
> -static int __perf_cpu_map__nr(const struct perf_cpu_map *cpus)
> +static unsigned int __perf_cpu_map__nr(const struct perf_cpu_map *cpus)
>  {
>  	return RC_CHK_ACCESS(cpus)->nr;
>  }
>  
> -struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx)
> +struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, unsigned int idx)
>  {
>  	struct perf_cpu result = {
>  		.cpu = -1
> @@ -269,7 +267,7 @@ struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx)
>  	return result;
>  }
>  
> -int perf_cpu_map__nr(const struct perf_cpu_map *cpus)
> +unsigned int perf_cpu_map__nr(const struct perf_cpu_map *cpus)
>  {
>  	return cpus ? __perf_cpu_map__nr(cpus) : 1;
>  }
> @@ -294,7 +292,7 @@ bool perf_cpu_map__is_empty(const struct perf_cpu_map *map)
>  
>  int perf_cpu_map__idx(const struct perf_cpu_map *cpus, struct perf_cpu cpu)
>  {
> -	int low, high;
> +	unsigned int low, high;
>  
>  	if (!cpus)
>  		return -1;
> @@ -324,7 +322,7 @@ bool perf_cpu_map__has(const struct perf_cpu_map *cpus, struct perf_cpu cpu)
>  
>  bool perf_cpu_map__equal(const struct perf_cpu_map *lhs, const struct perf_cpu_map *rhs)
>  {
> -	int nr;
> +	unsigned int nr;
>  
>  	if (lhs == rhs)
>  		return true;
> @@ -336,7 +334,7 @@ bool perf_cpu_map__equal(const struct perf_cpu_map *lhs, const struct perf_cpu_m
>  	if (nr != __perf_cpu_map__nr(rhs))
>  		return false;
>  
> -	for (int idx = 0; idx < nr; idx++) {
> +	for (unsigned int idx = 0; idx < nr; idx++) {
>  		if (__perf_cpu_map__cpu(lhs, idx).cpu != __perf_cpu_map__cpu(rhs, idx).cpu)
>  			return false;
>  	}
> @@ -353,7 +351,7 @@ struct perf_cpu perf_cpu_map__min(const struct perf_cpu_map *map)
>  	struct perf_cpu cpu, result = {
>  		.cpu = -1
>  	};
> -	int idx;
> +	unsigned int idx;
>  
>  	perf_cpu_map__for_each_cpu_skip_any(cpu, idx, map) {
>  		result = cpu;
> @@ -384,7 +382,7 @@ bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu
>  	if (!a || __perf_cpu_map__nr(b) > __perf_cpu_map__nr(a))
>  		return false;
>  
> -	for (int i = 0, j = 0; i < __perf_cpu_map__nr(a); i++) {
> +	for (unsigned int i = 0, j = 0; i < __perf_cpu_map__nr(a); i++) {
>  		if (__perf_cpu_map__cpu(a, i).cpu > __perf_cpu_map__cpu(b, j).cpu)
>  			return false;
>  		if (__perf_cpu_map__cpu(a, i).cpu == __perf_cpu_map__cpu(b, j).cpu) {
> @@ -410,8 +408,7 @@ bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu
>  int perf_cpu_map__merge(struct perf_cpu_map **orig, struct perf_cpu_map *other)
>  {
>  	struct perf_cpu *tmp_cpus;
> -	int tmp_len;
> -	int i, j, k;
> +	unsigned int tmp_len, i, j, k;
>  	struct perf_cpu_map *merged;
>  
>  	if (perf_cpu_map__is_subset(*orig, other))
> @@ -455,7 +452,7 @@ int perf_cpu_map__merge(struct perf_cpu_map **orig, struct perf_cpu_map *other)
>  struct perf_cpu_map *perf_cpu_map__intersect(struct perf_cpu_map *orig,
>  					     struct perf_cpu_map *other)
>  {
> -	int i, j, k;
> +	unsigned int i, j, k;
>  	struct perf_cpu_map *merged;
>  
>  	if (perf_cpu_map__is_subset(other, orig))
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index 13a307fc75ae..f747c0bc692d 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -127,7 +127,8 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
>  		     struct perf_thread_map *threads)
>  {
>  	struct perf_cpu cpu;
> -	int idx, thread, err = 0;
> +	unsigned int idx;
> +	int thread, err = 0;
>  
>  	if (cpus == NULL) {
>  		static struct perf_cpu_map *empty_cpu_map;
> @@ -460,7 +461,7 @@ int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx)
>  int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread)
>  {
>  	struct perf_cpu cpu __maybe_unused;
> -	int idx;
> +	unsigned int idx;
>  	int err;
>  
>  	perf_cpu_map__for_each_cpu(cpu, idx, evsel->cpus) {
> @@ -499,12 +500,13 @@ int perf_evsel__disable(struct perf_evsel *evsel)
>  
>  int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter)
>  {
> -	int err = 0, i;
> +	int err = 0;
>  
> -	for (i = 0; i < perf_cpu_map__nr(evsel->cpus) && !err; i++)
> +	for (unsigned int i = 0; i < perf_cpu_map__nr(evsel->cpus) && !err; i++) {
>  		err = perf_evsel__run_ioctl(evsel,
>  				     PERF_EVENT_IOC_SET_FILTER,
>  				     (void *)filter, i);
> +	}
>  	return err;
>  }
>  
> diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
> index e2be2d17c32b..c19678188b17 100644
> --- a/tools/lib/perf/include/internal/cpumap.h
> +++ b/tools/lib/perf/include/internal/cpumap.h
> @@ -16,16 +16,16 @@
>  DECLARE_RC_STRUCT(perf_cpu_map) {
>  	refcount_t	refcnt;
>  	/** Length of the map array. */
> -	int		nr;
> +	unsigned int	nr;
>  	/** The CPU values. */
>  	struct perf_cpu	map[];
>  };
>  
> -struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus);
> +struct perf_cpu_map *perf_cpu_map__alloc(unsigned int nr_cpus);
>  int perf_cpu_map__idx(const struct perf_cpu_map *cpus, struct perf_cpu cpu);
>  bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu_map *b);
>  
> -void perf_cpu_map__set_nr(struct perf_cpu_map *map, int nr_cpus);
> +void perf_cpu_map__set_nr(struct perf_cpu_map *map, unsigned int nr_cpus);
>  
>  static inline refcount_t *perf_cpu_map__refcnt(struct perf_cpu_map *map)
>  {
> diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
> index 58cc5c5fa47c..a1dd25db65b6 100644
> --- a/tools/lib/perf/include/perf/cpumap.h
> +++ b/tools/lib/perf/include/perf/cpumap.h
> @@ -49,7 +49,7 @@ LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
>   * perf_cpu_map__cpu - get the CPU value at the given index. Returns -1 if index
>   *                     is invalid.
>   */
> -LIBPERF_API struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
> +LIBPERF_API struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, unsigned int idx);
>  /**
>   * perf_cpu_map__nr - for an empty map returns 1, as perf_cpu_map__cpu returns a
>   *                    cpu of -1 for an invalid index, this makes an empty map
> @@ -57,7 +57,7 @@ LIBPERF_API struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, i
>   *                    the result is the number CPUs in the map plus one if the
>   *                    "any CPU"/dummy value is present.
>   */
> -LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
> +LIBPERF_API unsigned int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
>  /**
>   * perf_cpu_map__has_any_cpu_or_is_empty - is map either empty or has the "any CPU"/dummy value.
>   */
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index dc3f4e86b075..cc880ab596fe 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -211,7 +211,8 @@ static struct perf_pmu *cs_etm_get_pmu(struct auxtrace_record *itr)
>  static int cs_etm_validate_config(struct perf_pmu *cs_etm_pmu,
>  				  struct evsel *evsel)
>  {
> -	int idx, err = 0;
> +	unsigned int idx;
> +	int err = 0;
>  	struct perf_cpu_map *event_cpus = evsel->evlist->core.user_requested_cpus;
>  	struct perf_cpu_map *intersect_cpus;
>  	struct perf_cpu cpu;
> @@ -560,7 +561,7 @@ static size_t
>  cs_etm_info_priv_size(struct auxtrace_record *itr,
>  		      struct evlist *evlist)
>  {
> -	int idx;
> +	unsigned int idx;
>  	int etmv3 = 0, etmv4 = 0, ete = 0;
>  	struct perf_cpu_map *event_cpus = evlist->core.user_requested_cpus;
>  	struct perf_cpu_map *intersect_cpus;
> @@ -797,7 +798,7 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
>  			    struct perf_record_auxtrace_info *info,
>  			    size_t priv_size)
>  {
> -	int i;
> +	unsigned int i;
>  	u32 offset;
>  	u64 nr_cpu, type;
>  	struct perf_cpu_map *cpu_map;
> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> index 17ced7bbbdda..f00d72d087fc 100644
> --- a/tools/perf/arch/arm64/util/arm-spe.c
> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> @@ -144,7 +144,8 @@ static int arm_spe_info_fill(struct auxtrace_record *itr,
>  			     struct perf_record_auxtrace_info *auxtrace_info,
>  			     size_t priv_size)
>  {
> -	int i, ret;
> +	unsigned int i;
> +	int ret;
>  	size_t offset;
>  	struct arm_spe_recording *sper =
>  			container_of(itr, struct arm_spe_recording, itr);
> diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
> index cbc0ba101636..95e71c4f6c78 100644
> --- a/tools/perf/arch/arm64/util/header.c
> +++ b/tools/perf/arch/arm64/util/header.c
> @@ -43,7 +43,7 @@ static int _get_cpuid(char *buf, size_t sz, struct perf_cpu cpu)
>  int get_cpuid(char *buf, size_t sz, struct perf_cpu cpu)
>  {
>  	struct perf_cpu_map *cpus;
> -	int idx;
> +	unsigned int idx;
>  
>  	if (cpu.cpu != -1)
>  		return _get_cpuid(buf, sz, cpu);
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
> index 4ea4d022c9c3..0661e0f0b02d 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -221,7 +221,8 @@ static void gnr_uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool
>  	static struct perf_cpu_map *cha_adjusted[MAX_SNCS];
>  	static struct perf_cpu_map *imc_adjusted[MAX_SNCS];
>  	struct perf_cpu_map **adjusted = cha ? cha_adjusted : imc_adjusted;
> -	int idx, pmu_snc, cpu_adjust;
> +	unsigned int idx;
> +	int pmu_snc, cpu_adjust;
>  	struct perf_cpu cpu;
>  	bool alloc;
>  
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index d390ae4e3ec8..e60eea62c2fc 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -2310,7 +2310,6 @@ static int setup_nodes(struct perf_session *session)
>  {
>  	struct numa_node *n;
>  	unsigned long **nodes;
> -	int node, idx;
>  	struct perf_cpu cpu;
>  	int *cpu2node;
>  	struct perf_env *env = perf_session__env(session);
> @@ -2335,14 +2334,15 @@ static int setup_nodes(struct perf_session *session)
>  	if (!cpu2node)
>  		return -ENOMEM;
>  
> -	for (idx = 0; idx < c2c.cpus_cnt; idx++)
> +	for (int idx = 0; idx < c2c.cpus_cnt; idx++)
>  		cpu2node[idx] = -1;
>  
>  	c2c.cpu2node = cpu2node;
>  
> -	for (node = 0; node < c2c.nodes_cnt; node++) {
> +	for (int node = 0; node < c2c.nodes_cnt; node++) {
>  		struct perf_cpu_map *map = n[node].map;
>  		unsigned long *set;
> +		unsigned int idx;
>  
>  		set = bitmap_zalloc(c2c.cpus_cnt);
>  		if (!set)
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 40917a0be238..63a47820fd46 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -3695,7 +3695,7 @@ struct option *record_options = __record_options;
>  static int record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_cpu_map *cpus)
>  {
>  	struct perf_cpu cpu;
> -	int idx;
> +	unsigned int idx;
>  
>  	if (cpu_map__is_dummy(cpus))
>  		return 0;
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index b80c406d1fc1..b005b23f9d8c 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2572,7 +2572,6 @@ static struct scripting_ops	*scripting_ops;
>  static void __process_stat(struct evsel *counter, u64 tstamp)
>  {
>  	int nthreads = perf_thread_map__nr(counter->core.threads);
> -	int idx, thread;
>  	struct perf_cpu cpu;
>  	static int header_printed;
>  
> @@ -2582,7 +2581,9 @@ static void __process_stat(struct evsel *counter, u64 tstamp)
>  		header_printed = 1;
>  	}
>  
> -	for (thread = 0; thread < nthreads; thread++) {
> +	for (int thread = 0; thread < nthreads; thread++) {
> +		unsigned int idx;
> +
>  		perf_cpu_map__for_each_cpu(cpu, idx, evsel__cpus(counter)) {
>  			struct perf_counts_values *counts;
>  
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 73c2ba7e3076..46ef99f844dd 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -410,7 +410,7 @@ static int read_tool_counters(void)
>  	struct evsel *counter;
>  
>  	evlist__for_each_entry(evsel_list, counter) {
> -		int idx;
> +		unsigned int idx;
>  
>  		if (!evsel__is_tool(counter))
>  			continue;
> diff --git a/tools/perf/tests/bitmap.c b/tools/perf/tests/bitmap.c
> index 98956e0e0765..e7adf60be721 100644
> --- a/tools/perf/tests/bitmap.c
> +++ b/tools/perf/tests/bitmap.c
> @@ -16,7 +16,7 @@ static unsigned long *get_bitmap(const char *str, int nbits)
>  	bm = bitmap_zalloc(nbits);
>  
>  	if (map && bm) {
> -		int i;
> +		unsigned int i;
>  		struct perf_cpu cpu;
>  
>  		perf_cpu_map__for_each_cpu(cpu, i, map)
> diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
> index 2354246afc5a..b051dce2cd86 100644
> --- a/tools/perf/tests/cpumap.c
> +++ b/tools/perf/tests/cpumap.c
> @@ -156,7 +156,8 @@ static int test__cpu_map_print(struct test_suite *test __maybe_unused, int subte
>  	return 0;
>  }
>  
> -static int __test__cpu_map_merge(const char *lhs, const char *rhs, int nr, const char *expected)
> +static int __test__cpu_map_merge(const char *lhs, const char *rhs, unsigned int nr,
> +				 const char *expected)
>  {
>  	struct perf_cpu_map *a = perf_cpu_map__new(lhs);
>  	struct perf_cpu_map *b = perf_cpu_map__new(rhs);
> @@ -204,7 +205,8 @@ static int test__cpu_map_merge(struct test_suite *test __maybe_unused,
>  	return ret;
>  }
>  
> -static int __test__cpu_map_intersect(const char *lhs, const char *rhs, int nr, const char *expected)
> +static int __test__cpu_map_intersect(const char *lhs, const char *rhs, unsigned int nr,
> +				     const char *expected)
>  {
>  	struct perf_cpu_map *a = perf_cpu_map__new(lhs);
>  	struct perf_cpu_map *b = perf_cpu_map__new(rhs);
> diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
> index a0e88c496107..7ce1ad7b6ce5 100644
> --- a/tools/perf/tests/mem2node.c
> +++ b/tools/perf/tests/mem2node.c
> @@ -30,7 +30,7 @@ static unsigned long *get_bitmap(const char *str, int nbits)
>  
>  	if (map && bm) {
>  		struct perf_cpu cpu;
> -		int i;
> +		unsigned int i;
>  
>  		perf_cpu_map__for_each_cpu(cpu, i, map)
>  			__set_bit(cpu.cpu, bm);
> diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
> index 3644d6f52c07..0be43f8db3bd 100644
> --- a/tools/perf/tests/openat-syscall-all-cpus.c
> +++ b/tools/perf/tests/openat-syscall-all-cpus.c
> @@ -22,7 +22,8 @@
>  static int test__openat_syscall_event_on_all_cpus(struct test_suite *test __maybe_unused,
>  						  int subtest __maybe_unused)
>  {
> -	int err = TEST_FAIL, fd, idx;
> +	int err = TEST_FAIL, fd;
> +	unsigned int idx;
>  	struct perf_cpu cpu;
>  	struct perf_cpu_map *cpus;
>  	struct evsel *evsel;
> diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
> index ec01150d208d..9e6a0031e9ec 100644
> --- a/tools/perf/tests/topology.c
> +++ b/tools/perf/tests/topology.c
> @@ -67,7 +67,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
>  		.path = path,
>  		.mode = PERF_DATA_MODE_READ,
>  	};
> -	int i;
> +	unsigned int i;
>  	struct aggr_cpu_id id;
>  	struct perf_cpu cpu;
>  	struct perf_env *env;
> @@ -114,7 +114,7 @@ static int check_cpu_topology(char *path, struct perf_cpu_map *map)
>  
>  	TEST_ASSERT_VAL("Session header CPU map not set", env->cpu);
>  
> -	for (i = 0; i < env->nr_cpus_avail; i++) {
> +	for (i = 0; i < (unsigned int)env->nr_cpus_avail; i++) {
>  		cpu.cpu = i;
>  		if (!perf_cpu_map__has(map, cpu))
>  			continue;
> diff --git a/tools/perf/util/affinity.c b/tools/perf/util/affinity.c
> index 4fe851334296..6c64b5f69a4e 100644
> --- a/tools/perf/util/affinity.c
> +++ b/tools/perf/util/affinity.c
> @@ -90,7 +90,7 @@ void cpu_map__set_affinity(const struct perf_cpu_map *cpumap)
>  	int cpu_set_size = get_cpu_set_size();
>  	unsigned long *cpuset = bitmap_zalloc(cpu_set_size * 8);
>  	struct perf_cpu cpu;
> -	int idx;
> +	unsigned int idx;
>  
>  	if (!cpuset)
>  		return;
> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> index a5882b582205..2ffd7aefb6eb 100644
> --- a/tools/perf/util/bpf_counter.c
> +++ b/tools/perf/util/bpf_counter.c
> @@ -294,7 +294,8 @@ static int bpf_program_profiler__read(struct evsel *evsel)
>  	struct perf_counts_values *counts;
>  	int reading_map_fd;
>  	__u32 key = 0;
> -	int err, idx, bpf_cpu;
> +	int err, bpf_cpu;
> +	unsigned int idx;
>  
>  	if (list_empty(&evsel->bpf_counter_list))
>  		return -EAGAIN;
> @@ -318,11 +319,12 @@ static int bpf_program_profiler__read(struct evsel *evsel)
>  		}
>  
>  		for (bpf_cpu = 0; bpf_cpu < num_cpu_bpf; bpf_cpu++) {
> -			idx = perf_cpu_map__idx(evsel__cpus(evsel),
> -						(struct perf_cpu){.cpu = bpf_cpu});
> -			if (idx == -1)
> +			int i = perf_cpu_map__idx(evsel__cpus(evsel),
> +						  (struct perf_cpu){.cpu = bpf_cpu});
> +
> +			if (i == -1)
>  				continue;
> -			counts = perf_counts(evsel->counts, idx, 0);
> +			counts = perf_counts(evsel->counts, i, 0);
>  			counts->val += values[bpf_cpu].counter;
>  			counts->ena += values[bpf_cpu].enabled;
>  			counts->run += values[bpf_cpu].running;
> @@ -668,7 +670,7 @@ static int bperf__install_pe(struct evsel *evsel, int cpu_map_idx, int fd)
>  static int bperf_sync_counters(struct evsel *evsel)
>  {
>  	struct perf_cpu cpu;
> -	int idx;
> +	unsigned int idx;
>  
>  	perf_cpu_map__for_each_cpu(cpu, idx, evsel->core.cpus)
>  		bperf_trigger_reading(evsel->bperf_leader_prog_fd, cpu.cpu);
> @@ -695,13 +697,11 @@ static int bperf__read(struct evsel *evsel)
>  	struct bpf_perf_event_value values[num_cpu_bpf];
>  	struct perf_counts_values *counts;
>  	int reading_map_fd, err = 0;
> -	__u32 i;
> -	int j;
>  
>  	bperf_sync_counters(evsel);
>  	reading_map_fd = bpf_map__fd(skel->maps.accum_readings);
>  
> -	for (i = 0; i < filter_entry_cnt; i++) {
> +	for (__u32 i = 0; i < filter_entry_cnt; i++) {
>  		struct perf_cpu entry;
>  		__u32 cpu;
>  
> @@ -709,9 +709,10 @@ static int bperf__read(struct evsel *evsel)
>  		if (err)
>  			goto out;
>  		switch (evsel->follower_skel->bss->type) {
> -		case BPERF_FILTER_GLOBAL:
> -			assert(i == 0);
> +		case BPERF_FILTER_GLOBAL: {
> +			unsigned int j;
>  
> +			assert(i == 0);
>  			perf_cpu_map__for_each_cpu(entry, j, evsel__cpus(evsel)) {
>  				counts = perf_counts(evsel->counts, j, 0);
>  				counts->val = values[entry.cpu].counter;
> @@ -719,6 +720,7 @@ static int bperf__read(struct evsel *evsel)
>  				counts->run = values[entry.cpu].running;
>  			}
>  			break;
> +		}
>  		case BPERF_FILTER_CPU:
>  			cpu = perf_cpu_map__cpu(evsel__cpus(evsel), i).cpu;
>  			assert(cpu >= 0);
> diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
> index 17d7196c6589..5572ceccf860 100644
> --- a/tools/perf/util/bpf_counter_cgroup.c
> +++ b/tools/perf/util/bpf_counter_cgroup.c
> @@ -98,7 +98,7 @@ static int bperf_load_program(struct evlist *evlist)
>  	struct bpf_link *link;
>  	struct evsel *evsel;
>  	struct cgroup *cgrp, *leader_cgrp;
> -	int i, j;
> +	unsigned int i;
>  	struct perf_cpu cpu;
>  	int total_cpus = cpu__max_cpu().cpu;
>  	int map_fd, prog_fd, err;
> @@ -146,6 +146,8 @@ static int bperf_load_program(struct evlist *evlist)
>  
>  	evlist__for_each_entry(evlist, evsel) {
>  		if (cgrp == NULL || evsel->cgrp == leader_cgrp) {
> +			unsigned int j;
> +
>  			leader_cgrp = evsel->cgrp;
>  			evsel->cgrp = NULL;
>  
> @@ -234,7 +236,7 @@ static int bperf_cgrp__install_pe(struct evsel *evsel __maybe_unused,
>  static int bperf_cgrp__sync_counters(struct evlist *evlist)
>  {
>  	struct perf_cpu cpu;
> -	int idx;
> +	unsigned int idx;
>  	int prog_fd = bpf_program__fd(skel->progs.trigger_read);
>  
>  	perf_cpu_map__for_each_cpu(cpu, idx, evlist->core.all_cpus)
> @@ -286,7 +288,7 @@ static int bperf_cgrp__read(struct evsel *evsel)
>  
>  	evlist__for_each_entry(evlist, evsel) {
>  		__u32 idx = evsel->core.idx;
> -		int i;
> +		unsigned int i;
>  		struct perf_cpu cpu;
>  
>  		err = bpf_map_lookup_elem(reading_map_fd, &idx, values);
> diff --git a/tools/perf/util/bpf_kwork.c b/tools/perf/util/bpf_kwork.c
> index 5cff755c71fa..d3a2e548f2b6 100644
> --- a/tools/perf/util/bpf_kwork.c
> +++ b/tools/perf/util/bpf_kwork.c
> @@ -148,7 +148,8 @@ static bool valid_kwork_class_type(enum kwork_class_type type)
>  static int setup_filters(struct perf_kwork *kwork)
>  {
>  	if (kwork->cpu_list != NULL) {
> -		int idx, nr_cpus;
> +		unsigned int idx;
> +		int nr_cpus;
>  		struct perf_cpu_map *map;
>  		struct perf_cpu cpu;
>  		int fd = bpf_map__fd(skel->maps.perf_kwork_cpu_filter);
> diff --git a/tools/perf/util/bpf_kwork_top.c b/tools/perf/util/bpf_kwork_top.c
> index b6f187dd9136..189a29d2bc96 100644
> --- a/tools/perf/util/bpf_kwork_top.c
> +++ b/tools/perf/util/bpf_kwork_top.c
> @@ -123,7 +123,8 @@ static bool valid_kwork_class_type(enum kwork_class_type type)
>  static int setup_filters(struct perf_kwork *kwork)
>  {
>  	if (kwork->cpu_list) {
> -		int idx, nr_cpus, fd;
> +		unsigned int idx;
> +		int nr_cpus, fd;
>  		struct perf_cpu_map *map;
>  		struct perf_cpu cpu;
>  
> diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
> index 88e0660c4bff..0891d9c73660 100644
> --- a/tools/perf/util/bpf_off_cpu.c
> +++ b/tools/perf/util/bpf_off_cpu.c
> @@ -67,7 +67,7 @@ static void off_cpu_start(void *arg)
>  	struct evlist *evlist = arg;
>  	struct evsel *evsel;
>  	struct perf_cpu pcpu;
> -	int i;
> +	unsigned int i;
>  
>  	/* update task filter for the given workload */
>  	if (skel->rodata->has_task && skel->rodata->uses_tgid &&
> diff --git a/tools/perf/util/bpf_trace_augment.c b/tools/perf/util/bpf_trace_augment.c
> index 56ed17534caa..9e706f0fa53d 100644
> --- a/tools/perf/util/bpf_trace_augment.c
> +++ b/tools/perf/util/bpf_trace_augment.c
> @@ -60,7 +60,7 @@ int augmented_syscalls__create_bpf_output(struct evlist *evlist)
>  void augmented_syscalls__setup_bpf_output(void)
>  {
>  	struct perf_cpu cpu;
> -	int i;
> +	unsigned int i;
>  
>  	if (bpf_output == NULL)
>  		return;
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index a80845038a5e..11922e1ded84 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -254,7 +254,7 @@ struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
>  				       aggr_cpu_id_get_t get_id,
>  				       void *data, bool needs_sort)
>  {
> -	int idx;
> +	unsigned int idx;
>  	struct perf_cpu cpu;
>  	struct cpu_aggr_map *c = cpu_aggr_map__empty_new(perf_cpu_map__nr(cpus));
>  
> @@ -280,7 +280,7 @@ struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
>  		}
>  	}
>  	/* Trim. */
> -	if (c->nr != perf_cpu_map__nr(cpus)) {
> +	if (c->nr != (int)perf_cpu_map__nr(cpus)) {
>  		struct cpu_aggr_map *trimmed_c =
>  			realloc(c,
>  				sizeof(struct cpu_aggr_map) + sizeof(struct aggr_cpu_id) * c->nr);
> @@ -631,9 +631,9 @@ size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size)
>  
>  #define COMMA first ? "" : ","
>  
> -	for (i = 0; i < perf_cpu_map__nr(map) + 1; i++) {
> +	for (i = 0; i < (int)perf_cpu_map__nr(map) + 1; i++) {
>  		struct perf_cpu cpu = { .cpu = INT16_MAX };
> -		bool last = i == perf_cpu_map__nr(map);
> +		bool last = i == (int)perf_cpu_map__nr(map);
>  
>  		if (!last)
>  			cpu = perf_cpu_map__cpu(map, i);
> @@ -679,7 +679,7 @@ static char hex_char(unsigned char val)
>  
>  size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size)
>  {
> -	int idx;
> +	unsigned int idx;
>  	char *ptr = buf;
>  	unsigned char *bitmap;
>  	struct perf_cpu c, last_cpu = perf_cpu_map__max(map);
> diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
> index 8bbeb2dc76fd..e0091804fe98 100644
> --- a/tools/perf/util/cputopo.c
> +++ b/tools/perf/util/cputopo.c
> @@ -191,7 +191,7 @@ bool cpu_topology__core_wide(const struct cpu_topology *topology,
>  		const char *core_cpu_list = topology->core_cpus_list[i];
>  		struct perf_cpu_map *core_cpus = perf_cpu_map__new(core_cpu_list);
>  		struct perf_cpu cpu;
> -		int idx;
> +		unsigned int idx;
>  		bool has_first, first = true;
>  
>  		perf_cpu_map__for_each_cpu(cpu, idx, core_cpus) {
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 93d475a80f14..1e54e2c86360 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -718,7 +718,7 @@ int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu)
>  
>  		for (i = 0; i < env->nr_numa_nodes; i++) {
>  			struct perf_cpu tmp;
> -			int j;
> +			unsigned int j;
>  
>  			nn = &env->numa_nodes[i];
>  			perf_cpu_map__for_each_cpu(tmp, j, nn->map)
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 2b0df7bd9a46..5a30caaec73e 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -1701,7 +1701,7 @@ static void python_process_stat(struct perf_stat_config *config,
>  	struct perf_cpu_map *cpus = counter->core.cpus;
>  
>  	for (int thread = 0; thread < perf_thread_map__nr(threads); thread++) {
> -		int idx;
> +		unsigned int idx;
>  		struct perf_cpu cpu;
>  
>  		perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 4b465abfa36c..09de5288f9e1 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -2766,7 +2766,8 @@ struct evsel *perf_session__find_first_evtype(struct perf_session *session,
>  int perf_session__cpu_bitmap(struct perf_session *session,
>  			     const char *cpu_list, unsigned long *cpu_bitmap)
>  {
> -	int i, err = -1;
> +	unsigned int i;
> +	int err = -1;
>  	struct perf_cpu_map *map;
>  	int nr_cpus = min(perf_session__env(session)->nr_cpus_avail, MAX_NR_CPUS);
>  	struct perf_cpu cpu;
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index dc2b66855f6c..993f4c4b8f44 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -897,7 +897,7 @@ static bool should_skip_zero_counter(struct perf_stat_config *config,
>  				     const struct aggr_cpu_id *id)
>  {
>  	struct perf_cpu cpu;
> -	int idx;
> +	unsigned int idx;
>  
>  	/*
>  	 * Skip unsupported default events when not verbose. (default events
> @@ -1125,7 +1125,7 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
>  				 struct evlist *evlist,
>  				 struct outstate *os)
>  {
> -	int all_idx;
> +	unsigned int all_idx;
>  	struct perf_cpu cpu;
>  
>  	perf_cpu_map__for_each_cpu(cpu, all_idx, evlist->core.user_requested_cpus) {
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 976a06e63252..14d169e22e8f 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -246,9 +246,11 @@ void evlist__reset_prev_raw_counts(struct evlist *evlist)
>  
>  static void evsel__copy_prev_raw_counts(struct evsel *evsel)
>  {
> -	int idx, nthreads = perf_thread_map__nr(evsel->core.threads);
> +	int nthreads = perf_thread_map__nr(evsel->core.threads);
>  
>  	for (int thread = 0; thread < nthreads; thread++) {
> +		unsigned int idx;
> +
>  		perf_cpu_map__for_each_idx(idx, evsel__cpus(evsel)) {
>  			*perf_counts(evsel->counts, idx, thread) =
>  				*perf_counts(evsel->prev_raw_counts, idx, thread);
> @@ -580,7 +582,7 @@ static void evsel__update_percore_stats(struct evsel *evsel, struct aggr_cpu_id
>  	struct perf_counts_values counts = { 0, };
>  	struct aggr_cpu_id id;
>  	struct perf_cpu cpu;
> -	int idx;
> +	unsigned int idx;
>  
>  	/* collect per-core counts */
>  	perf_cpu_map__for_each_cpu(cpu, idx, evsel->core.cpus) {
> @@ -617,7 +619,7 @@ static void evsel__process_percore(struct evsel *evsel)
>  	struct perf_stat_evsel *ps = evsel->stats;
>  	struct aggr_cpu_id core_id;
>  	struct perf_cpu cpu;
> -	int idx;
> +	unsigned int idx;
>  
>  	if (!evsel->percore)
>  		return;
> diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
> index b1d259f590e9..e360e7736c7b 100644
> --- a/tools/perf/util/svghelper.c
> +++ b/tools/perf/util/svghelper.c
> @@ -726,7 +726,8 @@ static void scan_core_topology(int *map, struct topology *t, int nr_cpus)
>  
>  static int str_to_bitmap(char *s, cpumask_t *b, int nr_cpus)
>  {
> -	int idx, ret = 0;
> +	unsigned int idx;
> +	int ret = 0;
>  	struct perf_cpu_map *map;
>  	struct perf_cpu cpu;
>  
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index bd811b2b7890..467517f4996a 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -2364,7 +2364,8 @@ static int setup_parallelism_bitmap(void)
>  {
>  	struct perf_cpu_map *map;
>  	struct perf_cpu cpu;
> -	int i, err = -1;
> +	unsigned int i;
> +	int err = -1;
>  
>  	if (symbol_conf.parallelism_list_str == NULL)
>  		return 0;
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index ef79433ebc3a..912fd4414937 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -1261,7 +1261,7 @@ static void synthesize_cpus(struct synthesize_cpu_map_data *data)
>  
>  static void synthesize_mask(struct synthesize_cpu_map_data *data)
>  {
> -	int idx;
> +	unsigned int idx;
>  	struct perf_cpu cpu;
>  
>  	/* Due to padding, the 4bytes per entry mask variant is always smaller. */
> -- 
> 2.53.0.851.ga537e3e6e9-goog
> 
